const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  let contract;
  let owner;
  beforeEach(async function (){
    const Betting = await ethers.getContractFactory("Betting");
    const better = await Betting.deploy();
    contract = await better.deployed();
    [owner] = await ethers.getSigners();

  });
  it("Should return the new greeting once it's changed", async function () {

    expect(value).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
