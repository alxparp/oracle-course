-- DROP TABLES
DROP TABLE TRANSACTION CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE POSITION CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;


-- CREATE TABLES
CREATE TABLE PRODUCT (
    product_id NUMBER(2),
    product_name VARCHAR(32),
    price REAL NOT NULL
);

CREATE TABLE LOCATION (
    location_id NUMBER(2),
    city_name VARCHAR2(32)
);

CREATE TABLE DEPARTMENT (
    department_id NUMBER(2),
    department_name VARCHAR2(32),
    location_id NUMBER(2) NOT NULL
);

CREATE TABLE POSITION (
    position_id NUMBER(2),
    position_name VARCHAR(32)
);

CREATE TABLE EMPLOYEE (
    employee_id NUMBER(2),
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR2(32) NOT NULL,
    hire_date DATE NOT NULL,
    manager_id NUMBER(2) NOT NULL,
    department_id NUMBER(2) NOT NULL,
    position_id NUMBER(2) NOT NULL
);

CREATE TABLE TRANSACTION (
    trans_id NUMBER(2),
    trans_type VARCHAR2(8),
    trans_date date NOT NULL,
    product_id NUMBER(2) NOT NULL,
    employee_id NUMBER(2) NOT NULL
);


-- CREATE PRIMARY KEYS
ALTER TABLE PRODUCT ADD
    CONSTRAINT PROD_PK
        PRIMARY KEY (product_id);

ALTER TABLE LOCATION ADD
    CONSTRAINT LOC_PK
        PRIMARY KEY (location_id);

ALTER TABLE DEPARTMENT ADD
    CONSTRAINT DEP_PK
        PRIMARY KEY (department_id);

ALTER TABLE POSITION ADD
    CONSTRAINT POS_PK
        PRIMARY KEY (position_id);

ALTER TABLE EMPLOYEE ADD
    CONSTRAINT EMPL_PK
        PRIMARY KEY (employee_id);

ALTER TABLE TRANSACTION ADD
    CONSTRAINT TRANS_PK
        PRIMARY KEY (trans_id);


-- CREATE FOREIGN KEYS
ALTER TABLE DEPARTMENT ADD
        CONSTRAINT DEP_LOC_FK 
            FOREIGN KEY (location_id)
                REFERENCES LOCATION (location_id);
                               
ALTER TABLE EMPLOYEE ADD
        CONSTRAINT EMPL_MNG_FK 
            FOREIGN KEY (manager_id)
                REFERENCES EMPLOYEE (employee_id); 
                
ALTER TABLE EMPLOYEE ADD
        CONSTRAINT EMPL_DEP_FK 
            FOREIGN KEY (department_id)
                REFERENCES DEPARTMENT (department_id);                
                
ALTER TABLE EMPLOYEE ADD
        CONSTRAINT EMPL_POS_FK 
            FOREIGN KEY (position_id)
                REFERENCES POSITION (position_id);

ALTER TABLE TRANSACTION ADD
        CONSTRAINT TRANS_PROD_FK 
            FOREIGN KEY (product_id)
                REFERENCES PRODUCT (product_id);   
                
 ALTER TABLE TRANSACTION ADD
        CONSTRAINT TRANS_EMPL_FK 
            FOREIGN KEY (employee_id)
                REFERENCES EMPLOYEE (employee_id);             
       
                
--CHECK
ALTER TABLE TRANSACTION ADD CONSTRAINT tans_types
	CHECK ( trans_type IN ('buy','sell'));  
    

-- POTENTIAL KEYS
ALTER TABLE DEPARTMENT MODIFY (department_name NOT NULL);
ALTER TABLE DEPARTMENT ADD CONSTRAINT dep_key
	UNIQUE (department_name);    
    
ALTER TABLE POSITION MODIFY (position_name NOT NULL);
ALTER TABLE POSITION ADD CONSTRAINT position_key
	UNIQUE (position_name);      
    
ALTER TABLE LOCATION MODIFY (city_name NOT NULL);
ALTER TABLE LOCATION ADD CONSTRAINT location_key
	UNIQUE (city_name);     
    
ALTER TABLE PRODUCT MODIFY (product_name NOT NULL);
ALTER TABLE PRODUCT ADD CONSTRAINT product_key
	UNIQUE (product_name);      
                
                