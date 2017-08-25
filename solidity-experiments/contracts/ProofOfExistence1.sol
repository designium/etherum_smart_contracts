pragma solidity ^0.4.4;

contract ProofOfExistence1 {

  bytes32 public proof;


  function notarize(string document) {
    proof = calculateProof(document);
  }

  function calculateProof(string document) constant returns (bytes32) {
    return sha256(document);
  }
}
