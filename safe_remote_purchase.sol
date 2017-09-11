pragma solidity ^0.4.11;

contract Purchase {
  uint public value;
  address public seller;
  address public buyer;
  enum State { Created, Locked, Inactive }
  State public state;



  // end of contract
}
