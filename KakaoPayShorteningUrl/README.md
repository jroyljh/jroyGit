# KAKAOPAY 사내정보시스템 사전과제

##**ROOT Page**
- URL : http://localhost:8080//KakaoPayShorteningUrl/InsertUrl.jsp

  
  
##**요구사항**    
[사전과제 프로젝트 내용]  
- URL 을 입력받아 짧게 줄여주고, Shortening 된 URL 을 입력하면 원래 URL 로 리다이렉트하는 URL

[Shortening Service]  
https://en.wikipedia.org/wiki/URL_shortening => http://localhost/RTbpeNTl  
- webapp 으로 개발하고 URL 입력폼 제공 및 결과 출력  
- URL Shortening Key 는 8 Character 이내로 생성되어야 합니다.  
- 동일한 URL 에 대한 요청은 동일한 Shortening Key 로 응답해야 합니다.  
- Shortening 된 URL 을 요청받으면 원래 URL 로 리다이렉트 합니다.  
- Shortening Key 생성 알고리즘은 직접 구현해야 합니다. (라이브러리 사용 불가)  
- Unit Test 코드 작성  
- Database 사용은 필수 아님 (선택)  
	
- 기타
	- README.md 파일에 프로젝트 소개 및 문제해결 전략 그리고 프로젝트 빌드와 실행 방법 명시
	- 언어, 프레임워크의 제한 없음

  
  
##**문제해결**

- Shortening url 생성 알고리즘  
		1. Unique한 URL 생성을 위해  Java.util.Random Seed값을 DB Autoincreament Sequence를 통해 Long 타입의 난수생성  
		2. 1번의 난수값을 A-Z, a-z, 0-9 총 62글자의 8 character 경우의 수  MAX 218340105584896 + 1로 나눈 값으로 난수범위 생성  
		3. 2번의 나머지 값을 62로 나눈 나머지 값으로 순차적으로 while문을 돌면서 몫이 0보다 클때까지 62글자에서 추출  
			ex) 난수가 max값일시 나머지가 0으로 62글자 중 첫글자 8개로 생성   
  
  

##**API정보**

- 데이터 타입 : JSON  
	{
	  "SUCCESS_YN": "Y",
	  "Raw_URL": "http://www.kakaopay.com",
	  "Result": "조회"
    }
	
- 방식 AJAX / Method : POST 

- 호출 URL :   http://localhost:8080//KakaoPayShorteningUrl/RawUrlReceive.jsp  // 기본 URL 입력시   
             http://localhost:8080//KakaoPayShorteningUrl/ShortUrlReceive.jsp  // Shortening URL 입력시 

  
  
##**개발환경**
- JAVA8
- Jquery
- AJAX
- JSON
- InMemoryDB(Apache Derby)

  
  
##**빌드 및 생성 방법**
- InMemoryDB 설치 프로젝트에 첨부된 db-derby-10.14.2.0-bin.zip => 설치경로 C:\Apache
	
	1. 프롬프트 창 OPEN  
	C:\>cd Apache  
	C:\Apache>cd db-derby-10.14.2.0-bin  
	C:\Apache\db-derby-10.14.2.0-bin>cd bin  
	C:\Apache\db-derby-10.14.2.0-bin\bin>startNetworkServer  
	Sat Aug 03 03:12:35 KST 2019 : 기본 서버 보안 정책을 사용하여 보안 관리자가 설치  
	됩니다.  
	Sat Aug 03 03:12:36 KST 2019 : Apache Derby 네트워크 서버 - 10.14.2.0 - (1828579
	)이(가) 시작되어 1527 포트에서 접속을 승인할 준비가 되었습니다.  

	2. 새로운 프롬프트창 OPEN  
	C:\>cd Apache  
	C:\Apache>cd db-derby-10.14.2.0-bin  
	C:\Apache\db-derby-10.14.2.0-bin>cd bin  
	C:\Apache\db-derby-10.14.2.0-bin\bin>ij  
	ij 버전 10.14  
	ij> driver 'org.apache.derby.jdbc.ClientDriver';  
	ij> connect 'jdbc:derby://localhost:1527/MyDb';  
	ij>  
	테이블 및 시퀀스 생성  
	CREATE TABLE URL_MAPPING (ID INT NOT NULL,  RAW_URL VARCHAR(4000), SHORT_URL VARCHAR(8));  
	CREATE sequence seq AS int start with 1;  
	  