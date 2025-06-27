const { ethers } = require("hardhat");

async function main() {
  console.log("Starting deployment to Core Blockchain...");

  // Get the deployer account
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Check account balance
  const balance = await deployer.getBalance();
  console.log("Account balance:", ethers.utils.formatEther(balance), "CORE");

  if (balance.lt(ethers.utils.parseEther("0.01"))) {
    throw new Error("Insufficient balance for deployment. Need at least 0.01 CORE for gas fees.");
  }

  // Get the contract factory
  const LocalMarketPrediction = await ethers.getContractFactory("LocalMarketPrediction");

  console.log("Deploying LocalMarketPrediction contract...");

  // Deploy the contract
  const localMarketPrediction = await LocalMarketPrediction.deploy();

  // Wait for deployment to finish
  await localMarketPrediction.deployed();

  console.log("✅ LocalMarketPrediction deployed successfully!");
  console.log("📄 Contract Address:", localMarketPrediction.address);
  console.log("🔗 Transaction Hash:", localMarketPrediction.deployTransaction.hash);
  console.log("⛽ Gas Used:", localMarketPrediction.deployTransaction.gasLimit.toString());

  // Verify deployment by calling a contract function
  try {
    const marketCounter = await localMarketPrediction.marketCounter();
    console.log("🔍 Verification: Market counter initialized to:", marketCounter.toString());
    
    const owner = await localMarketPrediction.owner();
    console.log("👤 Contract Owner:", owner);
    
    const minStake = await localMarketPrediction.MIN_STAKE();
    console.log("💰 Minimum Stake:", ethers.utils.formatEther(minStake), "CORE");

  } catch (error) {
    console.error("❌ Contract verification failed:", error.message);
  }

  // Save deployment info
  const deploymentInfo = {
    network: "coreTestnet",
    contractName: "LocalMarketPrediction",
    contractAddress: localMarketPrediction.address,
    deployerAddress: deployer.address,
    transactionHash: localMarketPrediction.deployTransaction.hash,
    blockNumber: localMarketPrediction.deployTransaction.blockNumber,
    gasUsed: localMarketPrediction.deployTransaction.gasLimit.toString(),
    timestamp: new Date().toISOString()
  };

  console.log("\n📋 Deployment Summary:");
  console.log("=".repeat(50));
  console.log(JSON.stringify(deploymentInfo, null, 2));
  console.log("=".repeat(50));

  return localMarketPrediction;
}

// Execute deployment
main()
  .then(() => {
    console.log("\n🎉 Deployment completed successfully!");
    process.exit(0);
  })
  .catch((error) => {
    console.error("\n💥 Deployment failed:");
    console.error(error);
    process.exit(1);
  });
