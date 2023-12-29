// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "openzeppelin-contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

contract YieldToken is ERC20, Ownable {
    constructor() ERC20("YieldToken", "YT") Ownable(msg.sender) {}

    function generateYield(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}