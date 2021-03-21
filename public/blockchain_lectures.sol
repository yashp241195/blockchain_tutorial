
pragma solidity >=0.7.0 <0.8.0;

// ********** Lec 1
contract SimpleContract {

    int public count = 0;
    
    function increment() public {
        count++;
    }
    
    
}

// ********** Quick Bank 

contract Bank {
    
    int bal;
    
    constructor() public {
        bal = 1;
    }
    
    function getBalance() view public returns(int){
        return bal;
    }
    
    function withdraw(int amount) public{
        bal = bal - amount;
    }
    
    function deposit(int amount) public{
        bal = bal + amount;   
    }

}

// ********** first

contract Counter{
    
    uint count;
    
    constructor() public{
        count = 0;
    }
    
    function getCount() public view returns(uint){
        return count;
    }
    
    function incrementCount() public{
        count++;
    }
    
    
}

// ********** second


contract MyContract{
    
    string public myString = "Hello, world!";
    bytes32 public myBytes32 = "Hello, world!";
    int public myInt = 1;
    uint public myUint = 1;
    uint256 public myUint256 = 1;
    uint8 public myUint8 = 1;
    address public myAddress = 0x5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c;
    
    // uint = usigned int = can't be negative

    struct MyStruct {
        uint myUint;
        string myString;
    }

    MyStruct public myStruct = MyStruct(1, "Hello, World!");

    uint[] public uintArray = [1,2,3];

    string[] public stringArray = ['apple', 'banana', 'carrot'];
    
    mapping(uint => string) public names;
    
    constructor(){
        names[1] = "James";
        names[2] = "Clara";
        names[3] = "Andrews";
    }

    
}

// ********** BookStore.sol


contract BookStore{
    
    struct Book{
        string title;
        string author;
    }
    
    mapping(uint => string) public names;
    mapping(uint => Book) public books;
    mapping(address => mapping(uint=>Book)) public myBooks;
    
    constructor() public {
        names[1] = "Adam";
        names[2] = "Bruce";
        names[3] = "Carl";
    }

    function addBook(uint _id, string memory _title, string memory _author) public {
        books[_id] = Book(_title, _author);
    }
    
    function addMyBook(uint _id, string memory _title, string memory _author) public {
        myBooks[msg.sender][_id] = Book(_title, _author);
    }
    
    
}


// ********** Hotel Room


contract HotelRoom{
    
    address payable public owner;
    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;
    
    // listen the event on web3js
    event Occupy(address _occupant, uint _value);
    
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }
    
    modifier costs(uint _amount) {
        require( msg.value >= _amount ," Not enough ether provided ");
        _;
        
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    // function book() external payable onlyWhileVacant costs(2 ether){
    //     currentStatus = Statuses.Occupied;
    //     owner.transfer(msg.value);
    //     emit Occupy(msg.sender, msg.value);
    // }
    
    // send ethers to hotels via metamask wallet,
    
    receive() external payable onlyWhileVacant costs(0.1 ether){
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
    
    function getOwnerAddress() view public returns(address){
        return owner;
    }
    
}

// ********** inheritance 1


contract MyContract{
    
    string secret;
    address owner;
    
    
    modifier onlyOwner(){
        require(msg.sender == owner, "Must be owner");
        _;
    }
    
    constructor(string memory _secret) public {
        secret = _secret;
        owner = msg.sender;
    }
    
    function getSecret() public view onlyOwner returns(string memory){
        return secret;
    }
    
    
}

// ********** inheritance 2

contract Ownable{
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner," must be owner ");
        _;
    }
    
}


contract MyContract is Ownable{
    string secret;
    
    constructor(string memory _secret) public{
        secret = _secret;
        super;
    }
    
    function getSecret() public view onlyOwner returns(string memory){
        return secret;
    }
    
    
    
}

// ********** factory



contract Ownable{
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner," must be owner ");
        _;
    }
    
}

contract SecretVault{
    
    string secret;
    
    constructor(string memory _secret) public {
        secret = _secret;
    }
    
    function getSecret() public view returns(string memory){
        return secret;
    }
    
}


contract MyContract is Ownable{
    
    address secretVault;
    
    constructor(string memory _secret) public{
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
    }
    
    function getSecret() public view onlyOwner returns(string memory){
        SecretVault _secretVault = SecretVault(secretVault);
        return _secretVault.getSecret();
    }

    
}







