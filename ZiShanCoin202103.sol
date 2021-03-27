pragma solidity ^0.4.16;

contract ZiShanCoin{
    
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals;
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    
    function ZiShanCoin() public {
        name = "ZiShanCoin2021";
        symbol = "ZSC";
        totalSupply = 210000000000;
        decimals = 4;
        balances[msg.sender] = totalSupply;
    }  
  
    function transfer(address _to, uint256 _value) public 
    returns (bool success) {
        require(_to != 0x0);
        require(balances[msg.sender] >= _value && 
            balances[_to] + _value > balances[_to]);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;  
    }

    function balanceOf(address _owner) public constant 
    returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public 
    returns (bool success){
        allowed[msg.sender][_spender] = _value;  
        Approval(msg.sender, _spender, _value);  
        return true;  
    }
    
    function transferFrom(address _from, address _to, uint256 _value) 
    public returns (bool success){
        require(_from != 0x0 && _to != 0x0);
        require(balances[_from] >= _value && 
            allowed[_from][msg.sender] >= _value &&
            balances[_to]+_value > balances[_to]);  
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;  
    }
  
    function allowance(address _owner, address _spender) 
    public constant returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from,
        address indexed _to, uint256 _value);
    
    event Approval(address indexed _owner,
        address indexed _spender, uint256 _value);
}


