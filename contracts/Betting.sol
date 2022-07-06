//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Bet {
    address public player;
    bool public Win;
    bool public Loose;
    bool public Draw;
    

    receive() external payable{}

    function placeBet() external {}

    function result() external {}

    function claimWins() external public
}