// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {MoodNFTS} from "../../src/MoodNFTS.sol";

contract MoodNFTSTest is Test {
    MoodNFTS moodNfts;

    // ✅ FIX: Sirf raw base64 — contract khud prefix lagayega
    // "data:image/svg+xml;base64," prefix NAHI hona chahiye yahan
    string public constant HAPPY_SVG_URI =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj4gaGkhIHlvdSBkZWNvZGVkIHRoaXMhIDwvdGV4dD4KPC9zdmc+";

    string public constant SAD_SVG_URI =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KICA8IS0tIGZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iMjUwIiBjeT0iMjUwIiByPSIyMDAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBleWVzIC0tPgogIDxjaXJjbGUgY3g9IjIwMCIgY3k9IjIyMCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgogIDxjaXJjbGUgY3g9IjMwMCIgY3k9IjIyMCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIHNtaWxlIC0tPgogIDxwYXRoIGQ9Ik0xODAgMzAwIFEyNTAgMzcwIDMyMCAzMDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMTAiIGZpbGw9Im5vbmUiLz4KPC9zdmc+";

    // ✅ FIX: USER = EOA address — test contract khud mint na kare
    address USER = makeAddr("user");

    function setUp() public {
       address priceFeed = address(1); // dummy for test

moodNfts = new MoodNFTS(
    SAD_SVG_URI,
    HAPPY_SVG_URI,
    priceFeed
);
    }

    function testViewTokenURI() public {
        // ✅ FIX: vm.prank(USER) lagao — EOA mint karega, test contract nahi
        // Test contract IERC721Receiver implement nahi karta
        vm.prank(USER);
        moodNfts.mintNFTS();

        string memory uri = moodNfts.tokenURI(0);
        console.log(uri);
        assert(bytes(uri).length > 0);
    }
}