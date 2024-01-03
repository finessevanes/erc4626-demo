//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC4626, ERC20} from "@solmate/src/mixins/ERC4626.sol";

/**
 * @title TokenVault
 * @dev Implementation of the ERC4626 standard for tokenized vaults with a custom yield mechanism.
 */
contract TokenVault is ERC4626 {
    // Define a constant for the yield percentage
    uint8 constant YIELD = 10;

    /**
     * @notice Constructs the TokenVault contract.
     * @param _asset Address of the ERC20 token to be used as the underlying asset.
     * @param _name Name of the tokenized vault.
     * @param _symbol Symbol of the tokenized vault.
     */
    constructor(
        ERC20 _asset,
        string memory _name,
        string memory _symbol
    ) ERC4626(_asset, _name, _symbol) {}

    /**
     * @notice Deposits assets into the vault and mints corresponding shares.
     * @param _assets Amount of the asset token to be deposited.
     * @dev Ensures the deposit amount is greater than zero.
     */
    function customDeposit(uint _assets) public {
        require(_assets > 0, "Deposit less than Zero");
        deposit(_assets, msg.sender);
    }

    /**
     * @notice Withdraws assets from the vault by redeeming shares and includes yield.
     * @param _shares Amount of shares the user wants to convert into assets.
     * @param _receiver Address of the user who will receive the withdrawn assets.
     * @dev Ensures the withdrawal amount and receiver address are valid.
     */
    function customWithdraw(uint _shares, address _receiver) public {
        require(_shares > 0, "Withdraw must be greater than Zero");
        require(_receiver != address(0), "Zero Address");
        uint256 percent = (YIELD * _shares) / 100;
        uint256 assets = _shares + percent;
        redeem(assets, _receiver, msg.sender);
    }

    /**
     * @notice Returns the total number of assets held in the vault.
     * @return Total assets in the vault.
     */
    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this));
    }

    /**
     * @notice Returns the total asset balance of a specific user.
     * @param _user Address of the user.
     * @return The total assets of the user.
     */
    function totalAssetsOfUser(address _user) public view returns (uint256) {
        return asset.balanceOf(_user);
    }
}
