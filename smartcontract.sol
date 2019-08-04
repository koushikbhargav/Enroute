pragma solidity ^0.4.17;

contract DappToken {
    string  public name = "enroute";
    string  public symbol = "ENRO";
    string  public standard = "Enroute Token v1.0";
    uint256 public totalSupply;

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

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor (uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }
      function deposit( uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[address(this)] += _value;

        emit Transfer(msg.sender, address(this), _value);

        return true;
    }
    function finaltransfer(address _to) public returns (bool success){
        balanceOf[_to]+=balanceOf[address(this)];
        balanceOf[address(this)] -= balanceOf[address(this)];
        emit Transfer(address(this),_to,balanceOf[address(this)]);

        return true;

    }
    function etransfer( address _to,uint _var) public returns (bool success) {
        balanceOf[address(this)]+=balanceOf[address(this)]*2/40;
        uint temp=balanceOf[address(this)];
        balanceOf[address(this)] -= balanceOf[address(this)]/(_var);
        balanceOf[_to] += temp/(_var);


        emit Transfer(address(this),  _to,balanceOf[address(this)]/(_var) );


        return true;

    }
    function getBalance() public view returns (uint256) {
        return balanceOf[address(this)];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function stake() public returns (bool success) {
        balanceOf[address(this)]+=10;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

}