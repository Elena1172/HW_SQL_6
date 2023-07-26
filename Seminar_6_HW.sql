-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP DATABASE IF EXISTS Seminar6_HW;
CREATE DATABASE Seminar6_HW;
USE Seminar6_HW;
DROP FUNCTION IF EXISTS datetime_;
DROP PROCEDURE IF EXISTS print_datetime;
DROP FUNCTION IF EXISTS numbers_;
DROP PROCEDURE IF EXISTS numbers;
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION datetime_(n INT)
RETURNS VARCHAR(50) 
DETERMINISTIC
BEGIN
  DECLARE msg VARCHAR(50);
  DECLARE a INT;
  DECLARE a1 INT;
  DECLARE a2 INT;
  DECLARE a3 INT;
  SET a = n DIV (24*60*60);
  SET a1 = (n%(24*60*60)) DIV 3600;
  SET a2 = ((n%(24*60*60))% 3600) DIV 60;
  SET a3 = ((n%(24*60*60))% 3600) % 60;
  SET msg = CONCAT(a, ' day ', a1, ' hours ', a2, ' minutes ', a3 , ' seconds');
  RETURN msg;
END//


CREATE PROCEDURE print_datetime
(
	IN number_ INT 
)
BEGIN
	DECLARE n INT;
    DECLARE result VARCHAR(50) DEFAULT "";
    DECLARE a INT;
    DECLARE a1 INT;
	DECLARE a2 INT;
    DECLARE a3 INT;
	SET n = number_;
    SET a = (n DIV (24*60*60));
    SET a1 = (n%(24*60*60)) DIV 3600;
    SET a2 = ((n%(24*60*60))%3600) DIV 60;
    SET a3 = ((n%(24*60*60))%3600)%60;
	SET result = CONCAT(result, a, ' days ', a1, ' hours ', a2, ' minutes ', a3, ' second');
	
	SELECT result;
END //
-- Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10
CREATE FUNCTION numbers_(n INT)
RETURNS VARCHAR(30) 
DETERMINISTIC
BEGIN
  DECLARE msg VARCHAR(30) DEFAULT "";
  DECLARE i INT;
  SET i = 2;
  WHILE i <= n DO
	SET msg = CONCAT(msg, i);
    IF i > (n-2) THEN
		RETURN  msg;
	END IF;
  SET msg = CONCAT(msg, ', ');
  SET i = i +2;
  END WHILE;
END  //
CREATE PROCEDURE numbers(IN n INT)
BEGIN
DECLARE row_numbers VARCHAR(30) DEFAULT "";
  DECLARE i INT;
  SET i = 2;
  WHILE i <= n DO
	SET row_numbers = CONCAT(row_numbers, i);
    IF i > (n-2) THEN
		SELECT  row_numbers;
	END IF;
  SET row_numbers = CONCAT(row_numbers, ', ');
  SET i = i +2;
  END WHILE;
END //
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".
CREATE FUNCTION hello()
RETURNS VARCHAR(30) 
DETERMINISTIC
BEGIN
DECLARE time_ TIME;
DECLARE res VARCHAR(20);
SET time_ = now();
IF time_ BETWEEN '06:00:00' AND '11:59:59'
THEN SET res = 'Доброе утро';
ELSEIF time_ BETWEEN '12:00:00' AND '17:59:59'
THEN SET res = 'Добрый день';
ELSEIF time_ BETWEEN '18:00:00' AND '23:59:59'
THEN SET res = 'Добрый вечер';
ELSEIF time_ BETWEEN '00:00:00' AND '05:59:59'
THEN SET res = 'Доброй ночи';
END IF;
RETURN res;
END //
DELIMITER ;

SELECT datetime_(123456) AS get_datetime;
CALL print_datetime(123456);
SELECT numbers_(10) AS row_numbers;
CALL numbers(10);
SELECT hello();