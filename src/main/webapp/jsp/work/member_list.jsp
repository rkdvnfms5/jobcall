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
			<h2 class="work-basic-header-title">멤버 <span class="info">${fn:length(MemberList)}</span></h2>
			<form id="" class="search-form" action="/work/members">
				<fieldset>
					<input type="text" class="search-input" autocomplete="off" autocapitalize="off" name="search" title="검색어 입력" placeholder="ID, 이름, 소속 검색" value="${Member.search}">
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
				<div class="member-list-area">
					<div class="member-list-header">
						<span>${empty Member.search? '전체 멤버':Member.search }${empty Member.search? '':' 검색 결과' }</span>
					</div>
					<div class="member-list-body">
						<ul class="members-list">
							<c:forEach items="${MemberList}" var="memberOne">
								<li>
									<div class="member-profile" onclick="showMemberProfile(${memberOne.seq}, this);" >
										<span class="avatar" style="width: 36px; height: 36px; background-image:
										 url('${empty memberOne.profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':memberOne.profile}');"></span>
									</div>
									<div class="member-meta">
										<div class="member-id">${memberOne.id} (${memberOne.name})</div>
										<div class="member-department">${memberOne.department}</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
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