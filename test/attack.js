const { expect } = require("chai");
const { ethers } = require("hardhat");
const { utils, BigNumber } = require("ethers");

describe("Attack it!", ()=> {
    it("Should guess the same nmber as the game and recieve the ether", async() => {

        const game = await ethers.getContractFactory("Game");
        const _game = await game.deploy({value : utils.parseEther("0.1")})
        await _game.deployed()

        console.log("Game Contract :", _game.address)

        const attack = await ethers.getContractFactory("Attack")
        const _attack = await attack.deploy(_game.address)
        await _attack.deployed()

        const tx = await _attack.attack()
        await tx.wait()

        const balance = await _game.getBalance()
        expect(balance).to.equal(BigNumber.from("0"))
    })
})
