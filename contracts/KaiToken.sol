// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";

contract KaiToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("KaiToken", "KAIT") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}