// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Game{

    constructor() payable {}

    // Randomly picks a number out of 0 to 2²⁵⁶–1
    function pickACard() private view returns(uint){
        uint pickedCard = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp)));
        return pickedCard; // keccack256 converts bytes to bytes32 string
    }

    function guess(uint _guess) public {

        uint _pickedCard = pickACard();
        if(_pickedCard == _guess){
            (bool sent, ) = msg.sender.call{value : 0.1 ether}("");
            require(sent,"Failed to sent any ether!");
        }
    }

    function getBalance() view public returns(uint){
        return address(this).balance;
    }

}