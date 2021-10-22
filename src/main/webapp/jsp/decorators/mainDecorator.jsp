<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/jsp/include/common_header.jsp"%>
<sitemesh:write property='head' />
</head>
<body>
	<h1>데코레이터</h1>
	<%@ include file="/jsp/include/main_header.jsp"%>
	<sitemesh:write property='body' />
</body>
</html>