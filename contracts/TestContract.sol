pragma solidity ^0.8.0;

contract Test {
    address public owner;
    uint public balance;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed receiver, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor(uint initialBalance) {
        owner = msg.sender;
        balance = initialBalance;
    }

    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than zero");
        balance += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() public view returns (uint) {
        return balance;
    }

    function destroyContract() public onlyOwner {
        selfdestruct(payable(owner));
    }
}