// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Librairies{

    function concatener(string memory _stringA, uint _numberA, uint _numberB) external pure returns(string memory){ //string + nombre+ autre nombre    retourner une string de la concaténation des trois 

        string memory res = string(abi.encodePacked(_stringA, Strings.toString(_numberA), Strings.toString(_numberB))); // Cree string string qui result des trois 
                                    //Concatene               Librairie String             Libraire toString sur numberB
        return res;
    }

}