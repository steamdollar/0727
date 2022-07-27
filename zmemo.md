# 느프트 민팅

느프트를 만든다.

Account1 > 컨트랙트에 이더리움을 주고 느프트를 받는다.

이 때 느프트를 받을 떄 사진이나 내용이 무작위적으로 받을 수 있도록 해보자.

16가지 정도..

사용자들끼리 느프트를 거래할 수 있는 컨트랙트도 만들어본다.

오늘은 ERC721의 함수를 직접 작성하지 않고 오픈 제펠린의 컨트랙트를 활용한다.


truffle/contracts 안에 오픈제펠린 설치

솔리디티 파일을 만든다.

ERC721Enumerable.sol을 import한다

Ownable.sol도..

생성자 함수 ERC721 상속해서 ㅁ나들어주고

mintTOken, tokenURI 함수를 쓰는데

tokenURi는 상속받아 오되, 내가 만들고 싶은대로 고쳐서 쓸거기 때문에 override 넣어줘야 함

mintToken은 그냥 내가 새로 선언한 함수

//

mintToken 먼저 만들고

tokenURI 만들어보자

이걸 넣으면 배포한 느프트가 보일거고 등등..

json meatdata..

딱히 표준은 없고 그냥 큰 시장의 권장 사항을 따라감

아무튼 각각의 tokenURI를 발행 느프트의 수가 많을때는 어떻게 편하게 만드냐

tokenId를 기준으로 중간 매개체 역할을 해줄 구조체 struct를 하나 만들거다.

//

우리가 nft를 살 때 레어도에 따라 나올 확률이 다르다.

같은 레어도에도 여러가지 느프트가 있을거고..

https://github.com/ingoo-blockchain/NFT_Mint/tree/master/public

//

아무튼 TokenData 구조체를 만들고 이걸 token과 연결한 TokenDatas 매핑을 만든다. 

이 구조체 각각의 값을 정하기 위해 getRandomNum 함수를 작성한다.

했으면 mintToken 함수에서 호출해주면 됨

tokenURI gkatndptj 특정 토큰의 정보를 가져와 uri를 만들어주는데

데이터 타입이 달라서 변환을 하기가 귀찮다.

그래서 라이브러리가 있다.

오픈 제펠린 > utils/String.sol에 있다.

//

생성자 함수에 배포를 진행할때의 베이스 url을 넣는다.

얘는 ERC721에 있는건 아니므로 상속값은 아님

https://gateway.pinata.cloud/ipfs/QmUsEKtVS5Gn4rZWbYfD7D4qLLKPf1YbsBWYaSqtmCPBzf

일단 이걸로 쓴다..

remixd -s . --remix-ide https://remix.ethereum.org

//

saleToken 컨트랙트를 만든다.