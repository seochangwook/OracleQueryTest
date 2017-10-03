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

-- 센서값 테이블 생성(필요시 value를 추가하는 형태로 가변적 가능, 센서의 정보에 따라서 유동적) --
-- 실제 센서의 스팩등의 세부사항은 센서 테이블을 참조하여 가져온다 --
CREATE TABLE sensorvalue(
  sensor_id VARCHAR2(50),
  sensor_name VARCHAR2(150),
  sensor_value_1 VARCHAR2(50),
  sensor_value_2 VARCHAR2(50),
  sensor_regDate DATE,
  sensor_modifyDate VARCHAR2(150),
  PRIMARY KEY(sensor_id)
);

-- 

DROP TABLE sensorvalue;
    
/* TCL */
COMMIT;


/* DML */
SELECT * 
FROM userinfo;

SELECT * 
FROM sensorvalue;

-- 회원 테이블 샘플 데이터
INSERT INTO userinfo 
VALUES('scw3315', 'tjckd246!', '서창욱', '경기도 수원시 장안구 이목동 수원장안힐스테이트', '01042084757', 1);

-- 센서값 테이블 기초데이터 삽입 --
INSERT INTO sensorvalue 
VALUES('10001', 'temphumisensor', '', '', SYSDATE, '');

/* PROCEDURE */