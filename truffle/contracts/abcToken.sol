// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./node_modules/openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";

contract abcToken is ERC721Enumerable, Ownable {
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {

    }

    function mintToken() public {
        uint tokenId = totalSupply() + 1;
        // totalSupply함수는 erc721Enu에 있다.
        _mint(msg.sender, tokenId);
    }

    function tokenURI(uint tokenId) public override view returns (string memory) {

    }
}