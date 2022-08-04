pragma solidity ^0.8.4;

contract SubOverflow {
    // Modify this function so on overflow it sets value to 0
    function subtract(uint256 x, uint256 y) public pure returns (uint256) {
        // Write assembly code that handles overflows
        assembly {
            let result := sub(x, y)
            if gt(result, add(x, y)) {
                stop()
            }
            mstore(0, result)
            return(0, 32)
        }
    }
}
