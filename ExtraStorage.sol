// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage { //SS is parent contract of ES
    // virtual keyword inserted for this overriding purpose in SS store function
    function store(uint256 _favoriteNumber) public override { //overriding function of SS without creating an object
        favoriteNumber = _favoriteNumber + 5;
    }
}
