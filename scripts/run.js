require("@nomiclabs/hardhat-waffle");

const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    let waveTxn = await waveContract.wave('Pasta', 'One-Pot Vegetarian Pasta with Alfredo sauce');
    await waveTxn.wait(); // Wait for transaction to be mined

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave('Pizza', 'Vegetarian with spinach and mushrooms');
    await waveTxn.wait(); // Wait for transaction to be mined

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error){
        console.log(error);
        process.exit(1);
    }
};

runMain();