<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ page import="com.poozim.jobcall.util.StringUtil"%>

<c:if test="${coverFlag}">
	<div class="wall-board-item ${coverClass}">
</c:if>
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
				<div class="board-header-meta-id">${search eq Board.member_id? '<mark>':''}${Board.member_id}${search eq Board.member_id? '</mark>':''} (${search eq Board.member_name? '<mark>':''}${Board.member_name}${search eq Board.member_name? '</mark>':''})</div>
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
								<div class="schedule-title">${search eq Board.title? '<mark>':''}${Board.title}${search eq Board.title? '</mark>':''}</div>
								<div class="schedule-date">${Board.startdate} ${Board.starttime} - ${Board.enddate} ${Board.endtime}</div>
							</div>
						</div>
					</c:when>
					<c:when test="${Board.type eq 'vote'}">
						<div class="vote-info">
							<div class="vote-info-header">
								<div class="vote-info-header-q">Q</div>
								<div class="vote-info-header-title">
									${search eq Board.title? '<mark>':''}${Board.title}${search eq Board.title? '</mark>':''}
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
				${StringUtil.decryptXSSHtml(Board.content)}
			</div>
			<c:if test="${not empty Board.workBoardFileList}">
				<div class="board-body-attach">
					<div class="board-body-attach-header">
						<label class="">
							<span class="ra-checkbox">
								<input type="checkbox" value="" onclick="check_attach_all(this)"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
							</span>
							전체 선택
						</label>
						<button type="button" class="ra-button small" onclick="download_attache_files(this)">다운로드</button>
					</div>
					<ul class="attach-list">
						<c:forEach items="${Board.workBoardFileList}" var="BoardFile">
							<li>
								<span class="ra-checkbox">
									<input type="checkbox" name="download_file" value="${BoardFile.object_name}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
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
				<div class="textarea board-modify-textArea" contenteditable="true" oninput="$(this).siblings('input[name=content]').val($(this).html());checkMention(this);checkBoard(this);">${StringUtil.decryptXSSHtml(Board.content)}</div>
				<input type="hidden" name="content" value="${Board.content}">
				<div class="textarea-mention-list hide"><ul></ul></div>
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
				<button type="button" class="link-copy-btn" aria-label="링크 복사" onclick="copyLink(${Board.group_seq}, ${Board.seq})">
					<i class="ico ico-linkcopy" aria-hidden="true"><svg width="16px" height="7px" viewBox="0 0 16 7" version="1.1"><g id="linkcopy" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd" transform="translate(8.000000, 3.500000) scale(1, -1) translate(-8.000000, -3.500000)"><path d="M9,1 L12.5,1 C13.8704373,1 15,2.12608684 15,3.5 C15,4.87364425 13.870712,6 12.5,6 L9,6 L9,7 L12.5,7 C14.4224156,7 16,5.42651184 16,3.5 C16,1.573111 14.4220333,0 12.5,0 L9,0 L9,1 Z M7,1 L3.5,1 C2.12956271,1 1,2.12608684 1,3.5 C1,4.87364425 2.12928797,6 3.5,6 L7,6 L7,7 L3.5,7 C1.57758439,7 0,5.42651184 0,3.5 C0,1.573111 1.5779667,0 3.5,0 L7,0 L7,1 Z M5,3 L11,3 L11,4 L5,4 L5,3 Z"></path></g></svg></i>
				</button>
				<c:if test="${Board.member_seq eq member.seq}">
					<button type="button" id="" class="board-setting-btn" onclick="$(this).parent().next().toggleClass('hide');">
						<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>
					</button>
				</c:if>
			</span>
			
			<c:if test="${Board.member_seq eq member.seq}">
				<ul class="board-setting-menu hide">
					<li><button type="button" onclick="modifyBoardForm(this)">수정하기</button></li>
					<li><button type="button" onclick="deleteBoard(this)">삭제하기</button></li>
				</ul>
			</c:if>
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
						<input type="file" class="board-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles" onchange="boardModifyAttach(this)">
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
					${StringUtil.decryptXSSHtml(Comment.content)}
					</div>
					<c:if test="${Comment.noticeyn eq 'N'}">
						<br>
						<c:if test="${not empty Comment.commentFileList}">
							<div class="comment-body-attach">
								<div class="comment-body-attach-header">
									<label class="">
										<span class="ra-checkbox">
											<input type="checkbox" value="" onclick="check_attach_all(this)"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
										</span>
										전체 선택
									</label>
									<button type="button" class="ra-button small" onclick="download_attache_files(this)">다운로드</button>
								</div>
								<ul class="attach-list">
									<c:forEach items="${Comment.commentFileList}" var="CommentFile">
										<li>
											<span class="ra-checkbox">
												<input type="checkbox" name="download_file" value="${CommentFile.object_name}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
											</span>
											<a class="file-name" href="${CommentFile.src}">${CommentFile.name} (${CommentFile.size})</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</c:if>
						
						<div class="comment-body-modify hide">
							<div class="textarea comment-modify-textArea" contenteditable="true" oninput="$(this).siblings('input[name=content]').val($(this).html());checkMention(this);checkComment(this);">${StringUtil.decryptXSSHtml(Comment.content)}</div>
							<input type="hidden" name="content" value="${Comment.content}">
							<div class="textarea-mention-list hide"><ul></ul></div>
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
								<li><button type="button" onclick="deleteComment(${Comment.seq}, this)">삭제하기</button></li>
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
  							<input type="file" class="comment-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles" onchange="commentModifyAttach(this)">
					</div>
				</c:if>
				
			</form>
		</div>
		</c:forEach>
	</div>
	<form action="/work/comment" class="comment-insert-form" method="post">
	<input type="hidden" name="board_seq" value="${Board.seq}">
	<div class="comment-input">
		<div class="textarea comment-input-textArea" contenteditable="true" oninput="$(this).siblings('input[name=content]').val($(this).html());checkMention(this);checkComment(this);"></div>
		<input type="hidden" name="content" value="">
		<div class="textarea-mention-list hide"><ul></ul></div>
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
			<input type="file" class="comment-input-attach hide" multiple="multiple" autocomplete="off" name="attachFiles" onchange="commentInsertAttach(this)">
		</div>
	</div>
</form>
<c:if test="${coverFlag}">
	</div>
</c:if>
