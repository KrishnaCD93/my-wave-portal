// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // Create wave event
    event NewWave(address indexed from, uint256 timestamp, string dish, string recipe);

    // Create a struct name wave that allows us to customize what's inside
    struct Wave {
        address waver; // The address of the user who waved.
        string dish; // The dish the user sent.
        string recipe; // The recipe the user uses.
        uint256 timestamp; // The timestamp when the user waved.
    }

    //Declare a variable waves taht lets me store an array of structs.
    Wave[] waves;

    constructor() {
        console.log("Ready to build a web3 dApp!");
    }

    function wave(string memory _dish, string memory _recipe) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        waves.push(Wave(msg.sender, _dish, _recipe, block.timestamp)); // Store the wave data in the array
        emit NewWave(msg.sender, block.timestamp, _dish, _recipe);
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