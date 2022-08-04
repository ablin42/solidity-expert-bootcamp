pragma solidity ^0.8.4;

contract Intro {
    function intro() public pure returns (uint16) {
        uint256 mol = 420;

        // Yul assembly magic happens within assembly{} section
        assembly {
            let stackVar := mol
            mstore(0, stackVar)

            return(0, 32)
        }
    }
}
