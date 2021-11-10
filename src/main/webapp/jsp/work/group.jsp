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
		<header class="group-header">
			<div class="group-header__image">
				<div style="background-image: url('https://t1.daumcdn.net/agit_resources/images/background/9.png');"></div>
			</div>
			
			<div class="group-header__body">
				<div class="group-header__info">
					<h2 class="group-header__title">
						<a class="group-header__title-link" href="#">${WorkGroup.name}</a>
					</h2>
					<p class="group-header__short-desc">${WorkGroup.name} 업무 협업방입니다.</p>
					<div class="group-header__meta">
						<c:if test="${WorkGroup.access eq 'private'}">
							<span class="group-header__private-group" title="이 그룹은 초대를 받은 아지트 멤버들에게만 보입니다.">
								<i class="ico ico-lock" aria-hidden="true">
									<svg width="8px" height="10px" viewBox="0 0 8 10" version="1.1"><g id="lock" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M6.93177579,4.00166776 L6.93177579,2.96834236 C6.93177579,1.33357103 5.60056952,0.00832702498 3.9658879,0.00832702498 C2.32787324,0.00832702498 1,1.33901285 1,2.96834236 L1,4.00638348 C0.43643723,4.05812741 0,4.41813387 0,4.85503827 L0,9.14496173 C0,9.61718633 0.510070171,10 1.14005102,10 L6.85994898,10 C7.48958177,10 8,9.61744737 8,9.14496173 L8,4.85503827 C8,4.40089775 7.52824857,4.02945121 6.93177579,4.00166776 Z M2,4 L2,2.99011614 C2,1.89521499 2.8973316,1 4,1 C5.10293921,1 6,1.89311649 6,2.99011614 L6,4 L2,4 Z"></path></g></svg>
								</i>
								비공개 그룹
							</span>
						</c:if>
						
						<span class="middle-dot"> · </span>
						<span class="group-header__master-nickname">${WorkGroup.register} (마스터명)</span>
						<span class="middle-dot"> · </span>
						<span class="group-header__members-count">${WorkGroup.member_count}명</span>
					</div>
				</div>
				<div class="group-header__controls">
					<!-- <span class="ra-popover__trigger group-header__notification-menu-wraper" title="">
						<button class="ra-config__button group-header__notification-menu-button">
							<i class="ico ico-notification" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 14 14"><path fill="#FFF" fill-rule="evenodd" d="M10.638 6.13c0-1.125-.27-2.095-.809-2.91a3.761 3.761 0 0 0-1.978-1.546l-.04-.02-.087-.021a4.37 4.37 0 0 0-.172-.049v-.5c0-.298-.102-.553-.305-.765A.98.98 0 0 0 6.512 0a.994.994 0 0 0-.755.319 1.068 1.068 0 0 0-.306.766v.5a4.37 4.37 0 0 0-.172.048l-.087.02-.04.02A3.761 3.761 0 0 0 3.174 3.22c-.54.815-.809 1.785-.809 2.91l.021 3.565L1 11.141v.706h11v-.706l-1.386-1.446.024-3.565zM6.512 14c-.385 0-.712-.135-.982-.405a1.368 1.368 0 0 1-.404-1.007h2.772c0 .402-.134.738-.404 1.007-.27.27-.597.405-.982.405z"></path></svg></i>
							<span>웹 푸시</span>
							<i class="ico ico-expand" aria-hidden="true"><svg width="12px" height="7px" viewBox="0 0 12 7" version="1.1"><g id="expand" stroke="none" stroke-width="1" fill="#D8D8D8" fill-rule="evenodd"><path d="M10.59375,0 L12,1.32911392 L6,7 L0,1.32911392 L1.40625,0 L6,4.34177215 L10.59375,0 Z"></path></g></svg></i>
						</button>
					</span>
					<button class="ra-config__button group-header__feed-button">
						<i class="ico ico-preview" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 14 14"><g id="setting" stroke="none" stroke-width="1" fill="#5A86DD" fill-rule="evenodd"><path fill-rule="evenodd" d="M4.02 10.815a7.511 7.511 0 0 1-2.423-1.66A7.334 7.334 0 0 1 0 6.688a7.475 7.475 0 0 1 1.59-2.473A7.441 7.441 0 0 1 6.985 1.94c1.08 0 2.073.203 3.01.607a7.37 7.37 0 0 1 2.415 1.67A7.475 7.475 0 0 1 14 6.688c-.367.93-.9 1.752-1.597 2.465a7.511 7.511 0 0 1-2.608 1.738c-.844.353-1.771.53-2.78.53-1.039 0-1.966-.177-2.812-.53a9.342 9.342 0 0 1-.183-.077zm2.955-.965a3.175 3.175 0 1 0 0-6.35 3.175 3.175 0 0 0 0 6.35zM7 8.65a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"></path></g></svg></i>
						피드
					</button> -->
					<c:if test="${WorkGroup.member_seq eq member.seq}">
						<span class="ra-popover__trigger group-header__config-menu-button-wraper" title="">
							<button class="ra-config__button group-header__config-menu-button" onclick="goGroupSetting(${WorkGroup.seq})">
								<i class="ico ico-setting" aria-hidden="true"><svg width="12px" height="12px" viewBox="0 0 12 12" version="1.1"><g id="setting" stroke="none" stroke-width="1" fill="#5A86DD" fill-rule="evenodd"><path d="M5,2.12601749 L5,0.999807492 C5,0.447629061 5.44386482,0 6,0 C6.55228475,0 7,0.443716645 7,0.999807492 L7,2.12601749 C7.36702099,2.22048216 7.71365561,2.36572819 8.03196735,2.55381909 L8.82856325,1.75722319 C9.21901236,1.36677408 9.84939373,1.36411236 10.2426407,1.75735931 C10.633165,2.1478836 10.6359924,2.77822114 10.2427768,3.17143675 L9.44618091,3.96803265 C9.63427181,4.28634439 9.77951784,4.63297901 9.87398251,5 L11.0001925,5 C11.5523709,5 12,5.44386482 12,6 C12,6.55228475 11.5562834,7 11.0001925,7 L9.87398251,7 C9.77951784,7.36702099 9.63427181,7.71365561 9.44618091,8.03196735 L10.2427768,8.82856325 C10.6332259,9.21901236 10.6358876,9.84939373 10.2426407,10.2426407 C9.8521164,10.633165 9.22177886,10.6359924 8.82856325,10.2427768 L8.03196735,9.44618091 C7.71365561,9.63427181 7.36702099,9.77951784 7,9.87398251 L7,11.0001925 C7,11.5523709 6.55613518,12 6,12 C5.44771525,12 5,11.5562834 5,11.0001925 L5,9.87398251 C4.63297901,9.77951784 4.28634439,9.63427181 3.96803265,9.44618091 L3.17143675,10.2427768 C2.78098764,10.6332259 2.15060627,10.6358876 1.75735931,10.2426407 C1.36683502,9.8521164 1.36400758,9.22177886 1.75722319,8.82856325 L2.55381909,8.03196735 C2.36572819,7.71365561 2.22048216,7.36702099 2.12601749,7 L0.999807492,7 C0.447629061,7 0,6.55613518 0,6 C0,5.44771525 0.443716645,5 0.999807492,5 L2.12601749,5 C2.22048216,4.63297901 2.36572819,4.28634439 2.55381909,3.96803265 L1.75722319,3.17143675 C1.36677408,2.78098764 1.36411236,2.15060627 1.75735931,1.75735931 C2.1478836,1.36683502 2.77822114,1.36400758 3.17143675,1.75722319 L3.96803265,2.55381909 C4.28634439,2.36572819 4.63297901,2.22048216 5,2.12601749 Z M6,8 C7.1045695,8 8,7.1045695 8,6 C8,4.8954305 7.1045695,4 6,4 C4.8954305,4 4,4.8954305 4,6 C4,7.1045695 4.8954305,8 6,8 Z"></path></g></svg></i>
								<span>그룹관리</span>
								<!-- 
								<i class="ico ico-expand" aria-hidden="true"><svg width="12px" height="7px" viewBox="0 0 12 7" version="1.1"><g id="expand" stroke="none" stroke-width="1" fill="#D8D8D8" fill-rule="evenodd"><path d="M10.59375,0 L12,1.32911392 L6,7 L0,1.32911392 L1.40625,0 L6,4.34177215 L10.59375,0 Z"></path></g></svg></i>
							 	-->
							</button>
						</span>
					</c:if>
				</div>
			</div>
			
			<div class="group-header__footer group-header__desc--open">
				<pre class="group-header__desc group-header__desc--premode">나만의 그룹에서 내 업무와 관련된 다양한 생각들을 정리하고 기록을 남겨보세요</pre>
				<button class="group-header__desc-button">설명 접기</button>
				<strong class="screen-out">그룹 탭 메뉴</strong>
				<ul class="ra-tab-menu tab-menu__group" role="tablist">
					<li class="ra-tab-menu__item ra-tab-menu__item--active" role="tab" aria-selected="true">
						<a href="#">전체</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">멤버</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">사진</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">파일</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">일정</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">노트</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">요청</a>
					</li>
				</ul>
			</div>
		</header>
		
		<div class="wall-list-page">
			<div class="message-form-group message-form-group--PLAIN">
			
			</div>
		</div>
	</section>
</article>
<script>
function goGroupSetting(groupseq){
	location.href = '/work/group/' + groupseq + '/setting';
}
</script>
</body>
</html>