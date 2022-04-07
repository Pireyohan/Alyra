// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract GestionnaireEleve {

    address owner; // ladresse du principal

    struct Grade {
        string subject; // matiere
        uint grade;     // note
    }

    struct Student {
        string firstName;
        string  lastName;
        uint numberOfGrades;
        mapping (uint => Grade) grades; // un mapping pour faire correler l'eleve avec ses notes
    }

    mapping (address => Student) students; // pour chaque adresse pour un eleve avec nom prenom et nombre de notes

    constructor() {
        owner =msg.sender; // le msg.sender est celui qui deploy et donc sera le owner du contrat
    }

    function addStudent (address _addressStudent, string memory _firstName, string memory _lastName) public { 
        require(msg.sender == owner , "Not the owner"); // il faut etre owner
        bytes memory firstNameOfAddress = bytes(students[_addressStudent].firstName); // convertir en bytes
        require (firstNameOfAddress.length ==0 , "Existe deja"); // leleve nexiste pas 
        students[_addressStudent].firstName=_firstName;
        students[_addressStudent].lastName=_lastName;
    }

    function addGrade(address _addressStudent, uint _grade, string memory _subject) public {
        require(msg.sender== owner , "Not the owner");
        bytes memory firstNameOfAddress= bytes(students[_addressStudent].firstName);
        require(firstNameOfAddress.length >0 , "Il faut creer l eleve");
        students[_addressStudent].grades[students[_addressStudent].numberOfGrades].grade= _grade;
        students[_addressStudent].grades[students[_addressStudent].numberOfGrades].subject= _subject;
        students[_addressStudent].numberOfGrades++;// incrementer le nombre de notes dun certains eleve

    }

    function getGrades(address _studentAddress) public view returns(uint[] memory){//recuperer les notes sous forme d'un tableau
        require(msg.sender== owner , "Not the owner");
        uint numberGradesThisStudent = students[_studentAddress].numberOfGrades; // recuperer le nombre de notes qu'a un eleve
        uint[] memory grades = new uint[](numberGradesThisStudent); // tableau memory , attenation indique la taille
        for (uint i =0; i < numberGradesThisStudent; i++){ //boucle pour parcourir le nombre de note du students
            grades[i]=students[_studentAddress].grades[i].grade; // on vient rajouter la note dans le tableau grades
        }
        return grades; 
    }
}