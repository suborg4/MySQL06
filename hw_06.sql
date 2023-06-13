/*
Базы данных и SQL (семинары)
Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы
1 Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
2 Выведите только четные числа от 1 до 10. 
Пример: 2,4,6,8,10 
*/

use hw_06;

--1

drop function times;
delimiter //
create function times (seconds int)
returns varchar(100)
deterministic
begin
declare days char(3);
declare hours, minutes, sec char(2);
declare result varchar(100);
set days = cast(floor(seconds/60/60/24) as char(3));
set hours = cast(floor(mod(seconds/60/60/24,1)*24) as char(2));
set minutes = cast(floor(mod(mod(seconds/60/60/24,1)*24,1)*60) as char(2));
set sec = cast(round(mod(mod(mod(seconds/60/60/24,1)*24,1)*60,1)*60) as char(2));
set result = concat(days, " days ", hours, " hours ", minutes, " minutes ", sec, " seconds");
return result;
end //
delimiter ;

select times(123456);

--2

drop procedure if exists even;
delimiter //
create procedure even(in start_number int, in end_number int)
begin
	declare res varchar(100) default '';
	if (start_number % 2 != 0) then set start_number = start_number + 1;
	end if;
	while (start_number <= end_number) do
		set res = concat(res, ' ', start_number);
        set start_number = start_number + 2;
	end while;
    select res;
end //
delimiter ;

call even(1, 10);
