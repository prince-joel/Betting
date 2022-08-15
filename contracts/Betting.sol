// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Betting{
    event PlaceBet(address caller, uint choice);
    event Deposit(address caller, uint amount);
    event Launch(uint ID, uint32 StartAt, uint32 EndAt);

    
        // string result;

         uint public time = block.timestamp;

    struct Bet{
        uint  betAmount;
        address owner;
        uint accountBalance;
        uint reward;
        bool hasPlacedBet;
        Status  choice;

    }

    enum Status {
        homeWin,
        awayLoose,
        draw
    }
    mapping(address => Bet) public usersBet;

    struct Matchs{
        uint matchID;
        uint startAt;
        uint endAt;
        uint  TotalBetAmount;
        Outcome outcome;

    }
    mapping(address => Bet) winners;
    mapping(uint => Matchs) public game;

    enum Outcome{
        homeWin,
        awayLoose,
        draw
    }

    enum Result{
        Success,
        failed
    }
    Result  result;

    

    function deposit() payable external{
        require(msg.value >= 1 ether, "invalid amount");
        Bet memory myBet = usersBet[msg.sender];
        myBet.owner = msg.sender;
        myBet.accountBalance = myBet.accountBalance + msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function launch(uint _ID, uint32 _startAt, uint32 _endAt) external {
        Matchs memory match1 = game[_ID];
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= _startAt + 90 minutes, "end at > max duration");
        match1.startAt = _startAt;
        match1.endAt = _endAt;
        match1.matchID = _ID;
        emit Launch(_ID, _startAt, _endAt);

    }
    function bet(uint _ID, Status _choice, uint amount) payable external {
        Bet memory myBet = usersBet[msg.sender];
       Matchs memory match1 = game[_ID];
        require(block.timestamp <= match1.endAt, "ended");
        myBet.choice = _choice;
        myBet.betAmount += amount;
        match1.TotalBetAmount = match1.TotalBetAmount + amount;
        myBet.accountBalance = myBet.accountBalance - amount;
        myBet.hasPlacedBet = true;
        emit PlaceBet(msg.sender, amount); 
    }

    function getResult(uint _ID) external view returns( Result){
      Matchs memory match1 = game[_ID];
      Bet memory myBet = usersBet[msg.sender];
     require(match1.endAt >= block.timestamp + 90 minutes, "Has not ended");
      require(myBet.hasPlacedBet == true, "Bet first");
    //   uint8 betChoice = uint8(myBet.choice);
      if (keccak256(abi.encodePacked(myBet.choice )) == keccak256(abi.encodePacked(match1.outcome))) {
            return Result(0);
        }else {
            return Result(1);
        }
   
    }
    function claim(uint _ID) external{
    }

    function reward(uint _ID) external{
        Matchs storage match1 = game[_ID];
        Bet storage myBet = usersBet[msg.sender];

        myBet.reward = myBet.betAmount / match1.TotalBetAmount * 100;
    }
}
