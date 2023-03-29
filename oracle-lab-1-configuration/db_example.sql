drop table Emp CASCADE CONSTRAINTS;
drop table Dept CASCADE CONSTRAINTS;
drop table Salgrade CASCADE CONSTRAINTS;

CREATE TABLE Dept(  -- division description
   deptno NUMERIC(2) NOT NuLL,  -- N division
   dname VARCHAR(15) NOT NULL,  -- name of division
   loc VARCHAR(15) NOT NULL, -- division location
   CONSTRAINT dept_pk 
          PRIMARY KEY (deptno), -- column is the primary key 
   CONSTRAINT dept_name_uk 
          UNIQUE (dname) -- column contains non-repeating values
);

CREATE TABLE Emp( -- description of department employees
  empno NUMERIC(4) PRIMARY KEY, -- N employee
  ename VARCHAR(10) NOT NULL, -- employee name
  job VARCHAR(10) NOT NULL, -- employee position
  mgr NUMERIC(4), -- N manager of employee
  hiredate DATE NOT NULL, -- hiredate  
  sal FLOAT NOT NULL, -- employee salary
  comm FLOAT, -- employee commission
  deptno NUMERIC(2),  -- N department, where employee works
  FOREIGN KEY (deptno) 
          REFERENCES Dept (deptno) -- column is a foreign key
);

CREATE TABLE Salgrade( -- description of the salary range for various groups of employees
  grade NUMERIC(1) NOT NULL,  -- N groups of employees
  minsal FLOAT NOT NULL, -- min salary
  hisal FLOAT NOT NULL,  -- max salary
  CONSTRAINT salgrade_pk PRIMARY KEY (grade)
);

commit;

INSERT INTO Salgrade VALUES (1,700,1200);
INSERT INTO Salgrade VALUES (2,1201,1400);
INSERT INTO Salgrade VALUES (3,1401,2000);
INSERT INTO Salgrade VALUES (4,2001,3000);
INSERT INTO Salgrade VALUES (5,3001,9999);

INSERT INTO Dept VALUES (10,'ACCOUNTING','NEW_YORK');
INSERT INTO Dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO Dept VALUES (30,'SALES','CHICAGO');
INSERT INTO Dept VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO Emp VALUES (7839,'KING','PRESIDENT',null,TO_DATE('1981-11-17', 'YYYY-MM-DD'),5000,null,10);
INSERT INTO Emp VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1981-05-01', 'YYYY-MM-DD'), 2850,null,30);
INSERT INTO Emp VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('1981-06-09', 'YYYY-MM-DD'), 1500,null,10);
INSERT INTO Emp VALUES (7566,'JONES','MANAGER',7839,TO_DATE('1981-04-02', 'YYYY-MM-DD'), 2975,null,20);
INSERT INTO Emp VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('1981-09-28', 'YYYY-MM-DD'), 1250,1400,30);
INSERT INTO Emp VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('1981-02-20', 'YYYY-MM-DD'), 1600,300,30);
INSERT INTO Emp VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('1981-09-08', 'YYYY-MM-DD'), 1500,0,30);
INSERT INTO Emp VALUES (7900,'JAMES','CLERK',7698,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 950,null,30);
INSERT INTO Emp VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('1981-02-22', 'YYYY-MM-DD'), 1250,500,30);
INSERT INTO Emp VALUES (7902,'FORD','ANALYST',7566,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 3000,null,20);
INSERT INTO Emp VALUES (7369,'SMITH','CLERK',7902,TO_DATE('1980-12-17', 'YYYY-MM-DD'), 800,null,20);
INSERT INTO Emp VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('1982-12-09', 'YYYY-MM-DD'), 3000,null,20);
INSERT INTO Emp VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('1983-01-12', 'YYYY-MM-DD'), 1100,null,20);
INSERT INTO Emp VALUES (7934,'MILLER','CLERK',7782,TO_DATE('1982-01-23', 'YYYY-MM-DD'), 1300,null,10);

commit;

