//Ecrire un smart contract  qui gère un magasin d'articles (addItem, getItem , setItem)
// On stock ces produits dans un mapping test

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Shop {
    mapping(string => Item) public shop;
    struct Item {
        uint256 price;
        uint256 units;
    }

    function createItem(string memory _name, uint256 _price) external {
        /*method1.*/
        shop[_name] = Item(_price, 1);
        /* method2.
       shop[_name].price = _price;
       shop[_name].units = 1;
       */
        /*method3. 
       shop[_name] = Item({price :_price, units: 1});
       */
    }

    function setItem(
        string memory _name,
        uint256 _price,
        uint256 _units
    ) external {
        shop[_name].price = _price;
        shop[_name].units = _units;
    }

    function getItem(string memory _name)
        public
        view
        returns (uint256, uint256)
    {
        return (shop[_name].price, shop[_name].units);
    }
}
