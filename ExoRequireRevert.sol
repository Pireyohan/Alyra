// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract ExoRequireRevert {
    uint256 nombre;

    function setNombre(uint256 _nombre) public {
        // if (_nombre == 10) {
        //     revert("le nombre ne peut pas etre egale a 10");
        // }
        require(_nombre != 10, "le nombre ne peut pas etre egale a 10");

        nombre = _nombre;
    }

    function getNombre() public view returns (uint256) {
        return nombre;
    }
}
