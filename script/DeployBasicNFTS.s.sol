//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {BasicNFTS} from "../src/BasicNFTS.sol";

contract DeployBasicNFTS is Script {
    function run() external returns(BasicNFTS) {
        vm.startBroadcast();
        BasicNFTS basicNFTS = new BasicNFTS();
        vm.stopBroadcast();
        return basicNFTS;
    }
}