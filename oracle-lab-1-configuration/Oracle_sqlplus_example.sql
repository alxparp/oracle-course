/* 
������� ������� ������ ��� ������ � SQL Plus
������ ������ �.�. blazhko@ieee.org
��������� cp1251 (WIN)

*/

-- 0. ������ ��������� sqlplus
-- 1. ����������� � ������� �� ����� ��������������
-- �������� 
-- 1-� ������� - ����� ����� ���� Oracle
CONNECT system/������
-- 2-� ������� - � ��������� ������ �� (� �� Windows-������� cmd , � �� Linux - ���� ��������� �������)
-- a) ����������� � ������� ( ��� �� - �� ���������)
sqlplus system/1234
-- b) ����������� � �������, ��� �� - TNS-��� XE
sqlplus system/1234@XE
-- c) ����������� � �������
sqlplus system/1234@localhost
-- d) ����������� � ������� ( IP = localhost, port=1521, ��� �� (SID) = XE )
sqlplus system/1234@localhost:1521/XE

-- 2. ����������� ������ ������������ student c ������� p1234
CREATE USER student IDENTIFIED BY p1234;

-- 3. �������������� ������������ student ���� ������� � ������� (CONNECT) � ���� ���������� ��������� (RESOURCE)
GRANT CONNECT, RESOURCE TO student;

-- 4. ����� �������������� (����������)
DISCONNECT;

-- 5. ����������� � ������� ������ ������������
CONNECT student/p1234

-- 6. �������� ���� ������ ����� �������� �����-�������, �������������� �� ������ c:\db_example.sql
@ c:\db_example.sql

-- 7. ��������� sqlplus ( ������ ���� ������ )
SET LINESIZE 120
SET PAGESIZE 30

