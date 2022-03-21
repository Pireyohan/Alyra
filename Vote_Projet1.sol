// SPDX-License-Identifier: MIT 
pragma solidity 0.8.8;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Voting system
 * @author Pire Yohan, Promo Kovan (1er quarter 2022)
 * @dev made a voting system for the challenge n°1 Alyra
 */
contract Voting is Ownable {
    // Variable declarations
    uint public winningProposalId; // ID winner 
    uint public totalVotes; // Storing the total vote in a variable 
    
    WorkflowStatus public workflowStatus; // allows to know the status at any time
   
    //Mappings declare
    mapping(address => Voter) public whitelist; // list of voters registered by the admin
    
     // Voter structure (imposed)
    struct Voter
        {
            bool isRegistered;          // booléan to registered
            bool hasVoted;              // booléan , has voted
            uint votedProposalId;       // for the id of the voted proposal
        }

    // Structure of the candidate/proposal
    struct Proposal
        {
            string description;         // Proposal name to string
            uint voteCount;             // number of votes counted in uint
        }
    
    // List of candidates to table
    Proposal[] public applicants;
    //  mapping(uint => Proposal) public applicants; (other way to WRITE)
        
    // Enumeration that manages the different states of a vote (imposed subject)
    enum WorkflowStatus
        {
            RegisteringVoters,
            ProposalsRegistrationStarted,
            ProposalsRegistrationEnded,
            VotingSessionStarted,
            VotingSessionEnded,
            VotesTallied
        }
 
    // List of events (imposed subject)
    event VoterRegistered(address voterAddress);  
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);  
    event Voted (address voter, uint proposalId);
    //Add event
    event ProposalsRegistrationStarted();               
    event ProposalsRegistrationEnded();                        
    event VotingSessionStarted();                       
    event VotingSessionEnded();                          
    event VotesTallied();
    

  constructor() Ownable() {

      workflowStatus = WorkflowStatus.RegisteringVoters; // default status at instantiation
      //Adding a "blank vote" by default ?
      //applicants.push(Proposal('Vote Blanc', 0)); 
  }
  
  /*
    List of different functions that will be called via onlyAdmin for management.
    A dispatching of the different functions is set up for more clarity in my head
  */  
  function sessionProposalStarted() public onlyAdmin {
      
      workflowStatus = WorkflowStatus.ProposalsRegistrationStarted;
      emit ProposalsRegistrationStarted();
      emit WorkflowStatusChange(workflowStatus, WorkflowStatus.ProposalsRegistrationStarted);
  }
  
  function sessionProposalEnded() public onlyAdmin {
      
      workflowStatus = WorkflowStatus.ProposalsRegistrationEnded;
      emit ProposalsRegistrationEnded();
      emit WorkflowStatusChange(workflowStatus, WorkflowStatus.ProposalsRegistrationEnded);
  }
  
  function votingSessionStarted() public onlyAdmin {
      
      workflowStatus = WorkflowStatus.VotingSessionStarted;
      emit VotingSessionStarted();
      emit WorkflowStatusChange(workflowStatus, WorkflowStatus.VotingSessionStarted);
      
  }
  
  function votingSessionEnded() public onlyAdmin {
      
      workflowStatus = WorkflowStatus.VotingSessionEnded;
      emit VotingSessionEnded();
      emit WorkflowStatusChange(workflowStatus, WorkflowStatus.VotingSessionEnded);
  }
  
  
  /**
   *  @dev Function to count votes and determine the winner
   */
   function votesTallied() public onlyAdmin {
       
        require(workflowStatus == WorkflowStatus.VotingSessionEnded, "the Session is always open !");
        workflowStatus = WorkflowStatus.VotesTallied; // status change

        uint winnerId; // Id gagnant
        uint winningVoteCount; // vote counting for the winner

        for(uint i = 0; i < applicants.length; i++)  // Loop to go through the length of the candidates table
        {
            if (applicants[i].voteCount > winningVoteCount)  // If the vote count of one of the indexes of the table is higher than the vote count for the winner 
            {
                winningVoteCount = applicants[i].voteCount; // We get the total votes for a given candidate
                winnerId = i; // initialize the id in winnerID
            }
        
            totalVotes+= applicants[i].voteCount; // We count the vote of each candidate via the index => totalVotes
        }
        winningProposalId = winnerId;   // Id of the winner declared in the contract variable
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionEnded, WorkflowStatus.VotesTallied); //Voting session is finished and are counted
        emit VotesTallied();
        
    }

   /**
   * @dev Function that allows to return the information about the winner of the vote
   */
  function winnerIs() public canDo(WorkflowStatus.VotesTallied) view returns(uint winnerId, string memory description, uint voteCount, uint totaleVotes)
    {
        return (
                    winningProposalId,   // retur l'Id winner
                    applicants[winningProposalId].description, // return  string/pseudo proposal
                    applicants[winningProposalId].voteCount,   // return the number of votes of the winner
                    totalVotes                                 // return vote totals
        
               );
    }

   /**
    *@dev Function to add voters to the whitelist via the Admin 
   */
  function addVoterToWhitelist(address _address) public onlyAdmin {
      
      require(workflowStatus == WorkflowStatus.RegisteringVoters, "Registering Voters essential");        
      require(!whitelist[_address].isRegistered, "Voter exists in the whitelist");
        
      whitelist[_address].isRegistered = true;  // Boolean is Registred =true => it is registered
      whitelist[_address].hasVoted = false;     // Boolean has voted =false => but has not yet voted
      workflowStatus = WorkflowStatus.RegisteringVoters;
      emit VoterRegistered(_address);           // Event generated when adding a voter via _address
  }
  
  /**
   * @dev Function that allows a whitelist voter to vote via an Id  
   */
  function vote(uint _proposalId) public canDo(WorkflowStatus.VotingSessionStarted) 
  {
      address votant = msg.sender; 

      // voter makes his choice, we match if he is record, that he can vote, that he has not already voted and not owner
      if (whitelist[votant].isRegistered == true && whitelist[votant].hasVoted == false && votant != owner())
      {
          whitelist[votant].hasVoted = true; 
          whitelist[votant].votedProposalId = _proposalId;
          emit Voted(votant, _proposalId);
          applicants[_proposalId].voteCount++; //we increment one more vote
      }
      emit Voted(votant, _proposalId);    
  }

  /**
   *@dev  Method that allows the proposal of a candidate
   */
  function candidatePropose(string memory _description) public canDo(WorkflowStatus.ProposalsRegistrationStarted) {
     
     address votant = msg.sender;
     if (whitelist[votant].isRegistered == true && votant != owner())
     {
         applicants.push(Proposal(_description, 0)); // We add the new proposal
         uint proposalId = applicants.length-1;      // we determine is ID
         emit ProposalRegistered(proposalId);       //  emit an event
      }
  }
  
    
    modifier onlyAdmin() { 
       require(msg.sender == owner(),"Only the admin can call this function !");
       _; //adds a _ , this is the standard.
   }
   
    modifier canDo(WorkflowStatus _workflowStatus)
    { 
       require(workflowStatus == _workflowStatus,"The current status does not allow this action !");
       _; //adds a _ , this is the standard.
    }
    
}
// Deployment ropsten metamask
// Transaction Hash:
// 0x1b445fa9a1e8ff95ded1c10078e48eb9a7659e18724d9feeb7d1b613d8191886 
// Status:
// Success
// Block:
// 12114957 2 Block Confirmations
// Timestamp:
// 46 secs ago (Mar-21-2022 03:06:51 PM +UTC)
// From:
// 0x004f1e2def73317def5a68533c20c16a244d420a 
// To:
// [Contract 0x4ab3153087f3d4987488f8c46d4b9de5c2622fcaCreated] 
// Value:
// 0 Ether ($0.00)
// Transaction Fee:
// 0.113929872088229913 Ether ($0.00)
// Gas Price:
// 0.000000060829657061 Ether (60.829657061 Gwei)