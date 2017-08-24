pragma solidity ^0.4.11;

// https://solidity.readthedocs.io/en/latest/solidity-by-example.html

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

  /// Create a simple auction with '_biddingTime'
  /// seconds bidding time on behalf of the
  /// beneficiary address '_beneficiary'

  function SimpleAuction(uint _biddingTime, address _beneficiary) {
    beneficiary = _beneficiary;
    auctionStart = now;
    biddingTime = _biddingTime;
  }

  /// Bid on the auction with the value sent
  /// together with this transaction.
  /// The value will only be refunded if the
  /// auction is not won.
  function bid() payable {
    require(now <= (auctionStart + biddingTime));
    require(msg.value > highestBid);

    if (highestBidder != 0) {
      pendingReturns[highestBidder] += highestBid;
    }

    highestBidder = msg.sender;
    highestBid = msg.value;

    HighestBidIncreased(msg.sender, msg.value);
  }

  /// Withdraw a bid that was overbid.
  function withdraw() returns (bool) {
    uint amount = pendingReturns[msg.sender];
    if (amount > 0) {
      pendingReturns[msg.sender] = 0;

      if (!msg.sender.send(amount)) {
        pendingReturns[msg.sender] = amount;
        return false;
      }
    }

    return true;
  }

  /// End the auction and send the highest bid
  /// to the beneficiary.

  function auctionEnd() {
    require(now >= (auctionStart + biddingTime));
    require(!ended);

    ended = true;
    AuctionEnded(highestBidder, highestBid);

    beneficiary.transfer(highestBid);
  }


// Ending of the contract
}
