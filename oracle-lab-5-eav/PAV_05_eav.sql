-- 1. Create a logical database called your_eav_name

-- 2. In the database, create database tables of the EAV/CR type.

drop table OBJTYPE CASCADE CONSTRAINTS;
drop table ATTRTYPE CASCADE CONSTRAINTS;
drop table OBJECTS CASCADE CONSTRAINTS;
drop table ATTRIBUTES CASCADE CONSTRAINTS;
drop table OBJREFERENCE CASCADE CONSTRAINTS;

CREATE TABLE OBJTYPE
  (
    OBJECT_TYPE_ID NUMBER(20) NOT NULL ENABLE,
    PARENT_ID      NUMBER(20),
    CODE           VARCHAR2(20) NOT NULL UNIQUE,
    NAME           VARCHAR2(200 BYTE),
    DESCRIPTION    VARCHAR2(1000 BYTE),
    CONSTRAINT CON_OBJECT_TYPE_ID 
		PRIMARY KEY (OBJECT_TYPE_ID),
    CONSTRAINT CON_PARENT_ID 
		FOREIGN KEY (PARENT_ID) 
			REFERENCES OBJTYPE (OBJECT_TYPE_ID) 
			ON DELETE CASCADE ENABLE
  );
  
  
CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20) NOT NULL,
    OBJECT_TYPE_ID 		NUMBER(20) NOT NULL,
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200 BYTE),
    CONSTRAINT CON_ATTR_ID 
		PRIMARY KEY (ATTR_ID),
    CONSTRAINT CON_ATTR_OBJECT_TYPE_ID 
		FOREIGN KEY (OBJECT_TYPE_ID) 
			REFERENCES OBJTYPE (OBJECT_TYPE_ID),
	CONSTRAINT CON_ATTR_OBJECT_TYPE_ID_REF 
		FOREIGN KEY (OBJECT_TYPE_ID_REF) 
			REFERENCES OBJTYPE (OBJECT_TYPE_ID)
);


CREATE TABLE OBJECTS (
    OBJECT_ID      NUMBER(20) NOT NULL,
    PARENT_ID      NUMBER(20),
    OBJECT_TYPE_ID NUMBER(20) NOT NULL,
    NAME           VARCHAR2(2000 BYTE),
    DESCRIPTION    VARCHAR2(4000 BYTE),
    CONSTRAINT CON_OBJECTS_ID 
		PRIMARY KEY (OBJECT_ID),
    CONSTRAINT CON_PARENTS_ID 
		FOREIGN KEY (PARENT_ID) 
			REFERENCES OBJECTS (OBJECT_ID) 
			ON DELETE CASCADE DEFERRABLE,
    CONSTRAINT CON_OBJ_TYPE_ID 
		FOREIGN KEY (OBJECT_TYPE_ID) 
			REFERENCES OBJTYPE (OBJECT_TYPE_ID)
);


CREATE TABLE ATTRIBUTES
  (
    ATTR_ID    NUMBER(20) NOT NULL,
    OBJECT_ID  NUMBER(20) NOT NULL,
    VALUE      VARCHAR2(4000 BYTE),
    DATE_VALUE DATE,
	CONSTRAINT CON_ATTRIBUTES_PK 
		PRIMARY KEY (ATTR_ID,OBJECT_ID),
    CONSTRAINT CON_AOBJECT_ID 
		FOREIGN KEY (OBJECT_ID) 
			REFERENCES OBJECTS (OBJECT_ID) 
			ON DELETE CASCADE,
    CONSTRAINT CON_AATTR_ID 
		FOREIGN KEY (ATTR_ID) 
			REFERENCES ATTRTYPE (ATTR_ID) 
			ON DELETE CASCADE
  ); 
  
  
CREATE TABLE OBJREFERENCE
  (
    ATTR_ID   NUMBER(20) NOT NULL,
    REFERENCE NUMBER(20) NOT NULL,
    OBJECT_ID NUMBER(20) NOT NULL,
	CONSTRAINT CON_OBJREFERENCE_PK 
		PRIMARY KEY (ATTR_ID,REFERENCE,OBJECT_ID),
    CONSTRAINT CON_REFERENCE 
		FOREIGN KEY (REFERENCE) 
			REFERENCES OBJECTS (OBJECT_ID) 
			ON DELETE CASCADE,
    CONSTRAINT CON_ROBJECT_ID 
		FOREIGN KEY (OBJECT_ID) 
			REFERENCES OBJECTS (OBJECT_ID) 
			ON DELETE CASCADE,
    CONSTRAINT CON_RATTR_ID 
		FOREIGN KEY (ATTR_ID) 
			REFERENCES ATTRTYPE (ATTR_ID) 
			ON DELETE CASCADE
  );
 

-- 3. For classes from the UML diagram that describe cities and subdivisions, 
--    fill in descriptions of object types, attribute types. 

-- 4. For each class, create two object instances by filling in the 
--    appropriate tables.

-- 6. For classes from the UML diagram that describe employees, fill in the 
--    descriptions of object types, attribute types.

-- 7. For each class, create two object instances by filling in the 
--    appropriate tables.
  
-- INSERT INTO OBJTYPE

insert into objtype (obj_type_id, parent_id, code, name, description)
values (1, null, 'LOC', 'Місто', null);

insert into objtype (obj_type_id, parent_id, code, name, description)
values (2, 1, 'DEP', 'Офіс', null);

insert into objtype (obj_type_id, parent_id, code, name, description)
values (3, null, 'EMP', 'Співробітник', null);

insert into objtype (obj_type_id, parent_id, code, name, description)
values (4, 3, 'MGR', 'Менеджер', null);

-- insert into objtype (obj_type_id, parent_id, code, name, description)
-- values (5, 3, 'SM', 'Продавець', null); 

-- insert into objtype (obj_type_id, parent_id, code, name, description)
-- values (6, 3, 'SP', 'Постачальник', null); 

insert into objtype (obj_type_id, parent_id, code, name, description)
values (5, null, 'PROD', 'Продукт', null);


-- INSERT INTO ATTRTYPE

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (1, 1, null, 'NAME', 'Назва');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (2, 1, null, 'POSTAL_CODE', 'Поштовий код');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (3, 1, null, 'ADDRESS', 'Адреса');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (4, 1, null, 'COUNTRY', 'Країна');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (5, 1, null, 'REGION', 'Регіон');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (6, 2, null, 'NAME', 'Назва');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (7, 3, null, 'FIRST_NAME', 'Імя');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (8, 3, null, 'LAST_NAME', 'Фамілія');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (9, 3, null, 'EMAIL', 'Ел. пошта');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (10, 3, null, 'SALARY', 'Зарплатня');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (11, 3, null, 'HIRE_DATE', 'Дата найму');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (12, 5, null, 'NAME', 'Назва');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (13, 5, null, 'PRICE', 'Ціна');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (14, 5, null, 'COUNT', 'Кількість');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (15, 3, 5, 'BUY', 'Купівля');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (16, 3, 5, 'SELL', 'Продаж');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (17, 3, 2, 'WORK', 'Робота');

insert into attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
values (18, 3, 4, 'MANAGEMENT', 'Управління');


-- INSERT INTO OBJECTS

insert into objects (object_id, parent_id, object_type_id, name, description)
values (1, null, 1, 'Odesa', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (2, 1, 2, 'Odesa Office', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (3, null, 3, 'Sidorov Sidor Sidorovich', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (4, null, 3, 'Petrov Petr Petrovich', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (5, null, 3, 'Ivanov Ivan Ivanovich', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (6, null, 5, 'Kiwi', null);

insert into objects (object_id, parent_id, object_type_id, name, description)
values (7, null, 5, 'Apple', null);


-- INSERT INTO ATTRIBUTES

insert into attributes (attr_id, object_id, value, date_value)
values (1, 1, 'Odesa', null);

insert into attributes (attr_id, object_id, value, date_value)
values (2, 1, 52345, null);

insert into attributes (attr_id, object_id, value, date_value)
values (3, 1, 'Tenistaya, 9/11', null);

insert into attributes (attr_id, object_id, value, date_value)
values (4, 1, 'Ukraine', null);

insert into attributes (attr_id, object_id, value, date_value)
values (5, 1, 'EASTERN', null);

insert into attributes (attr_id, object_id, value, date_value)
values (6, 2, 'Odesa Office', null);

insert into attributes (attr_id, object_id, value, date_value)
values (7, 3, 'Sidor', null);

insert into attributes (attr_id, object_id, value, date_value)
values (8, 3, 'Sidorov', null);

insert into attributes (attr_id, object_id, value, date_value)
values (9, 3, 'sidor@gmail.com', null);

insert into attributes (attr_id, object_id, value, date_value)
values (10, 3, 10000, null);

insert into attributes (attr_id, object_id, value, date_value)
values (11, 3, null, '22.04.23');

insert into attributes (attr_id, object_id, value, date_value)
values (12, 6, 'Kiwi', null);

insert into attributes (attr_id, object_id, value, date_value)
values (13, 6, 50, null);

insert into attributes (attr_id, object_id, value, date_value)
values (14, 6, 10, null);


-- INSERT INTO OBJREFERENCE

insert into objreference (attr_id, object_id, reference)
values (15, 6, 3);

insert into objreference (attr_id, object_id, reference)
values (16, 6, 4);

insert into objreference (attr_id, object_id, reference)
values (17, 3, 2);

insert into objreference (attr_id, object_id, reference)
values (17, 4, 2);

insert into objreference (attr_id, object_id, reference)
values (17, 5, 2);

insert into objreference (attr_id, object_id, reference)
values (18, 3, 5);

insert into objreference (attr_id, object_id, reference)
values (18, 4, 5);


-- 5. Run a query to the database, which receives the name of cities and 
--    subdivisions.

SELECT 
    LOC.NAME LOC, DEP.NAME DEP
FROM 
    OBJECTS LOC, OBJECTS DEP,
    OBJTYPE LOC_TYPE, OBJTYPE DEP_TYPE
WHERE 
    LOC.OBJECT_TYPE_ID = LOC_TYPE.OBJECT_TYPE_ID
    AND LOC_TYPE.CODE = 'LOC'
    
    AND DEP.OBJECT_TYPE_ID = DEP_TYPE.OBJECT_TYPE_ID
    AND DEP_TYPE.CODE = 'DEP'
    
    AND DEP.PARENT_ID = LOC.OBJECT_ID;
	

-- 8. Run a query to the database that receives the last name of the employees 
--    and the salary of the employees.

SELECT 
    LASTNAME_ATTR.VALUE LAST_NAME, SALARY_ATTR.VALUE SALARY
FROM 
    ATTRIBUTES LASTNAME_ATTR, ATTRIBUTES SALARY_ATTR,
    ATTRTYPE LASTNAME_TYPE, ATTRTYPE SALARY_TYPE,
    OBJECTS EMP
WHERE
    LASTNAME_ATTR.ATTR_ID = LASTNAME_TYPE.ATTR_ID
    AND LASTNAME_TYPE.CODE = 'LAST_NAME'
    
    AND SALARY_ATTR.ATTR_ID = SALARY_TYPE.ATTR_ID
    AND SALARY_TYPE.CODE = 'SALARY'
    
    AND LASTNAME_ATTR.OBJECT_ID = EMP.OBJECT_ID
    AND SALARY_ATTR.OBJECT_ID = EMP.OBJECT_ID;


-- 9. Run a query to the database, which:
--    - receives the names of departments;
--    - receives the names of employees working in the specified divisions;
--    - units are located in one of the cities, the name of which was 
--      previously entered.

SELECT 
    DEP_ATTR.VALUE DEPARTMENT, LASTNAME_ATTR.VALUE LAST_NAME
FROM 
    ATTRIBUTES DEP_ATTR, ATTRIBUTES LASTNAME_ATTR, ATTRIBUTES CITY_ATTR,
    ATTRTYPE DEP_TYPE, ATTRTYPE LASTNAME_TYPE, ATTRTYPE CITY_TYPE, ATTRTYPE WORK_TYPE,
    OBJREFERENCE REF
WHERE
    DEP_TYPE.CODE = 'NAME'
    AND DEP_ATTR.ATTR_ID = DEP_TYPE.ATTR_ID
    
    AND LASTNAME_TYPE.CODE = 'LAST_NAME'
    AND LASTNAME_ATTR.ATTR_ID = LASTNAME_TYPE.ATTR_ID
    
    AND CITY_ATTR.VALUE = 'Odesa'
    AND CITY_ATTR.ATTR_ID = CITY_TYPE.ATTR_ID
    AND CITY_TYPE.CODE = 'NAME'
    
    AND DEP_ATTR.OBJECT_ID = REF.REFERENCE
    AND LASTNAME_ATTR.OBJECT_ID = REF.OBJECT_ID
    
    AND REF.ATTR_ID = WORK_TYPE.ATTR_ID
    AND WORK_TYPE.CODE = 'WORK';
	
	

