CREATE VIEW first_cw AS
SELECT a.department_id, a.employee_id, a.last_name, a.first_name, a.salary 
FROM employees a
WHERE a.salary < 
(SELECT MAX(salary) 
FROM employees
WHERE a.department_id = department_id
GROUP BY department_id);

CREATE TABLE mecz (gospodarz VARCHAR(30),gosc VARCHAR(30), gole_gospodarza INT, gole_goscia INT);

INSERT INTO mecz VALUES ('Czechy', 'Litwa', 2,1);
INSERT INTO mecz VALUES ('Wenezuela', 'Niemcy', 4,3);
INSERT INTO mecz VALUES ('Szwecja', 'Chorwacja', 1,5);
INSERT INTO mecz VALUES ('Libia', 'Portugalia', 3,2);
INSERT INTO mecz VALUES ('Chiny', 'Japonia', 1,1);
INSERT INTO mecz VALUES ('Korea Poludniowa', 'Korea Polnocna', 0,1);
INSERT INTO mecz VALUES ('Grecja', 'Macedonia', 1,0);
INSERT INTO mecz VALUES ('Afganistan', 'Wlochy', 0,2);
INSERT INTO mecz VALUES ('Kanada', 'USA', 0,1);
INSERT INTO mecz VALUES ('Szkocja', 'Pakistan',3,0);
INSERT INTO mecz VALUES ('Chile', 'Bialorus', 1,2);
INSERT INTO mecz VALUES ('Mongolia', 'Kazachstan', 2,1);
INSERT INTO mecz VALUES ('Polska', 'Wegry', 1,3);
