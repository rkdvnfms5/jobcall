package com.poozim.jobcall.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class OciUtil {
	public static PropertiesUil propsUtil;
	public static String compartmentId;
	public static String namespace;
	
	public static String host = "https://objectstorage.ap-seoul-1.oraclecloud.com";
	
	public OciUtil() throws IOException {
		propsUtil = new PropertiesUil();
		this.compartmentId = propsUtil.getProperty("compartment_ocid");
		this.namespace = propsUtil.getProperty("storage_namespace");
	}
	
	public static int createBucket(String name) throws IOException {
		URL url = new URL(host + "/n/" + namespace + "/b/");
		HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoInput(true);
		conn.setDoOutput(true);
		
		BufferedReader br;
		
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		
		String buf;
		StringBuffer data = new StringBuffer();
		
		while((buf = br.readLine()) != null) {
			data.append(buf + "\r\n");
		}
		conn.disconnect();
		
		System.out.println("@@@@@@@@@@@@@ data : " + data.toString());
		return 0;
	}
}
