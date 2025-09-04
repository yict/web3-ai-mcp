require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
console.log("INFURA_API_KEY", process.env.INFURA_API_KEY);
console.log("PRIVATE_KEY", process.env.PRIVATE_KEY);
console.log("ETHERSCAN_API_KEY", process.env.ETHERSCAN_API_KEY);

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.28",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  }
};
