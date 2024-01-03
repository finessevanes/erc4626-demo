// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Import ERC20 and Ownable contracts from the OpenZeppelin library
import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/access/Ownable.sol";

/**
 * @title MockUSDC
 * @dev A mock USDC token contract for testing and development purposes.
 *      Inherits ERC20 and Ownable for standard token functionality and ownership features.
 */
contract MockUSDC is ERC20, Ownable {
    /**
     * @notice Constructor to create MockUSDC token
     * @dev Sets the initial token name to "MockUSDC", symbol to "mUSDC", and mints 100 tokens to the deployer.
     */
    constructor() ERC20("MockUSDC", "mUSDC") Ownable(msg.sender) {
        _mint(msg.sender, 100e18);
    }

    /**
     * @notice Allows the contract owner to mint new tokens.
     * @param to The address that will receive the minted tokens.
     * @param amount The number of tokens to be minted.
     * @dev Accessible only by the contract owner.
     */
    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
