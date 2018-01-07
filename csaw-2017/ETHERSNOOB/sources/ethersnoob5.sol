pragma solidity ^0.4.16;

contract Storage{
  uint storedData;

  uint flag;
  
function set(uint data, uint data2, uint data3) {
    storedData = 4*((data**data2) - data3);
  }
  

function get_flag() constant returns (string){
		if (flag == 0x1337){
			return "[CONGRATZ] You beat chal1, show this to a judge.";
		}
		return "get me a 0x1337 for a flag!";
	}

function get() constant returns (uint) {
	uint res = storedData + 0x593d;
	flag = 0x101;

	if(res == 0xba1){
		flag = 0x1337;
	}
	
	return res;
  }
}
