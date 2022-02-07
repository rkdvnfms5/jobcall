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
	<section class="work-basic-page">
		<header class="work-basic-header">
			<h2 class="work-basic-header-title">그룹 <span class="info">${fn:length(WorkGroupList)}</span></h2>
			<form id="" class="search-form" action="/work/groups">
				<fieldset>
					<input type="text" class="search-input" autocomplete="off" autocapitalize="off" name="search" title="검색어 입력" placeholder="그룹 검색" value="${Group.search}">
					<button class="search-btn" type="submit">
						<i class="ico ico-search" aria-hidden="true"><svg width="15px" height="14px" viewBox="0 0 15 14" version="1.1"><g id="search" stroke="none" stroke-width="1" fill="#565A5F" fill-rule="evenodd"><path d="M9.9603736,10.3329493 C8.91643607,11.0870077 7.60676898,11.5357143 6.18487913,11.5357143 C2.77379116,11.5357143 0.00855799453,8.95335668 0.00855799453,5.76785714 C0.00855799453,2.5823576 2.77379116,0 6.18487913,0 C9.5959671,0 12.3612003,2.5823576 12.3612003,5.76785714 C12.3612003,7.09571193 11.8807175,8.31876567 11.0732587,9.29366358 L15,12.9607143 L13.8871149,14 L9.9603736,10.3329493 Z M6.18487913,10.3214286 C8.87784331,10.3214286 11.0609221,8.2827252 11.0609221,5.76785714 C11.0609221,3.25298909 8.87784331,1.21428571 6.18487913,1.21428571 C3.49191494,1.21428571 1.30883613,3.25298909 1.30883613,5.76785714 C1.30883613,8.2827252 3.49191494,10.3214286 6.18487913,10.3214286 Z"></path></g></svg></i>
					</button>
				</fieldset>
			</form>
		</header>
		
		<div class="work-basic-content">
			<div class="work-basic-content-header">
				
			</div>
			<div class="work-basic-content-body">
				<div class="group-list-area">
					<ul class="group-list">
						<c:forEach items="${WorkGroupList}" var="group">
							<li class="group-item" onclick="location.href='/work/group/${group.seq}'">
								<h3 class="group-item-title">${group.name}</h3>
								<p class="group-item-info">${group.content}</p>
								<div class="group-item-footer">
									<span class="group-members">멤버 <span class="primary">${group.member_count}</span></span>
									<c:if test="${group.attendyn eq 'Y'}">
										<button type="button" class="group-exit-button" onclick="exitGroup(${group.seq})">나가기</button>
									</c:if>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</section>
</article>
<script>
$(document).ready(function(){
	$('.group-exit-button').on("click", function(e){
		e.stopPropagation();
	})
})

function exitGroup(group_seq){
	showLoading();
	
	$.ajax({
		url : '/work/groups',
		method : 'DELETE',
		data : {group_seq : group_seq},
		dataType : 'JSON',
		success : function(res){
			if(res.res == 1){
				location.reload();
			} else {
				alret(res.msg);
			}
			hideLoading();
		},
	})
}

</script>
</body>
</html>