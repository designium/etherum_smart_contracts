pragma solidty ^0.4.11;

contract SimpleAuction {
  address public beneficiary;
  uint public auctionStart;
  uint public biddingTime;

  address public highestBidder;
  uint public highestBid;

  mapping(address => uint) pendingReturns;

  bool ended;

  event HighestBidIncreased(address bidder, uint amount);
  event AuctionEnded(address winner, uint amount);



// Ending of the contract
}
