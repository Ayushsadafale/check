//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor() ERC20("Coffee Token","CTC"){
        //initial supply
        _mint(msg.sender, 10000); //creating initial supply and allocate to contract deployer
    }
    //change no. of Decimals
    function decimals()public view virtual override returns (uint8) {
        return 0;
    }
}