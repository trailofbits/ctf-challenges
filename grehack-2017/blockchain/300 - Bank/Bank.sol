/*

Binary: 
60606040526000600160006101000a81548160ff021916908315150217905550341561002a57600080fd5b5b61004661004c64010000000002610785176401000000009004565b5b61008f565b336001806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b565b6107f48061009e6000396000f30060606040523615610081576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806341c0e1b514610085578063473ca96c1461009a578063a3a7e7f3146100af578063a9059cbb146100e8578063c0e317fb1461012a578063da76d5cd14610134578063f8b2cb4f14610157575b5b5b005b341561009057600080fd5b6100986101a4565b005b34156100a557600080fd5b6100ad610259565b005b34156100ba57600080fd5b6100e6600480803573ffffffffffffffffffffffffffffffffffffffff169060200190919050506102a9565b005b34156100f357600080fd5b610128600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091908035906020019091905050610446565b005b6101326105bd565b005b341561013f57600080fd5b610155600480803590602001909190505061060c565b005b341561016257600080fd5b61018e600480803573ffffffffffffffffffffffffffffffffffffffff1690602001909190505061073c565b6040518082815260200191505060405180910390f35b6001809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156101ff57600080fd5b3373ffffffffffffffffffffffffffffffffffffffff166108fc3073ffffffffffffffffffffffffffffffffffffffff16319081150290604051600060405180830381858888f19350505050151561025657600080fd5b5b565b60003073ffffffffffffffffffffffffffffffffffffffff163114156102a6577f29822734f2619c764b25a111ff2328da08e02d6652fc891eb80227a6ec58774360405160405180910390a15b5b565b6000808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546000808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054011015151561037457600080fd5b6000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546000808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000828254019250508190555060008060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055505b50565b806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541015151561049357600080fd5b6000808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054816000808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054011015151561052057600080fd5b806000808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282540192505081905550806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825403925050819055505b5050565b346000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825401925050819055505b565b60001515600160009054906101000a900460ff16151514151561062e57600080fd5b60018060006101000a81548160ff021916908315150217905550806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541015151561069557600080fd5b3373ffffffffffffffffffffffffffffffffffffffff168160405160006040518083038185876187965a03f19250505015156106d057600080fd5b806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825403925050819055505b6000600160006101000a81548160ff0219169083151502179055505b50565b60008060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205490505b919050565b336001806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b5600a165627a7a723058206485fea87c9d0857359f1c3adebf9a9ec21c04294d8f995350798622a99486600029
Contract JSON ABI 
[{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"win","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"}],"name":"transferAll","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"amount","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"addToBalance","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"}],"name":"withdrawBalance","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"u","type":"address"}],"name":"getBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[],"name":"Win","type":"event"}]



*/
pragma solidity ^0.4.16;

contract Bank {
    mapping (address => uint) userBalance;
    bool protection = false;
    address owner;

    event Win();
    
    function Bank(){
        initBank();
    }

    function initBank() private{
        owner = msg.sender;
    }

    function () payable {}
    
    function win() public{
        if(this.balance ==0){
            Win();
        }
    }
   
    modifier no_reentrancy(){
        require(protection == false);
        protection = true;
        _;
        protection = false;
    }
   
    function getBalance(address u) constant  public returns(uint) {
        return userBalance[u];
    }

    function addToBalance() payable  public{	
        userBalance[msg.sender] += msg.value;
    }   
    
    function transfer(address to, uint amount){
        require(userBalance[msg.sender] >= amount);
        require(userBalance[to] + amount >= userBalance[to]);
        userBalance[to] += amount;
        userBalance[msg.sender] -= amount;
    }
    
    function transferAll(address to){
        require(userBalance[to] + userBalance[msg.sender] >= userBalance[to]);
        userBalance[to] += userBalance[msg.sender];
        userBalance[msg.sender] = 0;
    }

    function withdrawBalance(uint amount) no_reentrancy() public {
        require(userBalance[msg.sender] >= amount);
        if( ! (msg.sender.call.value(amount)() ) ){
            revert();
        }
        userBalance[msg.sender] -= amount;
    }   
    
    function kill(){
        require(msg.sender == owner);
        msg.sender.transfer(this.balance);
    }
}
