// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {MyToken} from "./MyToken.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract EVSController {

    MyToken public token;
    AggregatorV3Interface public priceFeed;

    // 1 MTK = $5 USD (Chainlink 8 decimals)
    uint256 public constant TOKEN_PRICE_USD = 5 * 1e8;

    constructor(
        address _token,
        address _priceFeed
    ) {
        token = MyToken(_token);
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function depositAndMint(uint256 wethAmount) external {

        require(wethAmount > 0, "Invalid amount");

        // 1️⃣ Get ETH/USD price (8 decimals)
        (, int256 price,,,) = priceFeed.latestRoundData();
        require(price > 0, "Invalid price");

        uint256 ethPrice = uint256(price);

        // 2️⃣ Convert ETH → USD value
        uint256 usdValue = (ethPrice * wethAmount) / 1e18;

        // 3️⃣ Calculate tokens ($5 per token)
        uint256 mintAmount = usdValue / TOKEN_PRICE_USD;

        require(mintAmount > 0, "Too small to mint");

        // 4️⃣ Mint tokens
        token.mint(msg.sender, mintAmount);
    }
}