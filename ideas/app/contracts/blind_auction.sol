pragma solidity ^0.4.11;

contract BlindAuction {
  struct Bid {
    bytes32 blindedBid;
    uint deposit;
  }

  address public beneficiary;
  uint public auctionStart;
  uint public biddingEnd;
  uint public revealEnd;
  bool public ended;

  mapping(address => Bid[]) public bids;

  address public highestBidder;
  uint public highestBid;

  mapping(address => uint) pendingReturns;

  event AuctionEnded(address winner, uint highestBid);

  modifier onlyBefore(uint _time) { require(now < _time); _; }
  modifier onlyAfter(uint _time) { require(now > _time); _; }

  function BlindAuction(
    uint _biddingTime,
    uint _revealTime,
    address _beneficiary
    ) {
    beneficiary = _beneficiary;
    auctionStart = now;
    biddingEnd = now + _biddingTime;
    revealEnd = biddingEnd + _revealTime;
  }

  function bid(bytes32 _blindedBid)
    payable
    onlyBefore(biddingEnd) {
    bids[msg.sender].push(Bid({
      blindedBid: _blindedBid,
      deposit: msg.value
      }));
  }

  function reveal( uint[] _values, bool[] _fake, bytes32[] _secret) onlyAfter(biddingEnd) onlyBefore(revealEnd) {
    uint length = bids[msg.sender].length;
    require(_values.length == length);
    require(_fake.length == length);
    require(_secret.length == length);

    uint refund;

    for (uint i = 0; i < length; i++) {
      var bid = bids[msg.sender][i];
      var (value, fake,secret) = (_values[i], _fake[i], _secret[i]);
      if (bid.blindedBid != keccak256(value, fake, secret)) {
        continue;
      }
      refund += bid.deposit;
      if (!fake && bid.deposit >= value) {
        if (placeBid(msg.sender, value))
          refund -= value;
      }
      bid.blindedBid = bytes32(0);
    }
    msg.sender.transfer(refund);
  }

  function placeBid(address bidder, uint value) internal returns (bool success) {
    if (value <= highestBid) {
      pendingReturns[highestBidder] += highestBid;
    }
    highestBid = value;
    highestBidder = bidder;
    return true;
  }

  function withdraw() {
    uint amount = pendingReturns[msg.sender];
    if (amount > 0) {
      pendingReturns[msg.sender] = 0;

      msg.sender.transfer(amount);
    }
  }

  function auctionEnd() onlyAfter(revealEnd) {
    require(!ended);
    AuctionEnded(highestBidder, highestBid);
    ended = true;
    beneficiary.transfer(this.balance);
  }

  // end of the contract
}
