##1

DECLARE
number_max NUMBER;
new_department_name DEPARTMENTS.DEPARTMENT_NAME%TYPE:='EDUCATION';
BEGIN
SELECT MAX(DEPARTMENT_ID) INTO numer_max 
FROM DEPARTMENTS;
DBMS_OUTPUT.PUT_LINE('Najwyższe id departamentu to: ' || number_max);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) 
VALUES (numer_max+10, new_department_name, NULL, NULL);
END;

##2

DECLARE
number_max NUMBER;
new_number_max NUMBER;
new_department_name DEPARTMENTS.DEPARTMENT_NAME%TYPE:='EDUCATION';
BEGIN
SELECT MAX(DEPARTMENT_ID) INTO number_max 
FROM DEPARTMENTS;
DBMS_OUTPUT.PUT_LINE('Najwyższe id departamentu to: ' || number_max);
new_number_max:=number_max+10;
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) 
VALUES (new_number_max, new_department_name, NULL, NULL);
UPDATE DEPARTMENTS 
SET LOCATION_ID = 3000
WHERE DEPARTMENT_ID=new_number_max;
END;

##3

CREATE TABLE nowa (pole VARCHAR(10));
BEGIN
    FOR i IN 1..10 LOOP
    IF NOT (i=4 OR i=6) 
    THEN
    INSERT INTO nowa VALUES(i);
        DBMS_OUTPUT.PUT_LINE('Wartość i: '||TO_CHAR(i));
        END IF;
    END LOOP;
END;

##4

DECLARE
country_row COUNTRIES%ROWTYPE;
BEGIN
SELECT COUNTRY_ID ,COUNTRY_NAME ,REGION_ID  INTO country_row 
FROM COUNTRIES 
WHERE COUNTRY_ID = 'CA';
DBMS_OUTPUT.PUT_LINE('Country name: '||country_row.country_name);
DBMS_OUTPUT.PUT_LINE('Country name: '||country_row.country_id);
END;


##5

DECLARE
TYPE departments_name IS TABLE OF
DEPARTMENTS.DEPARTMENT_NAME%TYPE INDEX BY 
PLS_INTEGER;
names departments_name;
BEGIN
FOR i IN 1..100 LOOP
IF (MOD(i,10)=0) 
THEN 
SELECT department_name INTO names(i) FROM DEPARTMENTS
    WHERE DEPARTMENT_ID=i;
    DBMS_OUTPUT.PUT_LINE(names(i));
    END IF;
END LOOP;
END;

##6

DECLARE
TYPE departments_name IS TABLE OF
DEPARTMENTS%ROWTYPE INDEX BY 
PLS_INTEGER;
names departments_name;
BEGIN
FOR i IN 1..100 LOOP
IF (MOD(i,10)=0) 
THEN 
SELECT DEPARTMENT_ID ,DEPARTMENT_NAME ,MANAGER_ID ,LOCATION_ID  INTO names(i) FROM DEPARTMENTS
    WHERE DEPARTMENT_ID=i;
    DBMS_OUTPUT.PUT_LINE(names(i).DEPARTMENT_ID || ' ' || names(i).DEPARTMENT_NAME || ' ' || names(i).MANAGER_ID || ' ' || names(i).LOCATION_ID);
    END IF;
END LOOP;
END;

##7

DECLARE
emp employees%ROWTYPE;
CURSOR wynagrodzenie IS
SELECT LAST_NAME, SALARY, DEPARTMENT_ID 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID=50;
FOR emp IN wynagrodzenie LOOP
IF (emp.salary > 3100)
THEN 
DBMS_OUTPUT.PUT_LINE(emp.last_name ||' '|| emp.salary ||' nie dawać podwyżki');
ELSE 
DBMS_OUTPUT.PUT_LINE(emp.last_name ||' '||  emp.salary ||' dawać podwyżke');
END IF;
END LOOP;
END;


##8

DECLARE
    CURSOR widelki(min_salary NUMBER, max_salary NUMBER, first_letter VARCHAR2, middle_letter VARCHAR2) IS
        SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES WHERE (salary >= min_salary AND salary <= max_salary AND ((first_name LIKE (first_letter)||'%') OR first_name LIKE ('%'||middle_letter)||'%'));
    wynik widelki%ROWTYPE;
BEGIN
    OPEN widelki(1000, 5000, 'A', 'a');
    LOOP 
    FETCH widelki INTO wynik;
    EXIT WHEN widelki%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('A: imie: '||wynik.first_name||(' nazwisko: '||wynik.last_name||(' wynagrodzenie: '||wynik.salary)));
    END LOOP;
CLOSE widelki;
 OPEN widelki(5000, 20000, 'U', 'u');
    LOOP 
    FETCH widelki INTO wynik;
    EXIT WHEN widelki%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('U: imie: '||wynik.first_name||(' nazwisko: '||wynik.last_name||(' wynagrodzenie: '||wynik.salary)));
    END LOOP;
END;

##9a

CREATE OR REPLACE PROCEDURE add_row(SELECT_JOB_ID IN VARCHAR2, SELECT_JOB_TITLE IN VARCHAR2) IS
BEGIN
    INSERT INTO JOBS VALUES(SELECT_JOB_ID , SELECT_JOB_TITLE, NULL, NULL);
    dbms_output.put_line('Ok');
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Others wyjątek');
END;
/
EXECUTE add_row('testid1', 'testtitle1');




##9b

CREATE OR REPLACE PROCEDURE modyfikuj_tytul(SELECT_JOB_ID IN VARCHAR2, NEW_JOB_TITLE IN VARCHAR2) IS
wynik JOBS%ROWTYPE;
BEGIN
    SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY 
    INTO wynik 
    FROM JOBS 
    WHERE JOB_ID=SELECT_JOB_ID;
    UPDATE JOBS
    SET JOB_TITLE = NEW_JOB_TITLE;
    dbms_output.put_line('Zmieniono');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Wyją†ek');
    WHEN OTHERS THEN
    dbms_output.put_line('Others wyjątek');
END;



##9c

CREATE OR REPLACE PROCEDURE usun_wiersz(SELECT_JOB_ID IN VARCHAR2) IS
wynik JOBS%ROWTYPE;
BEGIN
    SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY INTO wynik 
    FROM JOBS 
    WHERE JOB_ID=SELECT_JOB_ID;
    DELETE FROM JOBS;
    dbms_output.put_line('Usunięto');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Wyjątek no data found');
    WHEN OTHERS THEN
    dbms_output.put_line('Wyją†ek others');
END;



##9d

CREATE OR REPLACE PROCEDURE wyciagnij_zarobki_nazwisko(GET_SALARY OUT NUMBER, GET_LAST_NAME OUT VARCHAR2, SELECT_EMPLOYEE_ID IN NUMBER) IS
BEGIN
    SELECT SALARY, LAST_NAME INTO GET_SALARY, GET_LAST_NAME 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_ID=SELECT_EMPLOYEE_ID;
    dbms_output.put_line('Wyciągnięto zarobki i nazwisko');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Wyjątek no data found');
    WHEN OTHERS THEN
    dbms_output.put_line('Wyją†ek others');
END;



##9e

CREATE SEQUENCE id_seq
INCREMENT BY 10
    START WITH 10
    MINVALUE 10
    MAXVALUE 100
    CYCLE
    CACHE 2;

CREATE OR REPLACE PROCEDURE dodajpracownika(EMPLOYEE_ID IN NUMBER DEFAULT id_seq.nextval, FIRST_NAME IN VARCHAR2 DEFAULT 'Jan', LAST_NAME IN VARCHAR2 DEFAULT 'Kowalski', 
    EMAIL IN VARCHAR2 DEFAULT 'jankowalski@jk.com',PHONE_NUMBER IN VARCHAR2 DEFAULT '123456789', HIRE_DATE IN DATE DEFAULT SYSDATE, 
    JOB_ID IN VARCHAR2 DEFAULT '10', SALARY IN NUMBER DEFAULT 4500, COMMISSION_PCT IN NUMBER DEFAULT 5, MANAGER_ID IN NUMBER DEFAULT 100, 
    DEPARTMENT_ID IN NUMBER DEFAULT 1) IS
wynik jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
    IF SALARY>20000 
    THEN
        RAISE wyjatek;
    END IF;
    INSERT INTO EMPLOYEES VALUES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID);
EXCEPTION
    WHEN wyjatek THEN
    dbms_output.put_line('Pracownik ma za duże wynagrodzenie');
    WHEN OTHERS THEN
    dbms_output.put_line('Others wyjątek');
END;

