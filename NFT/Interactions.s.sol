// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNFTS} from "../src/BasicNFTS.sol";

contract MintBasicNFTS is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address contractAddress = 0xe10D320D023AAE06bf98c8334112d7711BD936bF;

        vm.startBroadcast();
        BasicNFTS(contractAddress).mintNFTS(PUG_URI);
        vm.stopBroadcast();
    }
}