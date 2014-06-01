/*此数据库为mysql*/

DROP DATABASE IF EXISTS ASOSSH;
CREATE DATABASE asossh DEFAULT CHARACTER SET UTF8  ;

use asossh;

 
DROP TABLE IF EXISTS user_head;
/*头像表*/
CREATE TABLE user_head(
	head_id		INT(11)		NOT NULL AUTO_INCREMENT, 				/*编号*/
	head_image	VARCHAR(80) NOT NULL,								/*图片的数据*/
	user_id		INT(11)		NOT NULL ,
	head_time	TIMESTAMP 	NOT NULL DEFAULT CURRENT_TIMESTAMP ,	/*上传时间*/
	PRIMARY KEY(head_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 
DROP TABLE IF EXISTS user_info;
/*用户表*/
CREATE TABLE user_info(
	user_id		INT(11)			NOT NULL AUTO_INCREMENT,		/*用户的id*/
	username	CHAR(50)		NOT NULL,						/*用户名*/
	password	VARCHAR(50) 	NOT NULL,						/*密码*/
	qq			VARCHAR(20),									/*QQ*/
	email		VARCHAR(50) 	NOT NULL ,						/*email*/
	dis			CHAR(255),										/*个人描述*/
	mood		VARCHAR(80),									/*心情*/
	sex  		 CHAR(1) 		NOT NULL,						/*性别*/
	integral	INT(11) 		NOT NULL,						/*积分*/
	hobby		VARCHAR(80),									/*爱好*/
	payname     varchar(128) DEFAULT 'makegoodsecret@sina.com',  /*用户的支付宝账号,目前只有卖家有效*/
	emailstatu 	CHAR(1)   		NOT NULL ,						/*用户的激活状况 ，未激活为0，激活为1，升级为饭店管理员为2*/
	level		INT(11)  		NOT NULL,						/*美食等级*/
	number		INT(11)  		NOT NULL,						/*访问次数*/
	power   	CHAR(1)  		NOT NULL ,						/*权限  管理员的权限为1，普通用户为0*/
	user_login_city VARCHAR(16) NOT NULL,
	time		TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP ,		/*注册的时间*/
	PRIMARY KEY(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS user_col;
/*我的收藏表*/
CREATE TABLE user_col(
	col_id 		INT(11)  	NOT NULL AUTO_INCREMENT,
	goods_id	INT(11)		DEFAULT '0' COMMENT '美食的id',							/*收藏美食的id*/
	meal_id		INT(11)   	DEFAULT '0' COMMENT '套餐的id',							/*收藏套餐的id*/
	hotel_id   	INT(11) 	DEFAULT '0' COMMENT '饭店的id',	  					 	/*收藏饭店的id*/
	user_id		INT(11)	    NOT NULL,												/*用户的id*/
	col_time	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,						/*收藏的时间*/
	PRIMARY KEY(col_id)							
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS sort;
/*美食种类表*/
CREATE TABLE sort(
	sort_id		INT(11)  	NOT NULL AUTO_INCREMENT,				/*美食种类表的id*/
	sort_name	CHAR(50)  	NOT NULL,								/*种类名称*/
	hotel_id    INT(11)     NOT NULL  ,  							/*饭店的id*/
	PRIMARY KEY(sort_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS goods_info;
/*美食信息表*/
CREATE TABLE goods_info(
	goods_id  		INT(11) 	NOT NULL AUTO_INCREMENT,				/*美食的编号*/
	goods_name		CHAR(50)	NOT NULL,								/*美食名称*/
	goods_dis		TEXT,												/*美食描述*/
	sort_id			INT(11) 	NOT NULL,								/*美食的种类id*/
	goods_price		DOUBLE 		NOT NULL,								/*美食的价格*/
	hotel_id   		INT(11) 	NOT NULL  ,  							/*饭店的id*/
	user_id         INT(11)  	NOT NULL,								/*上传用户的id*/
	goods_time		TIMESTAMP 	NOT NULL DEFAULT CURRENT_TIMESTAMP,		/*上传的时间*/
	PRIMARY KEY(goods_id)						
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*用户申请成为卖家*/
DROP TABLE IF EXISTS applyseller;
create table applyseller(
	applyseller_id  INT(11) NOT NULL AUTO_INCREMENT  ,
	applyseller_logo      VARCHAR(250)  	NOT NULL  ,      	/*申请饭店的商标(图片)*/
	applyseller_certificate VARCHAR(250) 	NOT NULL  ,      	/*申请饭店的证书(图片)*/
	applyseller_status   char(1)  NOT NULL  ,					/*申请的状态*/
	user_id		INT(11)			NOT NULL ,
	applyseller_time      TIMESTAMP  		NOT NULL DEFAULT CURRENT_TIMESTAMP  ,   /*申请饭店的时间*/
	PRIMARY key(applyseller_id)
)engine=InnoDB  DEFAULT  CHARSET=utf8;

/*饭店的信息表*/
DROP TABLE IF EXISTS hotel;
create table hotel(
	hotel_id   		INT(11) 		NOT NULL AUTO_INCREMENT ,    /*饭店的id*/
	hotel_name		VARCHAR(50) 	NOT NULL,					/*饭店名称*/
	hotel_ads       TEXT 			NOT NULL,					/*饭店的描述*/
	hotel_province    		VARCHAR(128) NOT NULL,				/*省*/
	hotel_city				VARCHAR(128) ,						/*市*/
	hotel_county			VARCHAR(128) ,					  /*区县*/
	hotel_other_address      VARCHAR(128) NOT NULL,				/*其他详细信息*/	
	hotel_cellphone  			VARCHAR(64)   	,				/*手机号码*/
	hotel_phonesection		VARCHAR(16)    ,					 /*区号*/
	hotel_phonecode          	VARCHAR(64)     ,				/*电话号码*/
	hotel_otherphone        	VARCHAR(64)    ,				/*分机号码*/
	
	hotel_lng		FLOAT(17,14) 	NOT NULL,					/*饭店所在地的经度*/
	hotel_lat		FLOAT(17,14) 	NOT NULL,					/*饭店所在地的纬度*/
	hotel_logo      VARCHAR(250)  	NOT NULL  ,      			/*饭店的商标(图片)*/
	hotel_certificate VARCHAR(250) 	NOT NULL  ,      			/*饭店的证书(图片)*/
	hotel_level      DOUBLE(11,2)  		NOT NULL  ,        			/*饭店的等级*/
	hotel_grade      INT(11)  		NOT NULL  ,    				/*饭店的访问次数及人气*/
	hotel_status     CHAR(1)  		NOT NULL,					/*饭店的状态是否开业*/
	user_id          INT(11) 		NOT NULL,					/*创建者的id,管理员创建为0*/
	hotel_time      TIMESTAMP  		NOT NULL DEFAULT CURRENT_TIMESTAMP  ,   /*饭店创建的时间*/
	hotel_shop_am_start  TIME   ,					        	/*饭店的营业中午开始时间*/
	hotel_shop_am_end    TIME      ,							/*饭店的营业中午结束时间*/
	hotel_shop_pm_start   TIME      NOT NULL,				/*饭店的营业晚上开始时间*/
	hotel_shop_pm_end    TIME      NOT NULL,					/*饭店的营业晚上结束时间*/
	PRIMARY KEY(hotel_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*套餐表*/
DROP TABLE IF EXISTS meal;
create table meal(
	meal_id   		INT(11)   		NOT NULL auto_increment,			/*套餐的编号*/
	meal_name  		VARCHAR(80)  	NOT NULL  ,							/*套餐的名称*/
	hotel_id   	 	INT (11)  		NOT NULL   ,   						/*套餐的所属饭店*/
	meal_price  	DOUBLE  		NOT NULL    ,						/*套餐的价格*/
	meal_statu    	CHAR(1)     	NOT NULL ,							/*套餐是否有效*/
	meal_time      TIMESTAMP   		NOT NULL DEFAULT CURRENT_TIMESTAMP,	/*套餐生成的时间*/
	primary key(meal_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*套餐与美食多对多关中间表*/
DROP TABLE IF EXISTS goods_meal;
CREATE TABLE goods_meal(
	meal_id   		INT(11)   		NOT NULL,
	goods_id  		INT(11) 		NOT NULL,
	PRIMARY KEY (meal_id, goods_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*美食图片表*/
DROP TABLE IF EXISTS goods_image;
CREATE TABLE goods_image(
	gimage_id  		INT(11)  		NOT NULL AUTO_INCREMENT ,			/*美食的图片编号*/
	gimage_image	VARCHAR(80) 	NOT NULL,							/*美食的图片*/
	goods_id  		INT(11) 		NOT NULL      ,
	gimage_time  	TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP,	/*上传图片的时间*/
	PRIMARY KEY(gimage_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS goods_assess;
/*美食评价表*/
CREATE TABLE goods_assess(
	ass_id  		INT(11)  		NOT NULL AUTO_INCREMENT ,		
	goods_id  		INT(11)  		 ,		  							/*美食的id*/
	meal_id   		INT(11)  		 ,			 						/*套餐的id*/
	hotel_id   		INT(11) 		 NOT NULL,									/*饭店的id*/
	user_id			INT(11)			NOT NULL,								/*评价的用户*/
	ass_stars       INT(11)         NOT NULL  DEFAULT '5' COMMENT '评价的星级' ,    /*用户评价的星级*/
	ass_dis			TEXT           	,										/*评价的内容*/
	ass_ip          VARCHAR(32)     NOT NULL,								/*评论者的ip地址*/
	order_id 		INT(11)			NOT NULL,                               /*订餐表的id*/
	ass_time  		TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP,		/*评价的时间*/
	PRIMARY KEY(ass_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS recommend;
/*每日推荐表*/
CREATE TABLE recommend(
	rec_id  		INT(11)  		NOT NULL AUTO_INCREMENT,			/*每日推荐的id*/
	goods_id  		INT(11)			NOT NULL,							/*美食的id*/
	hotel_id   		INT(11) 		DEFAULT '0' COMMENT '饭店的id',		/*饭店的id*/
	recommend_time  TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP,	/*推荐表的时间*/
	PRIMARY KEY(rec_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS ads;
/*广告表*/
CREATE TABLE ads(
	ads_id		INT(11)			NOT NULL AUTO_INCREMENT,		/*广告的id*/
	ads_image  	VARCHAR(80)  	NOT NULL,						/*广告的图片*/
	ads_dis		TEXT			NOT NULL,   					/*广告描述*/
	ads_statu   CHAR(1)			NOT NULL ,						/*广告的状态*/
	ads_time   TIMESTAMP     	NOT NULL DEFAULT CURRENT_TIMESTAMP,	/*添加广告的时间*/
	PRIMARY KEY(ads_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*收货地址*/

DROP TABLE IF EXISTS order_address;
CREATE  TABLE   order_address(
	order_address_id   INT(11)  	NOT NULL   AUTO_INCREMENT ,/*收货地址id*/
	order_name   		VARCHAR(64) NOT NULL,					/*收件人*/
	province    		VARCHAR(128) NOT NULL,					/*省*/
	city				VARCHAR(128) ,							/*市*/
	county				VARCHAR(128) ,							/*区县*/
	other_address      VARCHAR(128) NOT NULL,					/*其他详细信息*/	
	postCode			INT(11)		,							/*邮政编号*/
	cellphone  			VARCHAR(64)   	,							/*手机号码*/
	phonesection		VARCHAR(16)    ,					 		 /*区号*/
	phonecode          	VARCHAR(64)     ,						    /*电话号码*/
	otherphone        	VARCHAR(64)    ,						   /*分机号码*/
	user_id				INT(11)		NOT NULL,					/*用户id*/
	order_address_status  CHAR(1)	NOT NULL,					/*是否默认*/
	PRIMARY  KEY(order_address_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	



/*订餐表*/

DROP TABLE IF EXISTS goods_order;

CREATE TABLE goods_order(
	order_id 		INT(11)			NOT NULL AUTO_INCREMENT,   
	order_number    varchar(128)	NOT NULL ,				/*订单号*/ 						
	user_id			INT(11)			NOT NULL,				/*用户id*/
	order_address_id INT(11)  		NOT NULL ,				/*收货地址id*/
	goods_id  		INT(11)  				,				/*美食的id*/
	meal_id   		INT(11)   		        ,				/*套餐的id*/
	hotel_id   		INT(11)         NOT NULL ,				/*饭店id*/
	goods_number    INT(11)         NOT NULL, 				/*订的数量*/
	goodsormeal_ads TEXT              ,						/*单独的说明*/     
	alipay_trade_no varchar(128)    DEFAULT NULL COMMENT '支付宝交易号',  
	trade_status   varchar(128)     DEFAULT 'none',       		/*订单的状态*/
	order_ads		TEXT			,						/*订单说明,总说明,或者说是补充说明*/
	order_time		TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,				/*订单生成的时间*/
	PRIMARY    KEY(order_id) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*购物车表*/

DROP TABLE IF EXISTS goods_cart;

CREATE TABLE goods_cart(
	cart_id 		INT(11)			NOT NULL AUTO_INCREMENT,   
	user_id			INT(11)			NOT NULL,									/*用户id*/
	goods_id  		INT(11)  		DEFAULT '0' COMMENT '美食的id',				/*美食的id*/
	meal_id   		INT(11)   	    DEFAULT '0' COMMENT '套餐的id',				/*套餐的id*/
	goods_number    INT(11)         NOT NULL, 									/*订的数量*/
	order_ads		TEXT			,											/*说明*/
	PRIMARY    KEY(cart_id) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*好友关系表*/
DROP TABLE IF EXISTS user_friend;
CREATE TABLE  user_friend(
	user_friend_id  INT(11)   NOT   NULL  AUTO_INCREMENT,
	user_id         INT(11)   NOT   NULL,
	friend_id  		INT(11)   NOT   NUll ,
	friend_group    char      NOT   NUll  DEFAULT  '0' COMMENT '默认分组',
	relation  		 char     NOT   NULL DEFAULT  '1'  COMMENT   '普通好友',
	user_friend_time TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(user_friend_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



/**对好友分组*/
DROP TABLE IF EXISTS friend_group ;
CREATE  TABLE friend_group(
	friend_group_id int(11)  NOT  NULL AUTO_INCREMENT,
	user_id         int(11)  NOT  NULL ,
	friend_group_name  VARCHAR(32) NOT NULL,
	PRIMARY  KEY(friend_group_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/**好友关系表*/
DROP TABLE IF EXISTS user_friend ;
CREATE TABLE  user_friend(
	user_friend_id  int(11)  NOT   NULL  AUTO_INCREMENT ,
	user_id         int(11)   NOT   NULL,
	friend_id  	  int(11)   NOT   NULL ,
	friend_group_id int(11)     NOT   NULL , 	/**对该好友分组*/
	hiding_status   char(1)     NOT   NULL ,   	/**好友是否隐身(0不隐身,1隐身)*/
	gps_share       char(1)    NOT   NULL  ,    	/**用户是否共享GPS(0共享,1不共享)*/
	friend_apply_for_status char(1)  NOT   NULL  , /**是否为申请好友那一方(0是，1不是)*/
	user_friend_status  	char(1)     NOT   NULL  , 
	 /**是否同意加好友 n没有处理好友请求,y代表为申请好友的那一方，*/
	 /**0代表解除好友关系,1代表接受，2代表拒绝，3代表拉入黑名单,4代表加为密友*/
	user_friend_time TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(user_friend_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*发信息表*/
DROP TABLE  IF EXISTS  chat;
CREATE TABLE  chat(
	chat_id         bigint(11)      NOT  NULL  AUTO_INCREMENT  ,
	user_friend_id  INT(11)      NOT  NULL  ,					/*好友关系表*/
	chat_text       text         NOT  NUll  ,					/*内容*/
	friend_id       INT(11)      NOT  NUll  ,                 /*信息接收方*/
	chat_status     char         NOT  NULL  DEFAULT  '0' COMMENT  '发送的信息没有查看',  
	chat_time TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(chat_id)
)ENGINE=InnoDB  DEFAULT  CHARSET=utf8;



/**发送图片或压缩包表*/
DROP TABLE IF EXISTS chat_transmit_files ;
CREATE TABLE chat_transmit_files(
    chat_transmit_files_id   int(11)   NOT NULL AUTO_INCREMENT,
    chat_file           VARCHAR(32) NOT NULL,
    user_friend_id   int(11)     NOT  NULL  ,
    friend_id       int(11)      NOT  NULL  ,  
    chat_transmit_files_status  VARCHAR(1)  NOT NULL,
    chat_time      TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(chat_transmit_files_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

 
/**群表的类型*/
DROP TABLE  IF EXISTS user_friend_group_type ;
CREATE TABLE  user_friend_group_type(
	user_friend_group_type_id int(11) NOT NULL AUTO_INCREMENT,
	user_friend_group_type_name  VARCHAR(64) NOT NULL ,
	PRIMARY  KEY(user_friend_group_type_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
/**群表*/
DROP TABLE  IF EXISTS user_friend_group ;
CREATE TABLE  user_friend_group(
	user_friend_group_id  int(11)  NOT NULL AUTO_INCREMENT,
	user_id  int(11)  NOT NULL    ,								 
	user_friend_group_name  VARCHAR(64) NOT NULL,
	user_friend_group_publicnotice VARCHAR(128) NOT  NULL,		 
	user_friend_group_type_id  int(11)  NOT NULL,  
 	user_friend_group_time TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(user_friend_group_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
/**群与用户多对多中间表*/
DROP TABLE IF EXISTS group_user ;
CREATE TABLE  group_user (
	user_friend_group_id  int(11)  NOT NULL ,
	user_id    int(11)              NOT NULL,
	PRIMARY  KEY(user_friend_group_id ,user_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 
/**个人微博记录表*/
DROP TABLE IF EXISTS miniblogs ;
CREATE TABLE  miniblogs(
	miniblogs_id  int(11)  NOT NULL AUTO_INCREMENT,
	miniblogs_content  VARCHAR(256) NOT NULL,
	user_id  int(11) NOT NULL ,
	user_friend_support  int(11)  NOT  NULL , 	 
	user_friend_footpoint  int(11)   NOT NULL ,       
	miniblogs_status  char  NOT  NULL ,        
	miniblogs_time    TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(miniblogs_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 

/**个人微薄评价表*/
DROP TABLE IF EXISTS miniblogs_assess ;
CREATE TABLE  miniblogs_assess(
	miniblogs_assess_id  int(11)  NOT  NULL AUTO_INCREMENT ,
	user_friend_id       int(11)  NOT   NULL  ,   
	miniblogs_id  int(11)  NOT NULL,
	miniblogs_assess_content  VARCHAR(128) NOT NULL , 
	miniblogs_assess_time TIMESTAMP    	NOT NULL DEFAULT CURRENT_TIMESTAMP,		
	PRIMARY  KEY(miniblogs_assess_id)  
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


commit;
show tables;
