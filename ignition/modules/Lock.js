const hre = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();//acounts within the network mentioned in config.
    console.log("Deploying contract with the account", deployer.address);

    //Deploy MyToken
    const MyToken = await ethers.deployContract("MyToken");
    await MyToken.waitForDeployment();
    console.log("MyToken Deployed To:", MyToken.target);

    //Deploy Kyc contract
    const KycContract = await ethers.deployContract("KycContract");
    await KycContract.waitForDeployment();
    console.log("KycContract Deployed To:", KycContract.target);

    //Deploy MytokenSale
    const lockedAmount = ethers.paraseEther("0.001");
   
    const MyTokenSale = await ethers.deployContract("MyTokenSale",MyToken.target,KycContract.target,lockedAmount);
    await MyTokenSale.waitForDeployment();
    console.log("MyTokenSale Deployed To:",MyTokenSale.target);
   
     //transfer tokens from MyTokenSale
     await MyToken.transfer(MyTokenSale.target,10000);
     
    
}


//we require this pattern to  be able to use async/await everywhere
// and properly handle errors.
main().catch((error)=> {
    console.error(error);
    process.exitCode = 1;
})