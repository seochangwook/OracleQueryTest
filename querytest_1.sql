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

/* ���� �߰� */
