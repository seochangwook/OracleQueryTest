/* 유저 테이블 생성 및 검증 */
create table userinfo
(
    user_id varchar2(50), --유저 아이디
    user_password varchar2(150), -- 유저 비밀번호
    user_email varchar2(150), -- 유저 이메일
    user_phonenumber varchar2(50), -- 유저 핸드폰 번호
    user_manage number(2), --관리자 유무
    user_reg_date DATE, -- 가입날짜
    user_push_use number(2), -- 이메일 알림 유무
    primary key(user_id)
);

COMMIT;
    
select * from userinfo;

/* 유저 추가 (추후에 메일 수신동의 테이블과 같이 프로시저 태워서 추가)*/
INSERT INTO userinfo(user_id, user_password, user_email, user_phonenumber, user_manage, user_reg_date, user_push_use)
VALUES('scw3315', 'tjckd246!', 'scw05313315@gmail.com', '01042084757', 1, sysdate, 1);
INSERT INTO userinfo(user_id, user_password, user_email, user_phonenumber, user_manage, user_reg_date, user_push_use)
VALUES('scw0531', '1234', 'scw0531@naver.com', '01047243307', 0, sysdate, 1);