/*회원 정보를 저장하는 테이블*/

Create Table mbtbl(
	idx number not null, --행의 번호 1씩증가
	id varchar2(100) not null, --회원의 id
	pass varchar2(100) not null, --회원의 password정보를 저장
	name varchar2(100) not null, --회원의 이름을 저장하는 컬럼
	email varchar2(100) not null, --email 정보 저장
	city varchar2(100) null,
	phone varchar2(100)  null
);

alter table mbtbl
add constraint mbtbl_id_pk primary key (id);

/*	
 	01 : statement , 02 : preparedStatement
 	insert01.jsp	: 사용자 정보를 입력
  	list01.jsp 		: 사용자 정보를 출력
  	delete01.jsp	: 사용자 정보를 삭제
  	update01.jsp	: 사용자 정보를 수정
 */
