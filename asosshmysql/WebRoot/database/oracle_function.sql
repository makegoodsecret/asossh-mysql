1.获得弧度的函数
create or replace function rad(d number) return number
is 
Pi number :=3.1415926;
begin
return d*Pi/180.0;
end;
/
--测试
select rad(360) from dual;
drop function rad;   --删除函数

2.根据经纬度计算距离
create or replace function getdistance(
  lat1 number,lng1 number, lat2 number,lng2 number
)
return number
is 
earth_padius number :=6378.137;
radLat1      number :=rad(lat1);
radLat2      number :=rad(lat2);
a            number :=radLat1 - radLat2;
b            number :=rad(lng1)-rad(lng2);
s            number :=0;
begin
s:=2*Asin(Sqrt(power(sin(a/2),2)
	+cos(radLat1)*cos(radLat2)*power(sin(b/2),2)));
s:=s*earth_padius;
s:=Round(s*10000)/10000;
return s;
end;
/
--测试
select getdistance(121.506656,31.245087,121.508883,31.243481) from dual; 
结果是：0.2649千米
3.根据两个饭店的id 计算两个饭店的距离
create or replace function getdisbyhotelId(
hotelId1 number,hotelId2 number
)
return number 
is 
lat1 number :=0;
lng1 number :=0;
lat2 number :=0;
lng2 number :=0;
begin
select 	"HOTEL_LAT" ,"HOTEL_LNG" into lat1 , lng1   from "HOTEL" where "HOTEL_ID"=hotelId1;	 	
select 	"HOTEL_LAT" ,"HOTEL_LNG" into lat2 , lng2   from "HOTEL" where "HOTEL_ID"=hotelId2;				  
return getdistance(lat1,lng1,lat2,lng2);
end;
/	
 

