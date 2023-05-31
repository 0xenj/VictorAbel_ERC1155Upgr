const { ethers, upgrades } = require("hardhat");

const PROXY = "0x401aE4c321efe65DB6c4b735932cA55fF0335e43";

async function main() {
  const NewContract = await ethers.getContractFactory("ARTbres_ForetsV3");
  console.log("Upgrading Contract...");
  contractInstance = await upgrades.upgradeProxy(PROXY, NewContract);
  console.log(`Contract upgraded successfully at ${contractInstance.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
