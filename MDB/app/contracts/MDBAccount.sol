pragma solidity ^0.4.7;

contract MDBAccount {
  struct Post {
    uint timestamp;
    string message;
  }

  uint public numberPosts;
  address public owner;
  mapping (uint => Post) posts;

  modifier isOwner() {
    require(owner == msg.sender);
    _;
  }

  function MDBAccount(address _owner) {
    owner = _owner;
    numberPosts = 0;
  }

  function post(string message) isOwner() {
    require(bytes(message).length <= 160);
    posts[numberPosts].timestamp = now;
    posts[numberPosts].message = message;
    numberPosts++;
  }

  function getPost(uint postId) constant returns (string message, uint timestamp) {
    require(postId < numberPosts);
    message = posts[postId].message;
    timestamp = posts[postId].timestamp;
  }

  function getOwnerAddress() constant returns (address _owner) {
    return owner;
  }

  function getNumberPosts() constant returns (uint _numberPosts) {
    return numberPosts;
  }

}
