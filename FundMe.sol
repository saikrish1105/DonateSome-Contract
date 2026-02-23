// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    // minimum USD people can send
    uint256 public constant MINUSD = 1;

    // address of people sending funds and how much they sent
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    // define the owner
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    // allow users to send money
    function fund() public payable{
        // PriceConverter.getConversionRate(msg.value) = msg.value.getConversionRate()
        require(msg.value.getConversionRate() >= (MINUSD*1e18),"You need to spend more ETH!"); // msg.value : number of wei sent with message   
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }   
    
    // modifier to allow only owner to withdraw
    modifier onlyOwner() {
        // require(msg.sender == owner,"NOT OWNER!");
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    // allow owner to withdraw the money
    function withdraw() public onlyOwner{
        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    // if someone send eth without the fund function
    // call the fund function anyway to run the contract as it is supposed to be
    receive() external payable {
        fund();
    }
}