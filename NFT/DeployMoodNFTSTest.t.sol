//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFTS} from "../../script/DeployMoodNFTS.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFTSTest is Test {
    DeployMoodNFTS public deployer;

    function setUp() public {
        deployer = new DeployMoodNFTS();
    } 

    function testConvertSvgToURI() public view{
        string memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj4gaGkhIHlvdSBkZWNvZGVkIHRoaXMhIDwvdGV4dD4KPC9zdmc+";
        string memory svg = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"500\" height=\"500\">\n<text x=\"0\" y=\"15\" fill=\"black\"> hi! you decoded this! </text>\n</svg>";
        string memory actualURI =  deployer.svgToBase64(svg);
        assert(
            keccak256(abi.encodePacked(expectedURI)) ==
            keccak256(abi.encodePacked(actualURI))
        ); 
    }
}