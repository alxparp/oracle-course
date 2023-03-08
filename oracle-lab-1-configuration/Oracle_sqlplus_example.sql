/* 
Примеры простых команд при работе с SQL Plus
Лектор Блажко А.А. blazhko@ieee.org
Кодировка cp1251 (WIN)

*/

-- 0. Запуск программы sqlplus
-- 1. Подключение к системе от имени администратора
-- Варианты 
-- 1-й вариант - через пункт меню Oracle
CONNECT system/пароль
-- 2-й вариант - с командной строки ОС (в ОС Windows-команда cmd , в ОС Linux - свои известные способы)
-- a) Подключение к системе ( имя БД - по умолчанию)
sqlplus system/1234
-- b) Подключение к системе, имя БД - TNS-имя XE
sqlplus system/1234@XE
-- c) Подключение к системе
sqlplus system/1234@localhost
-- d) Подключение к системе ( IP = localhost, port=1521, имя БД (SID) = XE )
sqlplus system/1234@localhost:1521/XE

-- 2. Регистрация нового пользователя student c паролем p1234
CREATE USER student IDENTIFIED BY p1234;

-- 3. Предоставление пользователю student прав доступа к системе (CONNECT) и прав управления ресурсами (RESOURCE)
GRANT CONNECT, RESOURCE TO student;

-- 4. Выход администратора (отключение)
DISCONNECT;

-- 5. Подключение к системе нового пользователя
CONNECT student/p1234

-- 6. Создание базы данных через загрузку файла-скрипта, расположенного по адресу c:\db_example.sql
@ c:\db_example.sql

-- 7. Настройка sqlplus ( размер окна вывода )
SET LINESIZE 120
SET PAGESIZE 30

