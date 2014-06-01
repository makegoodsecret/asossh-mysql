drop function IF EXISTS rad $$;
/*开启mysql的编译器*/
delimiter $$
create  function rad(d double)
returns double
begin
 declare Pi double default 3.1415926;
 declare C  double default 0.00;
 set C = d*Pi/180.0;
 return C;
 end $$
/*关闭编辑器*/
 delimiter ;
/*测试*/
select rad(90);

/*根据经纬度计算距离*/

drop function if exists getdistance;
delimiter $$
create function getdistance(lat1 double ,lng1 double, lat2 double ,lng2 double)
returns double
begin
declare  earth_padius double  default 6378.137;
declare  radLat1      double  default rad(lat1);
declare  radLat2      double  default rad(lat2);
declare  a            double  default radLat1 - radLat2;
declare  b            double  default rad(lng1) - rad(lng2);
declare  s            double  default 0.00;
set s=2*Asin(Sqrt(power(sin(a/2),2)
	+cos(radLat1)*cos(radLat2)*power(sin(b/2),2)));
set s=s*earth_padius;
set s=Round(s*10000)/10000;
return s ;
end $$


select getdistance(27.00,127.00,30.00,128.00);
delimiter $$