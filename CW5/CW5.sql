#1

CREATE OR REPLACE FUNCTION nazwapracy(select_id NUMBER) RETURN VARCHAR IS
value VARCHAR(20);
BEGIN
SELECT d.department_name INTO value from departments d where d.department_id = select_id;
return value;
EXCEPTION 
when no_data_found then
return 'Nieprawidłowe id';
END nazwapracy;
/
EXECUTE dbms_output.put_line(nazwapracy(1))

