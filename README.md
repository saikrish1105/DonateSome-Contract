# FundMe – Sepolia Testnet

A smart contract deployed on Ethereum Sepolia for collecting donations. 

Users can donate ETH to the contract, and donations must be worth at least **$1 USD**, enforced using the ETH/USD price feed from Chainlink.

The contract:

* Tracks funders and their funded amounts
* Restricts withdrawals to the immutable owner
* Transfers the full contract balance to the owner on withdrawal
* Uses a price conversion library for ETH → USD validation

Built with Solidity ^0.8.18.

