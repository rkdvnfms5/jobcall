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
	
		<div class="group-members-page">
			<div class="group-members-page-header">
			
			</div>
			<div class="group-members-page-body">
				<ul class="group-members-list">
					<c:forEach items="${MemberList}" var="member">
						<li>
							<div class="group-member-profile">
								<span class="avatar" style="width: 36px; height: 36px; background-image:
								 url('${empty member.profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':member.profile}');"></span>
							</div>
							<div class="group-member-meta">
								<div class="group-member-id">${member.id} (${member.name})</div>
								<div class="group-member-department">${member.department}</div>
							</div>
						</li>
					</c:forEach>
				</ul>
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