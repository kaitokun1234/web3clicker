// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract clicker {

    struct employee{
        uint8 grade;
        uint8 speed;
        uint8 stamina;
        uint256 dna;
    }
    
    event BuyEmployee(employee newEmployee);
    event receivedReward(uint amount);

    mapping(uint => address) employeeToOwner;
    mapping(address => uint) ownerEmployeeCount;

    employee[] employees;
    uint randmodule = 10 ** 16;
    ERC20 token;

    constructor(address _tokenAddr) {
        token = ERC20(_tokenAddr);
    }

    function buyEmployee(uint256 _cost) public payable{
        require(token.balanceOf(msg.sender) >= _cost, "Insufficient token balance");
        token.transferFrom(msg.sender, address(this), _cost);
        employee _employee = generateEmployee();
        employees.push(_employee);
        employeeToOwner[_dna] = msg.sender;
        ownerEmployeeCount[msg.sender]++;
        emit BuyEmployee(_employee);
    }

    function generateEmployee() private view returns(employee){
        uint8 _grade = random("") % 3;
        uint8 _speed = (random(string(_grade)) % 10)*_grade;
        uint8 _stamina = (random(string(_speed)) % 10)*_grade;
        uint _dna = random(string(_speed+_stamina+_grade));
        employee _employee = employee(_grade, _speed, _stamina, _dna);
        return _employee;
    }

    function receiveReward(uint _amount) public{
        require(token.balanceOf(this) >= _amount);
        token.transfer(msg.sender, _amount); 
    }

    function getAllEmployees() public view{
        return employees;
    } 

    function random(string _str) private view returns (uint) {
        uint rand = uint(keccak256(block.timestamp + _str));
        uint result = rand % randmodule;
        return result;
    }
}