pragma solidity ^0.4.11;

contract Counter {

  uint count = 0;
  address owner;

  function Counter() {
    owner = msg.sender;
  }

  function increment() public {
    if (owner == msg.sender) {
      count = count + 1;
    }
  }

  function getCount() constant returns (uint) {
    return count;
  }

  function kill() {
    if (owner == msg.sender) {
      selfdestruct(owner);
    }
  }

}
