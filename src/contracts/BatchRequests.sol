// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.9;

import "../interfaces/IStaking.sol";
import "../structs/Batch.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BatchRequests is Ownable {
    address[] public contracts;

    /**
        @notice sendWithdrawalRequests on all addresses in contracts
     */
    function sendWithdrawalRequests() external {
        for (uint256 i = 0; i < contracts.length; i++) {
            if (
                contracts[i] != address(0) &&
                IStaking(contracts[i]).canBatchTransactions()
            ) {
                IStaking(contracts[i]).sendWithdrawalRequests();
            }
        }
    }

    /**
        @notice shows which contracts can batch
        @return (address, bool)[]
     */
    function canBatchContracts() external view returns (Batch[] memory) {
        Batch[] memory batch = new Batch[](contracts.length);
        for (uint256 i = 0; i < contracts.length; i++) {
            bool canBatch = IStaking(contracts[i]).canBatchTransactions();
            batch[i] = Batch(contracts[i], canBatch);
        }
        return batch;
    }

    /**
        @notice shows if contracts can batch by index
        @return (address, bool)
     */
    function canBatchContractByIndex(uint256 _index)
        external
        view
        returns (address, bool)
    {
        return (
            contracts[_index],
            IStaking(contracts[_index]).canBatchTransactions()
        );
    }

    /**
        @notice get address in contracts by index
        @return address
     */
    function getAddressByIndex(uint256 _index) external view returns (address) {
        return contracts[_index];
    }

    /**
        @notice get addresses in contracts
        @return address[]
     */
    function getAddresses() external view returns (address[] memory) {
        return contracts;
    }

    /**
        @notice add address to contracts array
        @param _address - address to add
     */
    function addAddress(address _address) external onlyOwner {
        contracts.push(_address);
    }

    /**
        @notice remove address to contracts array
        @param _address - address to remove
     */
    function removeAddress(address _address) external onlyOwner {
        for (uint256 i = 0; i < contracts.length; i++) {
            if (contracts[i] == _address) {
                delete contracts[i];
            }
        }
    }
}
