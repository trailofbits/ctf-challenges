/*

Binary: 
6060604052341561000f57600080fd5b5b6108bd8061001f6000396000f30060606040523615610081576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680630fbc0cd114610085578063473ca96c146100cb5780634e272768146100e0578063527749a4146100ea578063c79568461461010f578063dbf2f3c214610160578063fde7c834146101ad575b5b5b005b341561009057600080fd5b6100c9600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091908035600019169060200190919050506101db565b005b34156100d657600080fd5b6100de61044b565b005b6100e861049b565b005b61010d600480803590602001909190803560001916906020019091905050610586565b005b341561011a57600080fd5b610146600480803573ffffffffffffffffffffffffffffffffffffffff169060200190919050506106e7565b604051808215151515815260200191505060405180910390f35b341561016b57600080fd5b610197600480803573ffffffffffffffffffffffffffffffffffffffff1690602001909190505061073e565b6040518082815260200191505060405180910390f35b6101d9600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091905050610787565b005b60008060001515600260008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff16151514151561023d57600080fd5b60028360006040516020015260405180826000191660001916815260200191505060206040518083038160008661646e5a03f1151561027b57600080fd5b5050604051805190509150600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546000191682600019161415156102db57600080fd5b60026000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205481151561032557fe5b0490508373ffffffffffffffffffffffffffffffffffffffff166108fc829081150290604051600060405180830381858888f19350505050151561036857600080fd5b3373ffffffffffffffffffffffffffffffffffffffff166108fc829081150290604051600060405180830381858888f1935050505015156103a857600080fd5b6001600260008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff02191690831515021790555060008060008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055505b50505050565b60003073ffffffffffffffffffffffffffffffffffffffff16311415610498577f29822734f2619c764b25a111ff2328da08e02d6652fc891eb80227a6ec58774360405160405180910390a15b5b565b60008060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506000600102600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002081600019169055506000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff0219169083151502179055505b565b81341115151561059557600080fd5b60008060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541415156105e257600080fd5b6000341115156105f157600080fd5b6002828115156105fd57fe5b0682036000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555080600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002081600019169055506000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff0219169083151502179055505b5050565b6000600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff1690505b919050565b60008060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205490505b919050565b60001515600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff1615151415156107e657600080fd5b60008060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205411151561083357600080fd5b60023481151561083f57fe5b0634036000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825401925050819055505b505600a165627a7a72305820b11f4acf87c33cd87700e9327d9392ae5dd47670b2f72a4b70930106f5038e5e0029
Contract JSON ABI 
[{"constant":false,"inputs":[{"name":"chall","type":"address"},{"name":"solution","type":"bytes32"}],"name":"bounty_solve","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"win","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"remove_bounty","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"reward","type":"uint256"},{"name":"chall","type":"bytes32"}],"name":"add_bounty","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"chall","type":"address"}],"name":"get_solved","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"chall","type":"address"}],"name":"get_reward","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"chall","type":"address"}],"name":"increase_bounty","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[],"name":"Win","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"","type":"bytes32"}],"name":"Hash","type":"event"}]


*/


pragma solidity ^0.4.16;

contract Bounty{
    mapping(address => uint) rewards;
    mapping(address => bytes32) challs;
    mapping(address => bool) solved;

    event Win();

    event Hash(bytes32);

    function win() public{
        if(this.balance ==0){
            Win();
        }
    }

    function () payable {}

    function get_reward(address chall) returns(uint){
        return rewards[chall];
    }

    function get_solved(address chall) returns(bool){
        return solved[chall];
    }

    function add_bounty(uint reward, bytes32 chall) payable  public{
        require(msg.value <= reward);
        require(rewards[msg.sender]== 0);
        require(msg.value>0);

        rewards[msg.sender] = reward - reward%2;
        challs[msg.sender] = chall;
        solved[msg.sender] = false;

    }

    function increase_bounty(address chall) payable  public{
        require(solved[chall] == false);
        require(rewards[msg.sender]>0);
        rewards[msg.sender] += msg.value - msg.value%2;
    }

    function remove_bounty() payable  public{
        rewards[msg.sender] = 0;
        challs[msg.sender] = 0;
        solved[msg.sender] = false;
    }

    function bounty_solve(address chall, bytes32 solution)  public{
        require(solved[chall] == false);
        bytes32 hash = sha256(solution);
        require(hash == challs[chall]);

        uint reward = rewards[msg.sender] / 2;
        chall.transfer(reward);

        msg.sender.transfer(reward);

        solved[chall] = true;
        rewards[chall] = 0x0;
    }
}
