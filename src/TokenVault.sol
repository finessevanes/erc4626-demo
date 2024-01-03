//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC4626, ERC20} from "@solmate/src/mixins/ERC4626.sol";

contract TokenVault is ERC4626 {
    uint8 constant YIELD = 10;

    constructor(
        ERC20 _asset,
        string memory _name,
        string memory _symbol
    ) ERC4626(_asset, _name, _symbol) {}

    /**
     * @notice function to deposit assets and receive vault tokens in exchange
     * @param _assets amount of the asset token
     */
    function customDeposit(uint _assets) public {
        require(_assets > 0, "Deposit less than Zero");
        deposit(_assets, msg.sender);
    }

    /**
     * @notice Function to allow msg.sender to withdraw their deposit plus accrued interest
     * @param _shares amount of shares the user wants to convert
     * @param _receiver address of the user who will receive the assets
     */
    function customWithdraw(uint _shares, address _receiver) public {
        require(_shares > 0, "withdraw must be greater than Zero");
        require(_receiver != address(0), "Zero Address");
        uint256 percent = (YIELD * _shares) / 100;
        uint256 assets = _shares + percent;
        redeem(assets, _receiver, msg.sender);
    }

    /**
     * @notice Returns the total number of assets currently held in the vault.
     * @dev This function is an override of the totalAssets() function from the ERC-4626 library.
     * It calculates the total assets by checking the vault's balance of the underlying asset.
     * @return The total asset balance of the vault.
     */
    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this));
    }

    /**
     * @notice Returns the total balance of a user's underlying asset.
     * @dev This function provides a view into an individual user's asset balance.
     * It is useful for users to query their current asset holdings in the vault.
     * @param _user The address of the user whose asset balance is being queried.
     * @return The total asset balance of the specified user.
     */
     function totalAssetsOfUser(address _user) public view returns (uint256) {
        return asset.balanceOf(_user);
    }
}