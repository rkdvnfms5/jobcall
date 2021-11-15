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
		
	<form action="/work/board" id="insertBoardForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="group_seq" value="${WorkGroup.seq}">
		<div class="wall-list-page">
			<div class="message-form-group message-form-group--PLAIN">
				<div class="message-form-group__header">
					<ul class="message-form-group__tabs">
						<li class="message-form-group__tab message-form-group__tab--active">
							<button type="button">
								<i class="ico ico-wall_form_plain" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_plain"><path d="M4.84456465,13.6099463 C5.03399088,13.5213435 5.21151614,13.3986953 5.3680596,13.2421518 L13.4644334,5.145778 C14.1751621,4.43504933 14.1823793,3.26136717 13.4629255,2.54191344 C12.7384559,1.8174438 11.5776819,1.8217846 10.859061,2.54040555 L2.76268715,10.6367794 C2.60721175,10.7922548 2.48540199,10.9698842 2.39750031,11.1600664 L2.22570384,11.1737627 L2,14.004839 L4.8310763,13.7791351 L4.84456465,13.6099463 L4.84456465,13.6099463 Z M9.73653905,3.66292745 L12.3419115,6.26829991 L11.5777165,7.03249494 L8.97234401,4.42712249 L9.73653905,3.66292745 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>글쓰기</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button type="button">
								<i class="ico ico-wall_form_schedule" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_schedule"><path transform="translate(0, -1)" d="M1,17 C0.4,17 0,16.6 0,16 L0,4 C0,3.4 0.4,3 1,3 L3,3 L3,2 C3,1.4 3.4,1 4,1 C4.6,1 5,1.4 5,2 L5,3 L11,3 L11,2 C11,1.4 11.4,1 12,1 C12.6,1 13,1.4 13,2 L13,3 L15,3 C15.6,3 16,3.4 16,4 L16,16 C16,16.6 15.6,17 15,17 L1,17 Z M2,6 L14,6 L14,15 L2,15 L2,6 Z M10,8 L12,8 L12,10 L10,10 L10,8 Z M4,8 L6,8 L6,10 L4,10 L4,8 Z M4,11 L6,11 L6,13 L4,13 L4,11 Z M7,8 L9,8 L9,10 L7,10 L7,8 Z M10,11 L12,11 L12,13 L10,13 L10,11 Z M7,11 L9,11 L9,13 L7,13 L7,11 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>일정</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button type="button">
								<i class="ico ico-wall_form_task" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_task"><path d="M1.00087166,0 L14.9991283,0 C15.5518945,0 16,0.444630861 16,1.00087166 L16,14.9991283 C16,15.5518945 15.5553691,16 14.9991283,16 L1.00087166,16 C0.448105505,16 0,15.5553691 0,14.9991283 L0,1.00087166 C0,0.448105505 0.444630861,0 1.00087166,0 Z M2,2 L14,2 L14,14 L2,14 L2,2 Z M7.12238198,8.12173857 L9.94873775,5.29538279 C10.340406,4.90371453 10.9717757,4.90006449 11.3650227,5.29331144 C11.755547,5.68383574 11.7625006,6.3100471 11.3629513,6.70959635 L7.83156011,10.2409876 C7.83121477,10.2413329 7.83086924,10.2416779 7.83052353,10.2420227 C7.83017914,10.242368 7.8298341,10.2427136 7.82948876,10.2430589 C7.43896446,10.6335832 6.80862693,10.6364106 6.41541132,10.243195 L4.29381873,8.12160244 C3.90336961,7.73115333 3.9007079,7.10077196 4.29395485,6.70752501 C4.68447914,6.31700071 5.31481668,6.31417327 5.70803229,6.70738888 L7.12238198,8.12173857 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>요청</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button type="button">
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
										<textarea rows="8" cols="" name="content" id="contentTextArea"></textarea>
   									</div>
	    						</div>
	    						<ul class="board-insert-attach-list" id="board-insert-attach-list">
	    							<!-- <li>
	    								<span class="file-name">1분자기소개.txt (2.28KB)</span>
	    								<span class="file-delete"> X </span>
	    							</li> -->
	    						</ul>
	    						<div class="message-form__footer">
	    							<div class="message-form__footer-leftalign">
	    								<span class="message-form__attach-file" onclick="$('#attachFiles').click();">
	    									<button type="button" class="icon-button" aria-label="[object Object]">
	    										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
	    									</button>
	    									<span class="message-form__attach-file-label">파일첨부</span>
	    								</span>
	    							</div>
	    							<div class="message-form-submit-control">
	    								<button class="ra-button message-form-submit-control__cancel-button">취소</button>
	    								<button type="submit" id="insert-submit" onclick="" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
	    							</div>
	    						</div>
	    					</div>
	    					<input id="attachFiles" name="attachFiles" type="file" multiple="multiple" class="hide">
	    				</div>
	    			</div>
    			</div>
			</div>
		</div>
		</form>
		<div class="scroll-container scroll-container--window wall__wall-message-list" tabindex="-1">
			<div class="wall-list-wrap">
				<c:forEach items="${WorkBoardList}" var="Board">
					<div class="wall-board-item">
						<form action="/work/board/${Board.seq}" class="updateBoardForm" method="post">
						<input type="hidden" name="seq" value="${Board.seq}" />
						<div class="wall-board">
							<div class="board-header">
								<div class="board-header-profile">
									<span class="avatar" url="https://t1.daumcdn.net/agit_resources/images/empty_profile.png" style="width: 50px; height: 50px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile.png&quot;);"></span>
								</div>
								<div class="board-header-meta">
									<div class="board-header-meta-id">${Board.member_id}</div>
									<div class="board-header-meta-date">${Board.regdate}</div>
								</div>
							</div>
							
							<div class="board-body">
								<div class="board-body-content">
								${Board.content}
								</div>
								<c:if test="${not empty Board.workBoardFileList}">
									<div class="board-body-attach">
										<div class="board-body-attach-header">
											<label class="">
												<span class="ra-checkbox">
													<input type="checkbox" value=""><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
												</span>
												전체 선택
											</label>
										</div>
										<ul class="attach-list">
											<c:forEach items="${Board.workBoardFileList}" var="BoardFile">
												<li>
													<span class="ra-checkbox">
														<input type="checkbox" value="${BoardFile.src}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
													</span>
													<a class="file-name" href="${BoardFile.src}">${BoardFile.name} (${BoardFile.size})</a>
												</li>
											</c:forEach>
										</ul>
									</div>
								</c:if>
								<div class="board-body-modify hide">
									<textarea rows="8" cols="" name="content" id="" class="board-modify-textArea">${Board.content}</textarea>
									<ul class="board-modify-attach-list">
										<c:forEach items="${Board.workBoardFileList}" var="BoardFile">
											<li>
												<span class="file-name">${BoardFile.name} (${BoardFile.size})</span>
		    									<span class="file-delete" onclick="addDeleteAttacheFiles(${BoardFile.seq}, this)"> X </span>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							
							<div class="board-footer">
								<span class="msg-button"><span class="text-info">댓글</span><span class="num-count">${fn:length(Board.commentList)}</span></span>
								<span class="float-right">
									<button type="button" class="link-copy-btn" aria-label="링크 복사">
										<i class="ico ico-linkcopy" aria-hidden="true"><svg width="16px" height="7px" viewBox="0 0 16 7" version="1.1"><g id="linkcopy" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd" transform="translate(8.000000, 3.500000) scale(1, -1) translate(-8.000000, -3.500000)"><path d="M9,1 L12.5,1 C13.8704373,1 15,2.12608684 15,3.5 C15,4.87364425 13.870712,6 12.5,6 L9,6 L9,7 L12.5,7 C14.4224156,7 16,5.42651184 16,3.5 C16,1.573111 14.4220333,0 12.5,0 L9,0 L9,1 Z M7,1 L3.5,1 C2.12956271,1 1,2.12608684 1,3.5 C1,4.87364425 2.12928797,6 3.5,6 L7,6 L7,7 L3.5,7 C1.57758439,7 0,5.42651184 0,3.5 C0,1.573111 1.5779667,0 3.5,0 L7,0 L7,1 Z M5,3 L11,3 L11,4 L5,4 L5,3 Z"></path></g></svg></i>
									</button>
									<button type="button" id="" class="board-setting-btn" onclick="$(this).parent().next().toggleClass('hide');">
										<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>
									</button>
								</span>
								
								<ul class="board-setting-menu hide">
									<c:if test="${Board.member_seq eq member.seq}">
										<li><button type="button" onclick="modfifyBoardForm(this)">수정하기</button></li>
										<li><button type="button" onclick="deleteBoard(${Board.seq})">삭제하기</button></li>
									</c:if>
								</ul>
							</div>
							
							<div class="board-footer-modify message-form__footer hide">
								<div class="message-form__footer-leftalign">
    								<span class="message-form__attach-file" onclick="$(this).closest('.updateBoardForm').find('.board-modify-attach').click();" style="border: 1px solid #e3e3e3; cursor: pointer; padding: 2px 10px 3px 7px; border-radius: 3px;">
    									<button type="button" class="icon-button" aria-label="[object Object]">
    										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
    									</button>
    									<span class="message-form__attach-file-label">파일첨부</span>
    								</span>
    							</div>
    							<div class="message-form-submit-control">
    								<button type="button" class="ra-button message-form-submit-control__cancel-button" onclick="cancelModifyBoard(this)">취소</button>
    								<button type="button" id="update-submit" onclick="modifyBoard(this)" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">수정하기</button>
    							</div>
    							<input type="file" class="board-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">
							</div>
						</div>
						</form>
						<c:forEach items="${Board.commentList}" var="Comment">
							<div class="wall-comment">
								<div class="comment-header">
									<div class="comment-header-profile">
										<span class="avatar" url="https://t1.daumcdn.net/agit_resources/images/empty_profile.png" style="width: 36px; height: 36px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile.png&quot;);"></span>
									</div>
									<div class="comment-header-meta">
										<div class="comment-header-meta-id">${Comment.member_id}</div>
										<div class="comment-header-meta-date">${Comment.regdate}</div>
									</div>
								</div>
								<div class="comment-body">
									<div>
									${Comment.content}
									</div>
								</div>
								
								<div class="comment-footer">
									<button id="" class="comment-like-btn">
										<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>
									</button>
									<button id="" class="comment-dislike-btn">
										<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>
									</button>
									<span class="float-right">
										<button id="" class="comment-setting-btn">
											<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>
										</button>
									</span>
								</div>
							</div>
						</c:forEach>
						
						<div class="comment-input">
							<textarea rows="5" cols=""></textarea>
							
							<ul class="board-insert-attach-list" id="board-insert-attach-list">
	   							<li>
	   								<span class="file-name">1분자기소개.txt (2.28KB)</span>
	   								<span class="file-delete"> X </span>
	   							</li>
	   						</ul>
		    						
							<div class="comment-input-footer">
								<span class="message-form__attach-file" onclick="">
									<button type="button" class="icon-button" aria-label="[object Object]">
										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
									</button>
									<span class="message-form__attach-file-label">파일첨부</span>
								</span>
								<div class="float-right">
									<button class="comment-input-btn" disabled="disabled">작성하기</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
</article>
<script>
var board_attache_files = new Array();
var delete_board_attach_files;
var board_modify_files = new Array();

$(document).ready(function(){
	$("#contentTextArea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkBoardValue();
		if(check){
			$("#insert-submit").attr("disabled", false);
		} else {
			$("#insert-submit").attr("disabled", true);
		}
	});
	
	$("#attachFiles").on("change", function(){
		board_attache_files = Array.from($(this)[0].files);
		setBoardInsertAttacheHtml();
	});
	
	$(".board-modify-textArea").on('focusin focusout propertychange change keyup paste input', function(){
		var updateTextArea = $(this).closest(".updateBoardForm").find(".board-modify-textArea");
		if($.trim(updateTextArea.val()) != ''){
			$(this).closest(".updateBoardForm").find("#update-submit").attr("disabled", false);
		} else {
			$(this).closest(".updateBoardForm").find("#update-submit").attr("disabled", true);
		}
	});
	
	$(".board-modify-attach").on("change", function(){
		
		board_modify_files = Array.from($(this)[0].files);
		var ul = $(this).closest(".updateBoardForm").find(".board-modify-attach-list");
		
		setBoardModifyAttacheHtml(ul);
	});
})

function checkBoardValue(){
	if($.trim($("#contentTextArea").val()) == ''){
		return false;
	}
	
	return true;
}

function goGroupSetting(groupseq){
	location.href = '/work/group/' + groupseq + '/setting';
}

function insertBoard(){
	var url = $("#insertBoardForm").attr("action");
	var data = new FormData();
	var formData = $("#insertBoardForm").serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
	})
	
	/*
	var attachFileArr = new FormData($("#insertBoardForm")[0]).getAll("attachFiles");

	
	for(var i=0; i<attachFileArr.length; i++){
		data.append("attachFiles", attachFileArr[i]);
	}
	*/
	
	for(var i=0; i<board_attache_files.length; i++){
		data.append("attachFiles", board_attache_files[i]);
	}
	
	data.append("type", "plain");
	
	$.ajax({
		url : url,
		type : 'POST',
		enctype: 'multipart/form-data',
		data : data,
		processData: false,
		contentType : false,
		dataType : 'JSON',
		success : function(res){
			location.reload();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
		}
	})
	
}

function setBoardInsertAttacheHtml(){
	if(board_attache_files.length > 0){
		var html = "";
		for(var i=0; i<board_attache_files.length; i++){
			html += '<li><span class="file-name">' + board_attache_files[i].name + ' ('+ board_attache_files[i].size +')</span>';
			html += '<span class="file-delete" onclick="removeBoardInsertAttache(' + i + ')"> X </span></li>';
			
			$("#board-insert-attach-list").empty();
			$("#board-insert-attach-list").append(html);
		}
	} else if(board_attache_files.length == 0) {
		$("#board-insert-attach-list").empty();
	}
	
}

function removeBoardInsertAttache(index){
	if(board_attache_files.length > index){
		board_attache_files.splice(index, 1);
		setBoardInsertAttacheHtml();
	}
}

function deleteBoard(seq){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			url : '/work/board/' + seq,
			method : 'DELETE',
			dataType : 'JSON',
			success : function(res){
				if(res.res == 1){
					alert("삭제되었습니다.");
					location.reload();
				} else {
					alert("삭제를 실패했습니다.\n본인이 작성한 글이 맞는지 확인하세요.");
				}
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
			}
		})
	}
}

function modfifyBoardForm(obj) {
	var board_body = $(obj).closest(".wall-board").find(".board-body");
	
	board_body.find(".board-body-attach").hide();
	board_body.find(".board-body-content").hide();
	$(obj).closest(".wall-board").find(".board-footer").hide();
	$(obj).closest(".board-setting-menu").toggleClass("hide");
	
	board_body.find(".board-body-modify .board-modify-attach-list").find("li").removeClass("hide");
	board_body.find(".board-body-modify").show();
	$(obj).closest(".wall-board").find(".board-footer-modify").show();
	
	delete_board_attach_files = new Array();
}

function cancelModifyBoard(obj){
	var board_body = $(obj).closest(".wall-board").find(".board-body");
	
	board_body.find(".board-body-modify").hide();
	$(obj).closest(".wall-board").find(".board-footer-modify").hide();
	
	board_body.find(".board-body-attach").show();
	board_body.find(".board-body-content").show();
	$(obj).closest(".wall-board").find(".board-footer").show();
	
	delete_board_attach_files = null;
	$("#update-submit").attr("disabled", true);
	board_modify_files = new Array();
}

function addDeleteAttacheFiles(boardFile_seq, obj){
	delete_board_attach_files.push(boardFile_seq);
	$(obj).closest("li").addClass("hide");
}

function modifyBoard(obj){
	var updateForm = $(obj).closest(".updateBoardForm");
	
	var url = updateForm.attr("action");
	var data = new FormData();
	var formData = updateForm.serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
		
	})
	
	/*
	var attachFileArr = new FormData(updateForm[0]).getAll("attachFiles");
	
	if(attachFileArr.length > 0){
		for(var i=0; i<attachFileArr.length; i++){
			if(attachFileArr[i].name != ''){
				data.append("attachFiles", attachFileArr[i]);
			}
		}
	}
	*/
	if(board_modify_files.length > 0){
		for(var i=0; i<board_modify_files.length; i++){
			if(board_modify_files[i].name != ''){
				data.append("attachFiles", board_modify_files[i]);
			}
		}
	}
	
	if(delete_board_attach_files.length > 0 ){
		for(var i=0; i<delete_board_attach_files.length; i++){
			data.append("boardFileSeqList", delete_board_attach_files[i]);
		}
	} else {
		data.append("boardFileSeqList", new Array());
	}
	
	$.ajax({
		url : url,
		type : 'PUT',
		enctype: 'multipart/form-data',
		data : data,
		processData: false,
		contentType : false,
		dataType : 'JSON',
		success : function(res){
			location.reload();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
		}
	})
}

function setBoardModifyAttacheHtml(ul){
	ul.find('li.added').remove();
	var array = board_modify_files;
	console.log(array);
	if(array.length > 0){
		var html = "";
		for(var i=0; i<array.length; i++){
			html += '<li class="added block"><span class="file-name">' + array[i].name + ' ('+ array[i].size +')</span>';
			html += '<span class="file-delete" onclick="removeBoardModifyAttache(' + i + ', this)"> X </span></li>';
			
		}
		ul.append(html);
	}
	
}

function removeBoardModifyAttache(index, obj){
	var ul = $(obj).closest(".updateBoardForm").find(".board-modify-attach-list");
	if(board_modify_files.length > index){
		board_modify_files.splice(index, 1);
		setBoardModifyAttacheHtml(ul);
	}
}
</script>
</body>
</html>