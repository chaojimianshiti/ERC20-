Transfer: event({_from: indexed(address),
  _to: indexed(address), _value: uint256})
Approval: event({_owner: indexed(address),
  _spender: indexed(address), _value: uint256})

name: public(bytes32)
symbol: public(bytes32)
totalSupply: public(uint256)
decimals: public(uint256)

balances: uint256[address]
allowed: uint256[address][address]

@public
def __init__():
    self.name = convert("ZiShanCoinV01", bytes32)
    self.symbol = convert("ZSCV01", bytes32)
    self.decimals = 4
    self.totalSupply =210000000000
    self.balances[msg.sender] = self.totalSupply

@public
@constant
def balanceOf(_owner: address) -> uint256:
    return self.balances[_owner]

@public
def transfer(_to: address, _amount: uint256) -> bool:
    if self.balances[msg.sender] >= _amount and \
       self.balances[_to] + _amount >= self.balances[_to]:
        self.balances[msg.sender] -= _amount
        self.balances[_to] += _amount
        log.Transfer(msg.sender, _to, _amount)
        return True
    else:
        return False

@public
def approve(_spender: address, _amount: uint256) -> bool:
    self.allowed[msg.sender][_spender] = _amount
    log.Approval(msg.sender, _spender, _amount)
    return True

@public
def transferFrom(_from: address, _to: address, _value: uint256) -> bool:
    if _value <= self.allowed[_from][msg.sender] and \
       _value <= self.balances[_from]:
        self.balances[_from] -= _value
        self.allowed[_from][msg.sender] -= _value
        self.balances[_to] += _value
        log.Transfer(_from, _to, _value)
        return True
    else:
        return False

@public
def allowance(_owner: address, _spender: address) -> uint256:
    return self.allowed[_owner][_spender]
