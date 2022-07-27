// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./abcToken.sol";

contract SaleToken {
    abcToken public Token;

    constructor(address _tokenAddress) {
        Token = abcToken(_tokenAddress);
    }

    // 토큰 가격 매핑
    mapping(uint => uint) public tokenPrices;

    // 판매 토큰 배열
    uint[] public SaleTokenList;

    // 토큰 판매 등록
    function SalesToken(uint _tokenId, uint _price) public {
        // 판매 전 체크 사항
        address tokenOwner = Token.ownerOf(_tokenId);
        require(tokenOwner == msg.sender);
        require(_price > 0);
        // 판매 플랫폼 입장에서 위임을 받은게 맞는지..
        require(Token.isApprovedForAll(msg.sender, address(this)));

        tokenPrices[_tokenId] = _price;
        SaleTokenList.push(_tokenId);
    }

    // 토큰 구매
    function PurchaseToken(uint _tokenId) public payable {
        address tokenOwner = Token.ownerOf(_tokenId);
        require(tokenOwner != msg.sender);
        require(tokenPrices[_tokenId] > 0);
        require(tokenPrices[_tokenId] <= msg.value);

        payable(tokenOwner).transfer(msg.value);
        // ca가 토큰 오너에게 구매자가 입력한 value만큼 이더를 준다

        Token.transferFrom(tokenOwner, msg.sender, _tokenId);
        
        tokenPrices[_tokenId] = 0;
        popSaleToken(_tokenId);
    }

    function cancelSaleToken(uint _tokenId) public {
        address tokenOwner = Token.ownerOf(_tokenId);
        require(tokenOwner == msg.sender);
        require(tokenPrices[_tokenId] > 0); // 가격이 0보다 크다는걸 판매 중인 토큰이라고 간주

        tokenPrices[_tokenId] = 0;
        popSaleToken(_tokenId);
    }
    
    // 판매 종료 함수
    function popSaleToken(uint _tokenId) private returns (bool) {
        for (uint i = 0; i < SaleTokenList.length; i++) {
            if (SaleTokenList[i] == _tokenId) {
                SaleTokenList[i] = SaleTokenList[SaleTokenList.length -1];
                SaleTokenList.pop();
                return true;
            }
        }
        return false;
    }
}