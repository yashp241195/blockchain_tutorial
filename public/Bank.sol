// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;


// ********** Quick Bank 

contract Bank {
    
    int bal;
    
    constructor() public {
        bal = 1;
    }
    
    function getBalance() view public returns(int){
        return bal;
    }
    
    function withdraw(int amount) public{
        bal = bal - amount;
    }
    
    function deposit(int amount) public{
        bal = bal + amount;   
    }

}
