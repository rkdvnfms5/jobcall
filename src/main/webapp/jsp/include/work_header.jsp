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
				<li>
					<button type="button" class="btn-notice" onclick="openNotify()">
						<i class="ico ico-notify" aria-hidden="true"><svg width="22px" height="24px" viewBox="0 0 22 24" version="1.1"><g id="notify" stroke="none" stroke-width="1" fill="#8D9192" fill-rule="evenodd"><path d="M14.881368,21 C14.435062,22.7236084 12.86651,24 11.0000101,24 C9.13691145,24 7.56548092,22.7254067 7.11864711,21 L4.4474646,21 L1.4868545,21 C0.0106719325,21 -0.449693943,20.045404 0.485061809,18.8678503 L2.9215317,15.7985197 L2.9215317,9.5284967 C2.9215317,6.23499368 5.22690577,3.48803865 8.3104299,2.85955053 C8.30826986,2.81479495 8.30717723,2.76975568 8.30717723,2.7244582 C8.30717723,1.21978149 9.51279505,0 11,0 C12.4872049,0 13.6928228,1.21978149 13.6928228,2.7244582 C13.6928228,2.77020551 13.6917083,2.81568946 13.6895054,2.8608838 C16.7641629,3.49319612 19.0784683,6.247648 19.0784683,9.5284967 L19.0784683,15.7985197 L21.5149382,18.8678503 C22.4496939,20.045404 21.9893281,21 20.5131455,21 L17.5525354,21 L14.881368,21 Z M4.46161637,20 L17.5383836,20 L20.4925996,20 C21.1302276,20 21.1245332,20.0120473 20.7106926,19.4895853 L18.2794849,16.4202548 L18.0631806,16.1471769 L18.0631806,15.7985197 L18.0631806,9.5284967 C18.0631806,6.76098439 16.1247492,4.38490752 13.4826945,3.8403852 L12.6454242,3.66782543 L12.6870398,2.81219879 C12.6884556,2.78308906 12.6891667,2.75383815 12.6891667,2.7244582 C12.6891667,1.76946868 11.9302754,1 11,1 C10.0697246,1 9.31083329,1.76946868 9.31083329,2.7244582 C9.31083329,2.75355045 9.31153052,2.78251618 9.31291881,2.81134361 L9.35417909,3.66809841 L8.51552252,3.83940452 C5.86695103,4.38040843 3.93681935,6.74752834 3.93681935,9.5284967 L3.93681935,15.7985197 L3.93681935,16.1471769 L3.72051513,16.4202548 L1.28930737,19.4895853 C0.875466754,20.0120473 0.869772386,20 1.50740042,20 L4.46161637,20 Z M13.8292943,21 C13.4174579,22.1651924 12.3062188,23 11,23 C9.69378117,23 8.58254212,22.1651924 8.17070571,21 L13.8292943,21 L13.8292943,21 Z"></path></g></svg></i>
					</button>
				</li>
				<li class="btn-logout">
					<a href="/sign/logout">로그아웃</a>
				</li>
			</ul>
		</div>
	</div>
</header>

<div id="notify-layer" class="notify-layer">
	<ul class="notify-list">
		<%-- <c:forEach items="${NotificationList}" var="Notification">
			<li class="${Notification.confirmyn eq 'N'? 'new':''}" onclick="location.href='/work/group/${Notification.group_seq}/${Notification.board_seq}'">
				<div class="notify-profile">
					<span class="avatar"
					style="width: 50px; height: 50px; 
					background-image: url('${empty Notification.member_profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':Notification.member_profile}');">
					</span>
				</div>
				<div class="notify-content">
					${Notification.content}
				</div>
				<div class="notify-date">
					${fn:split(Notification.regdate, ' ')[0]}
				</div>
			</li>
		</c:forEach> --%>
	</ul>
	<div class="empty-notify" style="display: none;">
		<i class="ico ico-notify" aria-hidden="true"><svg width="22px" height="24px" viewBox="0 0 22 24" version="1.1"><g id="notify" stroke="none" stroke-width="1" fill="#8D9192" fill-rule="evenodd"><path d="M14.881368,21 C14.435062,22.7236084 12.86651,24 11.0000101,24 C9.13691145,24 7.56548092,22.7254067 7.11864711,21 L4.4474646,21 L1.4868545,21 C0.0106719325,21 -0.449693943,20.045404 0.485061809,18.8678503 L2.9215317,15.7985197 L2.9215317,9.5284967 C2.9215317,6.23499368 5.22690577,3.48803865 8.3104299,2.85955053 C8.30826986,2.81479495 8.30717723,2.76975568 8.30717723,2.7244582 C8.30717723,1.21978149 9.51279505,0 11,0 C12.4872049,0 13.6928228,1.21978149 13.6928228,2.7244582 C13.6928228,2.77020551 13.6917083,2.81568946 13.6895054,2.8608838 C16.7641629,3.49319612 19.0784683,6.247648 19.0784683,9.5284967 L19.0784683,15.7985197 L21.5149382,18.8678503 C22.4496939,20.045404 21.9893281,21 20.5131455,21 L17.5525354,21 L14.881368,21 Z M4.46161637,20 L17.5383836,20 L20.4925996,20 C21.1302276,20 21.1245332,20.0120473 20.7106926,19.4895853 L18.2794849,16.4202548 L18.0631806,16.1471769 L18.0631806,15.7985197 L18.0631806,9.5284967 C18.0631806,6.76098439 16.1247492,4.38490752 13.4826945,3.8403852 L12.6454242,3.66782543 L12.6870398,2.81219879 C12.6884556,2.78308906 12.6891667,2.75383815 12.6891667,2.7244582 C12.6891667,1.76946868 11.9302754,1 11,1 C10.0697246,1 9.31083329,1.76946868 9.31083329,2.7244582 C9.31083329,2.75355045 9.31153052,2.78251618 9.31291881,2.81134361 L9.35417909,3.66809841 L8.51552252,3.83940452 C5.86695103,4.38040843 3.93681935,6.74752834 3.93681935,9.5284967 L3.93681935,15.7985197 L3.93681935,16.1471769 L3.72051513,16.4202548 L1.28930737,19.4895853 C0.875466754,20.0120473 0.869772386,20 1.50740042,20 L4.46161637,20 Z M13.8292943,21 C13.4174579,22.1651924 12.3062188,23 11,23 C9.69378117,23 8.58254212,22.1651924 8.17070571,21 L13.8292943,21 L13.8292943,21 Z"></path></g></svg></i>
		<p>알림이 없습니다.</p>
	</div>
	<div id ="notify-loading" class="notify-loading" style="display: none;">
		<div class="loading"></div>
	</div>
</div>
<form id="notify-form">
	<input type="hidden" name="limit" value="20" />
	<input type="hidden" name="offset" value="0" />
</form>

<script>
var paging = true;

function openNotify(){
	if(!$("#notify-layer").hasClass("on")){
		if($("#notify-layer ul.notify-list li").length == 0){
			getNotify();
		}
	}
	$('#notify-layer').toggleClass('on')
}

function getNotify(){
	$("#notify-loading").show();
	//show 로딩
	
	$.ajax({
		url : '/work/notify',
		method : 'GET',
		data : $("#notify-form").serialize(),
		dataType : 'JSON',
		success : function(res) {
			var html = "";
			if(res.list.length > 0) {
				for(var i=0; i<res.list.length; i++){
					html += htmlNotify(res.list[i]);
				}
			}
			$("#notify-layer ul.notify-list").prepend(html);
			
			//set limit offset
			var offset = Number($("#notify-form input[name='offset']").val()) + Number(res.list.length);
			$("#notify-form input[name='offset']").val(offset);
			
			//when empty notify
			if($("#notify-layer ul.notify-list li").length == 0){
				$("#notify-layer .empty-notify").show();
			} else {
				$("#notify-layer .empty-notify").hide();
			}
			
			$("#notify-loading").hide();
		},
		error : function(error) {
			$("#notify-loading").hide();
		}
		//hide 로딩
	})
}

function htmlNotify(notify){
	var html = "";
	
	var profile = (notify.member_profile == '' || notify.member_profile == undefined ? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png' : notify.member_profile);
	
	html += '<li class="';
	if(notify.confrimyn == 'N'){
		html += 'new';
	}
	html += '" onclick="location.href=\'/work/group/' + notify.group_seq + '/' + notify.board_seq + '\'">';
	html += '<div class="notify-profile">';
	html += '<span class="avatar" style="width: 50px; height: 50px; background-image: url(\'' + profile + '\');"></span></div>';
	html += '<div class="notify-content">' + notify.content + '</div>';
	html += '<div class="notify-date"> ' + notify.regdate.split(' ')[0] + ' </div></li>';
		
	return html;
}

</script>
