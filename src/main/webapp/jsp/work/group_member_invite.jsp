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
				<div class="group-members-list-title">그룹에 참여하지 않은 멤버 (${fn:length(MemberList)})</div>
				<ul class="group-members-list">
					<c:forEach items="${MemberList}" var="member">
						<li>
							<span class="ra-checkbox" style="margin-left: 3px; margin-right: 8px;">
								<input type="checkbox" name="invite_member" value="${member.seq}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
							</span>
							<div class="group-member-profile" onclick="showMemberProfile(${member.seq}, this);" >
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
			<div class="group-members-page-footer">
				<button type="button" class="ra-button" onclick="inviteMembers()">
					초대하기
				</button>
			</div>
			<div class="group-members-invited-page-body">
				<div class="group-members-list-title">초대 중인 멤버 (${fn:length(InviteLogList)})</div>
				<ul class="group-members-invited-list">
					<c:choose>
						<c:when test="${fn:length(InviteLogList) gt 0}">
							<c:forEach items="${InviteLogList}" var="invitedMember">
								<li>
									<div class="group-member-profile" onclick="showMemberProfile(${invitedMember.seq}, this);" >
										<span class="avatar" style="width: 36px; height: 36px; background-image:
										 url('${empty invitedMember.profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':member.profile}');"></span>
									</div>
									<div class="group-member-meta">
										<div class="group-member-id">${invitedMember.id} (${invitedMember.name})</div>
										<div class="group-member-department">${invitedMember.department}</div>
									</div>
									<div class="groupo-member-invite">
										<button type="button" class="ra-button" onclick="reInvite(${invitedMember.inviteLog_seq})">재초대</button>
										<button type="button" class="ra-button" onclick="cancelInvite(${invitedMember.inviteLog_seq})">초대 취소</button>
									</div>
								</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li>초대 중인 멤버가 없습니다.</li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
		</div>
	</section>
</article>
<script>
$(document).ready(function(){
	
})

function inviteMembers(){
	var memberSeqArr = new Array();
	$("input[name='invite_member']:checked").each(function(index, item){
		memberSeqArr.push(item.value);
	});
	
	if(memberSeqArr.length > 0){
		$.ajax({
			url : '/work/group/${WorkGroup.seq}/invite',
			method : 'POST',
			data : {member_seq : memberSeqArr},
			dataType : 'JSON',
			success : function(res){
				if(res.res == 1){
					location.reload();
				}
				else {
					alert(res.msg);
				}
			}
		})
	} else {
		alert('선택된 초대할 멤버가 없습니다.');
	}
	
}

function cancelInvite(inviteLog_seq){
	if(inviteLog_seq > 0 && confirm("초대를 취소하시겠습니까?")){
		$.ajax({
			url : '/work/group/${WorkGroup.seq}/invite',
			method : 'DELETE',
			data : {seq : inviteLog_seq},
			dataType : 'JSON',
			success : function(res){
				if(res.res == 1){
					location.reload();
				}
				else {
					alert(res.msg);
				}
			}
		})
	}
}

function reInvite(inviteLog_seq){
	if(inviteLog_seq > 0){
		$.ajax({
			url : '/work/group/${WorkGroup.seq}/invite',
			method : 'PUT',
			data : {seq : inviteLog_seq},
			dataType : 'JSON',
			success : function(res){
				if(res.res == 1){
					alert("초대 완료");
					location.reload();
				}
				else {
					alert(res.msg);
				}
			}
		})
	}
}

</script>
</body>
</html>