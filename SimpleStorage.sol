// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; //Solidity Version - 0.8.7: Stable

contract SimpleStorage {
    // Data types: boolean, uint, int, address, bytes
    uint256 favoriteNumber; //Default value = 0

    //Mappings are like a dictionary
    mapping(string => uint256) public nameToFavoriteNumber; // Name: Favorite Number
    
    //Object creation
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;//Dynamic array: No size of array mentioned; Static array: People[3] public people;


    function store(uint256 _favouriteNumber) public virtual {
        favoriteNumber = _favouriteNumber;
        retrieve();
    }

    //view and pure keywords don't charge gas
    //view does not create a transaction in blockchain, but only reads what exists 
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    //pure function does not read or write. 
    function add() private pure returns (uint256){
        return (1+1);
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}


//six places to store data in Solidity: calldata, memory, storage, stack, code, logs
//memory and calldata store the variable temporarily, storage stores the variable permanently even outside the function,
//example: favoriteNumber declared globally in the contract.
//calldata type is immutable, memory is mutable

//data locations have to be specified for arrays, structs, and mappings
//string being an array requires a DL, while uint256 doesn't.
