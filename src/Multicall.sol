pragma solidity >=0.5.0;
pragma experimental ABIEncoderV2;

/// @title Multicall - Aggregate results from multiple read-only function calls

contract Multicall {
    function aggregate(address[] calldata contracts, bytes[] calldata bytecodes) public returns (uint256 blockNumber, bytes[] memory returnData) {
        require(contracts.length == bytecodes.length, "parameters should be of the same length");
        blockNumber = block.number;
        returnData = new bytes[](contracts.length);
        for(uint256 i = 0; i < contracts.length; i++) {
            (bool success, bytes memory ret) = contracts[i].call(bytecodes[i]);
            require(success);
            returnData[i] = ret;
        }
    }

    function batch(address[] calldata contracts, bytes[] calldata bytecodes) public returns (uint256 blockNumber, bool[] memory result, bytes[] memory returnData) {
        require(contracts.length == bytecodes.length, "parameters should be of the same length");
        blockNumber = block.number;
        result = new bool[](contracts.length);
        returnData = new bytes[](contracts.length);
        for(uint256 i = 0; i < contracts.length; i++) {
            (bool success, bytes memory ret) = contracts[i].call(bytecodes[i]);
            result[i] = success;
            returnData[i] = ret;
        }
    }

    // Helper functions
    function getEthBalance(address addr) public view returns (uint256 balance) {
        balance = addr.balance;
    }
    function getBlockHash(uint256 blockNumber) public view returns (bytes32 blockHash) {
        blockHash = blockhash(blockNumber);
    }
    function getLastBlockHash() public view returns (bytes32 blockHash) {
        blockHash = blockhash(block.number - 1);
    }
    function getCurrentBlockTimestamp() public view returns (uint256 timestamp) {
        timestamp = block.timestamp;
    }
    function getCurrentBlockDifficulty() public view returns (uint256 difficulty) {
        difficulty = block.difficulty;
    }
    function getCurrentBlockGasLimit() public view returns (uint256 gaslimit) {
        gaslimit = block.gaslimit;
    }
    function getCurrentBlockCoinbase() public view returns (address coinbase) {
        coinbase = block.coinbase;
    }
}
