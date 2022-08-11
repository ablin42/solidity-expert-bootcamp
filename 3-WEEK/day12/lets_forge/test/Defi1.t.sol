// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
// Standard test libs
import "forge-std/Test.sol";
import "forge-std/Vm.sol";
// Contract under test
import {DeFi1} from "../src/Defi1.sol";

/*
Imagine you have been given the DeFi1 contract by a colleague and asked to test it
using Foundry.
Your colleague explains that the contract allows

    -investors to be added by the administrator
    -investors to claim tokens, but the amount that they can claim should reduce every 1000 blocks.

When testing make sure you know
    -how would you advance blocks
    -how would you make sure every block will work
    -how would you make sure the contract works with different starting values such as
        -block reward,
        -numbers of investors
        -initial number of tokens
*/

// interface Vm {
//     function warp(uint256) external;
// }

contract Defi1Test is Test {
    // Variable for contract instance
    DeFi1 private defi1;

    function setUp() public {
        // Instantiate new contract instance
        defi1 = new DeFi1(1000, 100);
        defi1.addInvestor(msg.sender);
    }

    function test_addInvestor() public {
        assertTrue(defi1.investors(0) == msg.sender);
        defi1.addInvestor(msg.sender);
        //! Same investor added twice, this test should fail
        assertTrue(defi1.investors(1) == msg.sender);
    }

    function test_claimTokens() public {
        defi1.claimTokens();
        // Check that the investor has received tokens
        assertTrue(defi1.balanceOf(msg.sender) == 1000);
    }

    function test_calculatePayout() public {
        emit log_uint(block.number);
        // vm.warp(100);
        // emit log_uint(block.number);

        uint256 payout = defi1.calculatePayout();
        // Check that the payout is correct

        assertTrue(payout == 1000);
    }
}
