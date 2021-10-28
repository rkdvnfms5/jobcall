package com.poozim.jobcall.filter;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils;

public class XSSFilterWrapper extends HttpServletRequestWrapper{

	private byte[] rawData;
	
	public XSSFilterWrapper(HttpServletRequest request) {
		super(request);
		try {
			if(request.getMethod().equalsIgnoreCase("post") && (request.getContentType().equals("application/json") || request.getContentType().equals("multipart/form-data"))) {
				InputStream is = request.getInputStream();
				this.rawData = replaceXSS(IOUtils.toByteArray(is));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	
	//XSS replace
	private byte[] replaceXSS(byte[] data) {
		String strData = new String(data);
		strData = strData.replaceAll("\\<", "&lt;").replaceAll("\\>", "&gt;").replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		
		return strData.getBytes();
	}
	
	private String replaceXSS(String value) {
		if(value != null) {
			value = value.replaceAll("\\<", "&lt;").replaceAll("\\>", "&gt;").replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		}
		return value;
	}
	
	//새로운 인풋스트림을 리턴하지 않으면 에러가 남
	@Override
	public ServletInputStream getInputStream() throws IOException {
		if(this.rawData == null) {
			return super.getInputStream();
		}
		final ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(this.rawData);
		
		return new ServletInputStream() {
			
			@Override
			public int read() throws IOException {
				// TODO Auto-generated method stub
				return byteArrayInputStream.read();
			}
		};
	}

	@Override
	public String getQueryString() {
		return replaceXSS(super.getQueryString());
	}


	@Override
	public String getParameter(String name) {
		return replaceXSS(super.getParameter(name));
	}


	@Override
	public Map<String, String[]> getParameterMap() {
		Map<String, String[]> params = super.getParameterMap();
		if(params != null) {
			params.forEach((key, value) -> {
				for(int i=0; i<value.length; i++) {
					value[i] = replaceXSS(value[i]);
				}
			});
		}
		return params;
	}


	@Override
	public String[] getParameterValues(String name) {
		String[] params = super.getParameterValues(name);
		if(params != null) {
			for(int i=0; i<params.length; i++) {
				params[i] = replaceXSS(params[i]);
			}
		}
		return params;
	}


	@Override
	public BufferedReader getReader() throws IOException {
		return new BufferedReader(new InputStreamReader(this.getInputStream(), "UTF_8"));
	}

	
	
}
