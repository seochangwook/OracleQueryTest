/* ���� ���̺� ���� �� ���� */
create table userinfo
(
    user_id varchar2(50), --���� ���̵�
    user_password varchar2(150), -- ���� ��й�ȣ
    user_email varchar2(150), -- ���� �̸���
    user_phonenumber varchar2(50), -- ���� �ڵ��� ��ȣ
    user_manage number(2), --������ ����
    user_reg_date DATE, -- ���Գ�¥
    user_push_use number(2), -- �̸��� �˸� ����
    primary key(user_id)
);

COMMIT;
    
select * from userinfo;

/* ���� �߰� (���Ŀ� ���� ���ŵ��� ���̺�� ���� ���ν��� �¿��� �߰�)*/
INSERT INTO userinfo(user_id, user_password, user_email, user_phonenumber, user_manage, user_reg_date, user_push_use)
VALUES('scw3315', 'tjckd246!', 'scw05313315@gmail.com', '01042084757', 1, sysdate, 1);
INSERT INTO userinfo(user_id, user_password, user_email, user_phonenumber, user_manage, user_reg_date, user_push_use)
VALUES('scw0531', '1234', 'scw0531@naver.com', '01047243307', 0, sysdate, 1);