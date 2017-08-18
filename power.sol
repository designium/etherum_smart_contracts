pragma solidity ^0.4.11;

contract power {
  uint value;

  /* this function is executed at initializatin of the contract */
  function power(uint number, uint p) {
    value = number ** p;
  }

  function getPower() constant returns (uint) {
    return value;
  }
}
