// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import {EVSController} from "../src/EVSController.sol";
import {DepositWETH} from "../src/DepositWETH.sol";

interface IWETH {
    function deposit() external payable;
    function approve(address spender, uint256 amount) external returns (bool);
}

contract Interactions is Script {

    function run() external {

        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        // 🔹 UPDATE THESE AFTER DEPLOY
        address weth = 0xdd13E55209Fd76AfE204dBda4007C227904f0a81;
        address deposit = 0x6D8A607ef81a912a0B520f900406Da557ed4E21b;
        address controller = 0xd370dD486f969B18845Fd2b58Ac2A91Fad5b5d1C;

        uint256 amount = 0.1 ether;

        // 1️⃣ ETH → WETH
        IWETH(weth).deposit{value: amount}();

        // 2️⃣ approve DepositWETH
        IWETH(weth).approve(deposit, amount);

        // 3️⃣ deposit into system
        DepositWETH(deposit).deposit(msg.sender, amount);

        // 4️⃣ mint tokens
        EVSController(controller).depositAndMint(amount);

        vm.stopBroadcast();
    }
}