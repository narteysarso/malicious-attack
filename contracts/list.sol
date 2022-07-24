// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./helper.sol";

contract List {
    Helper helper;
    constructor(Helper _helper) payable {
        // typecasting address to contract makes this susceptible to malicious/phising attacks
        // by redeploying this contract and passing a malicious contract address.
        helper = Helper(_helper);
    }

    function isUserEligible() public view returns(bool) {
        return helper.isUserEligible(msg.sender);
    }

    function addUserToList() public  {
        helper.setUserEligible(msg.sender);
    }

    fallback() external {}


}