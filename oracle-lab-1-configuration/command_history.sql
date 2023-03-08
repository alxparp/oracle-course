SQL> alter user system identified by 1234;

User altered.

SQL> connect system/1234;
Connected.
SQL> connect system/1234@XE;
Connected.
SQL> connect system/1234@localhost;
Connected.
SQL> connect system/1234@localhost:1521/xe;
Connected.
SQL> show user;
USER is "SYSTEM"
SQL> create user c##student identified by 1234;

User created.

SQL> connect c##student/1234;
ERROR:
ORA-01045: ¿¿¿¿¿¿¿¿¿¿¿¿ C##STUDENT ¿¿ ¿¿¿¿¿ ¿¿¿¿¿¿¿¿¿¿ CREATE SESSION; ¿¿¿¿ ¿ 
¿¿¿¿¿¿¿ ¿¿¿¿¿¿¿¿¿ 


Warning: You are no longer connected to ORACLE.
SQL> grant all privileges to c##student;
SP2-0640: Not connected
SQL> show user;
USER is ""
SQL> connect system/1234;
Connected.
SQL> grant all privileges to c##student;

Grant succeeded.

SQL> connect c##student/1234;
Connected.
SQL> @ "C:\db_example.sql"
drop table Emp CASCADE CONSTRAINTS
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


drop table Dept CASCADE CONSTRAINTS
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


drop table Salgrade CASCADE CONSTRAINTS
           *
ERROR at line 1:
ORA-00942: table or view does not exist 



Table created.


Table created.


Table created.


Commit complete.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


Commit complete.

SQL> select deptno, dname, loc from dept;

    DEPTNO DNAME           LOC                                                  
---------- --------------- ---------------                                      
        10 ACCOUNTING      NEW_YORK                                             
        20 RESEARCH        DALLAS                                               
        30 SALES           CHICAGO                                              
        40 OPERATIONS      BOSTON                                               

SQL> select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp;

     EMPNO ENAME      JOB               MGR HIREDATE         SAL       COMM     
---------- ---------- ---------- ---------- --------- ---------- ----------     
    DEPTNO                                                                      
----------                                                                      
      7839 KING       PRESIDENT             17-NOV-81       5000                
        10                                                                      
                                                                                
      7698 BLAKE      MANAGER          7839 01-MAY-81       2850                
        30                                                                      
                                                                                
      7782 CLARK      MANAGER          7839 09-JUN-81       1500                
        10                                                                      
                                                                                

     EMPNO ENAME      JOB               MGR HIREDATE         SAL       COMM     
---------- ---------- ---------- ---------- --------- ---------- ----------     
    DEPTNO                                                                      
----------                                                                      
      7566 JONES      MANAGER          7839 02-APR-81       2975                
        20                                                                      
                                                                                
      7654 MARTIN     SALESMAN         7698 28-SEP-81       1250       1400     
        30                                                                      
                                                                                
      7499 ALLEN      SALESMAN         7698 20-FEB-81       1600        300     
        30                                                                      
                                                                                

     EMPNO ENAME      JOB               MGR HIREDATE         SAL       COMM     
---------- ---------- ---------- ---------- --------- ---------- ----------     
    DEPTNO                                                                      
----------                                                                      
      7844 TURNER     SALESMAN         7698 08-SEP-81       1500          0     
        30                                                                      
                                                                                
      7900 JAMES      CLERK            7698 03-DEC-81        950                
        30                                                                      
                                                                                
      7521 WARD       SALESMAN         7698 22-FEB-81       1250        500     
        30                                                                      
                                                                                

     EMPNO ENAME      JOB               MGR HIREDATE         SAL       COMM     
---------- ---------- ---------- ---------- --------- ---------- ----------     
    DEPTNO                                                                      
----------                                                                      
      7902 FORD       ANALYST          7566 03-DEC-81       3000                
        20                                                                      
                                                                                
      7369 SMITH      CLERK            7902 17-DEC-80        800                
        20                                                                      
                                                                                
      7788 SCOTT      ANALYST          7566 09-DEC-82       3000                
        20                                                                      
                                                                                

     EMPNO ENAME      JOB               MGR HIREDATE         SAL       COMM     
---------- ---------- ---------- ---------- --------- ---------- ----------     
    DEPTNO                                                                      
----------                                                                      
      7876 ADAMS      CLERK            7788 12-JAN-83       1100                
        20                                                                      
                                                                                
      7934 MILLER     CLERK            7782 23-JAN-82       1300                
        10                                                                      
                                                                                

14 rows selected.

SQL> set pagesize 80;
SQL> set linesize 120;
SQL> col ename format 99999;
SQL> col mgr format 9999;
SQL> col sal format 99999;
SQL> col comm format 99999;
SQL> col deptno format 999;
SQL> select * from emp;

     EMPNO ENAME      JOB          MGR HIREDATE     SAL   COMM DEPTNO                                                   
---------- ---------- ---------- ----- --------- ------ ------ ------                                                   
      7839 KING       PRESIDENT        17-NOV-81   5000            10                                                   
      7698 BLAKE      MANAGER     7839 01-MAY-81   2850            30                                                   
      7782 CLARK      MANAGER     7839 09-JUN-81   1500            10                                                   
      7566 JONES      MANAGER     7839 02-APR-81   2975            20                                                   
      7654 MARTIN     SALESMAN    7698 28-SEP-81   1250   1400     30                                                   
      7499 ALLEN      SALESMAN    7698 20-FEB-81   1600    300     30                                                   
      7844 TURNER     SALESMAN    7698 08-SEP-81   1500      0     30                                                   
      7900 JAMES      CLERK       7698 03-DEC-81    950            30                                                   
      7521 WARD       SALESMAN    7698 22-FEB-81   1250    500     30                                                   
      7902 FORD       ANALYST     7566 03-DEC-81   3000            20                                                   
      7369 SMITH      CLERK       7902 17-DEC-80    800            20                                                   
      7788 SCOTT      ANALYST     7566 09-DEC-82   3000            20                                                   
      7876 ADAMS      CLERK       7788 12-JAN-83   1100            20                                                   
      7934 MILLER     CLERK       7782 23-JAN-82   1300            10                                                   

14 rows selected.

SQL> connect system/1234;
Connected.
SQL> select * from c##student.dept;

DEPTNO DNAME           LOC                                                                                              
------ --------------- ---------------                                                                                  
    10 ACCOUNTING      NEW_YORK                                                                                         
    20 RESEARCH        DALLAS                                                                                           
    30 SALES           CHICAGO                                                                                          
    40 OPERATIONS      BOSTON                                                                                           

SQL> drop user c##student cascade;

User dropped.

SQL> spool off;
