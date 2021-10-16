// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    uint256 private seed; // Use this to help generate a random number.

    // Create wave event.
    event NewWave(address indexed from, uint256 timestamp, string dish, string recipe);

    // Create a struct name wave that allows us to customize what's inside.
    struct Wave {
        address waver; // The address of the user who waved.
        string dish; // The dish the user sent.
        string recipe; // The recipe the user uses.
        uint256 timestamp; // The timestamp when the user waved.
    }

    //Declare a variable waves taht lets me store an array of structs.
    Wave[] waves;

    // Address to uint mapping. Store the address of the last time the user waved.
    mapping(address => uint256) public lastWavedAt;

    constructor() payable{
        console.log("Ready to build a web3 dApp!");
    }

    function wave(string memory _dish, string memory _recipe) public {
        // Make sure the current timestamp is at least 30 seconds bigger than the last timestamp.
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30 secs"
        );
        // Update the current timestamp for the user.
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _dish, _recipe, block.timestamp)); // Store the wave data in the array.

        // Generate a psuedo random number between 0 and 100.
        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        // Set the generated, random number as the seed for the next wave.
        seed = randomNumber;

        // Give a 50% chance that user wins the prize.
        if (randomNumber < 50) {
            console.log("%s won", msg.sender);
        
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
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