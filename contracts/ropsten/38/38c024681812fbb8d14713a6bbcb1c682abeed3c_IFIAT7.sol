pragma solidity ^0.4.25;

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    assert(a == b * c + a % b); // There is no case in which this doesn&#39;t hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure  returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

    // ERC20 Token Smart Contract
    contract IFIAT7 {
        
        string public constant name = "iFiat Wrapper";
        string public constant symbol = "IFIAT";
        uint8 public constant decimals = 4;
        uint public _totalSupply = 7000000000;
        uint256 public RATE = 500;
        bool public isMinting = true;
        string public constant generatedBy  = "Geopay.me by FinTech Services";
        
        using SafeMath for uint256;
        address public owner;
        
 //       event  Approval(address indexed src, address indexed guy, uint wad);
 //       event  Transfer(address indexed src, address indexed dst, uint wad);
        event  Deposit(address indexed dst, uint wad);
        event  Withdrawal(address indexed src, uint wad);

        mapping (address => uint)                       public  balanceOf;
        mapping (address => mapping (address => uint))  public  allowance;
        
         // Functions with this modifier can only be executed by the owner
         modifier onlyOwner() {
            if (msg.sender != owner) {
                revert();
            }
             _;
         }
     
        // Balances for each account
        mapping(address => uint256) balances;
        // Owner of account approves the transfer of an amount to another account
        mapping(address => mapping(address=>uint256)) allowed;

        // Its a payable function works as a token factory.
        function () public payable{
            createTokens();
        }
        

        // Constructor
        constructor() public {
            owner = msg.sender; 
            balances[owner] = _totalSupply;
        }

        //allows owner to burn tokens that are not sold in a crowdsale
        function burnTokens(uint256 _value) public onlyOwner {

             require(balances[msg.sender] >= _value && _value > 0 );
             _totalSupply = _totalSupply.sub(_value);
             balances[msg.sender] = balances[msg.sender].sub(_value);
             
        }



        // This function creates Tokens  
         function createTokens() public payable {
            if(isMinting == true){
                require(msg.value > 0);
                uint256  tokens = msg.value.mul(RATE);
                balances[msg.sender] = balances[msg.sender].add(tokens);
                _totalSupply = _totalSupply.add(tokens);
                owner.transfer(msg.value);
            }
            else{
                revert();
            }
        }


        function endCrowdsale() public onlyOwner {
            isMinting = false;
        }

        function changeCrowdsaleRate(uint256 _value) public onlyOwner {
            RATE = _value;
        }


        
        function totalSupply() public constant returns(uint256){
            return _totalSupply;
        }
        // What is the balance of a particular account?
        function balanceOf(address _owner) public constant returns(uint256){
            return balances[_owner];
        }
  
        function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        deposit();
        }
        
        function withdraw(uint wad) public {
        require(balanceOf[msg.sender] >= wad);
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad);
        withdraw(wad);
        }
         // Transfer the balance from owner&#39;s account to another account   
        function transfer(address _to, uint256 _value) public returns(bool) {
            require(balances[msg.sender] >= _value && _value > 0 );
            balances[msg.sender] = balances[msg.sender].sub(_value);
            balances[_to] = balances[_to].add(_value);
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        
    // Send _value amount of tokens from address _from to address _to
    // The transferFrom method is used for a withdraw workflow, allowing contracts to send
    // tokens on your behalf, for example to "deposit" to a contract address and/or to charge
    // fees in sub-currencies; the command should fail unless the _from account has
    // deliberately authorized the sender of the message via some mechanism; we propose
    // these standardized APIs for approval:
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(allowed[_from][msg.sender] >= _value && balances[_from] >= _value && _value > 0);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
    // If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 _value) public returns(bool){
        allowed[msg.sender][_spender] = _value; 
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    // Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(address _owner, address _spender) public constant returns(uint256) {
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}