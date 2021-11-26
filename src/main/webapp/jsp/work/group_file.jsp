<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<article class="work-basic-layout-body">
	<section class="wall-page">
		<%@include file="/jsp/include/group_header.jsp" %>	
	
		<div class="group-file-page">
			<div class="group-file-page-header">
			
			</div>
			<div class="group-file-page-body">
				<table class="table-list">
					<colgroup>
						<col width="5%">
						<col width="*">
						<col width="25%">
						<col width="10%">
						<col width="15%">
						<col width="5%">
					</colgroup>
					<tr class="title">
						<td>
						
						</td>
						<td>
							파일명
						</td>
						<td>
							작성자
						</td>
						<td>
							확장자
						</td>
						<td>
							등록일
						</td>
						<td>
						
						</td>
					</tr>
					<c:forEach items="${FileList}" var="file">
						<tr>
							<td>
							
							</td>
							<td>
								<span class="file-icon">
									<i class="ico ico-file_others" aria-hidden="true"><svg width="22px" height="28px" viewBox="0 0 22 28" version="1.1"><g id="file_others" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><path d="M0,0 L14,0 L22,8 L22,28 L0,28 L0,0 L0,0 Z" fill="#BFBFBF"></path><path d="M14,0 L22,8 L14,8 L14,0 L14,0 Z" fill="#A2A2A2"></path></g></svg></i>
								</span>
								<div class="file-name"><a href="${file.src}" target="_blank">${file.name}</a></div>
								<div class="file-size">${file.size}</div>
							</td>
							<td>
								${file.member_id} (${file.member_name})
							</td>
							<td>
								<c:set var="fileNameArr" value="${fn:split(file.name, '.')}" />
								${fileNameArr[fn:length(fileNameArr)-1]}
							</td>
							<td>
								<fmt:parseDate value='${file.regdate}' var='regdate' pattern='yyyy-MM-dd'/>
                 				<fmt:formatDate value="${regdate}" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
</article>
<script>
$(document).ready(function(){
	
})

</script>
</body>
</html>