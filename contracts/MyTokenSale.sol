// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// Contract imports
import "./MyToken.sol";
import "./KycContract.sol";

contract MyTokenSale {
    // State variables
    address public admin;
    MyToken public tokenContract;
    KycContract public kycContract;
    uint256 public tokenPrice;

    // Event
    event TokenPurchased(address indexed buyer, uint256 indexed amount);

    // Constructor
    constructor(
        address _tokenAddress,
        address _kycContractAddress,
        uint256 _tokenPrice
    ) {
        admin = msg.sender;
        tokenContract = MyToken(_tokenAddress);
        kycContract = KycContract(_kycContractAddress);
        tokenPrice = _tokenPrice;
    }

    // Modifier
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not Authorized");
        _;
    }

    // Function to set the token price
    function setTokenPrice(uint256 _tokenPrice) external onlyAdmin {
        tokenPrice = _tokenPrice;
    }

    // Function to buy tokens
    function buyTokens() external payable {
        // Check KYC
        require(kycContract.isKycCompleted(msg.sender), "KYC Not Completed");

        // ETH given
        uint256 tokenToTransfer = (msg.value / tokenPrice);
        require(tokenToTransfer > 0, "Incorrect ETH Amount Sent");

        // Check token balance
        require(tokenContract.balanceOf(address(this)) >= tokenToTransfer, "Not Enough Tokens in Sale Account");

        // Transfer tokens
        tokenContract.transfer(msg.sender, tokenToTransfer);

        // Emit the event
        emit TokenPurchased(msg.sender, tokenToTransfer);
    }

    // Function to withdraw ETH
    function withdrawEth() external onlyAdmin {
        payable(admin).transfer(address(this).balance);
    }
}
