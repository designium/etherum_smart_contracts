pragma solidity ^0.4.11;

contract Purchase {
  uint public value;
  address public seller;
  address public buyer;
  enum State { Created, Locked, Inactive }
  State public state;

  function Purchase() payable {
    seller = msg.sender;
    value = msg.value / 2;
    require((2 * value) == msg.value);
  }

  modifier condition(bool _condition) {
    require(_condition);
    _;
  }

  modifier onlyBuyer() {
    require(msg.sender == buyer);
    _;
  }

  modifier onlySeller() {
    require(msg.sender == seller);
    _;
  }

  modifier inState(State _state) {
    require(state == _state);
    _;
  }



  // end of contract
}
