// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "./Ownable.sol";

contract GasContract is Ownable {
    struct ImportantStruct {
        //!
        uint256 valueA; // max 3 digits
        uint256 bigValue;
        uint256 valueB; // max 3 digits
    }

    uint256 public immutable totalSupply;
    uint256 internal paymentCounter = 0;
    address[5] public administrators;
    mapping(address => bool) internal admins; //!

    mapping(address => uint256) internal balances;
    mapping(address => uint256) public whitelist;
    mapping(address => Payment[]) internal payments;

    struct Payment {
        uint8 paymentType;
        uint256 paymentID;
        uint256 amount;
    }

    event Transfer(address recipient, uint256 amount);

    modifier onlyAdminOrOwner() {
        require(admins[msg.sender], "Not admin");
        _;
    }

    constructor(address[] memory _admins, uint256 _totalSupply) {
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;

        for (uint256 ii = 0; ii < administrators.length; ii++) {
            administrators[ii] = _admins[ii];
            admins[_admins[ii]] = true;
        }
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        balance_ = balances[_user];
    }

    function getTradingMode() public view returns (bool) {
        return true;
    }

    function getPayments(address _user)
        public
        view
        returns (Payment[] memory payments_)
    {
        payments_ = payments[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        payments[msg.sender].push(Payment(3, ++paymentCounter, _amount));
        emit Transfer(_recipient, _amount);
    }

    function updatePayment(
        address _user,
        uint256 _ID,
        uint256 _amount,
        uint8 _type
    ) public onlyAdminOrOwner {
        payments[_user][_ID - 1].paymentType = _type;
        payments[_user][_ID - 1].amount = _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        whitelist[_userAddrs] = _tier;
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount,
        ImportantStruct memory _struct //!
    ) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        balances[msg.sender] += whitelist[msg.sender];
        balances[_recipient] -= whitelist[msg.sender];
    }
}
