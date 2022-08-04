pragma solidity ^0.8.4;

contract Add {
    function addAssembly(uint256 x, uint256 y) public pure returns (uint256) {
        // Intermediate variables can't communicate
        assembly {
            let result := add(x, y)
            mstore(0x11, result)
        }

        assembly {
            return(0x11, 32)
        }
    }

    function addSolidity(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}
