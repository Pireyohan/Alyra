// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract ExoEnum{

    enum etape {commander ,expedier, liver} // 0 ,  1 ,  2

    struct produit{
        uint _SKU; //numero identif unique
        ExoEnum.etape _etape; // savoir sil a ete commander expedier etc..

    }                           //nom du mapping
    mapping(address => produit) CommandesClient; // une address ne pourra commander qun seul produit

    function commander( address _client, uint _SKU) public {// une adresse client qui va commander un produit representer pour un numero unique 
        produit memory p =produit(_SKU , etape.commander); //struc produit "p" nom de la variable structure
        CommandesClient[_client]=p; // j'attribue une certaine adresse (mapping ligne 13) un produit de la structure l16
    }

    function expedier(address _client) public { //pour une certaine adresse je vais expedier son produit 
        CommandesClient[_client]._etape=etape.expedier; // pour un certain client au niveau de letape  "etape.expedier"
    }

    function getsku(address _client) public view returns(uint) { // retourn un uint qui du numero SKU que le client a commandé
        return CommandesClient[_client]._SKU;
    }

    function getEtape(address _client) public view returns(etape) { // retourner une etape actuelle du produit d'un client 
        return CommandesClient[_client]._etape;

    }

}

