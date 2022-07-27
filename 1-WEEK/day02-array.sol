// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import "hardhat/console.sol";

contract ArrayExercise {
    uint256[] public array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    /*
        Write a function that will delete items (one at a time) from a dynamic array without
        leaving gaps in the array. You should assume that the items to be deleted are chosen
        at random, and try to do this in a gas efficient manner.
        For example imagine your array has 12 items and you need to delete the items at
        indexes 8, 2 and 7.
        The final array will then have items {0,1,3,4,5,6,9,10,11}
     */
    function deleteItems(uint256[] memory items) public {
        for (uint256 i = 0; i < items.length; i++) {
            array[items[i]] = array[array.length - 1];
            array.pop();
        }

        printArray();
    }

    function printArray() public view {
        for (uint256 i = 0; i < array.length; i++) {
            console.log(array[i]);
        }
    }
}
