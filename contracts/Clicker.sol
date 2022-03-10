// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract Clicker {

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
        employee memory _employee = generateEmployee();
        employees.push(_employee);
        employeeToOwner[_employee.dna] = msg.sender;
        ownerEmployeeCount[msg.sender]++;
        emit BuyEmployee(_employee);
    }

    function generateEmployee() private view returns(employee memory){
        uint8 _grade = uint8(random()) % 3;
        uint8 _speed = uint8(random()) % 10;
        _speed *= _grade;
        uint8 _stamina = _speed;
        uint _dna = random();
        employee memory _employee = employee(_grade, _speed, _stamina, _dna);
        return _employee;
    }

    function receiveReward(uint _amount) public{
        require(token.balanceOf(address(this)) >= _amount);
        token.transfer(msg.sender, _amount); 
    }

    function getAllEmployees() public view returns(employee[] memory){
        return employees;
    } 

    function random() private view returns (uint) {
        //uint rand = uint(keccak256(block.timestamp));
        uint rand = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
        uint result = rand % randmodule;
        return result;
    }
}