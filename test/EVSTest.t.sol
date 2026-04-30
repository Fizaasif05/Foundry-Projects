// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

import {MyToken} from "../src/MyToken.sol";
import {DepositWETH} from "../src/DepositWETH.sol";
import {EVSController} from "../src/EVSController.sol";
import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockWETH is ERC20 {
    constructor() ERC20("WETH", "WETH") {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract EVSTest is Test {

    MyToken token;
    DepositWETH deposit;
    EVSController controller;
    MockV3Aggregator feed;
    MockWETH weth;

    address user = address(1);

    function setUp() public {

        weth = new MockWETH();

        // ETH = $2000
        feed = new MockV3Aggregator(8, 2000 * 1e8);

        token = new MyToken();
        deposit = new DepositWETH(address(weth));

        controller = new EVSController(
            address(token),
            address(deposit),
            address(feed)
        );

        token.transferOwnership(address(controller));

        weth.mint(user, 10 ether);
    }

    function testDepositAndMint() public {
        vm.startPrank(user);

        // ✅ IMPORTANT: approve deposit (NOT controller)
        weth.approve(address(deposit), 1 ether);

        controller.depositAndMint(1 ether);

        vm.stopPrank();

        assertGt(token.balanceOf(user), 0);
    }
}