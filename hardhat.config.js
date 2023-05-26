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
    polygon: {
      url: process.env.RPC_POLYGON,
      accounts: [process.env.PRIVATE_KEY_POLYGON],
    },
  },
  etherscan: {
    apiKey: {
      polygon: process.env.API_KEY_POLYGON,
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
};
