pragma solidity ^0.4.7;

import "MDBAccount.sol";

contract MDBService {

  mapping (address => address) accounts;
  mapping (uint => address) ids;
  uint numberAccounts;

  function MDBService() {
    numberAccounts = 0;
  }

  function register() {
    require(accounts[msg.sender] == 0);
    ids[numberAccounts] = msg.sender;
    accounts[msg.sender] = new MDBAccount(msg.sender);
    numberAccounts++;
  }

  function getAccount(address adr) constant returns (address account) {
    return (accounts[adr]);
  }

  function getAccountId(uint id) constant returns (address account) {
    return (accounts[ids[id]]);
  }

  function getNbAccounts() constant returns (uint nb) {
    return (numberAccounts);
  }

}
