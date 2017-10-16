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
    role VARCHAR2(20), --security option
    PRIMARY KEY(user_id)
);
DESC userinfo;

-- 센서값 테이블 생성(필요시 value를 추가하는 형태로 가변적 가능, 센서의 정보에 따라서 유동적) --
-- 실제 센서의 스팩등의 세부사항은 센서 테이블을 참조하여 가져온다 --
CREATE TABLE sensorvalue(
  user_id VARCHAR2(50),
  sensor_id VARCHAR2(50),
  sensor_name VARCHAR2(150),
  sensor_value_1 VARCHAR2(50),
  sensor_value_2 VARCHAR2(50),
  sensor_value_3 VARCHAR2(50),
  sensor_reg_date DATE,
  sensor_modify_date VARCHAR2(150),
  PRIMARY KEY(sensor_id, user_id)
);

-- 테이블 구조 변경 --
ALTER TABLE sensorvalue ADD(sensor_value_3 VARCHAR2(50));

-- 

DROP TABLE userinfo;
    
/* TCL */
COMMIT;


/* DML */
SELECT * 
FROM userinfo;

SELECT * 
FROM sensorvalue;

-- 회원 테이블 샘플 데이터
INSERT INTO userinfo 
VALUES('scw3315', 'tjckd246!', '서창욱', '경기도 수원시 장안구 이목동 수원장안힐스테이트', '01042084757', 1, 'ROLE_ADMIN');

INSERT INTO userinfo 
VALUES('scw0531', '1234', 'tester', '서울특별시 금천구 가산디지털단지', '01011112222', 0, 'ROLE_USER');

-- 센서값 테이블 기초데이터 삽입 --
INSERT INTO sensorvalue 
VALUES('scw3315','10001', 'temphumisensor', '', '', '', SYSDATE, '');

INSERT INTO sensorvalue 
VALUES('scw3315','10002', 'lightsensor', '', '','', SYSDATE, '');

-- 센서값 테이블 업데이트 --
UPDATE sensorvalue 
SET sensor_value_1 = '27', sensor_value_2 = '36', sensor_modify_date = SYSDATE 
WHERE sensor_id = '10001' AND user_id = 'scw3315';

ROLLBACK;

-- 센서값 테이블 제거 --
delete from sensorvalue where user_id = 'scw3314';

-- 유저테이블 제거 --
delete from userinfo where user_id = 'scw3314';

-- 유저 상세 데이터 추출 --
SELECT u.user_id, u.user_address, s.sensor_name, u.USER_NAME, u.USER_PHONENUMBER
FROM userinfo u, sensorvalue s
WHERE u.user_id = s.user_id AND u.user_id = 'scw3315';

/* PROCEDURE */
-- 회원가입 로직(센서 유무 선택에 따른 센서 테이블 등록) --
CREATE OR REPLACE PROCEDURE ENROLL_USER 
(
  IN_ENROLL_TYPE IN INTEGER,
  IN_USER_ID IN USERINFO.USER_ID%TYPE,
  IN_USER_PSWD IN USERINFO.USER_PSWD%TYPE, 
  IN_USER_NAME IN USERINFO.USER_NAME%TYPE, 
  IN_USER_ADDRESS IN USERINFO.USER_ADDRESS%TYPE, 
  IN_USER_PHONENUMBER IN USERINFO.USER_PHONENUMBER%TYPE, 
  IN_MAIL_PUSH IN USERINFO.MAILPUSH_USE%TYPE, 
  IN_ROLE IN USERINFO.ROLE%TYPE,
  OUT_RESULT_VALUE OUT VARCHAR2
)
IS
-- 커서정의, 사용할 변수 정의
v_result_col NUMBER;
BEGIN
  IF IN_ENROLL_TYPE = 1 THEN -- 중복로그인 검사 --
    DBMS_OUTPUT.PUT_LINE('중복로그인 검사');
    SELECT 
      COUNT(*) INTO v_result_col 
    FROM 
      USERINFO
    WHERE
      USERINFO.USER_ID = IN_USER_ID;
    IF v_result_col >= 1 THEN
      OUT_RESULT_VALUE := 0;
      DBMS_OUTPUT.PUT_LINE('이미 존재하는 ID입니다');
    ELSIF v_result_col = 0 THEN
      OUT_RESULT_VALUE := 1;
      DBMS_OUTPUT.PUT_LINE('사용가능한 ID입니다');
    END IF;
    DBMS_OUTPUT.PUT_LINE('result: ' || OUT_RESULT_VALUE);
  ELSIF IN_ENROLL_TYPE = 2 THEN -- 회원가입 --
    -- 유저테이블 insert --
    INSERT INTO userinfo 
    VALUES(IN_USER_ID, IN_USER_PSWD, IN_USER_NAME, IN_USER_ADDRESS, IN_USER_PHONENUMBER, IN_MAIL_PUSH, IN_ROLE);
    
    --관련 센서 테이블 추가 --
    INSERT INTO sensorvalue 
    VALUES(IN_USER_ID,'10001', 'temphumisensor', '', '', '', SYSDATE, '');

    INSERT INTO sensorvalue 
    VALUES(IN_USER_ID,'10002', 'lightsensor', '', '','', SYSDATE, '');
    
    COMMIT;
    
    OUT_RESULT_VALUE := 1;
  ELSE
    OUT_RESULT_VALUE := '-1';
  END IF;
EXCEPTION -- 예외처리
WHEN OTHERS THEN
  OUT_RESULT_VALUE := '-1';
  ROLLBACK;
END;