// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.8;

contract CombineStrucArraymapping{     
     struct eleve {
         string nom;
         string prenom;
         uint[] notes;
     }
     mapping(address => eleve) Eleves;

     function addNote(address _eleve,uint _note) public { // ajouter une note a un eleve en particulier 
            Eleves[_eleve].notes.push(_note); // selectionne le mapping puis ladresse de leleve , on recupére les notes et on push 
     }
     function getNotes(address _eleve) public view returns (uint[] memory){ // function qui retourne les notes dun eleve en fonction de son adresse
        return Eleves[_eleve].notes;
     }

     function setNom(address _eleve, string memory _nom) public { // function set avec adresse dun eleve et son nom  pour changer son nom 
        Eleves[_eleve].nom=_nom;
     }
     function getNom(address _eleve) public view returns(string memory){ //function qui permet de retourner le nom d'un eleve en fonction d'une adresse
         return Eleves[_eleve].nom;
     }
}