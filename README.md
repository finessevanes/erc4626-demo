# ERC-4626 Token Vault Deployment Guide

This guide outlines the steps to deploy the MockUSDC and TokenVault contracts locally using Foundry and on the Polygon zkEVM Testnet.

## Overview
- **MockUSDC**: An ERC-20 compliant mock token. Upon deployment, the deployer is minted 100 mUSDC tokens.
- **TokenVault**: An ERC-4626 compliant token vault contract.

## Initial Setup
1. **Clone the Repository**:
   ```shell
   git clone https://github.com/finessevanes/erc4626-demo.git
   ```

2. **Navigate to the Project Directory**:
   ```shell
   cd erc4626-demo
   ```

3. **Build the Assets**:
   ```shell
   forge build
   ```

4. **Compile Contracts**:
   ```shell
   forge compile
   ```

## Deploying Locally

1. **Start Local Development Environment**:
   ```shell
   anvil
   ```
   - Note the public and private keys provided.

2. **Create and Configure .env File**:
   - Create a `.env` file in the project root:
     ```shell
     touch .env
     ```
   - Add the private key and RPC URL:
     ```
     ANVIL_PRIVATE_KEY=0x...
     ANVIL_PUBLIC_KEY=0x...
     ANVIL_RPC=http://127.0.0.1:8545
     ```

3. **Load Environment Variables**:
   ```shell
   source .env
   ```

4. **Deploy MockUSDC Contract**:
   ```shell
   forge create --rpc-url $ANVIL_RPC --private-key $ANVIL_PRIVATE_KEY MockUSDC
   ```
   - Save the contract address for later use.

5. **Deploy TokenVault Contract**:
   ```shell
   forge create --rpc-url $ANVIL_RPC --private-key $ANVIL_PRIVATE_KEY src/TokenVault.sol:TokenVault --constructor-args $ANVIL_MOCKUSDC_ADDRESS "MockUSDC" "mUSDC"
   ```

6. **Approve Spending Limit**:
   ```shell
   cast send --rpc-url $ANVIL_RPC --private-key $ANVIL_PRIVATE_KEY $ANVIL_MOCKUSDC_ADDRESS "approve(address, uint256)" [TOKENVAULT_CONTRACT_ADDRESS] 200000000000000000000
   ```

7. **Make a Deposit in TokenVault**:
   ```shell
   cast send --rpc-url $ANVIL_RPC --private-key $ANVIL_PRIVATE_KEY [TOKENVAULT_CONTRACT_ADDRESS] "customDeposit(uint256)" 50000000000000000000
   ```

8. **Make a Withdraw in TokenVault**:
   ```shell
   cast send --rpc-url $ANVIL_RPC --private-key $ANVIL_PRIVATE_KEY [TOKENVAULT_CONTRACT_ADDRESS] "customWithdraw(uint256, address)" 50000000000000000000 $ANVIL_PUBLIC_KEY
   ```

## Deploying on Polygon zkEVM Testnet

1. **Configure for Polygon zkEVM Testnet**:
   - Update `.env` with your private key and Polygon zkEVM Testnet RPC URL.

2. **Deploy MockUSDC Contract on Testnet**:
   ```shell
   forge create --rpc-url $POLYGON_ZKEVM_RPC --private-key $PRIVATE_KEY MockUSDC
   ```
   - Save the contract address for TokenVault deployment.

3. **Deploy TokenVault Contract on Testnet**:
   ```shell
   forge create --rpc-url $POLYGON_ZKEVM_RPC --private-key $PRIVATE_KEY src/TokenVault.sol:TokenVault --constructor-args [MOCKUSDC_CONTRACT_ADDRESS] "MockUSDC" "mUSDC"
   ```

## Notes
- Ensure you have enough MATIC for gas fees on the Polygon zkEVM Testnet.
- Replace placeholders like `[TOKENVAULT_CONTRACT_ADDRESS]` with actual contract addresses.
- For deploying on the testnet, ensure your wallet is configured correctly and you have testnet MATIC.
- If you're interested in learnng more about ERC-4626, make sure you read this 
- The following article has been developed in conjunction with the repository,[ERC-4626: The L2 DeFi Lifeline](https://mirror.xyz/dashboard/edit/AKb8MB8IVzVHp4ppSmJ9M03dyoxASgBO0_7TsGlxxKg).