// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.9;

contract LiquidityReserveStorage {
    address public stakingToken; // staking token address
    address public rewardToken; // reward token address
    address public stakingContract; // staking contract address
    uint256 public fee; // fee for instant unstaking
    uint256 public constant MINIMUM_LIQUIDITY = 10**15; // lock .001 stakingTokens for initial liquidity
    uint256 public constant BASIS_POINTS = 10000; // 100% in basis points
}