// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

//gas - 890,013
contract FundMe {
    using PriceConverter for uint256;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    uint256 public minimumUSD = 50*1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough!");
        //calculates eth in 18 decimals
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        require(msg.sender == owner, "Sender is not owner.");
        for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0); //resetting the array

        //withdraw funds
        //3 ways - transfer, send, call

        //transfer (2300 gas, returns error)
        //msg.sender is address, payable(msg.sender) is payable address. in solidity, payable addresses are needed to transfer currency
        //payable(msg.sender).transfer(address(this).balance);

        //send (2300 gas, returns bool)
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send Failed");

        //call (no gas cap, returns bool)
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not the owner!");
        _;
    }
}
