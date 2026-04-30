//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DepositWETH {

    IERC20 public immutable WETH;

    mapping(address => uint256) public balances;

    constructor(address _weth) {
        WETH = IERC20(_weth);
    }

    function deposit(address user, uint256 amount) external {
        require(amount > 0, "Invalid amount");

        require(
            WETH.transferFrom(user, address(this), amount),
            "Transfer failed"
        );

        balances[user] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        require(
            WETH.transfer(msg.sender, amount),
            "Withdraw failed"
        );
    }
}