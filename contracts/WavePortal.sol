// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // Create wave event
    event NewWave(address indexed from, uint256 timestamp, string message);

    // Create a struct name wave that allows us to customize what's inside
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    //Declare a variable waves taht lets me store an array of structs.
    Wave[] waves;

    constructor() {
        console.log("Ready to build a web3 dApp!");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // Store the wave data in the array
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory){
    // returns the struct array, waves, making it easy to retrieve the wave from the website.
        return waves;
    }

    function getTotalWaves () public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}