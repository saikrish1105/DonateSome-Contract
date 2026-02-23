# FundMe – Sepolia Testnet

A simple crowdfunding smart contract deployed on Ethereum Sepolia.

Users can fund the contract in ETH, and contributions must be worth at least **$1 USD**, enforced using the ETH/USD price feed from Chainlink.

The contract:

* Tracks funders and their funded amounts
* Restricts withdrawals to the immutable owner
* Transfers the full contract balance to the owner on withdrawal
* Uses a price conversion library for ETH → USD validation
s
Built with Solidity ^0.8.18.
