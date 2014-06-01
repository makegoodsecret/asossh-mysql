/*
--功能:将字符串转为年月日格式,删除时分秒.
--来源:http://jorkin.reallydo.com/article.asp?id=529
--参数:
      Datechar Varchar2
--Oracle9i测试通过
*/

Create Or Replace Function CDate(Datechar In Varchar2)
    Return Date Is ReallyDo Date;
Begin
    Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD'), 'YYYY-MM-DD') Into ReallyDo  From Dual;
    Return(ReallyDo);
End CDate;
/
/*
--功能:将字符串转为年月日时分秒格式.
--来源:http://jorkin.reallydo.com/article.asp?id=529
--参数:
      Datechar Varchar2
--Oracle9i测试通过
*/

Create Or Replace Function CDateTime(Datechar In Varchar2) 
Return Date Is ReallyDo Date;
Begin
    Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'),  'YYYY-MM-DD HH24:MI:SS'),  'YYYY-MM-DD HH24:MI:SS')
    Into ReallyDo From Dual;
    Return(ReallyDo);
End CDateTime;
/
/*
--功能:类似MySQL的日期比较函数
--来源:http://jorkin.reallydo.com/article.asp?id=529
--更新时间:20080721
--参数:
      Datepart  Varchar2 -- 比较年?月?日?
      StartDate Varchar2 -- 起始日期
      EndDate   Varchar2 -- 结束日期
--Oracle9i测试通过
*/

Create Or Replace Function Datediff
(
    Datepart  In Varchar2,
    StartDate In Varchar2,
    EndDate   In Varchar2
) Return Number Is
    ReallyDo Numeric;
Begin
    Select Case Upper(Datepart)
               When 'YYYY' Then
                Trunc(Extract(Year From CDate(EndDate)) -  Extract(Year From CDate(StartDate)))
               When 'M' Then
                Datediff('YYYY', StartDate, EndDate) * 12 +  (Extract(Month From CDate(EndDate)) -  Extract(Month From CDate(StartDate)))
               When 'D' Then
                Trunc(CDate(EndDate) - CDate(StartDate))
               When 'H' Then
                Datediff('D', StartDate, EndDate) * 24 +  (to_Number(to_char(CDateTime(EndDate), 'HH24')) - to_Number(to_char(CDateTime(StartDate), 'HH24')))
               When 'N' Then
                Datediff('D', StartDate, EndDate) * 24 * 60 + (to_Number(to_char(CDateTime(EndDate), 'MI')) -  to_Number(to_char(CDateTime(StartDate), 'MI')))
               When 'S' Then
                Datediff('D', StartDate, EndDate) * 24 * 60 * 60 +  (to_Number(to_char(CDateTime(EndDate), 'SS')) -  to_Number(to_char(CDateTime(StartDate), 'SS')))
               Else
                -29252888
           End
    Into ReallyDo From Dual;
    Return(ReallyDo);
End Datediff;
/
Select  Datediff('D' ,'2013-11-13','2013-11-14')  from dual;
Select  Datediff('D' ,'2013-12-13',to_char(sysdate,'yyyy-mm-dd'))  from dual ;
 

--使用此函数统计美食的销量
select o.goods_id ,  Datediff('D' ,to_char(o.order_time,'yyyy-mm-dd'),to_char(sysdate,'yyyy-mm-dd'))  datediff  ,sum(goods_number)
from asossh.goods_order o 
group by Datediff('D' ,to_char(o.order_time,'yyyy-mm-dd'),to_char(sysdate,'yyyy-mm-dd'))  ,o.goods_id 
having  Datediff('D' ,to_char(o.order_time,'yyyy-mm-dd'),to_char(sysdate,'yyyy-mm-dd')) <7;

--使用自带的
select o.goods_id , floor(to_char(sysdate,'yyyymmdd') - to_char(o.order_time,'yyyymmdd'))   datediff  ,sum(goods_number)
from asossh.goods_order o 
group by  floor(to_char(sysdate,'yyyymmdd') - to_char(o.order_time,'yyyymmdd'))  ,o.goods_id  
having  floor(to_char(sysdate,'yyyymmdd') - to_char(o.order_time,'yyyymmdd')) <7;


---在mysql中的使用
select o.goods_id ,  DATEDIFF(DATE(o.order_time),CURDATE())  datediff  ,sum(goods_number)
from asossh.goods_order o 
where o.goods_id = 4
group by  DATEDIFF(DATE(o.order_time),CURDATE())    ,o.goods_id  ;



--oracle中日期差返回天数  
create or replace  function  mydatebetween(onedate Date)
return number 
is 
begin 
return   Datediff('D' ,to_char(onedate,'yyyy-mm-dd'),to_char(sysdate,'yyyy-mm-dd'));
end ;
/

select o.goods_id , mydatebetween(o.order_time)   datediff  ,sum(goods_number)
from asossh.goods_order o 
where  mydatebetween(o.order_time)  <7
group by   mydatebetween(o.order_time)  ,o.goods_id  ;


-- mysql中日期差返回天数
drop function if exists mydatebetween$$;
delimiter $$
create function mydatebetween(onedate timestamp)
returns int
begin 
return DATEDIFF(DATE(onedate),CURDATE()) ;   
end $$
delimiter ;

select o.goods_id , mydatebetween(o.order_time)   datediff  ,sum(goods_number)
from asossh.goods_order o 
where  mydatebetween(o.order_time)  <7
group by   mydatebetween(o.order_time)  ,o.goods_id  ;

 
