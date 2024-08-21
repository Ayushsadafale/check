//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract KycContract{
    mapping(address => bool) allowed; //storing access data of kycwhitelisted accounts
    address public owner;
    //constructor
    constructor() {
        owner = msg.sender;
    }
    //onlyOwner access modifier
    modifier onlyOwner{
        require(msg.sender == owner,"Caller is not the Owner");
        _;
    }
    //whoever is calling this, is allowed to purchase token
    function setKycCompleted(address _addr) public onlyOwner{
        allowed[_addr] = true;
    }
    //whoever is calling this, is Not allowed to purchase token
    function setKycRevoked(address _addr) public onlyOwner{
        allowed[_addr] = false;
    }
    //checking if Kyc is already completed
    function KycCompleted(address _addr) public view returns (bool){
       return allowed[_addr];
    }
}