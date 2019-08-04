# KAKAOPAY �系�����ý��� ��������

##**ROOT Page**
- URL : http://localhost:8080//KakaoPayShorteningUrl/InsertUrl.jsp

  
  
##**�䱸����**    
[�������� ������Ʈ ����]  
- URL �� �Է¹޾� ª�� �ٿ��ְ�, Shortening �� URL �� �Է��ϸ� ���� URL �� �����̷�Ʈ�ϴ� URL

[Shortening Service]  
https://en.wikipedia.org/wiki/URL_shortening => http://localhost/RTbpeNTl  
- webapp ���� �����ϰ� URL �Է��� ���� �� ��� ���  
- URL Shortening Key �� 8 Character �̳��� �����Ǿ�� �մϴ�.  
- ������ URL �� ���� ��û�� ������ Shortening Key �� �����ؾ� �մϴ�.  
- Shortening �� URL �� ��û������ ���� URL �� �����̷�Ʈ �մϴ�.  
- Shortening Key ���� �˰����� ���� �����ؾ� �մϴ�. (���̺귯�� ��� �Ұ�)  
- Unit Test �ڵ� �ۼ�  
- Database ����� �ʼ� �ƴ� (����)  
	
- ��Ÿ
	- README.md ���Ͽ� ������Ʈ �Ұ� �� �����ذ� ���� �׸��� ������Ʈ ����� ���� ��� ���
	- ���, �����ӿ�ũ�� ���� ����

  
  
##**�����ذ�**

- Shortening url ���� �˰���  
		1. Unique�� URL ������ ����  Java.util.Random Seed���� DB Autoincreament Sequence�� ���� Long Ÿ���� ��������  
		2. 1���� �������� A-Z, a-z, 0-9 �� 62������ 8 character ����� ��  MAX 218340105584896 + 1�� ���� ������ �������� ����  
		3. 2���� ������ ���� 62�� ���� ������ ������ ���������� while���� ���鼭 ���� 0���� Ŭ������ 62���ڿ��� ����  
			ex) ������ max���Ͻ� �������� 0���� 62���� �� ù���� 8���� ����   
  
  

##**API����**

- ������ Ÿ�� : JSON  
	{
	  "SUCCESS_YN": "Y",
	  "Raw_URL": "http://www.kakaopay.com",
	  "Result": "��ȸ"
    }
	
- ��� AJAX / Method : POST 

- ȣ�� URL :   http://localhost:8080//KakaoPayShorteningUrl/RawUrlReceive.jsp  // �⺻ URL �Է½�   
             http://localhost:8080//KakaoPayShorteningUrl/ShortUrlReceive.jsp  // Shortening URL �Է½� 

  
  
##**����ȯ��**
- JAVA8
- Jquery
- AJAX
- JSON
- InMemoryDB(Apache Derby)

  
  
##**���� �� ���� ���**
- InMemoryDB ��ġ ������Ʈ�� ÷�ε� db-derby-10.14.2.0-bin.zip => ��ġ��� C:\Apache
	
	1. ������Ʈ â OPEN  
	C:\>cd Apache  
	C:\Apache>cd db-derby-10.14.2.0-bin  
	C:\Apache\db-derby-10.14.2.0-bin>cd bin  
	C:\Apache\db-derby-10.14.2.0-bin\bin>startNetworkServer  
	Sat Aug 03 03:12:35 KST 2019 : �⺻ ���� ���� ��å�� ����Ͽ� ���� �����ڰ� ��ġ  
	�˴ϴ�.  
	Sat Aug 03 03:12:36 KST 2019 : Apache Derby ��Ʈ��ũ ���� - 10.14.2.0 - (1828579
	)��(��) ���۵Ǿ� 1527 ��Ʈ���� ������ ������ �غ� �Ǿ����ϴ�.  

	2. ���ο� ������Ʈâ OPEN  
	C:\>cd Apache  
	C:\Apache>cd db-derby-10.14.2.0-bin  
	C:\Apache\db-derby-10.14.2.0-bin>cd bin  
	C:\Apache\db-derby-10.14.2.0-bin\bin>ij  
	ij ���� 10.14  
	ij> driver 'org.apache.derby.jdbc.ClientDriver';  
	ij> connect 'jdbc:derby://localhost:1527/MyDb';  
	ij>  
	���̺� �� ������ ����  
	CREATE TABLE URL_MAPPING (ID INT NOT NULL,  RAW_URL VARCHAR(4000), SHORT_URL VARCHAR(8));  
	CREATE sequence seq AS int start with 1;  
	  