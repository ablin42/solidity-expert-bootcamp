pragma solidity ^0.8.4;

contract Amount {
    function getAmount() public returns (uint256) {
        // Create a Solidity contract with one function
        // The function should return the amount of ETH that was passed to it, and the function
        // body should be written in assembly

        assembly {
            let sent := callvalue()
            mstore(0, sent)
            return(0, 32)
        }
    }
}
