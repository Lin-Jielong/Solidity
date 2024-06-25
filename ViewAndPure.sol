// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ViewAndPure {
    uint256 public num = 1;

    // Promise to modify this state.
    function addToNum(uint256 x) public view returns (uint256) {
        return num + x;
    }

    // Promise not to modify or read from this state.
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}