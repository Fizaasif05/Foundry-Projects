// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNFTS} from "../src/MoodNFTS.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFTS is Script {

    function run() external returns (MoodNFTS) {

        // 📁 SVG files read
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        // 🔗 Sepolia ETH/USD Price Feed
        address priceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

        vm.startBroadcast();

        MoodNFTS moodNfts = new MoodNFTS(
            svgToBase64(sadSvg),
            svgToBase64(happySvg),
            priceFeed
        );

        vm.stopBroadcast();

        return moodNfts;
    }

    // 🔁 SVG → Base64 (RAW, no prefix)
    function svgToBase64(string memory svg) public pure returns (string memory) {
        return Base64.encode(bytes(svg));
    }
}