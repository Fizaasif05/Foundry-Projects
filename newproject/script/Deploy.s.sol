// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import {MyToken} from "../src/MyToken.sol";
import {EVSController} from "../src/EVSController.sol";

contract Deploy is Script {

    function run() external {

        vm.startBroadcast();

        // 1️⃣ Deploy token
        MyToken token = new MyToken();

        // 2️⃣ Chainlink ETH/USD feed
        address priceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

        // 3️⃣ Deploy controller (ONLY 2 args)
        EVSController controller = new EVSController(
            address(token),
            priceFeed
        );

        // 4️⃣ give mint rights
        token.transferOwnership(address(controller));

        vm.stopBroadcast();
    }
}