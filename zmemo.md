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