/* DDL */
DROP TABLE tipinfo;

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

-- 실생활 팁 관련 테이블
CREATE TABLE tipinfo(
  tip_id VARCHAR2(50),
  tip_name VARCHAR2(50),
  tip_content VARCHAR2(200),
  tip_ref_address VARCHAR2(200),
  PRIMARY KEY(tip_id)
);

-- 테이블 구조 변경 --
ALTER TABLE sensorvalue ADD(sensor_value_1_on_off_flag VARCHAR2(10));
ALTER TABLE sensorvalue ADD(sensor_value_2_on_off_flag VARCHAR2(10));
ALTER TABLE sensorvalue ADD(sensor_value_3_on_off_flag VARCHAR2(10));
-- 

DROP TABLE userinfo;
    
/* TCL */
COMMIT;


/* DML */
SELECT * 
FROM userinfo;

SELECT * 
FROM sensorvalue;

SELECT *
FROM TIPINFO;

-- 팁 검색 --
SELECT * FROM TIPINFO WHERE TIPINFO.tip_name = '전기절약 팁!!';

UPDATE TIPINFO SET TIP_REF_ADDRESS = 'http://www.google.com' WHERE TIP_ID = 'tip2';
UPDATE TIPINFO SET TIP_REF_ADDRESS = 'http://blog.naver.com/scw0531' WHERE TIP_ID = 'tip3';
-- 회원 테이블 샘플 데이터
INSERT INTO userinfo 
VALUES('scw3315', 'tjckd246!', '서창욱', '경기도 수원시 장안구 이목동 수원장안힐스테이트', '01042084757', 1, 'ROLE_ADMIN');

INSERT INTO userinfo 
VALUES('scw0531', '1234', 'tester', '서울특별시 금천구 가산디지털단지', '01011112222', 0, 'ROLE_USER');

-- 센서값 테이블 기초데이터 삽입 --
INSERT INTO sensorvalue 
VALUES('e56abaff45aa8b8684e7df96a4f89c7f754ac457','10003', 'motionsensor', '', '', '', SYSDATE, '');

INSERT INTO sensorvalue 
VALUES('scw3315','10002', 'lightsensor', '', '','', SYSDATE, '');

-- 팁 관련 테이블 데이터 삽입 --
INSERT INTO tipinfo
VALUES('tip1', '전기절약 팁!!', '전기를 절약합시다', 'http://www.naver.com');

INSERT INTO tipinfo
VALUES('tip2', '수도절약 팁!!', '수도를 절약합시다', 'http://www.naver.com');

INSERT INTO tipinfo
VALUES('tip3', '환기 팁!!', '환기를 시킵시다', 'http://www.naver.com');

-- 센서값 테이블 업데이트 --
UPDATE sensorvalue 
SET sensor_value_1 = '27', sensor_value_2 = '36', sensor_modify_date = SYSDATE 
WHERE sensor_id = '10001' AND user_id = 'scw3315';

UPDATE sensorvalue SET user_id = '20e3266ddc4790e43799144fe51afae92b7281e8' WHERE user_id = 'scw3314';
UPDATE userinfo SET user_id = 'ed9a67a963f6e79d40b7275e299de690efc48232' WHERE user_id = 'scw0531';
COMMIT;

UPDATE sensorvalue 
SET sensor_value_1_on_off_flag = '0', sensor_value_2_on_off_flag = '0', sensor_value_3_on_off_flag = '0' 
WHERE sensor_id = '10002' AND user_id = '1595d09bdc5a5154d5abfb31203753bdf03c2470';

ROLLBACK;

-- 센서값 테이블 제거 --
delete from sensorvalue where user_id = 'scw3314';

-- 유저테이블 제거 --
delete from userinfo where user_id = 'scw3314';

-- 팁 관련 테이블 데이터 제거 --
delete from TIPINFO;

-- 유저 상세 데이터 추출 --
SELECT u.user_id, u.user_address, s.sensor_name, u.USER_NAME, u.USER_PHONENUMBER
FROM userinfo u, sensorvalue s
WHERE u.user_id = s.user_id AND u.user_id = 'scw3315';

/* PROCEDURE */
-- 회원가입 로직(센서 유무 선택에 따른 센서 테이블 등록) --
create or replace PROCEDURE ENROLL_USER 
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
    
    INSERT INTO sensorvalue 
    VALUES(IN_USER_ID,'10003', 'motionsensor', '', '','', SYSDATE, '');
    
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