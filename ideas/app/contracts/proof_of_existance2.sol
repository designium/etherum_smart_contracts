pragma solidity ^0.4.7;

//Proof of Existence contract, version 1
contract ProofExist2 {
  //state
  bytes32[] public proofs;

  function storeProof(bytes32 proof) {
    proofs.push(proof);
  }

  // calculate and store the proof for a document
  // * transactional function *
  function notarize(string document) {
    var proof = calculateProof(document);
    storeProof(proof);
  }

  //helper function to get a document's sha256
  //read only function

  function calculateProof(string document) constant returns (bytes32) {
    return sha256(document);
  }

  function checkDocument(string document) constant returns(bool) {
    var proof = calculateProof(document);
    return hasProof(proof);
  }

  function hasProof(bytes32 proof) constant returns (bool) {
    for (var i=0; i < proofs.length; i++) {
      if(proofs[i] == proof) {
        return true;
      }
    }
    return false;
  }
}
