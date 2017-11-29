pragma solidity ^0.4.16;

contract Casino {
    address owner = msg.sender;
    event CasinoFlag();
    event GenRandom(address player);
    mapping (address => uint16) internal bets;
    mapping (address => bool) public players;

    function bet() public payable {
        require(msg.value >= 1 ether);
        require(players[msg.sender] == false);
        players[msg.sender] = true;
        bets[msg.sender] = 0;
        GenRandom(msg.sender);
    }

    function sendNumber(uint16 random_number, address player_address) public {
        require(msg.sender == owner);
        require(players[player_address]);
        bets[player_address] = random_number;
    }

    function guessNumber(uint16 guess) public {
        require(players[msg.sender]);
        require(bets[msg.sender] != 0);
        players[msg.sender] = false;
        if (bets[msg.sender] == guess) {
          msg.sender.transfer(this.balance);
          CasinoFlag();
        }
        bets[msg.sender] = 0;
    }
}
