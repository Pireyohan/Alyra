// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;
import "@openzeppelin/contracts/access/Ownable.sol";

contract ExoImmo is Ownable{

    enum typeBien {terrain , maison , appartement}

    struct bien {
        uint id;
        string name;
        uint price;
        typeBien _typeBien;
    }
    uint compteur;

    mapping(address => bien[])  Possessions;


    function addBien(address _proprietaire, string memory _name, uint _price, typeBien _typeBien) public onlyOwner{
        require(_price > 1000, "Le bien doit couter plus de 1000wei");
        require(uint(_typeBien) >=0 , "le type de bien doit etre compris entre 0 et 2");
        require(uint(_typeBien) <=2 , "le type de bien doit etre compris entre 0 et 2");
        Possessions[_proprietaire].push(bien(compteur, _name, _price, _typeBien));
        compteur++;
    }

    function getBiens(address _proprietaire) public view returns(bien[] memory){
        return Possessions[_proprietaire];
    }
    function getNombreBiens(address _proprietaire) public view onlyOwner returns(uint){
        return Possessions[_proprietaire].length;
    }

    function getMesBiens() public view returns(bien[] memory){
        return Possessions[msg.sender];
    }
}