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
	
	<c:if test="${BoardOnly ne 'Y'}">
		<form action="/work/board" id="insertBoardForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="group_seq" id="group_seq" value="${WorkGroup.seq}">
		<input type="hidden" name="type" id="type" value="plain">
		<div class="wall-list-page">
			<div class="message-form-group message-form-group--PLAIN">
				<div class="message-form-group__header">
					<ul class="message-form-group__tabs">
						<li class="message-form-group__tab plain message-form-group__tab--active">
							<button type="button" onclick="setInsertBoardForm('plain')">
								<i class="ico ico-wall_form_plain" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_plain"><path d="M4.84456465,13.6099463 C5.03399088,13.5213435 5.21151614,13.3986953 5.3680596,13.2421518 L13.4644334,5.145778 C14.1751621,4.43504933 14.1823793,3.26136717 13.4629255,2.54191344 C12.7384559,1.8174438 11.5776819,1.8217846 10.859061,2.54040555 L2.76268715,10.6367794 C2.60721175,10.7922548 2.48540199,10.9698842 2.39750031,11.1600664 L2.22570384,11.1737627 L2,14.004839 L4.8310763,13.7791351 L4.84456465,13.6099463 L4.84456465,13.6099463 Z M9.73653905,3.66292745 L12.3419115,6.26829991 L11.5777165,7.03249494 L8.97234401,4.42712249 L9.73653905,3.66292745 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>글쓰기</span>
							</button>
						</li>
						<li class="message-form-group__tab schedule">
							<button type="button" onclick="setInsertBoardForm('schedule')">
								<i class="ico ico-wall_form_schedule" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_schedule"><path transform="translate(0, -1)" d="M1,17 C0.4,17 0,16.6 0,16 L0,4 C0,3.4 0.4,3 1,3 L3,3 L3,2 C3,1.4 3.4,1 4,1 C4.6,1 5,1.4 5,2 L5,3 L11,3 L11,2 C11,1.4 11.4,1 12,1 C12.6,1 13,1.4 13,2 L13,3 L15,3 C15.6,3 16,3.4 16,4 L16,16 C16,16.6 15.6,17 15,17 L1,17 Z M2,6 L14,6 L14,15 L2,15 L2,6 Z M10,8 L12,8 L12,10 L10,10 L10,8 Z M4,8 L6,8 L6,10 L4,10 L4,8 Z M4,11 L6,11 L6,13 L4,13 L4,11 Z M7,8 L9,8 L9,10 L7,10 L7,8 Z M10,11 L12,11 L12,13 L10,13 L10,11 Z M7,11 L9,11 L9,13 L7,13 L7,11 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>일정</span>
							</button>
						</li>
						<li class="message-form-group__tab request">
							<button type="button" onclick="setInsertBoardForm('request')">
								<i class="ico ico-wall_form_task" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_task"><path d="M1.00087166,0 L14.9991283,0 C15.5518945,0 16,0.444630861 16,1.00087166 L16,14.9991283 C16,15.5518945 15.5553691,16 14.9991283,16 L1.00087166,16 C0.448105505,16 0,15.5553691 0,14.9991283 L0,1.00087166 C0,0.448105505 0.444630861,0 1.00087166,0 Z M2,2 L14,2 L14,14 L2,14 L2,2 Z M7.12238198,8.12173857 L9.94873775,5.29538279 C10.340406,4.90371453 10.9717757,4.90006449 11.3650227,5.29331144 C11.755547,5.68383574 11.7625006,6.3100471 11.3629513,6.70959635 L7.83156011,10.2409876 C7.83121477,10.2413329 7.83086924,10.2416779 7.83052353,10.2420227 C7.83017914,10.242368 7.8298341,10.2427136 7.82948876,10.2430589 C7.43896446,10.6335832 6.80862693,10.6364106 6.41541132,10.243195 L4.29381873,8.12160244 C3.90336961,7.73115333 3.9007079,7.10077196 4.29395485,6.70752501 C4.68447914,6.31700071 5.31481668,6.31417327 5.70803229,6.70738888 L7.12238198,8.12173857 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>요청</span>
							</button>
						</li>
						<li class="message-form-group__tab vote">
							<button type="button" onclick="setInsertBoardForm('vote')">
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
							<!-- <div class="message-form__header">
								<div class="board-input-title">
									<input type="text" maxlength="30" name="title" id="board-insert-title" placeholder="투표 제목 입력">
								</div>
								<div class="vote-list">
									<div class="board-input-vote">
										<span class="poll-message-form__form-poll-item-seq"><i class="ico ico-check_circle" aria-hidden="true"><svg width="18" height="18" viewBox="0 0 18 18"><path fill="#E0E0E0" fill-rule="evenodd" d="M7.183 13.522l8.113-8.113-1.277-1.32-6.836 6.858L3.98 7.724 2.704 9l4.479 4.522zM9 0c1.644 0 3.166.411 4.565 1.233a8.53 8.53 0 0 1 3.202 3.202A8.851 8.851 0 0 1 18 9a8.851 8.851 0 0 1-1.233 4.565 8.53 8.53 0 0 1-3.202 3.202A8.851 8.851 0 0 1 9 18a8.851 8.851 0 0 1-4.565-1.233 8.691 8.691 0 0 1-3.202-3.224A8.812 8.812 0 0 1 0 9c0-1.63.411-3.144 1.233-4.543a8.858 8.858 0 0 1 3.224-3.224A8.812 8.812 0 0 1 9 0z"></path></svg></i></span>
										<input type="text" class="board-insert-vote" name="vote" placeholder="선택 사항 입력">
									</div>
									<div class="board-input-vote">
										<span class="poll-message-form__form-poll-item-seq"><i class="ico ico-check_circle" aria-hidden="true"><svg width="18" height="18" viewBox="0 0 18 18"><path fill="#E0E0E0" fill-rule="evenodd" d="M7.183 13.522l8.113-8.113-1.277-1.32-6.836 6.858L3.98 7.724 2.704 9l4.479 4.522zM9 0c1.644 0 3.166.411 4.565 1.233a8.53 8.53 0 0 1 3.202 3.202A8.851 8.851 0 0 1 18 9a8.851 8.851 0 0 1-1.233 4.565 8.53 8.53 0 0 1-3.202 3.202A8.851 8.851 0 0 1 9 18a8.851 8.851 0 0 1-4.565-1.233 8.691 8.691 0 0 1-3.202-3.224A8.812 8.812 0 0 1 0 9c0-1.63.411-3.144 1.233-4.543a8.858 8.858 0 0 1 3.224-3.224A8.812 8.812 0 0 1 9 0z"></path></svg></i></span>
										<input type="text" class="board-insert-vote" name="vote" placeholder="선택 사항 입력">
									</div>
								</div>
								
								<a class="board-add-vote-btn" onclick="addInputVote(this)">+ 선택 항목 추가</a>
							</div> -->
							<div class="message-form__body">
								<div class="message-form__text-wrap">
									<div class="react-measure-wrap">
										<textarea rows="8" cols="" name="content" id="contentTextArea"></textarea>
   									</div>
	    						</div>
	    						<ul class="board-insert-attach-list" id="board-insert-attach-list">
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
	    								<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
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
	</c:if>
		<div class="scroll-container scroll-container--window wall__wall-message-list" tabindex="-1">
			<div class="wall-list-wrap">
				<c:forEach items="${WorkBoardList}" var="Board" varStatus="board_status">
					<div class="wall-board-item ${board_status.last? 'observed':''}">
						<form action="/work/board/${Board.seq}" class="updateBoardForm" method="post">
						<input type="hidden" name="seq" value="${Board.seq}" />
						<div class="wall-board">
							<div class="board-header">
								<div class="board-header-profile" onclick="showMemberProfile(${Board.member_seq}, this)">
									<span class="avatar"
									style="width: 50px; height: 50px; 
									background-image: url('${empty Board.member_profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':Board.member_profile}');">
									</span>
								</div>
								<div class="board-header-meta">
									<div class="board-header-meta-id">${Board.member_id} (${Board.member_name})</div>
									<div class="board-header-meta-date">${Board.regdate}</div>
								</div>
							</div>
							
							<div class="board-body">
								<div class="board-body-meta">
									<c:choose>
										<c:when test="${Board.type eq 'request'}">
											<div class="worker-info">
												<span>담당자 : </span>
												<c:if test="${not empty Board.worker}">
													<c:set var="workerArr" value="${fn:split(Board.worker, ',')}" />
													<c:forEach items="${workerArr}" var="worker">
														<span class="worker-id">${worker}</span>
													</c:forEach>
												</c:if>
											</div>
											<div class="status-info">
												<span class="request ${Board.status eq 'request'? 'on':''}" <c:if test="${Board.status ne 'request'}">onclick="updateBoardStatus(${Board.seq}, 'request', this)"</c:if> >요청</span>
												<span class="process ${Board.status eq 'process'? 'on':''}" <c:if test="${Board.status ne 'process'}">onclick="updateBoardStatus(${Board.seq}, 'process', this)"</c:if> >진행</span>
												<span class="complete ${Board.status eq 'complete'? 'on':''}" <c:if test="${Board.status ne 'complete'}">onclick="updateBoardStatus(${Board.seq}, 'complete', this)"</c:if> >완료</span>
											</div>
										</c:when>
										<c:when test="${Board.type eq 'schedule'}">
											<div class="schedule-info">
												<div class="schedule-calendar">
													<div class="month">${(fn:split(Board.startdate,'-'))[1]}</div>
													<div class="day">${(fn:split(Board.startdate,'-'))[2]}</div>
												</div>
												<div class="schedule-text">
													<div class="schedule-title">${Board.title}</div>
													<div class="schedule-date">${Board.startdate} ${Board.starttime} - ${Board.enddate} ${Board.endtime}</div>
												</div>
											</div>
										</c:when>
										<c:when test="${Board.type eq 'vote'}">
											<div class="vote-info">
												<div class="vote-info-header">
													<div class="vote-info-header-q">Q</div>
													<div class="vote-info-header-title">
														${Board.title}
													</div>
													<div class="vote-info-header-desc">
														${Board.status eq 'process'? '진행 중인':'마감된'} 투표
													</div>
													<c:if test="${Board.status eq 'process' and Board.member_seq eq member.seq}">
														<button type="button" onclick="deadLineVote(${Board.seq}, this)" class="vote-deadline-btn">투표 마감하기</button>
													</c:if>
												</div>
												<div class="vote-info-body">
													<c:forEach items="${Board.boardVoteList}" var="vote">
														<div class="vote-info-body-content">
															<div class="vote-info-body-item ${vote.voteyn eq 'Y'? 'on':''}">
																<div class="poll-attachment__item-no-seq" <c:if test="${Board.status eq 'process'}">onclick="voteCheck(${vote.seq}, ${Board.seq}, this)"</c:if> ><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i></div>
																<span class="vote-info-body-item-name" <c:if test="${Board.status eq 'process'}">onclick="voteCheck(${vote.seq}, ${Board.seq}, this)"</c:if>>${vote.name}</span>
																<span class="vote-info-body-item-count" onclick="$(this).parent().siblings('.vote-member-list').toggleClass('hide')">${fn:length(vote.boardVoteMemberList)}</span>
															</div>
															<div class="vote-member-list hide">
																<div class="vote-member-list-header">
																	이 항목에 투표한 사람
																	<button type="button" class="vote-member-list-close" onclick="$(this).closest('.vote-member-list').addClass('hide')">X</button>
																</div>
																<div class="vote-member-list-body">
																	<ul>
																		<c:forEach items="${vote.boardVoteMemberList}" var="voteMember">
																			<li>${voteMember.member_id} (${voteMember.member_name})</li>
																		</c:forEach>
																	</ul>
																</div>
															</div>
														</div>
													</c:forEach>
												</div>
											</div>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</div>
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
									<c:choose>
										<c:when test="${Board.type eq 'request'}">
											<input type="hidden" name="worker" value="${Board.worker}">
											<div class="request-message-form">
												<div class="board-input-title">
													<c:set var="workerArr" value="${fn:split(Board.worker, ',')}" />
													<c:forEach items="${workerArr}" var="worker">
														<div class="worker-label">
															<span class="worker-label-id">${worker}</span>
															<span class="worker-label-cancel" onclick="removeRequestBoardWorker(this, '${worker}')">X</span>
														</div>
													</c:forEach>
													<input type="text" maxlength="30" name="input-worker" class="board-modify-worker" oninput="checkWorker(this)" placeholder="담당자 ID 입력">
												</div>
												<div class="mention-list hide">
													<ul></ul>
												</div>
											</div>
										</c:when>
										<c:when test="${Board.type eq 'schedule'}">
											<div class="board-input-date">
												<div class="input-datetime-container">
													<input type="text" class="input-startdate" name="startdate" value="${Board.startdate}">
												</div>
												<div class="input-datetime-container time ${empty Board.starttime? 'hide':''}">
													<input type="text" class="input-starttime" name="starttime" value="${Board.starttime}" placeholder="시작 시간">
												</div>
												 - 
												<div class="input-datetime-container">
													<input type="text" class="input-enddate" name="enddate" value="${Board.enddate}" >
												</div>
												<div class="input-datetime-container time ${empty Board.endtime? 'hide':''}">
													<input type="text" class="input-endtime" name="endtime" value="${Board.endtime}" placeholder="종료 시간">
												</div>
												<div class="input-date-type">
													<div>
														<label class="schedule-form__label">
															<span class="ra-checkbox">
																<input type="checkbox" name="allYN" onchange="checkDateType(this)" ${empty Board.starttime and empty Board.endtime? 'checked':''}>
																<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
															</span>
															종일
														</label>
													</div>
												</div>
											</div>
											<div class="board-input-title">
												<input type="text" maxlength="30" name="title" id="board-insert-title" value="${Board.title}" placeholder="일정 제목 입력">
											</div>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
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
								
								<!-- like btn -->
								<span class="feedback-button feedback-button--like ${Board.action eq 'like'? 'on':''}">
									<button type="button" class="icon-button feedback-button__thumb" aria-label="좋아요" onclick="actionCheck(this, 'like', 'board', ${Board.seq}, ${Board.actionLog_seq})">
										<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>
									</button>
									<span class="ra-popover__trigger" title="" onclick="$(this).siblings('.like-list').removeClass('hide')">
										<span class="feedback-button__count" role="button" title="이 글을 좋아한 사람">${fn:length(Board.likeList)}</span>
									</span>
									<div class="like-list hide">
										<div class="like-list-header">
											이 글을 좋아한 사람
											<button type="button" class="like-list-close" onclick="$(this).closest('.like-list').addClass('hide')">X</button>
										</div>
										<div class="like-list-body">
											<ul>
												<c:forEach items="${Board.likeList}" var="like">
													<li>${like.member_id} (${like.member_name})</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</span>
								
								<!-- dislike btn -->
								<span class="feedback-button feedback-button--dislike ${Board.action eq 'dislike'? 'on':''}">
									<button type="button" class="icon-button feedback-button__thumb" aria-label="싫어요" onclick="actionCheck(this, 'dislike', 'board', ${Board.seq}, ${Board.actionLog_seq})">
										<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>
									</button>
									<span class="ra-popover__trigger" title="" onclick="$(this).siblings('.like-list').removeClass('hide')">
										<span class="feedback-button__count" role="button" title="이 글을 싫어한 사람">${fn:length(Board.dislikeList)}</span>
									</span>
									<div class="like-list hide">
										<div class="like-list-header">
											이 글을 싫어한 사람
											<button type="button" class="like-list-close" onclick="$(this).closest('.like-list').addClass('hide')">X</button>
										</div>
										<div class="like-list-body">
											<ul>
												<c:forEach items="${Board.dislikeList}" var="dislike">
													<li>${dislike.member_id} (${dislike.member_name})</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</span>
								
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
										<li><button type="button" onclick="modifyBoardForm(this)">수정하기</button></li>
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
						<c:if test="${not empty Board.commentList and Board.first_comment_seq lt Board.commentList[0].seq}">
							<div class="prev-comment">
								<button type="button" onclick="scrollPaging('comment', $(this).closest('.wall-board-item').find('.wall-comment-list'))">이전 댓글 더보기</button>
								<form action="" class="comment_paging_form">
									<input type="hidden" name="limit" value="${Board.comment_limit}" />
									<input type="hidden" name="offset" value="${Board.comment_offset}" />
									<input type="hidden" name="board_seq" value="${Board.seq}" />
									<input type="hidden" name="first_comment_seq" value="${Board.first_comment_seq}" />
								</form>
							</div>
						</c:if>
						<div class="wall-comment-list">
							<c:forEach items="${Board.commentList}" var="Comment" varStatus="comment_status">
							<div class="wall-comment">
								<form action="/work/comment/${Comment.seq}" class="updateCommentForm" method="post">
									<div class="comment-header">
										<div class="comment-header-profile" onclick="showMemberProfile(${Comment.member_seq}, this)">
											<span class="avatar" 
											style="width: 36px; height: 36px; background-image: url('${empty Comment.member_profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':Comment.member_profile}');"></span>
										</div>
										<div class="comment-header-meta">
											<div class="comment-header-meta-id">${Comment.member_id} (${Comment.member_name})</div>
											<div class="comment-header-meta-date">${Comment.regdate}</div>
										</div>
									</div>
									<div class="comment-body">
										<div class="comment-body-content">
										${Comment.content}
										</div>
										<c:if test="${Comment.noticeyn eq 'N'}">
											<br>
											<c:if test="${not empty Comment.commentFileList}">
												<div class="comment-body-attach">
													<div class="comment-body-attach-header">
														<label class="">
															<span class="ra-checkbox">
																<input type="checkbox" value=""><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
															</span>
															전체 선택
														</label>
													</div>
													<ul class="attach-list">
														<c:forEach items="${Comment.commentFileList}" var="CommentFile">
															<li>
																<span class="ra-checkbox">
																	<input type="checkbox" value="${CommentFile.src}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
																</span>
																<a class="file-name" href="${CommentFile.src}">${CommentFile.name} (${CommentFile.size})</a>
															</li>
														</c:forEach>
													</ul>
												</div>
											</c:if>
											
											<div class="comment-body-modify hide">
												<textarea rows="8" cols="" name="content" id="" class="comment-modify-textArea">${Comment.content}</textarea>
												<ul class="comment-modify-attach-list">
													<c:forEach items="${Comment.commentFileList}" var="CommentFile">
														<li>
															<span class="file-name">${CommentFile.name} (${CommentFile.size})</span>
					    									<span class="file-delete" onclick="addCommentDeleteAttacheFiles(${CommentFile.seq}, this)"> X </span>
														</li>
													</c:forEach>
												</ul>
											</div>
										</c:if>
									</div>
									
									<c:if test="${Comment.noticeyn eq 'N'}">
										<div class="comment-footer">
											<!-- comment like btn -->
											<span class="feedback-button feedback-button--like ${Comment.action eq 'like'? 'on':''}">
												<button type="button" class="icon-button feedback-button__thumb" aria-label="좋아요" onclick="actionCheck(this, 'like', 'comment', ${Comment.seq}, ${Comment.actionLog_seq})">
													<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>
												</button>
												<span class="ra-popover__trigger" title="" onclick="$(this).siblings('.like-list').removeClass('hide')">
													<span class="feedback-button__count" role="button" title="이 글을 좋아한 사람">${fn:length(Comment.likeList)}</span>
												</span>
												<div class="like-list hide">
													<div class="like-list-header">
														이 글을 좋아한 사람
														<button type="button" class="like-list-close" onclick="$(this).closest('.like-list').addClass('hide')">X</button>
													</div>
													<div class="like-list-body">
														<ul>
															<c:forEach items="${Comment.likeList}" var="like">
																<li>${like.member_id} (${like.member_name})</li>
															</c:forEach>
														</ul>
													</div>
												</div>
											</span>
											
											<!-- comment dislike btn -->
											<span class="feedback-button feedback-button--dislike ${Comment.action eq 'dislike'? 'on':''}">
												<button type="button" class="icon-button feedback-button__thumb" aria-label="싫어요" onclick="actionCheck(this, 'dislike', 'comment', ${Comment.seq}, ${Comment.actionLog_seq})">
													<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>
												</button>
												<span class="ra-popover__trigger" title="" onclick="$(this).siblings('.like-list').removeClass('hide')">
													<span class="feedback-button__count" role="button" title="이 글을 싫어한 사람">${fn:length(Comment.dislikeList)}</span>
												</span>
												<div class="like-list hide">
													<div class="like-list-header">
														이 글을 싫어한 사람
														<button type="button" class="like-list-close" onclick="$(this).closest('.like-list').addClass('hide')">X</button>
													</div>
													<div class="like-list-body">
														<ul>
															<c:forEach items="${Comment.dislikeList}" var="dislike">
																<li>${dislike.member_id} (${dislike.member_name})</li>
															</c:forEach>
														</ul>
													</div>
												</div>
											</span>
											<c:if test="${Comment.member_seq eq member.seq}">
												<span class="float-right">
													<button type="button" id="" class="comment-setting-btn" onclick="$(this).parent().next().toggleClass('hide');">
														<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>
													</button>
												</span>
												<ul class="comment-setting-menu hide">
													<li><button type="button" onclick="modifyCommentForm(this)">수정하기</button></li>
													<li><button type="button" onclick="deleteComment(${Comment.seq})">삭제하기</button></li>
												</ul>
											</c:if>
										</div>
										
										<div class="comment-footer-modify message-form__footer hide">
											<div class="message-form__footer-leftalign">
			    								<span class="message-form__attach-file" onclick="$(this).closest('.updateCommentForm').find('.comment-modify-attach').click();" style="border: 1px solid #e3e3e3; cursor: pointer; padding: 2px 10px 3px 7px; border-radius: 3px;">
			    									<button type="button" class="icon-button" aria-label="[object Object]">
			    										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
			    									</button>
			    									<span class="message-form__attach-file-label">파일첨부</span>
			    								</span>
			    							</div>
			    							<div class="message-form-submit-control">
			    								<button type="button" class="ra-button message-form-submit-control__cancel-button" onclick="cancelModifyComment(this)">취소</button>
			    								<button type="button" id="update-comment-submit" onclick="modifyComment(this)" disabled class="update-comment-submit ra-button message-form-submit-control__submit-button ra-button--accent">수정하기</button>
			    							</div>
			    							<input type="file" class="comment-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">
										</div>
									</c:if>
									
								</form>
							</div>
							</c:forEach>
						</div>
						<form action="/work/comment" class="comment-insert-form" method="post">
						<input type="hidden" name="board_seq" value="${Board.seq}">
						<div class="comment-input">
							<textarea rows="5" cols="" class="comment-input-textArea" name="content"></textarea>
							
							<ul class="comment-insert-attach-list">
	   						</ul>
		    						
							<div class="comment-input-footer">
								<span class="message-form__attach-file" onclick="$(this).siblings('.comment-input-attach').click();">
									<button type="button" class="icon-button" aria-label="[object Object]">
										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
									</button>
									<span class="message-form__attach-file-label">파일첨부</span>
								</span>
								<div class="float-right">
									<button type="button" class="comment-input-btn" disabled="disabled" onclick="insertComment(this)">작성하기</button>
								</div>
								<input type="file" class="comment-input-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">
							</div>
						</div>
						</form>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
</article>
<form action="" id="pagingForm">
	<input type="hidden" name="limit" value="${limit}">
	<input type="hidden" name="offset" value="${offset + limit}">
	<input type="hidden" name="group_seq" value="${WorkGroup.seq}">
	<input type="hidden" name="member_seq" value="${member.seq}">
	<input type="hidden" name="total" value="${total}">
</form>
<div id="worker_list" class="worker_list hide">
	<c:forEach items="${GroupMemberList}" var="groupMember">
		<li class="${groupMember.id}" onclick="addRequestBoardWorker(${groupMember.seq},'${groupMember.id}', this);">
			<span class="avatar" url="https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png" subdomain="poozim" style="width: 30px; height: 30px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png&quot;);">
				<c:if test="${WorkGroup.member_seq eq groupMember.seq}">
					<button class="user-type-badge user-type-badge--x-small ${WorkGroup.member_seq eq groupMember.seq? 'user-type-badge--master':''}">
						<i class="ico ico-master" aria-hidden="true"><svg width="12px" height="12px" viewBox="0 0 12 12" version="1.1"><g id="master" stroke="none" stroke-width="1" fill="#B6B6B6" fill-rule="evenodd"><path d="M6.58747854,2.8805897 C6.59128227,2.89232338 6.59506039,2.90419325 6.59881229,2.91619933 L7.60714286,6.14285714 L9.52356702,2.73588085 C9.53622026,2.7133862 9.5488478,2.69147966 9.56144477,2.67016037 C9.21912618,2.39524243 9,1.97321105 9,1.5 C9,0.671572875 9.67157288,0 10.5,0 C11.3284271,0 12,0.671572875 12,1.5 C12,2.28644211 11.3947734,2.93152596 10.6246794,2.99489219 C10.6247471,2.99596099 10.6248144,2.9970307 10.6248813,2.99810135 L10.9376856,8.00296986 C10.9721009,8.5536144 10.5562834,9 10.0001925,9 L7.25,9 L4.75,9 L1.99980749,9 C1.44762906,9 1.02831477,8.54696369 1.06231438,8.00296986 L1.37511867,2.99810135 C1.37518558,2.9970307 1.3752529,2.99596098 1.37532062,2.9948922 C0.605226663,2.93152597 0,2.28644212 0,1.5 C0,0.671572875 0.671572875,0 1.5,0 C2.32842712,0 3,0.671572875 3,1.5 C3,1.97321634 2.78086892,2.39525187 2.43854375,2.67016959 C2.45114724,2.69148088 2.46377867,2.7133843 2.47643298,2.73588085 L4.39285714,6.14285714 L5.40118771,2.91619933 C5.40493953,2.90419351 5.40871772,2.89232366 5.41252169,2.8805898 C4.87607153,2.65202468 4.5,2.11993044 4.5,1.5 C4.5,0.671572875 5.17157288,0 6,0 C6.82842712,0 7.5,0.671572875 7.5,1.5 C7.5,2.11993036 7.12392858,2.65202453 6.58747854,2.8805897 Z M0,11 C0,10.4477153 0.455760956,10 1.00247329,10 L10.9975267,10 C11.5511774,10 12,10.4438648 12,11 C12,11.5522847 11.544239,12 10.9975267,12 L1.00247329,12 C0.448822582,12 0,11.5561352 0,11 Z"></path></g></svg></i>
					</button>
				</c:if>
			</span>
			<div class="user-info">
				<div class="user-info-title">
					${groupMember.id} (${groupMember.name})
				</div>
				<div class="user-info-subtitle">
					${groupMember.department}
				</div>
			</div>
		</li>
	</c:forEach>
</div>
<script>
var board_attache_files = new Array();
var delete_board_attach_files;
var board_modify_files = new Array();

var comment_attache_files = new Array();
var delete_comment_attach_files;
var comment_modify_files = new Array();

$(document).ready(function(){
	//board insert
	$("#contentTextArea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkBoardValue(this);
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
	
	//board modify
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
	
	
	//comment insert
	$(".comment-input-textArea").on('focusin focusout propertychange change keyup paste input', function(){
		if($.trim($(this).val()) != ''){
			$(this).closest(".comment-input").find(".comment-input-btn").attr("disabled", false);
		} else {
			$(this).closest(".comment-input").find(".comment-input-btn").attr("disabled", true);
		}
	});
	
	$(".comment-input-attach").on("change", function(){
		if($.trim($(this).closest(".comment-input").find(".comment-input-textArea").val()) != ''){
			$(this).closest(".comment-input").find(".comment-input-btn").attr("disabled", false);
		} else {
			$(this).closest(".comment-input").find(".comment-input-btn").attr("disabled", true);
		}
		
		comment_attache_files = Array.from($(this)[0].files);
		setCommentInsertAttacheHtml($(this).closest(".comment-input").find(".comment-insert-attach-list"));
	});
	
	//comment modify
	$(".comment-modify-textArea").on('focusin focusout propertychange change keyup paste input', function(){
		var updateTextArea = $(this).closest(".updateCommentForm").find(".comment-modify-textArea");
		if($.trim(updateTextArea.val()) != ''){
			$(this).closest(".updateCommentForm").find("#update-comment-submit").attr("disabled", false);
		} else {
			$(this).closest(".updateCommentForm").find("#update-comment-submit").attr("disabled", true);
		}
	});
	
	$(".comment-modify-attach").on("change", function(){
		
		comment_modify_files = Array.from($(this)[0].files);
		var ul = $(this).closest(".updateCommentForm").find(".comment-modify-attach-list");
		
		setCommentModifyAttacheHtml(ul);
	});
	
})

//paging
$(document).scroll(function() {
	if($(".observed").length > 0){
		var observed = $(".observed").prev()
		
		var current_scroll = $(this).scrollTop();
		var event_scroll = observed.offset().top - observed.outerHeight()
		
		var appendObj = $("div.wall-list-wrap");
		
		if(current_scroll >= event_scroll){
			
			//paging 호출
			$(".observed").removeClass("observed");
			scrollPaging("board", appendObj);
		}
	}
});

function scrollPaging(type, obj){
	
	
	if(type == 'board'){
		var data = $("#pagingForm").serialize();
		
		showLoading();
		$.ajax({
			url : '/work/board',
			method : 'GET',
			data : data,
			dataType : 'JSON',
			success : function(res){
				if(res.workBoardList.length > 0){
					for(var i=0; i<res.workBoardList.length; i++){
						var html = getBoardHtml(res.workBoardList[i], true, (i==(res.workBoardList.length-1)? "observed" : ""));
						obj.append(html);
					}
					
					var offset = $("#pagingForm input[name='offset']").val();
					$("#pagingForm input[name='offset']").val(Number(offset) + Number(res.workBoardList.length));
				} else {
					$(".observed").removeClass("observed");
				}
				hideLoading();
			},
			error : function(request, status, error){
				alert("error");
				hideLoading();
			}
		});
	}
	else if(type == 'comment'){
		var prev_comment = obj.siblings(".prev-comment");
		var form = prev_comment.find(".comment_paging_form");
		var data = form.serialize();
		showLoading();
		$.ajax({
			url : '/work/comment',
			method : 'GET',
			data : data,
			dataType : 'JSON',
			success : function(res){
				if(res.commentList.length > 0){
					/* var offset = form.find("input[name='offset']").val();
					var comment_offset = Number(offset) - Number(res.commentList.length);
					var comment_limit = Number(prev_comment.siblings(".wall-comment-list").children().length) + Number(res.commentList.length);*/
					var board_seq = res.commentList[0].board_seq;
					var board_obj = $(prev_comment).closest(".wall-board-item");
					
					reloadBoard(board_seq, board_obj, true);
				}
				hideLoading();
			},
			error : function(request, status, error){
				alert("error");
				hideLoading();
			}
		});
	}
}

function insertBoard(){
	var url = $("#insertBoardForm").attr("action");
	var data = new FormData();
	var formData = $("#insertBoardForm").serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
	})
	
	for(var i=0; i<board_attache_files.length; i++){
		data.append("attachFiles", board_attache_files[i]);
	}
	
	showLoading();
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
			hideLoading();
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
		showLoading();
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
					hideLoading();
				}
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
				hideLoading();
			}
		})
	}
}

function modifyBoardForm(obj) {
	var board_body = $(obj).closest(".wall-board").find(".board-body");
	
	board_body.find(".board-body-attach").hide();
	board_body.find(".board-body-content").hide();
	board_body.find(".board-body-meta").hide();
	$(obj).closest(".wall-board").find(".board-footer").hide();
	$(obj).closest(".board-setting-menu").toggleClass("hide");
	
	board_body.find(".board-body-modify .board-modify-attach-list").find("li").removeClass("hide");
	board_body.find(".board-body-modify").show();
	$(obj).closest(".wall-board").find(".board-footer-modify").show();
	
	delete_board_attach_files = new Array();
	
	// date time picker
	var form = $(obj).closest('form');
	form.find("input[name='startdate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	form.find("input[name='enddate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	form.find("input[name='starttime']").timepicker({
	});
	
	form.find("input[name='endtime']").timepicker({
	});
}

function cancelModifyBoard(obj){
	var board_body = $(obj).closest(".wall-board").find(".board-body");
	
	board_body.find(".board-body-modify").hide();
	$(obj).closest(".wall-board").find(".board-footer-modify").hide();
	
	board_body.find(".board-body-attach").show();
	board_body.find(".board-body-content").show();
	board_body.find(".board-body-meta").show();
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
	
	showLoading();
	
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
			hideLoading();
		}
	})
}

function setBoardModifyAttacheHtml(ul){
	ul.find('li.added').remove();
	var array = board_modify_files;
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

function setCommentInsertAttacheHtml(ul){
	ul.empty();
	var array = comment_attache_files;
	if(array.length > 0){
		var html = "";
		for(var i=0; i<array.length; i++){
			html += '<li class="block"><span class="file-name">' + array[i].name + ' ('+ array[i].size +')</span>';
			html += '<span class="file-delete" onclick="removeCommentInsertAttache(' + i + ', this)"> X </span></li>';
			
		}
		ul.append(html);
	}
}

function removeCommentInsertAttache(index, obj){
	var ul = $(obj).closest(".comment-input").find(".comment-insert-attach-list");
	if(comment_attache_files.length > index){
		comment_attache_files.splice(index, 1);
		setCommentInsertAttacheHtml(ul);
	}
}

function insertComment(obj){
	var insertForm = $(obj).closest(".comment-insert-form");
	
	var url = insertForm.attr("action");
	var data = new FormData();
	var formData = insertForm.serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
		
	})
	
	if(comment_attache_files.length > 0){
		for(var i=0; i<comment_attache_files.length; i++){
			if(comment_attache_files[i].name != ''){
				data.append("attachFiles", comment_attache_files[i]);
			}
		}
	}
	
	showLoading();
	
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
			hideLoading();
		}
	})
}

function modifyCommentForm(obj){
	var comment_body = $(obj).closest(".wall-comment").find(".comment-body");
	
	comment_body.find(".comment-body-attach").hide();
	comment_body.find(".comment-body-content").hide();
	$(obj).closest(".wall-comment").find(".comment-footer").hide();
	$(obj).closest(".comment-setting-menu").toggleClass("hide");
	
	comment_body.find(".comment-body-modify .comment-modify-attach-list").find("li").removeClass("hide");
	comment_body.find(".comment-body-modify").show();
	$(obj).closest(".wall-comment").find(".comment-footer-modify").show();
	
	delete_comment_attach_files = new Array();
}

function deleteComment(seq){
	if(confirm("정말 삭제하시겠습니까?")){
		showLoading();
		$.ajax({
			url : '/work/comment/' + seq,
			method : 'DELETE',
			dataType : 'JSON',
			success : function(res){
				if(res.res == 1){
					alert("삭제되었습니다.");
					location.reload();
				} else {
					alert("삭제를 실패했습니다.\n본인이 작성한 글이 맞는지 확인하세요.");
					hideLoading();
				}
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
				hideLoading();
			}
		})
	}
}

function cancelModifyComment(obj){
	var comment_body = $(obj).closest(".wall-comment").find(".comment-body");
	
	comment_body.find(".comment-body-modify").hide();
	$(obj).closest(".wall-comment").find(".comment-footer-modify").hide();
	
	comment_body.find(".comment-body-attach").show();
	comment_body.find(".comment-body-content").show();
	$(obj).closest(".wall-comment").find(".comment-footer").show();
	
	delete_comment_attach_files = null;
	$("#update-comment-submit").attr("disabled", true);
	comment_modify_files = new Array();
}

function addCommentDeleteAttacheFiles(commentFile_seq, obj){
	delete_comment_attach_files.push(commentFile_seq);
	$(obj).closest("li").addClass("hide");
}

function setCommentModifyAttacheHtml(ul){
	ul.find('li.added').remove();
	var array = comment_modify_files;
	if(array.length > 0){
		var html = "";
		for(var i=0; i<array.length; i++){
			html += '<li class="added block"><span class="file-name">' + array[i].name + ' ('+ array[i].size +')</span>';
			html += '<span class="file-delete" onclick="removeCommentModifyAttache(' + i + ', this)"> X </span></li>';
			
		}
		ul.append(html);
	}
	
}

function removeCommentModifyAttache(index, obj){
	var ul = $(obj).closest(".updateCommentForm").find(".comment-modify-attach-list");
	if(comment_modify_files.length > index){
		comment_modify_files.splice(index, 1);
		setCommentModifyAttacheHtml(ul);
	}
}

function modifyComment(obj){
	var updateForm = $(obj).closest(".updateCommentForm");
	
	var url = updateForm.attr("action");
	var data = new FormData();
	var formData = updateForm.serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
		
	})
	
	if(comment_modify_files.length > 0){
		for(var i=0; i<comment_modify_files.length; i++){
			if(comment_modify_files[i].name != ''){
				data.append("attachFiles", comment_modify_files[i]);
			}
		}
	}
	
	if(delete_comment_attach_files.length > 0 ){
		for(var i=0; i<delete_comment_attach_files.length; i++){
			data.append("commentFileSeqList", delete_comment_attach_files[i]);
		}
	} else {
		data.append("commentFileSeqList", new Array());
	}
	
	showLoading();
	
	$.ajax({
		url : url,
		type : 'PUT',
		enctype: 'multipart/form-data',
		data : data,
		processData: false,
		contentType : false,
		dataType : 'JSON',
		success : function(res){
			if(res.res == 1){
				location.reload();
			}
			else {
				alert(res.msg);
				hideLoading();
			}
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
			hideLoading();
		}
	})
}

function commentInsertAttach(obj){
	if($.trim($(obj).closest(".comment-input").find(".comment-input-textArea").val()) != ''){
		$(obj).closest(".comment-input").find(".comment-input-btn").attr("disabled", false);
	} else {
		$(obj).closest(".comment-input").find(".comment-input-btn").attr("disabled", true);
	}
	
	comment_attache_files = Array.from($(obj)[0].files);
	setCommentInsertAttacheHtml($(obj).closest(".comment-input").find(".comment-insert-attach-list"));
}

function commentModifyAttach(obj){
	comment_modify_files = Array.from($(obj)[0].files);
	var ul = $(obj).closest(".updateCommentForm").find(".comment-modify-attach-list");
	
	setCommentModifyAttacheHtml(ul);
}

function boardInsertAttach(obj){
	board_attache_files = Array.from($(obj)[0].files);
	setBoardInsertAttacheHtml();
}

function boardModifyAttach(obj){
	board_modify_files = Array.from($(obj)[0].files);
	var ul = $(obj).closest(".updateBoardForm").find(".board-modify-attach-list");
	
	setBoardModifyAttacheHtml(ul);
}

</script>
</body>
</html>