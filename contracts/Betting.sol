// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Betting{
    event PlaceBet(address caller, uint choice);
    event Deposit(address caller, uint amount);

    struct Users{
        address owner;
        uint accountBalance;
        uint betAmount;
        uint choice;
        bool hasPlacedBet;
    }

    struct Choice{
        string homeWin;
        string homeLoose;
        string awayWin;
        string awayLoose;
        string draw;
    }

    mapping(address => Users) user;
    mapping(address => Choice) usersChoice;

    function deposit() payable external{
        Users storage user1= user[msg.sender];
        require(msg.value > 0, "invalid amount");
        user1.owner = msg.sender;
        user1.accountBalance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function Bet(string memory _choice)external {
        Users storage user1 = user[msg.sender];
        Choice storage user1choice = usersChoice[msg.sender];

    }
    function getResult() external{}
    function claim() external{}
    function reward() external{}
}
