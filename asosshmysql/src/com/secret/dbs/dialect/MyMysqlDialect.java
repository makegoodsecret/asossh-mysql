package com.secret.dbs.dialect;

import org.hibernate.Hibernate;
import org.hibernate.dialect.function.SQLFunctionTemplate;

public class MyMysqlDialect extends  org.hibernate.dialect.MySQLDialect {
	public MyMysqlDialect(){
		super();
		registerFunction("rad", new SQLFunctionTemplate(Hibernate.STRING, "rad(?1 )"));
		registerFunction("getdistance", new SQLFunctionTemplate(Hibernate.STRING, "getdistance(?1,?2,?3,?4)"));
		registerFunction("mydatebetween", new SQLFunctionTemplate(Hibernate.STRING, "mydatebetween(?1)"));
	}
}
