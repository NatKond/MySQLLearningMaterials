-- Оператор AS - как (alias)
-- Можно изменить название столбца в запросе или определить его псевдоним
use gt081024;
set sql_safe_updates = 0;

select firstname as name, lastname as surname
from students;

select firstname, lastname, avg_mark*10 as new_avg_mark
from students
having new_avg_mark > 400;

-- Порядок выполнения SQL команд:
-- 1. From
-- 2. Where
-- 3. Group by
-- 4. Having
-- 5. Select 
-- 6. Order by
-- 7. Limit

-- Вывести имена, фамилии и новые средние оценки. Отсортировать по средним оценкам.
select firstname, lastname, avg_mark*10 as new_avg_mark
from students
order by new_avg_mark;

-- Функции для работы с числами (int/integer, numeric/decimal)
select 10*3+85/5 as result;
select 'String' as str;

-- round :  округляет число. В качестве первого параметра передается число. 
-- Второй параметр указывает на длину. Если длина представляет положительное число, то оно указывает,
-- до какой цифры после запятой идет округление. Если длина представляет отрицательное число, то оно указывает, 
-- до какой цифры с конца числа до запятой идет округление

select round(12.35) as result; -- 12
select round(12.57)  as result; -- 13
select round(12.3456123, 2) as result; -- 12.35
-- 12.345612
-- 12.34561
-- 12.3456
-- 12.346
-- 12.35
select round(1234.3456, -2) as result; -- 1200

-- Посчитать 10 процентов от средних оценок, вывести целое число
select round(avg_mark * 10 / 100) as new_avg_mark
from students;

-- ceiling: возвращает наименьшее целое число, которое больше или равно текущему значению.
select ceiling(12.35); -- 13
select ceiling(12.1); -- 13
select ceiling(12.9); -- 13

-- floor: возвращает наибольшее целое число, которое меньше или равно текущему значению.
select floor(12.35); -- 12
select floor(12.8); -- 12

-- abs: возвращает абсолютное значение числа.
select abs(5); -- 5
select abs(-13); -- 13

-- power: возводит число в определенную степень.
select power(5, 2); -- 25
select power(5, 3); -- 125
select power(25, 0.5); -- 5

-- sqrt: получает квадратный корень числа.
select sqrt(225); -- 15

-- rand: генерирует случайное число с плавающей точкой в диапазоне от 0 до 1(не включая 1).
select rand(); -- диапазон 0-1
select round(rand()*10); -- диапазон 0-10
select rand()*3 + 5; -- диапазон 5-8
select ceil(rand()*100);
-- запрос для генерации случайных целых чисел от 1 до 100 (вкл. концы).
select floor(rand()*100+1);

select floor(rand()*100+1);

-- Посчитать 10 процентов от средних оценок, вывести целое число
select firstname, lastname, round(avg_mark * 10 / 100) as new_avg_mark
from students;


-- запрос для генерации случайных целых чисел от 1 до 100 (вкл. концы).
select floor(1 + rand() * 100);

-- Функции для работы со строками(все типы данных)
-- concat: объединяет строки. В качестве параметра принимает от 2-х и более строк, которые надо соединить:
select concat(firstname, ' ', lastname) as full_name, avg_mark
from students;

-- Вывести информацию о студентах по шаблону - 'name - [firstname], surname - [lastname], gender - [gender]'
select concat('name - ', firstname, ', surname - ', lastname, ', gender - ', gender) as full_info
from students;

-- CONCAT_WS: также объединяет строки, но в качестве первого параметра принимает разделитель,
-- который будет соединять строки:
select concat_ws(' ', firstname, lastname, gender) as info
from students;

-- length: возвращает количество символов в строке. В качестве параметра в функцию передается строка, для которой надо найти длину:
select firstname, round(length(firstname)) as name_lenght
from students;

-- Вывести имена, фамилии и эмейлы сотрудников, у которых мейл содержит более 25 символов.
select first_name, last_name, email
from employees
where length(email) > 25;

select length('John'); -- 4

-- trim: удаляет начальные и конечные пробелы из строки. В качестве параметра принимает строку:
select trim(' John  '); -- 'John'

-- ltrim: удаляет начальные пробелы из строки. В качестве параметра принимает строку:
select ltrim(' John  '); -- 'John  '

-- rtrim: удаляет конечные пробелы из строки. В качестве параметра принимает строку:
select rtrim(' John  '); -- ' John'

-- left: вырезает с начала строки определенное количество символов. 
-- Первый параметр функции - строка, а второй - количество символов, которые надо вырезать с начала строки:
select left('john@gmail.com', 4);

select left(email, 5)
from employees1;

-- right: вырезает с конца строки определенное количество символов. 
-- Первый параметр функции - строка, а второй - количество символов, которые надо вырезать с конца строки:
select right('john@gmail.com', 3);

select right(email, 3)
from employees1;

-- substring(str, start[, length]): вырезает из строки str подстроку, начиная с позиции start. 
-- Третий необязательный параметр передает количество вырезаемых символов:
select substring('john@gmail.com', 5); -- '@gmail.com'
select substring('john@gmail.com', 5, 6);  -- '@gmail'

-- substring_index(str, delimeiter, count): вырезает из строки str подстроку. 
-- Параметр delimiter определяет разделитель внутри строки. 
-- А параметр count определяет, до какого вхождения разделителя надо вырезать подстроку. 
-- Если count положительный, то подстрока вырезается с начала, если count отрицательный, то с конца строки str:
select substring_index('iphone 16 pro max', ' ', 1); -- 'iphone'
select substring_index('iphone 16 pro max', ' ', 2); -- 'iphone 16'
select substring_index('iphone 16 pro max', ' ', -2); -- 'pro max'
select substring_index(email,'@', 1)
from employees1;

-- replace(search, find, replace): заменяет в строке search подстроку find на подстроку replace. 
-- Первый параметр функции - строка, второй - подстрока, которую надо заменить, а третий - подстрока, на которую надо заменить:

select replace('iphone 15 pro max', '15', '16');
select * from employees;

select replace(email,'example','gmail')
from employees1;

update employees1
set email = replace(email,'example','gmail');

select * from employees1;

-- lower: переводит строку в нижний регистр:
select lower('JOHN SMITH'); -- 'john smith'

-- upper: переводит строку в верхний регистр
select upper('John Smith'); -- 'JOHN SMITH'
-- 'boB broWn'
-- 'Bob Brown'


select upper(left('boB broWn', 1)); -- первая букву в верхнем регистре 

select substring_index('boB broWn', ' ', 1); -- первое слово до первого пробела (имя)

select length(substring_index('boB broWn', ' ', 1)) - 1; -- кол/во символов в имени без первой буквы 

select right(substring_index('boB broWn', ' ', 1), length(substring_index('boB broWn', ' ', 1)) - 1); -- имя без первой буквы

select lower(right(substring_index('boB broWn', ' ', 1), length(substring_index('boB broWn', ' ', 1)) - 1)); -- имя без первой буквы в нижнем регистре

select concat(upper(left('boB broWn', 1)), lower(right(substring_index('boB broWn', ' ',1), length (substring_index('boB broWn', ' ',1)) - 1)),' ', upper(left(substring_index('boB broWn', ' ',-1), 1)), lower(right(substring_index('boB broWn', ' ',-1), length (substring_index('boB broWn', ' ',-1))- 1)));
