package com.poozim.jobcall.util;

public class StringUtil {

	public static String getSizeStr(long size) {
		StringBuffer rtn;
		if(size > 1000000000) {
			double size_double = (double)(size/1000000000.00);
			rtn = new StringBuffer(Math.round(size_double*100/100.0) + "GB");
		}
		else if(size > 1000000) {
			double size_double = (double)(size/1000000.00);
			rtn = new StringBuffer(Math.round(size_double*100/100.0) + "MB");
		}
		else if(size > 1000) {
			double size_double = (double)(size/1000.00);
			rtn = new StringBuffer(Math.round(size_double*100/100.0) + "KB");
		} 
		else {
			rtn = new StringBuffer(size + "B");
		}
		return rtn.toString();
	}
}
