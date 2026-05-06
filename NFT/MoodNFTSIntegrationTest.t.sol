// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {MoodNFTS} from "../../src/MoodNFTS.sol";

contract MoodNFTSIntegrationTest is Test {
    MoodNFTS moodNfts;

    // ✅ FIX: Dono raw base64 hain — prefix NAHI
    // Contract tokenURI() mein khud "data:image/svg+xml;base64," add karta hai
    string public constant HAPPY_SVG_IMAGE_URI =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj4gaGkhIHlvdSBkZWNvZGVkIHRoaXMhIDwvdGV4dD4KPC9zdmc+";

    // ✅ FIX: "data:image/svg+xml;base64," hatao yahan se
    string public constant SAD_SVG_IMAGE_URI =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KICA8IS0tIGZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iMjUwIiBjeT0iMjUwIiByPSIyMDAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBleWVzIC0tPgogIDxjaXJjbGUgY3g9IjIwMCIgY3k9IjIyMCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgogIDxjaXJjbGUgY3g9IjMwMCIgY3k9IjIyMCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIHNtaWxlIC0tPgogIDxwYXRoIGQ9Ik0xODAgMzAwIFEyNTAgMzcwIDMyMCAzMDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMTAiIGZpbGw9Im5vbmUiLz4KPC9zdmc+";

    address USER = makeAddr("user");

    function setUp() public {
        address priceFeed = address(1); // dummy

moodNfts = new MoodNFTS(
    SAD_SVG_IMAGE_URI,
    HAPPY_SVG_IMAGE_URI,
    priceFeed
);
    }

    function testViewTokenURIIntegration() public {
        vm.prank(USER);
        moodNfts.mintNFTS();

        string memory uri = moodNfts.tokenURI(0);
        console.log(uri);
        assert(bytes(uri).length > 0);
    }

    function testFlipMoodIntegration() public {
        vm.prank(USER);
        moodNfts.mintNFTS();

        string memory beforeUri = moodNfts.tokenURI(0);

        vm.prank(USER);
        moodNfts.flipMood(0);

        string memory afterUri = moodNfts.tokenURI(0);

        assert(
            keccak256(abi.encodePacked(beforeUri)) !=
            keccak256(abi.encodePacked(afterUri))
        );
    }
}