<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잡콜이야</title>
<%@ include file="/jsp/include/common_header.jsp"%>
<link rel="stylesheet" href="/css/header.css"/>
<link rel="stylesheet" href="/css/main.css"/>
<script type="text/javascript" src="/scripts/sign.js" ></script>
<sitemesh:write property='head' />
</head>
<body>
	<%@ include file="/jsp/include/main_header.jsp"%>
	<sitemesh:write property='body' />
</body>
</html>