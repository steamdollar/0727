// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./node_modules/openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";
import "./node_modules/openzeppelin-solidity/contracts/utils/Strings.sol";

contract abcToken is ERC721Enumerable, Ownable {

    uint constant public MAX_TOKEN_COUNT = 1000;
    // 최대 발행 갯수

    uint public mint_price = 1 ether;
    // 돈의 단위를 적을 때 10**18을 직접 쓰면 연산때문에 돈이 나간다
    // 그래서 솔리디티에서 단위를 만들었음.. 알아서 1 ether를 10^18로 바꿔준다

    string public metadataURI; 

    constructor(string memory _name, string memory _symbol, string memory _metadataURI) ERC721(_name, _symbol) {
        metadataURI = _metadataURI;
    }

    struct TokenData {
        uint Rank;
        uint Type;
    }

    mapping(uint => TokenData) public TokenDatas;

    function mintToken() public payable{
        require(msg.value >= mint_price);
        require(MAX_TOKEN_COUNT > totalSupply());
        uint tokenId = totalSupply() + 1;
        // totalSupply함수는 erc721Enu에 있다.
        // TokenData memory random = getRandomNum(msg.sender, tokenId);
        TokenDatas[tokenId] = getRandomNum(msg.sender, tokenId);

        payable(Ownable.owner()).transfer(msg.value); // owner는 컨트랙트 배포자 Ownable 컨트랙트에 있음
        _mint(msg.sender, tokenId);
    }

    function tokenURI(uint _tokenId) public override view returns (string memory) {
        // tokenId > rank, type  
        // e.g. 1 > (1,4)
        // return baseurl/metadata/1/4.json
        // ipfs > 파일을 블록체인에 저장 : 파일 조각을 동시에 여러 노드에서 가져옴 faster than http
        // http://www.pinata.cloud/
        string memory Rank = Strings.toString(TokenDatas[_tokenId].Rank);
        string memory Type = Strings.toString(TokenDatas[_tokenId].Type);
        return string(abi.encodePacked(metadataURI,"/", Rank, "/", Type, ".json"));
    }

    function getRandomNum (address _owner, uint _tokenId) private pure returns(TokenData memory) {
        // Random
        // encodePacked 타입과 상관없이 변수들을 합쳐줌
        uint randomNum = uint(keccak256(abi.encodePacked(_owner, _tokenId))) % 100;
        TokenData memory data;

        data.Type = 1;
        data.Rank = 1;
        // 메모리 상으로 data 변수를 만들었고, 이건 랭크랑 타입을 만드는데 사용된 후,
        // 함수가 값을 리턴하면 사라짐
        // 대충 data를 조건문에 따라 경우를 나눠 만들었다치자.
        return data;
    }
}