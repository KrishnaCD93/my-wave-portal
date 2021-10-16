require("@nomiclabs/hardhat-waffle");

const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);

    // Get Contract balance
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance))
    
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    // Send a wave
    let waveTxn = await waveContract.wave('Pasta', 'One-Pot Vegetarian Pasta with Alfredo sauce');
    await waveTxn.wait(); // Wait for transaction to be mined

    // Another wave
    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.wave('Pizza', 'Vegetarian with spinach and mushrooms');
    await waveTxn.wait(); // Wait for transaction to be mined

    //Get contract balance to see what happened
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
        'Contract balance:', hre.ethers.utils.formatEther(contractBalance)
    );

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