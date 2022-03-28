// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    uint256 integer = 100; //tVariable d'état qui sera stocké de manière permanente dans la blockchain
}

// Smart contract qui définit un mapping "whitelist" ou la clé est une address et la valeur un booléan
contract Whitelist {
    mapping(address => bool) whitelist;
}

//Déclaration d'une struture Voter qui définit de multiples propriétés.
/* contract Ballot {
    struct Voter {
        uint256 weight;
        bool voted;
        address delegate;
        uint256 vote;
    }
} */

contract Whitelist2 {
    struct Person {
        // Structure de données
        string name;
        uint256 age;
    }
}

/* Methode 1 - paramètre par paramètre 

Person memory person; // Déclaration d’une variable de type Person
person.name = "name"; // Initialisation du premier paramètre de la struct
person.age = 30; // Initialisation du deuxième paramètre de la struct

Méthode 2 - en une seule ligne 

Person memory person = Person("name", 30); // Déclaration d’une variable de type Person et son initialisation */

//Votre smart contract devra définir une fonction addPerson qui prend deux paramètres _name et _age
//et qui permet de créer une nouvelle personne à l’aide de la struct Person.

contract Whitelist3 {
    struct Person {
        // Structure de données
        string name;
        uint256 age;
    }

    function addPerson(string memory _name, uint256 _age) public pure {
        Person memory person;
        person.name = _name;
        person.age = _age;
    }
}

/************************************************Array****************************************************/

//Person[] public people; // un tableau dynamique de type Person, peut contenir n "Person"

// Tableau avec une longueur fixe de 2 entiers :
//uint[2] fixedArray;
// un autre tableau fixe, pouvant contenir 5 string :
//string[5] stringArray;
// un Array dynamique - n'a pas de taille fixe, peut contenir n éléments :
//uint[] dynamicArray;

contract Whitelist4 {
    struct Person {
        // Structure de données
        string name;
        uint256 age;
    }
    Person[] public persons;
}

//Exo 4 Array Avancé
contract Whitelist5 {
    struct Person {
        string name;
        uint256 age;
    }
    Person[] public persons;

    function add(string memory _name, uint256 _age) public {
        Person memory person = Person(_name, _age); //création d'un nouvel objet
        persons.push(person); // Ajout de l'objet 'Person' dans le tableau
    }

    function remove() public {
        persons.pop(); // Suppression du dernier objet du tableau
    }
}

//Déclaration énumération
contract Purchase {
    enum State {
        Created,
        Locked,
        Inactive
    } // Décalaration d’une énumération “State” qui définit trois états : Created, Locked et Inactive
}

/* 👉 Déclaration d’une variable de type Enum
 enum State { Created, Locked, Inactive }
State public defaultstate;

👉 Initialisation d’une variable de type Enum
enum State { Created, Locked, Inactive }
State public defaultstate = State.Created;

👉 Modification d’une variable de type Enum
enum State { Created, Locked, Inactive }
State public defaultstate = State.Created;

function turnStateLocked() public { defaultstate = State.Locked; }
function turnStateInactive() public { defaultstate = State.Inactive; } */

contract HelloWorld {
    // nom du contrat
    string myString = "Hello World !"; // string qui s'appelle myString  avec Hello World dedans

    function hello() public view returns (string memory) {
        // Fonction hello qui est public et qui renvoi un string ici myString
        return myString;
    }
}

// Votre smart contract va reproduire ce concept en autorisant un ensemble de compte Ethereum et en les stockant dans une whitelist.
contract Whitelist6 {
    mapping(address => bool) whitelist;
    event Authorized(address _address); // Event récupérer dans le chapitre Exercice events

    function authorize(address _address) public {
        whitelist[_address] = true;
        emit Authorized(_address); // Evenement declencheur
    }
}

//Votre smart contract doit définir une fonction getTime qui permet à un utilisateur de récupérer l’horodatage du bloc actuel.
contract Time {
    function getTime() public view returns (uint256) {
        return block.timestamp;
    }
}

//Votre smart contract doit définir un mapping choices, où la clé est une adresse et la valeur un uint.
//Votre smart contract doit définir une fonction add qui permet à un utilisateur de stocker son uint renseigné (en paramètre de la fonction _myuint) dans le mapping choices.
contract Choice {
    mapping(address => uint) choices;

    function add(uint _myuint) public {
        choices[msg.sender] = _myuint;
    }
}
