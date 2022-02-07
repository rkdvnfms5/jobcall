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
				<c:if test="${member.seq eq WorkGroup.master_seq}">
					<a class="ra-button" href="/work/group/${WorkGroup.seq}/invite">
						멤버 초대
					</a>
				</c:if>
			</div>
			<div class="group-members-page-body">
				<ul class="group-members-list">
					<c:forEach items="${MemberList}" var="memberOne">
						<li>
							<div class="group-member-profile" style="cursor: pointer;" onclick="showMemberProfile(${memberOne.seq}, this);" >
								<span class="avatar" style="width: 36px; height: 36px; background-image:
								 url('${empty memberOne.profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':memberOne.profile}');"></span>
							</div>
							<div class="group-member-meta">
								<div class="group-member-id">${memberOne.id} (${memberOne.name})</div>
								<div class="group-member-department">${memberOne.department}</div>
							</div>
							<c:if test="${member.seq ne memberOne.seq}">
								<c:if test="${member.seq eq WorkGroup.master_seq}">
									<div class="group-member-edit">
										<button type="button" class="ra-button" onclick="deleteGroupMember(${memberOne.seq})">내보내기</button>
									</div>
								</c:if>
							</c:if>
							
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

function deleteGroupMember(member_seq){
	if(member_seq > 0 && confirm("정말 내보내겠습니까?")){
		showLoading();
		$.ajax({
			url : '/work/group/${WorkGroup.seq}/member',
			method : 'DELETE',
			data : {delete_seq : member_seq},
			dataType : 'JSON',
			success : function(res) { 
				if(res.res == 1){
					location.reload();
				} else {
					alert(res.msg);
				}
				hideLoading();
			},
			error : function(error){
				alert(error);
				hideLoading();
			}
		})
	}
}
</script>
</body>
</html>