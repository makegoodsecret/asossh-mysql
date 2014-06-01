--Oracle 数据库的用户asossh 密码asossh
-- 创建用户asossh 
-- create user asossh identified by asossh;
-- 授权
-- grant connect,resource to asossh;

-- VARCHAR2(1 byte)   -- 只能为一位的byte类型的,(1、a可以存储中文不能存储)
-- VARCHAR2(1 CHAR)   -- 只能为一位的字符(可以存储中文)
-- insert into "ASOSSH"."test" values ("seq_test".nextval,'xukai'); //seq_test为序列
DROP TABLE "ASOSSH"."USER_HEAD" cascade constraints;
-- 头像表
CREATE TABLE "ASOSSH"."USER_HEAD"(
"HEAD_ID"  NUMBER(8,0) NOT NULL  ,
"HEAD_IMAGE" VARCHAR2 (128 CHAR) NOT NULL, 
"USER_ID"    NUMBER(8,0)   NOT NULL,
"HEAD_TIME" TIMESTAMP (6)   DEFAULT CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE
;

ALTER TABLE  "ASOSSH"."USER_HEAD" ADD  PRIMARY KEY  ("HEAD_ID");
DROP SEQUENCE  "ASOSSH"."USERHEADSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."USERHEADSEQUENCE"   MINVALUE 5 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 6 NOCACHE  NOORDER  NOCYCLE ;      

-- 用户表
DROP TABLE "ASOSSH"."USER_INFO" cascade constraints;
CREATE TABLE "ASOSSH"."USER_INFO"(
"USER_ID"  NUMBER(8,0)  NOT NULL  ,
"USERNAME" VARCHAR2(64 CHAR) NOT NULL  ,
"PASSWORD" VARCHAR2(64 CHAR) NOT NULL ,
"QQ"   VARCHAR2(16 CHAR)      NULL  ,
"EMAIL"  VARCHAR2(64 CHAR )   NOT NULL  ,
"DIS"  VARCHAR2(128 CHAR) NULL ,
"MOOD" VARCHAR2(128 CHAR) NULL ,
"SEX"  VARCHAR2(1 byte)  NOT NULL,
"INTEGRAL"  NUMBER(8,0)       NOT NULL  ,
"HOBBY"   VARCHAR2(128 CHAR)   NULL ,
"PAYNAME"  VARCHAR2(128 CHAR)  NULL  ,
"EMAILSTATU" VARCHAR2(1 byte) NOT NULL  ,
"USER_LEVEL"     NUMBER(8,0)      NOT NULL  ,
"VISIT_NUMBER"    NUMBER(8,0)      NOT NULL ,
"USER_LOGIN_CITY" VARCHAR2(16 CHAR) NOT NULL,
"POWER"     VARCHAR2(1 byte)  NOT NULL  ,
"TIME"      TIMESTAMP (6)  DEFAULT CURRENT_TIMESTAMP   
)
LOGGING
NOCOMPRESS
NOCACHE
;
ALTER  TABLE "ASOSSH"."USER_INFO" ADD  PRIMARY KEY  ("USER_ID");
DROP SEQUENCE  "ASOSSH"."USERINFOSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."USERINFOSEQUENCE"   MINVALUE 5 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 6 NOCACHE  NOORDER  NOCYCLE ;   
-- 我的收藏表
DROP TABLE "ASOSSH"."USER_COL" cascade constraints;
CREATE TABLE "ASOSSH"."USER_COL"(
"COL_ID" NUMBER(8,0) NOT  NULL ,
"GOODS_ID" NUMBER(8,0)  NULL  ,
"MEAL_ID"  NUMBER(8,0)   NULL  ,
"HOTEL_ID" NUMBER(8,0)   NULL  ,
"USER_ID"  NUMBER(8,0) NOT  NULL  ,
"COL_TIME"  TIMESTAMP (6)  DEFAULT CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE
;
ALTER TABLE "ASOSSH"."USER_COL" ADD  PRIMARY KEY  ("COL_ID");
DROP SEQUENCE  "ASOSSH"."USERCOLSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."USERCOLSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 美食种类表
DROP TABLE "ASOSSH"."SORT"  cascade constraints;
CREATE TABLE "ASOSSH"."SORT"(
"SORT_ID" NUMBER(8,0) NOT NULL  ,
"SORT_NAME" VARCHAR2(64 CHAR)  NOT NULL,  
"HOTEL_ID"  NUMBER(8,0)  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE
;
ALTER TABLE "ASOSSH"."SORT" ADD  PRIMARY KEY  ("SORT_ID");
DROP SEQUENCE  "ASOSSH"."SORTSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."SORTSEQUENCE"   MINVALUE 6 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 7 NOCACHE  NOORDER  NOCYCLE ;      

-- 美食信息表
DROP TABLE "ASOSSH"."GOODS_INFO"  cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_INFO"(
	"GOODS_ID"  		NUMBER(8,0) 	NOT NULL ,				 
	"GOODS_NAME"		VARCHAR2(64 CHAR)	NOT NULL,							 
	"GOODS_DIS"		   CLOB,												 
	"SORT_ID"			 NUMBER(8,0) 	NOT NULL,							 
	"GOODS_PRICE"		number(11,2)		NOT NULL,								 
	"HOTEL_ID"   		NUMBER(8,0) 	NOT NULL  ,  					 
	"USER_ID"         NUMBER(8,0) 	NOT NULL,								 
	"GOODS_TIME"	 TIMESTAMP (6)  DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE
;
ALTER TABLE "ASOSSH"."GOODS_INFO" ADD  PRIMARY KEY  ("GOODS_ID");
DROP SEQUENCE  "ASOSSH"."GOODSINFOSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."GOODSINFOSEQUENCE"   MINVALUE 13 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 14 NOCACHE  NOORDER  NOCYCLE ;      

-- 用户申请成为卖家
DROP TABLE "ASOSSH"."APPLYSELLER"  cascade constraints;
CREATE TABLE "ASOSSH"."APPLYSELLER"(
"APPLYSELLER_ID" NUMBER(8,0) NOT NULL ,
"APPLYSELLER_LOGO" VARCHAR2(256 CHAR) NOT NULL,
"APPLYSELLER_CERTIFICATE" VARCHAR2(256 CHAR) NOT NULL  ,
"APPLYSELLER_STATUS" VARCHAR2(1 byte) NOT NULL ,
"USER_ID" NUMBER(8,0)    NOT   NULL  ,
"APPLYSELLER_TIME" TIMESTAMP (6)   DEFAULT CURRENT_TIMESTAMP 
)	
 LOGGING
 NOCOMPRESS
 NOCACHE
 ;
ALTER TABLE "ASOSSH"."APPLYSELLER" ADD  PRIMARY KEY ("APPLYSELLER_ID");
DROP SEQUENCE  "ASOSSH"."APPLYSELLERSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."APPLYSELLERSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 饭店的信息表
DROP TABLE  "ASOSSH"."HOTEL" cascade constraints;
CREATE TABLE "ASOSSH"."HOTEL"(
	"HOTEL_ID"   				NUMBER(8,0)						NOT NULL ,
	"HOTEL_NAME"				VARCHAR2(64 CHAR) 			NOT NULL,				 
	"HOTEL_ADS"      			CLOB 			NOT NULL,			 
	"HOTEL_PROVINCE"    		VARCHAR2(128 CHAR) 			NOT NULL,			 
	"HOTEL_CITY"				VARCHAR2(128 CHAR) ,					 
	"HOTEL_COUNTY"				VARCHAR2(128 CHAR),					 
	"HOTEL_OTHER_ADDRESS"     	VARCHAR2(128 CHAR)			 NOT NULL,				 
	"HOTEL_CELLPHONE"  			VARCHAR2(64 CHAR)   	,				 
	"HOTEL_PHONESECTION"		VARCHAR2(16 CHAR)    ,					 
	"HOTEL_PHONECODE"          	VARCHAR2(64 CHAR)     ,			 
	"HOTEL_OTHERPHONE"        	VARCHAR2(64 CHAR)    ,				 
	"HOTEL_LNG"					number(17,14)  				NOT NULL,				 
	"HOTEL_LAT"					number(17,14) 				NOT NULL,					 
	"HOTEL_LOGO"    		  	VARCHAR2(256 CHAR)  		NOT NULL  ,      			 
	"HOTEL_CERTIFICATE"			VARCHAR2(256 CHAR) 			NOT NULL  ,      		 
	"HOTEL_LEVEL"      			number(11,2)  				NOT NULL  ,        		 
	"HOTEL_GRADE"      			NUMBER(8,0)  				NOT NULL  ,    			 
	"HOTEL_STATUS"     			VARCHAR2(1 byte)  			NOT NULL,				 
	"USER_ID"          			NUMBER(8,0) 						NOT NULL,					 
	"HOTEL_TIME"      			TIMESTAMP (6)  		 DEFAULT CURRENT_TIMESTAMP   ,    
	"HOTEL_SHOP_AM_START" 		VARCHAR2(32 CHAR)   ,   				        	 
	"HOTEL_SHOP_AM_END"    		VARCHAR2(32 CHAR)    ,   						 
	"HOTEL_SHOP_PM_START"  		VARCHAR2(32 CHAR) NOT NULL  ,   				 
	"HOTEL_SHOP_PM_END"   		VARCHAR2(32 CHAR) NOT NULL     				 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."HOTEL" ADD  PRIMARY KEY  ("HOTEL_ID");
DROP SEQUENCE  "ASOSSH"."HOTELSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."HOTELSEQUENCE"   MINVALUE 2 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 3 NOCACHE  NOORDER  NOCYCLE ;      

-- 套餐表
DROP TABLE  "ASOSSH"."MEAL" cascade constraints;
CREATE TABLE "ASOSSH"."MEAL"(
	"MEAL_ID"   		NUMBER(8,0)		       NOT NULL  ,			 
	"MEAL_NAME"  		VARCHAR2(128 CHAR) NOT NULL  ,							 
	"HOTEL_ID"   	 	NUMBER(8,0) 		   NOT NULL   ,   						 
	"MEAL_PRICE"  		number(13,2)  		      NOT NULL    ,						 
	"MEAL_STATU"    	 VARCHAR2(1 byte)    	NOT NULL ,							 
	"MEAL_TIME"     TIMESTAMP (6)    		 DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE
;

ALTER TABLE "ASOSSH"."MEAL" ADD  PRIMARY KEY  ("MEAL_ID");
DROP SEQUENCE  "ASOSSH"."MEALSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."MEALSEQUENCE"   MINVALUE 5 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 6 NOCACHE  NOORDER  NOCYCLE ;      

-- 套餐与美食多对多关中间表
DROP TABLE  "ASOSSH"."GOODS_MEAL" cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_MEAL"(
	"MEAL_ID"   		NUMBER(8,0)  		NOT NULL,
	"GOODS_ID"  		NUMBER(8,0) 		NOT NULL
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."GOODS_MEAL" ADD  PRIMARY KEY  ("MEAL_ID","GOODS_ID");
 

-- 美食图片表
DROP TABLE "ASOSSH"."GOODS_IMAGE" cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_IMAGE"(
	"GIMAGE_ID"  		NUMBER(8,0)  		NOT NULL ,
	"GIMAGE_IMAGE"	    VARCHAR2(128 CHAR) 	NOT NULL,	
	"GOODS_ID"  		NUMBER(8,0) 		NOT NULL      ,
	"GIMAGE_TIME"  	TIMESTAMP (6) 		 DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCACHE
NOCOMPRESS
;
ALTER TABLE "ASOSSH"."GOODS_IMAGE" ADD  PRIMARY KEY  ("GIMAGE_ID");
DROP SEQUENCE  "ASOSSH"."GOODSIMAGESEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."GOODSIMAGESEQUENCE"   MINVALUE 13 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 14 NOCACHE  NOORDER  NOCYCLE ;      

-- 美食评价表
DROP TABLE  "ASOSSH"."GOODS_ASSESS" cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_ASSESS"(
	"ASS_ID"  		NUMBER(8,0)  		NOT NULL   ,		
	"GOODS_ID"  	NUMBER(8,0)  		 ,		  							 
	"MEAL_ID"  		NUMBER(8,0)   		 ,			 						 
	"HOTEL_ID"  	NUMBER(8,0)  		 NOT NULL,								 
	"USER_ID"		NUMBER(8,0) 			 NOT NULL,							 
	"ASS_STARS"     NUMBER(8,0)           NOT NULL ,    
	"ASS_DIS"		CLOB        	,										 
	"ASS_IP"        VARCHAR2(32 CHAR) NOT NULL,							 
	"ORDER_ID" 		NUMBER(8,0)			 NOT NULL,                               
	"ASS_TIME"  	TIMESTAMP (6) 		 DEFAULT CURRENT_TIMESTAMP 		 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER   TABLE "ASOSSH"."GOODS_ASSESS" ADD  PRIMARY KEY  ("ASS_ID");
DROP SEQUENCE  "ASOSSH"."GOODSASSESSSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."GOODSASSESSSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 每日推荐表
DROP TABLE "ASOSSH"."RECOMMEND" cascade constraints;
CREATE TABLE "ASOSSH"."RECOMMEND"(
	"REC_ID"  		    NUMBER(8,0)  		NOT NULL ,			 
	"GOODS_ID"  		NUMBER(8,0)			NOT NULL,							 
	"HOTEL_ID"   		NUMBER(8,0)		NOT NULL ,		 
	"RECOMMEND_TIME"  TIMESTAMP (6)  		DEFAULT CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."RECOMMEND" ADD  PRIMARY KEY  ("REC_ID");
DROP SEQUENCE  "ASOSSH"."RECOMMENDSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."RECOMMENDSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 广告表
DROP TABLE "ASOSSH"."ADS" cascade constraints;
CREATE TABLE "ASOSSH"."ADS"(
	"ADS_ID"		NUMBER(8,0)		NOT NULL ,		 
	"ADS_IMAGE"  	VARCHAR2(128 CHAR)  	NOT NULL,					 
	"ADS_DIS"		CLOB			NOT NULL,   					 
	"ADS_STATU"   VARCHAR2(1 byte)			NOT NULL ,					 
	"ADS_TIME"  TIMESTAMP (6)      	 DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."ADS" ADD  PRIMARY KEY ("ADS_ID");
DROP SEQUENCE  "ASOSSH"."ADSSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."ADSSEQUENCE"   MINVALUE 7 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 8 NOCACHE  NOORDER  NOCYCLE ;      

-- 收货地址
DROP TABLE "ASOSSH"."ORDER_ADDRESS" cascade constraints;
CREATE  TABLE   "ASOSSH"."ORDER_ADDRESS"(
	"ORDER_ADDRESS_ID"   NUMBER(8,0)  	NOT NULL     , 
	"ORDER_NAME"   		VARCHAR2(64 CHAR) NOT NULL,					 
	"PROVINCE"    		VARCHAR2(128 CHAR) NOT NULL,					 
	"CITY"				VARCHAR2(128 CHAR) ,						 
	"COUNTY"				VARCHAR2(128 CHAR) ,							 
	"OTHER_ADDRESS"      VARCHAR2(128 CHAR) NOT NULL,					 
	"POSTCODE"			NUMBER(8,0)		,							 
	"CELLPHONE"  			VARCHAR2(64 CHAR)   	,							 
	"PHONESECTION"		VARCHAR2(16 CHAR)    ,					 		 
	"PHONECODE"          	VARCHAR2(64 CHAR)     ,						    
	"OTHERPHONE"        	VARCHAR2(64 CHAR)    ,						   
	"USER_ID"				NUMBER(8,0)	NOT NULL,					 
	"ORDER_ADDRESS_STATUS"  VARCHAR2(1 byte)	NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."ORDER_ADDRESS" ADD  PRIMARY KEY  ("ORDER_ADDRESS_ID");

DROP SEQUENCE  "ASOSSH"."ORDERADDRESSSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."ORDERADDRESSSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 订餐表

DROP TABLE "ASOSSH"."GOODS_ORDER" cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_ORDER"(
	"ORDER_ID" 		NUMBER(8,0)			NOT NULL ,   
	"ORDER_NUMBER"    VARCHAR2(128)	NOT NULL ,				 						
	"USER_ID"			NUMBER(8,0)			NOT NULL,				 
	"ORDER_ADDRESS_ID" NUMBER(8,0)  		NOT NULL ,				 
	"GOODS_ID"  		NUMBER(8,0)				,				 
	"MEAL_ID"   		NUMBER(8,0)  		        ,			 
	"HOTEL_ID"   		NUMBER(8,0)        NOT NULL ,				 
	"GOODS_NUMBER"   NUMBER(8,0)       NOT NULL, 			 
	"GOODSORMEAL_ADS" CLOB             ,						   
	"ALIPAY_TRADE_NO" VARCHAR2(128 CHAR)   ,  
	"TRADE_STATUS"   VARCHAR2(128 CHAR)     ,       		 
	"ORDER_ADS"		CLOB			,					 
	"ORDER_TIME"		TIMESTAMP (6)     DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."GOODS_ORDER" ADD  PRIMARY KEY  ("ORDER_ID");
DROP SEQUENCE  "ASOSSH"."GOODSORDERSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."GOODSORDERSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

 


-- 购物车表

DROP TABLE "ASOSSH"."GOODS_CART" cascade constraints;
CREATE TABLE "ASOSSH"."GOODS_CART"(
	"CART_ID" 		NUMBER(8,0)			NOT NULL ,   
	"USER_ID"		NUMBER(8,0)		NOT NULL,	 
	"GOODS_ID"  		NUMBER(8,0)		,
	"MEAL_ID"   		NUMBER(8,0)  	    ,
	"GOODS_NUMBER"    NUMBER(8,0)       NOT NULL, 						 
	"ORDER_ADS"		CLOB		 
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."GOODS_CART" ADD  PRIMARY KEY  ("CART_ID");
DROP SEQUENCE  "ASOSSH"."GOODSCARTSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."GOODSCARTSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 对好友分组
DROP TABLE "ASOSSH"."FRIEND_GROUP" cascade constraints;
CREATE  TABLE "ASOSSH"."FRIEND_GROUP"(
	"FRIEND_GROUP_ID" NUMBER(8,0)  NOT  NULL,
	"USER_ID"         NUMBER(8,0)  NOT  NULL ,
	"FRIEND_GROUP_NAME"  VARCHAR2(32 CHAR) NOT NULL
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER  TABLE  "ASOSSH"."FRIEND_GROUP" ADD  PRIMARY KEY   ("FRIEND_GROUP_ID");
DROP SEQUENCE  "ASOSSH"."FRIENDGROUPSEQUENCE";
CREATE SEQUENCE  "ASOSSH"."FRIENDGROUPSEQUENCE"  MINVALUE 5 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 6 NOCACHE  NOORDER  NOCYCLE ;

-- 好友关系表
DROP TABLE "ASOSSH"."USER_FRIEND" cascade constraints;
CREATE TABLE  "ASOSSH"."USER_FRIEND"(
	"USER_FRIEND_ID"  NUMBER(8,0)  NOT   NULL   ,
	"USER_ID"         NUMBER(8,0)   NOT   NULL,
	"FRIEND_ID"  	  NUMBER(8,0)   NOT   NULL ,
	"FRIEND_GROUP_ID" NUMBER(8,0)     NOT   NULL , 	-- 对该好友分组
	"HIDING_STATUS"   VARCHAR2(1 byte)     NOT   NULL ,   	-- 好友是否隐身(0不隐身,1隐身)
	"GPS_SHARE"       VARCHAR2(1 byte)    NOT   NULL  ,    	-- 用户是否共享GPS(0共享,1不共享)
	"FRIEND_APPLY_FOR_STATUS" VARCHAR2(1 byte)  NOT   NULL  , -- 是否为申请好友那一方(0是，1不是)
	"USER_FRIEND_STATUS"  	VARCHAR2(1 byte)     NOT   NULL  , 
	 -- 是否同意加好友 n没有处理好友请求,y代表为申请好友的那一方，
	 -- 0代表解除好友关系,1代表接受，2代表拒绝，3代表拉入黑名单,4代表加为密友
	"USER_FRIEND_TIME" TIMESTAMP (6)    DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE;
 ALTER TABLE "ASOSSH"."USER_FRIEND" ADD  PRIMARY KEY  ("USER_FRIEND_ID");
DROP SEQUENCE  "ASOSSH"."USERFRIENDSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."USERFRIENDSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;      

-- 发信息表
DROP TABLE  "ASOSSH"."CHAT" cascade constraints;
CREATE TABLE  "ASOSSH"."CHAT" (
	"CHAT_ID"         NUMBER(19,0)      NOT  NULL    ,
	"USER_FRIEND_ID"   NUMBER(8,0)     NOT  NULL  ,				 
	"CHAT_TEXT"      CLOB       NOT  NULL  ,				 
	"FRIEND_ID"       NUMBER(8,0)      NOT  NULL  ,                 
	"CHAT_STATUS"       VARCHAR2(1 byte)        NOT  NULL  ,  
	"CHAT_TIME" TIMESTAMP (6)        DEFAULT CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE "ASOSSH"."CHAT" ADD  PRIMARY KEY  ("CHAT_ID");
DROP SEQUENCE  "ASOSSH"."CHATSEQUENCE";  
CREATE SEQUENCE  "ASOSSH"."CHATSEQUENCE"   MINVALUE 0 MAXVALUE 9223372036854775807 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;   





-- 发送图片或压缩包表
DROP TABLE "ASOSSH"."CHAT_TRANSMIT_FILES" cascade constraints;
CREATE TABLE "ASOSSH"."CHAT_TRANSMIT_FILES"(
    "CHAT_TRANSMIT_FILES_ID"   NUMBER(8,0)   NOT NULL ,
    "CHAT_FILE"           VARCHAR2(32 CHAR) NOT NULL,
    "USER_FRIEND_ID"   NUMBER(8,0)     NOT  NULL  ,
    "FRIEND_ID"       NUMBER(8,0)      NOT  NULL  ,  
    "CHAT_TRANSMIT_FILES_STATUS"  VARCHAR2(1 byte)  NOT NULL,
    "CHAT_TIME"      TIMESTAMP (6)     DEFAULT CURRENT_TIMESTAMP 
)
LOGGING
NOCOMPRESS
NOCACHE;

ALTER TABLE "ASOSSH"."CHAT_TRANSMIT_FILES" ADD  PRIMARY KEY  ("CHAT_TRANSMIT_FILES_ID");
DROP SEQUENCE  "ASOSSH"."CHATTRANSMITFILESSEQUENCE";
CREATE SEQUENCE  "ASOSSH"."CHATTRANSMITFILESSEQUENCE"  MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

--群表的类型
DROP TABLE  "ASOSSH"."USER_FRIEND_GROUP_TYPE" cascade constraints;
CREATE TABLE "ASOSSH"."USER_FRIEND_GROUP_TYPE"(
	"USER_FRIEND_GROUP_TYPE_ID" NUMBER(8,0) NOT NULL ,
	"USER_FRIEND_GROUP_TYPE_NAME"  VARCHAR2(64 CHAR) NOT NULL
)
LOGGING
NOCOMPRESS
NOCACHE;

ALTER  TABLE "ASOSSH"."USER_FRIEND_GROUP_TYPE" ADD  PRIMARY KEY ("USER_FRIEND_GROUP_TYPE_ID");
DROP SEQUENCE  "ASOSSH"."USERFRIENDGROUPTYPESEQUENCE";
CREATE  SEQUENCE  "ASOSSH"."USERFRIENDGROUPTYPESEQUENCE"  MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

-- 群表
DROP TABLE  "ASOSSH"."USER_FRIEND_GROUP" cascade constraints;
CREATE TABLE "ASOSSH"."USER_FRIEND_GROUP"(
	"USER_FRIEND_GROUP_ID"  NUMBER(8,0)  NOT NULL,
	"USER_ID"  NUMBER(8,0)  NOT NULL    ,								 
	"USER_FRIEND_GROUP_NAME"  VARCHAR2(64 CHAR) NOT NULL,
	"USER_FRIEND_GROUP_PUBLICNOTICE" VARCHAR2(128 CHAR) NOT  NULL,		 
	"USER_FRIEND_GROUP_TYPE_ID"  NUMBER(8,0)  NOT NULL,  
 	"USER_FRIEND_GROUP_TIME" TIMESTAMP (6)   DEFAULT CURRENT_TIMESTAMP   
)
LOGGING
NOCOMPRESS
NOCACHE;

ALTER  TABLE  "ASOSSH"."USER_FRIEND_GROUP"  ADD  PRIMARY KEY  ("USER_FRIEND_GROUP_ID");
DROP SEQUENCE  "ASOSSH"."USERFRIENDGROUPSEQUENCE"  ;
CREATE  SEQUENCE  "ASOSSH"."USERFRIENDGROUPSEQUENCE"  MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

--  群与用户多对多中间表
DROP TABLE  "ASOSSH"."GROUP_USER" cascade constraints;
CREATE TABLE "ASOSSH"."GROUP_USER" (
	"USER_FRIEND_GROUP_ID"  NUMBER(8,0)  NOT NULL ,
	"USER_ID"    NUMBER(8,0)              NOT NULL
)
LOGGING
NOCOMPRESS
NOCACHE;
ALTER TABLE  "ASOSSH"."GROUP_USER" ADD  PRIMARY KEY ("USER_FRIEND_GROUP_ID" , "USER_ID");

 
-- 个人微博记录表
DROP TABLE "ASOSSH"."MINIBLOGS" cascade constraints;
CREATE TABLE "ASOSSH"."MINIBLOGS"(
	"MINIBLOGS_ID"  NUMBER(8,0)  NOT NULL,
	"MINIBLOGS_CONTENT"  VARCHAR2(256 CHAR) NOT NULL,
	"USER_ID"  NUMBER(8,0) NOT NULL ,
	"USER_FRIEND_SUPPORT"  NUMBER(8,0)  NOT  NULL , 	 
	"USER_FRIEND_FOOTPOINT"  NUMBER(8,0)   NOT NULL ,       
	"MINIBLOGS_STATUS"  VARCHAR2(1 byte)  NOT  NULL ,        
	"MINIBLOGS_TIME"    TIMESTAMP (6)  DEFAULT   CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE;

ALTER  TABLE  "ASOSSH"."MINIBLOGS"  ADD  PRIMARY KEY  ("MINIBLOGS_ID");
DROP SEQUENCE  "ASOSSH"."MINIBLOGSSEQUENCE";
CREATE SEQUENCE  "ASOSSH"."MINIBLOGSSEQUENCE"   MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;


-- 个人微薄评价表
DROP TABLE "ASOSSH"."MINIBLOGS_ASSESS" cascade constraints;
CREATE TABLE "ASOSSH"."MINIBLOGS_ASSESS"(
	"MINIBLOGS_ASSESS_ID"  NUMBER(8,0)  NOT  NULL  ,
	"USER_FRIEND_ID"       NUMBER(8,0)  NOT   NULL  ,   
	"MINIBLOGS_ID"  NUMBER(8,0)  NOT NULL,
	"MINIBLOGS_ASSESS_CONTENT"  VARCHAR2(128 CHAR) NOT NULL , 
	"MINIBLOGS_ASSESS_TIME"  TIMESTAMP (6)    DEFAULT CURRENT_TIMESTAMP  
)
LOGGING
NOCOMPRESS
NOCACHE;

ALTER TABLE  "ASOSSH"."MINIBLOGS_ASSESS"  ADD  PRIMARY KEY  ("MINIBLOGS_ASSESS_ID");
DROP SEQUENCE  "ASOSSH"."MINIBLOGSASSESSSEQUENCE";
CREATE  SEQUENCE  "ASOSSH"."MINIBLOGSASSESSSEQUENCE" MINVALUE 0 MAXVALUE 2147483647 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
 