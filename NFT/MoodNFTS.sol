// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {AggregatorV3Interface} 
from "@chainlink-brownie-contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract MoodNFTS is ERC721, Ownable {

    error MoodNFT_CantFlipMoodIfNotOwnerOrApproved();
    error MoodNFT_InsufficientETH();

    uint256 private s_tokenCounter;
    string private s_sadSVGImageUri;
    string private s_happySVGImageUri;

    AggregatorV3Interface public priceFeed;

    uint256 public constant MINT_PRICE_USD = 10 * 1e18;

    mapping(uint256 => Mood) public s_tokenIdToMood;

    enum Mood {
        HAPPY,
        SAD
    }

    constructor(
        string memory sadSVGImageUri,
        string memory happySVGImageUri,
        address _priceFeed
    ) ERC721("Mood NFTS", "MN") Ownable(msg.sender) {
        s_tokenCounter = 0;
        s_sadSVGImageUri = sadSVGImageUri;
        s_happySVGImageUri = happySVGImageUri;
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    // -------------------------
    // PRICE FUNCTIONS
    // -------------------------

    function getEthPrice() public view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price) * 1e10; // 8 decimals
    }

    function getMintPriceInETH() public view returns (uint256) {
        uint256 ethPrice = getEthPrice();
        return (MINT_PRICE_USD * 1e18) / ethPrice;
    }

    // -------------------------
    // MINT
    // -------------------------

    function mintNFTS() public payable {
    uint256 mintPrice = getMintPriceInETH();

    if (msg.value < mintPrice) {
        revert MoodNFT_InsufficientETH();
    }

    // mint NFT
    _mint(msg.sender, s_tokenCounter);
    s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
    s_tokenCounter++;

    // 💸 REFUND EXTRA ETH
    uint256 refund = msg.value - mintPrice;

    if (refund > 0) {
        (bool success, ) = payable(msg.sender).call{value: refund}("");
        require(success, "Refund failed");
    }
}

    // -------------------------
    // FLIP MOOD
    // -------------------------

    function flipMood(uint256 tokenId) public {
        address owner = ownerOf(tokenId);

        if (!_isAuthorized(owner, msg.sender, tokenId)) {
            revert MoodNFT_CantFlipMoodIfNotOwnerOrApproved();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    // -------------------------
    // TOKEN URI
    // -------------------------

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_ownerOf(tokenId) != address(0), "Nonexistent token");

        string memory imageURI = s_happySVGImageUri;

        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = s_sadSVGImageUri;
        }

        string memory json = Base64.encode(
            bytes(
                abi.encodePacked(
                    '{"name":"Mood NFT",',
                    '"description":"An NFT that reflects mood on-chain",',
                    '"attributes":[{"trait_type":"mood","value":"dynamic"}],',
                    '"image":"data:image/svg+xml;base64,',
                    imageURI,
                    '"}'
                )
            )
        );

        return string(abi.encodePacked(_baseURI(), json));
    }

    // -------------------------
    // WITHDRAW
    // -------------------------

    function withdraw() public onlyOwner {
        (bool success, ) = payable(owner()).call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}