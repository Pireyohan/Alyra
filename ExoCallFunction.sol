// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;


contract A{

    address addressB;

    function setAddressB(address _addressB) external {
        addressB= _addressB;
    }
    function callGetNombreContractB() external view returns(uint){
            B b=B(addressB);
            return b.getNombre();
    }
    function callSetNombreContractB(uint _nombre) external{
        B b=B(addressB);
        b.setNombre(_nombre);
    }
}

contract B {

    uint nombre;

    function getNombre() external view returns(uint){
        return nombre;

    }
    function setNombre(uint _nombre) external {
        nombre=_nombre;

    }
}

