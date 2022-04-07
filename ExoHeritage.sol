// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Owner{
    address owner; //stoker le proprio du contrat
    constructor(){
        owner=msg.sender; // celle qui appelle et proprio du contrat
    }
    modifier isOwner() {  
        require(msg.sender== owner, "Not the owner");
        _;

    }
}
// deux contrats qui communiquent entre eux
contract ExoModifier is Owner {

    uint nombre;
  
    function setNombre(uint _nombre) public isOwner { // jutilise le modifier et ne repete pas la ligne 14 , la fonction continue 
        nombre = _nombre;
    }
    function getNombre() public view returns (uint){
        return nombre;
    
    }

}