pragma solidity ^0.8.4;

contract Scope {
    uint256 public count = 10;

    function increment(uint256 numb) public {
        // Modify state of the count from within
        // the assembly segment
        assembly {
            let target := count.slot
            let currentCount := sload(target)
            let incremented := add(currentCount, numb)
            sstore(target, incremented)
        }
    }
}
