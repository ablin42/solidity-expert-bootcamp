// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

contract MemoryExercise {
    uint256[] public array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    /*
        Using Remix write a simple contract that uses a memory variable, then using the
        debugger step through the function and inspect the memory
    */
    function deleteItems(uint256[] memory items) public {
        for (uint256 i = 0; i < items.length; i++) {
            array[items[i]] = array[array.length - 1];
            array.pop();
        }
    }
}
