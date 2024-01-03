// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/access/Ownable.sol";

contract MockUSDC is ERC20, Ownable {
    constructor() ERC20("MockUSDC", "mUSDC") Ownable(msg.sender) {
        _mint(msg.sender, 100e18);
    }

    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}