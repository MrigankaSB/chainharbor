const hre = require("hardhat");

async function main() {
  const ChainHarbor = await hre.ethers.getContractFactory("ChainHarbor");
  const chainHarbor = await ChainHarbor.deploy();
  await chainHarbor.deployed();

  console.log(`✅ ChainHarbor deployed to: ${chainHarbor.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
