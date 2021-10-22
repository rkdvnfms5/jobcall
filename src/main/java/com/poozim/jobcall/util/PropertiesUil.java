package com.poozim.jobcall.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertiesUil {
	Properties props;
	private final String path = "classpath:/datasource.properties";
	
	public PropertiesUil() throws IOException {
		try {
			props = new Properties();
			FileInputStream fis = new FileInputStream(path);
			props.load(fis);
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public String getProperty(String prop) {
		return props.getProperty(prop, "");
	}
}
