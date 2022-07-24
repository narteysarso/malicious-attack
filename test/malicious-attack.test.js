const {
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Attack", function () {
  async function attackSetup(){
    const attackContract = await ethers.getContractFactory("Attacker");
    const _attackContract = await attackContract.deploy();
    await _attackContract.deployed();

    // Deploy the good contract
    const listContract = await ethers.getContractFactory("List");
    const _listContract = await listContract.deploy(_attackContract.address, {
      value: ethers.utils.parseEther("3"),
    });
    await _listContract.deployed();

    return {_listContract, _attackContract}
  }
  
  async function resistantSetup(){
    const attackContract = await ethers.getContractFactory("Attacker");
    const _attackContract = await attackContract.deploy();
    await _attackContract.deployed();

    // Deploy the good contract
    const listContract = await ethers.getContractFactory("ResistantList");
    const _listContract = await listContract.deploy( {
      value: ethers.utils.parseEther("3"),
    });
    await _listContract.deployed();

    return {_listContract, _attackContract}
  }



  it("Should change the eligibility of address in List contract", async function () {
    const {_listContract} = await loadFixture(attackSetup);
   
    const [_, addr1] = await ethers.getSigners();
    // Now lets add an address to the eligibility list
    await _listContract.connect(addr1).addUserToList();
    

    // check if the user is eligible
    const eligible = await _listContract.connect(addr1).isUserEligible();
    expect(eligible).to.equal(false);
  });
  
  it("Should fail to change eligibility of address in list contract", async function () {
    const {_listContract} = await loadFixture(resistantSetup);
   
    const [_, addr1] = await ethers.getSigners();
    // Now lets add an address to the eligibility list
    await _listContract.connect(addr1).addUserToList();
    

    // check if the user is eligible
    const eligible = await _listContract.connect(addr1).isUserEligible();
    expect(eligible).to.equal(true);
  });
});