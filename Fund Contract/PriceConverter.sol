// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //ETH in USD in 8 decimals
        return uint256(price*1e10); //ETH in 18 decimals (WEI)
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethRate = getPrice();
        uint256 ethInUsd = (ethRate*ethAmount) / 1e18;
        return (ethInUsd);
    }

}
