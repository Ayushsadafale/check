require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks:{
    hardhat:{
      chainId:1337,
    },
    ganache:{
      url:"http://127.0.0.1:7545",
      
    }
  },
  solidity: "0.8.20",
};


