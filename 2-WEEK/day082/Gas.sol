// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

error Unauthorized();

contract GasContract {
    uint16 public immutable totalSupply;
    uint16 internal paymentCounter;
    address[5] public administrators;
    mapping(address => bool) internal admins;

    mapping(address => uint16) internal balances;
    mapping(address => uint16) public whitelist;
    mapping(address => Payment[]) internal payments;

    struct ImportantStruct {
        uint8 valueA;
        uint8 valueB;
        uint64 bigValue;
    }
    struct Payment {
        uint8 paymentType;
        uint16 paymentID;
        uint16 amount;
    }

    event Transfer(address recipient, uint16 amount);

    constructor(address[] memory _admins, uint16 _totalSupply) {
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;

        for (uint8 i = 0; i < administrators.length; i++) {
            administrators[i] = _admins[i];
            admins[_admins[i]] = true;
        }
    }

    function addToWhitelist(address _userAddrs, uint8 _tier) external {
        whitelist[_userAddrs] = _tier;
    }

    function transfer(
        address _recipient,
        uint16 _amount,
        string calldata _name
    ) external {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        payments[msg.sender].push(Payment(3, ++paymentCounter, _amount));
        emit Transfer(_recipient, _amount);
    }

    function balanceOf(address _user) external view returns (uint16 balance_) {
        balance_ = balances[_user];
    }

    function whiteTransfer(address _recipient, uint16 _amount) external {
        balances[msg.sender] =
            balances[msg.sender] -
            _amount +
            whitelist[msg.sender];
        balances[_recipient] =
            balances[_recipient] +
            _amount -
            whitelist[msg.sender];
    }

    function updatePayment(
        address _user,
        uint8 _ID,
        uint16 _amount,
        uint8 _type
    ) external {
        if (!admins[msg.sender]) revert Unauthorized();
        payments[_user][_ID - 1].paymentType = _type;
        payments[_user][_ID - 1].amount = _amount;
    }

    function getTradingMode() public pure returns (bool tradingMode) {
        tradingMode = true;
    }

    function getPayments(address _user)
        external
        view
        returns (Payment[] memory payments_)
    {
        payments_ = payments[_user];
    }
}
