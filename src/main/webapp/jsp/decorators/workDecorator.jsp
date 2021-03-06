<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잡콜이야</title>
<%@ include file="/jsp/include/common_header.jsp"%>
<link rel="stylesheet" href="/css/header.css"/>
<link rel="stylesheet" href="/css/work.css"/>
<script type="text/javascript" src="/scripts/work.js" ></script>
<sitemesh:write property='head' />
<style>
.lodingDim {
	width: 100%;
	height: 100%;
	z-index: 999;
	background-color: rgba(0,0,0,0.5);
	position: fixed;
	top: 0;
}

.loading {
  position: fixed;
  top: 50%;
  left: 50%;
  width: 100px;
  height: 100px;
  transform: translate(-50%, -50%);
  z-index: 9999;
}

.loading::after {
  content: '';
  box-sizing: border-box;
  position: absolute;
  top: 50%;
  left: 50%;
  width: 64px;
  height: 64px;
  margin-top: -32px;
  margin-left: -32px;
  border-radius: 50%;
  border: 4px solid lightgrey;
  border-top-color: blue;
  animation: spinner .8s linear infinite;
}

@keyframes spinner {
  from {transform: rotate(0deg); }
  to {transform: rotate(360deg);}
}

</style>
</head>
<body>
	<%@ include file="/jsp/include/work_header.jsp"%>
	<div class="work-contents">
		<main class="work-basic-layout">
			<%@ include file="/jsp/include/work_lnb.jsp"%>
			<div id="work-deco-body">
				<sitemesh:write property='body' />
			</div>
		</main>
		<%@ include file="/jsp/include/work_chat.jsp"%>
	</div>
<input type="hidden" id="member_seq" value="${member.seq}">
<div class="lodingDim hide">
	<div class="loading"></div>
</div>
<script>
function getPageAjax(url){
	//$("#work-deco-body").load(url + " #work-deco-body");
	/*
	showLoading();
	$.ajax({
		url : url,
		method : 'GET',
		dataType : 'html',
		success : function(data) {
			var body_temp = $("#work-deco-body").html(data).find("#work-deco-body");
			var header_temp = $("#work-deco-body").html(data).find("header.work-header");
			//console.log(body_temp.html());
			$("#work-deco-body").html(body_temp.html());
			$("header.work-header").html(header_temp.html());
			
			hideLoading();
		},
		error : function(request, status, error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			hideLoading();
		}
	})
	
	history.pushState(null, '', url);
	*/
}
</script>
</body>
</html>