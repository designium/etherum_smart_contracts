pragma solidity ^0.4.11;

contract Counter {

    /* define variable count of the type uint */
    uint count = 0;

    /* this runs when the contract is executed */
    function increment() public {
       count = count + 1;
    }

    /* used to read the value of count */
    function getCount() constant returns (uint) {
       return count;
    }

}
