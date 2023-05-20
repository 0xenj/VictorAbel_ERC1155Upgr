const { ethers, upgrades } = require("hardhat");

const PROXY = "0x67d2E67180016C59a4210cD53DbfEfB9b3197018";

async function main() {
  const TestNFTV2 = await ethers.getContractFactory("TestNFTV2");
  console.log("Upgrading Contract...");
  contractInstance = await upgrades.upgradeProxy(PROXY, TestNFTV2);
  console.log(`Contract upgraded successfully at ${contractInstance.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
