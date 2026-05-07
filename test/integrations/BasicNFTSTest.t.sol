//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DeployBasicNFTS} from "../../script/DeployBasicNFTS.s.sol";
import {Test} from "forge-std/Test.sol";
import {BasicNFTS} from "../../src/BasicNFTS.sol";

contract BasicNFTSTest is Test {
    DeployBasicNFTS public deployer;
    BasicNFTS public basicNFTS;
    address public USER = makeAddr("user");
    string public constant PUG = "https://ipfs.io/ipfs/bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4";

    function setUp() public {
        deployer = new DeployBasicNFTS();
        basicNFTS = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFTS.name();
    
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
            keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
    vm.prank(basicNFTS.owner());

    basicNFTS.mintNFTS(PUG);

    // owner has NFT
    assert(basicNFTS.balanceOf(basicNFTS.owner()) == 1);

    // tokenURI check
    assert(
        keccak256(abi.encodePacked(PUG)) ==
        keccak256(abi.encodePacked(basicNFTS.tokenURI(0)))
    );
}
}