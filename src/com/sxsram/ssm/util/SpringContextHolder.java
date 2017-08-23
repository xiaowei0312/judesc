package com.sxsram.ssm.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringContextHolder {
	private static ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext_xml.xml");

	public static Object getBean(String string) {
		return ctx.getBean(string);
	}

	public static Object getBean(Class clazz) {
		return ctx.getBean(clazz);
	}
}
