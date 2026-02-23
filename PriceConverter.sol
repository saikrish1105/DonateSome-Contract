// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter{
    // 1 Eth = ? USD currently
    function getPrice() view internal returns(uint256){
        //address for sepolia testnet chainlink
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 1e10);
    }
    // x wei = ? USD
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountUSD = (ethPrice*ethAmount) / 1e18;
        return ethAmountUSD;
    }
}