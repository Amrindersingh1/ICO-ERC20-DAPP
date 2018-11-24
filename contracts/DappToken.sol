pragma solidity ^0.4.2;

contract DappToken {

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    //Name
    string public name = "DApp Token";

    //Symbol
    string public symbol = "DAPP";

    //Standard
    string public standard = "DApp Token v1.0";

    mapping(address => uint256) public balanceOf;
    
    //allowance
    mapping(address => mapping(address => uint256)) public allowance;

    //constructor
    //Set Total number of Token
    //Read Total number of Token
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    // Transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
       
        //Exception if account doesnt have enough
        require(balanceOf[msg.sender] >= _value);

        //Return a boolean
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        //Transfer Event
        emit Transfer(msg.sender, _to, _value);

        return true;

    }

    // approve
    function approve(address _spender, uint256 _value) public returns (bool success) {
        
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // transferFrom
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success) {

        // require from has enough
        require(balanceOf[_from] >= _value);

        //require allowance is big enough
        require(allowance[_from][msg.sender] >= _value);

        //change the balance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        //update the allowance
        allowance[_from][msg.sender] -= _value;

        //Transfer Event
        emit Transfer(_from, _to, _value);

        return true;
    }


}