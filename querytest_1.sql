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

/* 유저 추가 */
