pragma solidity ^0.8.0;

contract Test {
    address public owner;
    uint public balance;

    constructor(uint initialBalance) {
        owner = msg.sender;
        balance = initialBalance;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than zero");
        balance += amount;
    }

    function withdraw(uint amount) public {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint) {
        return balance;
    }

    function destroyContract() public onlyOwner {
        selfdestruct(payable(owner));
    }
}