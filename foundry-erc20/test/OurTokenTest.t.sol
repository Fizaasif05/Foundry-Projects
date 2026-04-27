//SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import "../src/OurToken.sol";
contract OurTokenTest is Test {

    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice"); 

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
       deployer = new DeployOurToken();
       ourToken = deployer.run();

         vm.prank(msg.sender);
            ourToken.transfer(bob, STARTING_BALANCE);
    }
    
    function testBobBalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob), "Bob should have the correct balance");
    } 

    function testAllowances() public {
        uint256 allowanceAmount = 1000;
        vm.prank(bob);

        ourToken.approve(alice, allowanceAmount);
        vm.prank(alice);

        ourToken.transferFrom(bob, alice, 500);
        assertEq(ourToken.balanceOf(alice), 500, "Alice should have received the transferred tokens");
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - 500, "Bob's balance should be reduced by the transfer amount");
        assertEq(ourToken.allowance(bob, alice), allowanceAmount - 500, "Allowance should be reduced by the transfer amount"); 
    }
}