const { ethers, upgrades } = require("hardhat");

async function main() {
  const Contract = await ethers.getContractFactory("ARTbres_Forets");
  const contract = await upgrades.deployProxy(Contract, {
    initializer: "initialize",
    kind: "uups",
  });

  await contract.deployed();
  console.log("Contract deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
