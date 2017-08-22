var assert = require('assert');
var Embark = require('embark');
var EmbarkSpec = Embark.initTests();
var web3 = EmbarkSpec.web3;

describe("MDBService", function() {
  before(function(done) {
    this.timeout(0);
    EmbarkSpec.deployAll({}, done);
  });

  // write tests here.

  it("Should be empty after deployment", function(done) {
    MDBService.register({gas:900000}, function(err, result) {
      MDBService.getNbAccounts(function(err, result) {
        assert.equal(result.toNumber(), 1);
        done();
      });
    });
  });

  it("A user can register an account", function(done) {
    MDBService.register({gas: 900000}, function(err, result) {
      MDBService.getNbAccounts(function(err, result) {
        assert.equal(result.toNumber(), 1);
        done();
      });
    });
  });

  it("Retrieving the account address should be the same and different from 0x0", function(done) {
    web3.eth.getAccounts(function(err, accounts) {
      MDBService.getAccount(accounts[0], function(err, accountaddress) {
        MDBService.getAccountId(0, function(err, accountaddressid) {
          assert.equal(accountaddress, accountaddressid);
          assert.notEqual(accountaddress, '0x0000000000000000000000000000000000000000');
            done();
        });
      });
    });
  });


  it("A user can't register more than once account", function(done) {
    MDBService.register({gas: 900000}, function(err, result) {
      MDBService.getNbAccounts(function(err, result) {
        assert.equal(result.toNumber(), 1);
        done();
      });
    });
  });



    });
