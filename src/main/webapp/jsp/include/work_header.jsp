<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<header class="work-header">
	<div class="work-header-contents">
		<h2 class="work-header-logo">
			<a href="/work/${LnbWork.seq}/home">${LnbWork.title} 업무방</a>
		</h2>
		<div class="work-header-search">
			<h2 class="screen-out"><span>검색창</span></h2>
			<form class="work-search-form" id="work-header-searchForm" action="/work/search">
				<c:if test="${not empty WorkGroup}">
					<input type="hidden" name="group_seq" value="${WorkGroup.seq}">
				</c:if>
				<input type="hidden" name="work_seq" value="${LnbWork.seq}">
				<div class="search-bar">
					<c:if test="${not empty WorkGroup}">
						<div class="search-bar-filter">
							<span class="search-bar-filter-label">그룹: ${WorkGroup.name}</span>
						</div>
					</c:if>
					<input type="text" name="search" class="search-bar__input" placeholder="키워드를 입력하세요" value="${search}" />
					<button type="submit" class="icon-button search-bar__search-button">
						<i class="ico ico-search" aria-hidden="true"><svg width="15px" height="14px" viewBox="0 0 15 14" version="1.1"><g id="search" stroke="none" stroke-width="1" fill="#565A5F" fill-rule="evenodd"><path d="M9.9603736,10.3329493 C8.91643607,11.0870077 7.60676898,11.5357143 6.18487913,11.5357143 C2.77379116,11.5357143 0.00855799453,8.95335668 0.00855799453,5.76785714 C0.00855799453,2.5823576 2.77379116,0 6.18487913,0 C9.5959671,0 12.3612003,2.5823576 12.3612003,5.76785714 C12.3612003,7.09571193 11.8807175,8.31876567 11.0732587,9.29366358 L15,12.9607143 L13.8871149,14 L9.9603736,10.3329493 Z M6.18487913,10.3214286 C8.87784331,10.3214286 11.0609221,8.2827252 11.0609221,5.76785714 C11.0609221,3.25298909 8.87784331,1.21428571 6.18487913,1.21428571 C3.49191494,1.21428571 1.30883613,3.25298909 1.30883613,5.76785714 C1.30883613,8.2827252 3.49191494,10.3214286 6.18487913,10.3214286 Z"></path></g></svg></i>
					</button>
				</div>
			</form>
		</div>
		<div class="work-header-nav">
			<ul>
				<li class="btn-logout">
					<a href="/sign/logout">로그아웃</a>
				</li>
			</ul>
		</div>
	</div>
</header>
