/* DDL */
DROP TABLE userinfo;

-- ȸ�� ���̺� ���� --
CREATE TABLE userinfo(
    user_id VARCHAR2(50),
    user_pswd VARCHAR2(150), --> ��ȣȭ ���� 
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

-- ȸ�� ���̺� ���� ������
INSERT INTO userinfo values('scw3315', 'tjckd246!', '��â��', '��⵵ ������ ��ȱ� �̸� ���������������Ʈ', '01042084757', 1);

/* PROCEDURE */
