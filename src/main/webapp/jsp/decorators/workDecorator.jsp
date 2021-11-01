<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/jsp/include/common_header.jsp"%>
<link rel="stylesheet" href="/css/header.css"/>
<link rel="stylesheet" href="/css/work.css"/>
<script type="text/javascript" src="/scripts/work.js" ></script>
<sitemesh:write property='head' />
</head>
<body>
	<%@ include file="/jsp/include/work_header.jsp"%>
	<div class="work-contents">
		<main class="work-basic-layout">
			<%@ include file="/jsp/include/work_lnb.jsp"%>
			<sitemesh:write property='body' />
		</main>
</div>
</body>
</html>