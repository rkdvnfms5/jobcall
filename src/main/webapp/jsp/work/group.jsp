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
							<span class="middle-dot"> · </span>
						</c:if>
						<span class="group-header__master-nickname">${WorkGroup.register} (마스터명)</span>
						<span class="middle-dot"> · </span>
						<span class="group-header__members-count">${WorkGroup.member_count}명</span>
					</div>
				</div>
				<div class="group-header__controls">
					<c:if test="${WorkGroup.member_seq eq member.seq}">
						<span class="ra-popover__trigger group-header__config-menu-button-wraper" title="">
							<button class="ra-config__button group-header__config-menu-button" onclick="goGroupSetting(${WorkGroup.seq})">
								<i class="ico ico-setting" aria-hidden="true"><svg width="12px" height="12px" viewBox="0 0 12 12" version="1.1"><g id="setting" stroke="none" stroke-width="1" fill="#5A86DD" fill-rule="evenodd"><path d="M5,2.12601749 L5,0.999807492 C5,0.447629061 5.44386482,0 6,0 C6.55228475,0 7,0.443716645 7,0.999807492 L7,2.12601749 C7.36702099,2.22048216 7.71365561,2.36572819 8.03196735,2.55381909 L8.82856325,1.75722319 C9.21901236,1.36677408 9.84939373,1.36411236 10.2426407,1.75735931 C10.633165,2.1478836 10.6359924,2.77822114 10.2427768,3.17143675 L9.44618091,3.96803265 C9.63427181,4.28634439 9.77951784,4.63297901 9.87398251,5 L11.0001925,5 C11.5523709,5 12,5.44386482 12,6 C12,6.55228475 11.5562834,7 11.0001925,7 L9.87398251,7 C9.77951784,7.36702099 9.63427181,7.71365561 9.44618091,8.03196735 L10.2427768,8.82856325 C10.6332259,9.21901236 10.6358876,9.84939373 10.2426407,10.2426407 C9.8521164,10.633165 9.22177886,10.6359924 8.82856325,10.2427768 L8.03196735,9.44618091 C7.71365561,9.63427181 7.36702099,9.77951784 7,9.87398251 L7,11.0001925 C7,11.5523709 6.55613518,12 6,12 C5.44771525,12 5,11.5562834 5,11.0001925 L5,9.87398251 C4.63297901,9.77951784 4.28634439,9.63427181 3.96803265,9.44618091 L3.17143675,10.2427768 C2.78098764,10.6332259 2.15060627,10.6358876 1.75735931,10.2426407 C1.36683502,9.8521164 1.36400758,9.22177886 1.75722319,8.82856325 L2.55381909,8.03196735 C2.36572819,7.71365561 2.22048216,7.36702099 2.12601749,7 L0.999807492,7 C0.447629061,7 0,6.55613518 0,6 C0,5.44771525 0.443716645,5 0.999807492,5 L2.12601749,5 C2.22048216,4.63297901 2.36572819,4.28634439 2.55381909,3.96803265 L1.75722319,3.17143675 C1.36677408,2.78098764 1.36411236,2.15060627 1.75735931,1.75735931 C2.1478836,1.36683502 2.77822114,1.36400758 3.17143675,1.75722319 L3.96803265,2.55381909 C4.28634439,2.36572819 4.63297901,2.22048216 5,2.12601749 Z M6,8 C7.1045695,8 8,7.1045695 8,6 C8,4.8954305 7.1045695,4 6,4 C4.8954305,4 4,4.8954305 4,6 C4,7.1045695 4.8954305,8 6,8 Z"></path></g></svg></i>
								<span>그룹관리</span>
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
				<div class="message-form-group__header">
					<ul class="message-form-group__tabs">
						<li class="message-form-group__tab message-form-group__tab--active">
							<button>
								<i class="ico ico-wall_form_plain" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_plain"><path d="M4.84456465,13.6099463 C5.03399088,13.5213435 5.21151614,13.3986953 5.3680596,13.2421518 L13.4644334,5.145778 C14.1751621,4.43504933 14.1823793,3.26136717 13.4629255,2.54191344 C12.7384559,1.8174438 11.5776819,1.8217846 10.859061,2.54040555 L2.76268715,10.6367794 C2.60721175,10.7922548 2.48540199,10.9698842 2.39750031,11.1600664 L2.22570384,11.1737627 L2,14.004839 L4.8310763,13.7791351 L4.84456465,13.6099463 L4.84456465,13.6099463 Z M9.73653905,3.66292745 L12.3419115,6.26829991 L11.5777165,7.03249494 L8.97234401,4.42712249 L9.73653905,3.66292745 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>글쓰기</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_schedule" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_schedule"><path transform="translate(0, -1)" d="M1,17 C0.4,17 0,16.6 0,16 L0,4 C0,3.4 0.4,3 1,3 L3,3 L3,2 C3,1.4 3.4,1 4,1 C4.6,1 5,1.4 5,2 L5,3 L11,3 L11,2 C11,1.4 11.4,1 12,1 C12.6,1 13,1.4 13,2 L13,3 L15,3 C15.6,3 16,3.4 16,4 L16,16 C16,16.6 15.6,17 15,17 L1,17 Z M2,6 L14,6 L14,15 L2,15 L2,6 Z M10,8 L12,8 L12,10 L10,10 L10,8 Z M4,8 L6,8 L6,10 L4,10 L4,8 Z M4,11 L6,11 L6,13 L4,13 L4,11 Z M7,8 L9,8 L9,10 L7,10 L7,8 Z M10,11 L12,11 L12,13 L10,13 L10,11 Z M7,11 L9,11 L9,13 L7,13 L7,11 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>일정</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_task" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_task"><path d="M1.00087166,0 L14.9991283,0 C15.5518945,0 16,0.444630861 16,1.00087166 L16,14.9991283 C16,15.5518945 15.5553691,16 14.9991283,16 L1.00087166,16 C0.448105505,16 0,15.5553691 0,14.9991283 L0,1.00087166 C0,0.448105505 0.444630861,0 1.00087166,0 Z M2,2 L14,2 L14,14 L2,14 L2,2 Z M7.12238198,8.12173857 L9.94873775,5.29538279 C10.340406,4.90371453 10.9717757,4.90006449 11.3650227,5.29331144 C11.755547,5.68383574 11.7625006,6.3100471 11.3629513,6.70959635 L7.83156011,10.2409876 C7.83121477,10.2413329 7.83086924,10.2416779 7.83052353,10.2420227 C7.83017914,10.242368 7.8298341,10.2427136 7.82948876,10.2430589 C7.43896446,10.6335832 6.80862693,10.6364106 6.41541132,10.243195 L4.29381873,8.12160244 C3.90336961,7.73115333 3.9007079,7.10077196 4.29395485,6.70752501 C4.68447914,6.31700071 5.31481668,6.31417327 5.70803229,6.70738888 L7.12238198,8.12173857 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>요청</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_poll" aria-hidden="true"><svg width="16" height="16" viewBox="0 0 16 16"><path fill="#828282" fill-rule="evenodd" d="M0 8h4.058v8H0V8zm6-6h4.058v14H6V2zm6 9h4.058v5H12v-5z"></path></svg>
								</i>
								<span>투표</span>
							</button>
						</li>
					</ul>
				</div>
				<div class="message-form-group__body">
					<div class="plain-message-form">
						<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">
							<div class="message-form__body">
								<div class="message-form__text-wrap">
									<div class="react-measure-wrap">
										<div class="prosemirror-root-dom ProseMirror" contenteditable="true" style="min-height: 99px;" spellcheck="false">
											<p><br></p>
										</div>
										<div class="ProseMirror__placeholder" style="display: block;">Ctrl+Enter 를 누르면 글이 등록됩니다</div>
   									</div>
	    						</div>
	    						<div class="message-form__footer">
	    							<div class="message-form__footer-leftalign">
	    								<span class="message-form__attach-file">
	    									<button type="button" class="icon-button" aria-label="[object Object]">
	    										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
	    									</button>
	    									<span class="message-form__attach-file-label">파일첨부</span>
	    								</span>
	    							</div>
	    							<div class="message-form-submit-control">
	    								<button class="ra-button message-form-submit-control__cancel-button">취소</button>
	    								<button disabled="" class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
	    							</div>
	    						</div>
	    					</div>
	    					<input type="file" multiple="" autocomplete="off" style="display: none;">
	    				</div>
	    			</div>
    			</div>
			</div>
			
			<div class="scroll-container scroll-container--window wall__wall-message-list" tabindex="-1">
				<div class="wall-list-wrap">
					<!-- <div class="wall-list-page__item" tabindex="-1">
						<div class="wall__wall-thread" data-thread-id="326136954">
							<div class="wall__wall-thread-parent">
								<section class="wall__wall-message">
									<div class="wall-message__header">
										<div class="wall-message__header-profile">
											<span class="ra-popover__trigger" title="">
												<span class="avatar" url="https://t1.daumcdn.net/agit_resources/images/empty_profile.png" style="width: 50px; height: 50px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile.png&quot;);">
												</span>
												<span class="screen-out">rkdvnfms5 미니프로필 보기</span>
											</span>
										</div>
										<div class="wall-message__header-meta">
											<div class="user-display-name wall-message__author-name">
												<span class="user-display-name__id">rkdvnfms5</span>
											</div>
											<div class="wall-message__meta">
												<a id="326136954" href="/g/300321196/wall/326136954">
													<span class="agit__from-now">2021년 11월 10일(수) 14:36</span>
												</a>
											</div>
										</div>
									</div>
									<div class="wall-message__body wall-message__body--feed">
										<div class="agit__message agit__message--summarized">
											<div class="marked react-afm">
												<div class="marked__paragraph">그릉ㄹ쓴다</div>
											</div>
										</div>
									</div>
									<div class="wall-message__footer">
										<span class="msg-button">
											<span class="text-info">댓글</span>
											<span class="num-count">0</span>
										</span>
										<span class="feedback-button feedback-button--like">
											<button type="button" class="icon-button feedback-button__thumb" aria-label="좋아요">
												<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>
											</button>
										</span>
										<span class="feedback-button feedback-button--dislike">
											<button type="button" class="icon-button feedback-button__thumb" aria-label="싫어요">
												<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>
											</button>
										</span>
										<div class="wall-message__footer-control">
											<button id="messageContextMenu326136954" class="agit__context-button" aria-label="글 관리 메뉴" aria-expanded="false">
												<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>
											</button>
											<ul tabindex="-1" class="focusable-component ra-menu hide" role="region" aria-label="게시글관리 메뉴" style="top: 29px; left: 521px;">
												<li class="ra-menu-item">
													<button type="button">이 글의 참여자와 대화하기</button>
												</li>
												<li class="ra-menu-item">
													<button type="button">공지사항 등록</button>
												</li>
												<li class="ra-menu-item">
													<button type="button">댓글창 닫기</button>
												</li>
												<li class="ra-menu-item">
													<button type="button">수정하기</button>
												</li>
												<li class="ra-menu-item">
													<button type="button">삭제하기</button>
												</li>
											</ul>
										</div>
									</div>
								</section>
							</div>
							<div class="wall__wall-thread-rest-container wall__wall-thread-rest-container--no-child">
								<div class="wall__wall-thread-children"></div>
								<div class="comment-form comment-form--collapsed">
									<div class="profile-icon-wrapper">
										<span class="avatar profile-icon-wrapper__profile" url="https://t1.daumcdn.net/agit_resources/images/empty_profile.png" style="width: 36px; height: 36px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile.png&quot;);"></span>
										<div class="profile-icon-wrapper__body comment-form__body">
											<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">
												<div class="message-form__body">
													<div class="message-form__text-wrap">
														<div class="react-measure-wrap">
															<div class="prosemirror-root-dom ProseMirror" contenteditable="true" style="min-height: 20px;" spellcheck="false">
																<p><br></p>
															</div>
															<div class="ProseMirror__placeholder" style="display: block;">댓글을 입력하세요</div>
																<div class="ProseMirror-floating-menu">
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--h1">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M.897 3.718h2.041V7.28h3.757V3.718h2.041V13H6.695V8.996H2.938V13H.897V3.718zM13.945 13h-1.562V8.006h-1.936V6.829c.271.007.533-.013.787-.06.253-.048.48-.132.681-.253.202-.122.373-.281.512-.479a1.7 1.7 0 0 0 .275-.737h1.243V13z"></path>
																		    </g>
																		</svg>
																	</button>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--h2">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M.897 3.718h2.041V7.28h3.757V3.718h2.041V13H6.695V8.996H2.938V13H.897V3.718zm9.106 4.972c-.013-.4.033-.772.14-1.115.107-.343.267-.643.48-.9.213-.257.482-.457.805-.6a2.727 2.727 0 0 1 1.115-.215c.32 0 .625.05.915.15.29.1.545.243.765.43.22.187.395.417.525.69.13.273.195.58.195.92 0 .353-.057.657-.17.91a2.39 2.39 0 0 1-.45.675 3.825 3.825 0 0 1-.635.535c-.237.16-.475.318-.715.475-.24.157-.473.325-.7.505-.227.18-.427.39-.6.63h3.31V13h-5.14c0-.407.058-.76.175-1.06.117-.3.275-.568.475-.805.2-.237.435-.455.705-.655.27-.2.555-.403.855-.61.153-.107.317-.215.49-.325.173-.11.332-.232.475-.365.143-.133.263-.283.36-.45.097-.167.145-.357.145-.57 0-.34-.098-.605-.295-.795-.197-.19-.448-.285-.755-.285a.917.917 0 0 0-.525.145 1.082 1.082 0 0 0-.345.38c-.087.157-.148.33-.185.52-.037.19-.055.378-.055.565h-1.36z"></path>
																		    </g>
																		</svg>
																	</button>
																	<span class="ProseMirror-floating-menu__divider"></span>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--bold" title="Ctrl + B">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M9.008 10.736a.958.958 0 0 0 .704-.288.958.958 0 0 0 .288-.704.984.984 0 0 0-.288-.712.945.945 0 0 0-.704-.296H6.656v2h2.352zm-2.352-6v2h2a.984.984 0 0 0 .712-.288.945.945 0 0 0 .296-.704.97.97 0 0 0-.296-.712.97.97 0 0 0-.712-.296h-2zM10.4 7.584a2.482 2.482 0 0 1 1.44 2.288c0 .47-.107.896-.32 1.28A2.421 2.421 0 0 1 9.376 12.4h-4.72V3.056h4.192a2.634 2.634 0 0 1 2.304 1.336c.235.41.352.861.352 1.352 0 .341-.101.68-.304 1.016-.203.336-.47.61-.8.824z"></path>
																		    </g>
																		</svg>
																	</button>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--italic" title="Ctrl + I">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M6.656 3.056H12v2h-1.872L7.872 10.4h1.472v2H4v-2h1.872l2.256-5.344H6.656z"></path>
																		    </g>
																		</svg>
																	</button>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--strike" title="Ctrl + Shift + X">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M2 9.744V8.4h12v1.344H2zm1.344-6.688h9.312v2H9.344v2H6.656v-2H3.344v-2zm3.312 10v-2h2.688v2H6.656z"></path>
																		    </g>
																		</svg>
																	</button>
																	<span class="ProseMirror-floating-menu__divider"></span>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--blockquote">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path stroke="#FFF" d="M1.5 2.5v12h13v-12h-13z"></path>
																		        <path fill="#FFF" d="M4 5h4v1H4V5zm0 3h8v1H4V8zm0 3h8v1H4v-1z"></path>
																		    </g>
																		</svg>
																	</button>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--code">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M4.944 11.056L4 12 0 8l4-4 .944.944L1.84 8l3.104 3.056zm6.056 0L14.104 8 11 4.944 11.944 4l4 4-4 4-.944-.944zM8.277 1.989l.99.139-1.67 11.883-.99-.139 1.67-11.883z"></path>
																		    </g>
																		</svg>
																	</button>
																	<span class="ProseMirror-floating-menu__divider"></span>
																	<button class="ProseMirror-floating-menu__button ProseMirror-floating-menu__button--link" title="Ctrl + K">
																		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
																		    <g fill="none" fill-rule="evenodd">
																		        <path fill="#FFF" d="M11.344 5.056c.597 0 1.152.15 1.664.448A3.32 3.32 0 0 1 14.656 8.4a3.32 3.32 0 0 1-1.648 2.896 3.245 3.245 0 0 1-1.664.448H8.656v-1.28h2.688a2 2 0 0 0 1.024-.28c.32-.187.573-.44.76-.76a2 2 0 0 0 .28-1.024 2 2 0 0 0-.28-1.024 2.077 2.077 0 0 0-.76-.76 2 2 0 0 0-1.024-.28H8.656v-1.28h2.688zm-6 4V7.744h5.312v1.312H5.344zM2.592 8.4a2 2 0 0 0 .28 1.024c.187.32.44.573.76.76a2 2 0 0 0 1.024.28h2.688v1.28H4.656c-.597 0-1.152-.15-1.664-.448A3.32 3.32 0 0 1 1.344 8.4a3.32 3.32 0 0 1 1.648-2.896 3.245 3.245 0 0 1 1.664-.448h2.688v1.28H4.656a2 2 0 0 0-1.024.28c-.32.187-.573.44-.76.76a2 2 0 0 0-.28 1.024z"></path>
																		    </g>
																		</svg>
																	</button>
																</div>
																<form class="ProseMirror-floating-menu__link-dialog">
																    <label for="pmLinkDialog">링크</label>
																    <input id="pmLinkDialog" type="text" value="">
																    <button type="submit">확인</button>
															    </form>
															</div>
															<div class="message-form__resize-handle">
																<span class="message-form__resize-handle-button"></span>
															</div>
															<div class="mention-autocomplete mention-autocomplete--empty mention-autocomplete--static-matched" style="left: 0px; top: 0px; display: none;">
																<ul class="mention-autocomplete__list"></ul>
																<ul class="mention-autocomplete__static-list">
																	<li>
																		<dl><dt>@all</dt><dd>아지트 멤버 모두에게 알림</dd></dl>
																	</li>
																	<li>
																		<dl><dt>@group</dt><dd>해당 그룹 멤버 모두에게 알림</dd></dl>
																	</li>
																</ul>
															</div>
															<div class="message-form__file-drop-label">이곳에 파일을 끌어 넣으세요.</div>
														</div>
														<div class="attachments-box attachments-box--form">
															<input type="file" multiple="" class="attachments-box__file-input">
														</div>
														<div class="message-form__footer">
															<div class="message-form__footer-leftalign">
																<span class="message-form__attach-file">
																	<button type="button" class="icon-button" aria-label="[object Object]">
																		<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
																	</button>
																	<span class="message-form__attach-file-label">파일첨부</span>
																</span>
															</div>
															<div class="message-form-submit-control">
																<button class="ra-button message-form-submit-control__cancel-button">취소</button>
																<button disabled="" class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
															</div>
														</div>
													</div>
													<input type="file" multiple="" autocomplete="off" style="display: none;">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div> -->
				</div>
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