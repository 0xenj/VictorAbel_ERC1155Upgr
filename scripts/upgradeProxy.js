const { ethers, upgrades } = require("hardhat");

const PROXY = "0x4bd941Fbe680e4921a4b42f29D4Ee4bB9Ff90CF4";

async function main() {
  const NewContract = await ethers.getContractFactory("ARTbres_Forets");
  console.log("Upgrading Contract...");
  contractInstance = await upgrades.upgradeProxy(PROXY, NewContract);
  console.log(`Contract upgraded successfully at ${contractInstance.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
