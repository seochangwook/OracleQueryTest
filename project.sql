/* DDL */
DROP TABLE userinfo;

-- 회원 테이블 생성 --
CREATE TABLE userinfo(
    user_id VARCHAR2(50),
    user_pswd VARCHAR2(150), --> 암호화 저장 
    user_name VARCHAR2(50),
    user_address VARCHAR2(200) NOT NULL,
    user_phonenumber VARCHAR2(50),
    mailpush_use INTEGER, --> 1/0, 1 : push yes, 0 : push no
    PRIMARY KEY(user_id)
);
DESC userinfo;

-- 
    
/* TCL */
COMMIT;


/* DML */
SELECT * FROM userinfo;

-- 회원 테이블 샘플 데이터
INSERT INTO userinfo values('scw3315', 'tjckd246!', '서창욱', '경기도 수원시 장안구 이목동 수원장안힐스테이트', '01042084757', 1);

/* PROCEDURE */
