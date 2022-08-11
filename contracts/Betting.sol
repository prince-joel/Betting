// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Betting{
    event PlaceBet(address caller, uint choice);
    event Deposit(address caller, uint amount);
    event Launch(uint ID, uint32 StartAt, uint32 EndAt);

    
        // string result;
        uint public TotalBetAmount;

    struct Bet{
        uint  betAmount;
        address owner;
        uint accountBalance;
        bool hasPlacedBet;
        Status  choice;
    }

    enum Status {
        homeWin,
        homeLoose,
        awayWin,
        awayLoose,
        draw
    }
    mapping(address => Bet) public usersBet;

    struct Matchs{
        uint matchID;
        uint startAt;
        uint endAt;
        Outcome outcome;

    }

    enum Outcome{
        homeWin,
        homeLoose,
        awayWin,
        awayLoose,
        draw
    }

    enum Result{
        Success,
        failed
    }
    mapping(uint => Matchs) public game;
    Result  result;

    

    function deposit() payable external{
        require(msg.value >= 1 ether, "invalid amount");
        Bet storage myBet = usersBet[msg.sender];
        myBet.owner = msg.sender;
        myBet.accountBalance = myBet.accountBalance + msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function launch(uint _ID, uint32 _startAt, uint32 _endAt) external {
        Matchs storage match1 = game[_ID];
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 minutes, "end at > max duration");
        match1.startAt = _startAt;
        match1.endAt = _endAt;
        match1.matchID = _ID;
        emit Launch(_ID, _startAt, _endAt);

    }
    function bet(uint _ID, Status _choice, uint amount)  external {
        Bet storage myBet = usersBet[msg.sender];
       Matchs storage match1 = game[_ID];
        require(block.timestamp <= match1.endAt, "ended");
        myBet.choice = _choice;
        myBet.betAmount += amount;
        TotalBetAmount += amount;
        myBet.accountBalance = myBet.accountBalance - amount;
        myBet.hasPlacedBet = true;
        emit PlaceBet(msg.sender, amount); 
    }

    // function getResult(uint _ID) external returns(uint Result){
    //   Matchs storage match1 = game[_ID];
    //   Bet storage myBet = usersBet[msg.sender];
    //  require(match1.endAt >= block.timestamp + 90 minutes, "Has not ended");
    //   require(myBet.hasPlacedBet == true, "Bet first");
      
    //   if (myBet.choice() == match1.outcome()) {
    //         return 0;
    //     }else {
    //         return 1;
    //     }
   
    // }
    function claim() external{}
    function reward() external{}
}
