require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-foundry");
require("dotenv").config({ path: __dirname + "/.env" });
require("@openzeppelin/hardhat-upgrades");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    hardhat: {},
    mumbai: {
      url: process.env.RPC_MUMBAI,
      accounts: [process.env.PRIVATE_KEY_MUMBAI],
    },
  },
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  mocha: {
    timeout: 200000,
  },
};
