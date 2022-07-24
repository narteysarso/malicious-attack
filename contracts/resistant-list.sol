// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./helper.sol";

contract ResistantList {
    Helper helper;
    constructor() payable{
        // creating a new Contract rather than typecasting makes this contract resistant to malicious/phising attacks
        // bcos redeploying this contract and passing a malicious contract address will fail.
        // Also verifying this contract on etherscan makes it easy for users to identify fake/knockoffs versions 
        // of this contract.
        helper = new Helper();
    }

    function isUserEligible() public view returns(bool) {
        return helper.isUserEligible(msg.sender);
    }

    function addUserToList() public  {
        helper.setUserEligible(msg.sender);
    }

    fallback() external {}


}