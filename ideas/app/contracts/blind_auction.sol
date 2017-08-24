pragma solidity ^0.4.11;

contract BlindAuction {
  struct Bid {
    bytes32 blindedBid;
    uint deposit;
  }

  address public beneficiary;
  uint public auctionStart;
  uint public bliddingEnd;
  uint public revealEnd;
  bool public ended;

  mapping(address => Bid[]) public bids;

  address public highestBidder;
  uint public highestBid;

  mapping(address => uint) pendingReturns;

  event AuctionEnded(address winner, uint highestBid);



  // end of the contract
}
