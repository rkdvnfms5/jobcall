<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.input-schedule {
	width: 100%;
	height: 100%;
	z-index: 888;
	background-color: rgba(0,0,0,0.5);
	position: fixed;
	top: 0;
	left: 0;
}

.input-schedule .input-schedule-box {
	position: fixed;
	top: 50%;
	left: 50%;
	padding: 30px 28px;
    width: 572px;
	transform: translate(-50%, -50%);
	background-color: #fff;
}
</style>
</head>
<body>
<article class="work-basic-layout-body">
	<section class="wall-page">
		<%@include file="/jsp/include/group_header.jsp" %>	
	
		<div class="group-schedule-page">
			<div class="group-schedule-page-header">
				<div class="">
					
				</div>
			</div>
			<div class="group-schedule-page-body">
				<table class="table-schedule">
					<colgroup>
						<col width="14.285%">
						<col width="14.285%">
						<col width="14.285%">
						<col width="14.285%">
						<col width="14.285%">
						<col width="14.285%">
						<col width="14.285%">
					</colgroup>
					<thead>
						<tr class="month">
							<td colspan="7">
								<button class="prev_month" onclick="moveMonth(${year}, ${month - 1})">&lt;</button>
								${year}년 ${month}월
								<button class="next_month" onclick="moveMonth(${year}, ${month + 1})">&gt;</button>
							</td>
						</tr>
						<tr class="title">
							<td>일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:forEach begin="1" end="${startBlank}" varStatus="status">
								<c:set var="day" value="${pre_lastDay - (startBlank - status.index)}" />
								<c:set var="date" value="${prev_monthYear}-${day lt 10? '0':''}${day}"/>
								<td class="disabled" onclick="openInputSchedule('${date}')">
									<span class="day">${day lt 10? '0':''}${day}</span>
									<ul class="schedule-list">
										<c:forEach items="${workBoardList}" var="board">
											<c:if test="${board.startdate <= date and board.enddate >= date}">
												<li>
													<span class="schedule-title">${board.title}</span>
													<div class="schedule-info hide">
														<div class="schedule-info-title">${board.title}</div>
														<div class="schedule-info-content">${board.content}</div>
														<div class="schedule-info-datetime">${board.startdate} ${board.starttime} - ${board.enddate} ${board.endtime}</div>
														<div class="schedule-info-member">${board.member_id} (${board.member_name})</div>
													</div>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</td>
							</c:forEach>
							<c:forEach begin="1" end="${7 - startBlank}" varStatus="status">
								<c:set var="date" value="${cur_monthYear}-${status.index lt 10? '0':''}${status.index}"/>
								<td class="${status.index eq  (7 - startBlank)? 'sat':''}" onclick="openInputSchedule('${date}')">
									<span class="day">${status.index lt 10? '0':''}${status.index}</span>
									<ul class="schedule-list">
										<c:forEach items="${workBoardList}" var="board">
											<c:if test="${board.startdate <= date and board.enddate >= date}">
												<li>
													<span class="schedule-title">${board.title}</span>
													<div class="schedule-info hide">
														<div class="schedule-info-title">${board.title}</div>
														<div class="schedule-info-content">${board.content}</div>
														<div class="schedule-info-datetime">${board.startdate} ${board.starttime} - ${board.enddate} ${board.endtime}</div>
														<div class="schedule-info-member">${board.member_id} (${board.member_name})</div>
													</div>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</td>
							</c:forEach>
						</tr>
						<c:forEach begin="${(8 - startBlank)}" end="${lastDay}" varStatus="status">
							<c:set var="date" value="${cur_monthYear}-${status.index lt 10? '0':''}${status.index}"/>
							<c:if test="${status.index % 7 eq (8 - startBlank) % 7}">
								<tr>
							</c:if>
							<td class="${status.index % 7 eq (8 - startBlank) % 7? 'sun':''}" onclick="openInputSchedule('${date}')">
								<input type="hidden" value="${status.index % 7}">
								<span class="day">${status.index lt 10? '0':''}${status.index}</span>
								<ul class="schedule-list">
									<c:forEach items="${workBoardList}" var="board">
										<c:if test="${board.startdate <= date and board.enddate >= date}">
											<li>
												<span class="schedule-title">${board.title}</span>
												<div class="schedule-info hide">
													<div class="schedule-info-title">${board.title}</div>
													<div class="schedule-info-content">${board.content}</div>
													<div class="schedule-info-datetime">${board.startdate} ${board.starttime} - ${board.enddate} ${board.endtime}</div>
													<div class="schedule-info-member">${board.member_id} (${board.member_name})</div>
												</div>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</td>
							
							<c:if test="${status.index % 7 eq (7-startBlank) % 7}">
								</tr>
							</c:if>
						</c:forEach>
						<c:forEach begin="1" end="${endBlank}" varStatus="status">
							<c:set var="date" value="${next_monthYear}-${status.index lt 10? '0':''}${status.index}"/>
							<td class="disabled" onclick="openInputSchedule('${date}')">
								<span class="day">${status.index lt 10? '0':''}${status.index}</span>
								<ul class="schedule-list">
									<c:forEach items="${workBoardList}" var="board">
										<c:if test="${board.startdate <= date and board.enddate >= date}">
											<li>
												<span class="schedule-title">${board.title}</span>
												<div class="schedule-info hide">
													<div class="schedule-info-title">${board.title}</div>
													<div class="schedule-info-content">${board.content}</div>
													<div class="schedule-info-datetime">${board.startdate} ${board.starttime} - ${board.enddate} ${board.endtime}</div>
													<div class="schedule-info-member">${board.member_id} (${board.member_name})</div>
												</div>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</td>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
</article>
<div class="input-schedule" style="display: none;">
	<form action="/work/board" id="insertBoardForm" method="post" >
		<input type="hidden" name="type" value="schedule">
		<input type="hidden" name="group_seq" id="group_seq" value="${WorkGroup.seq}">
		<div class="input-schedule-box">
			<div class="message-form-group__body">
				<div class="schedule-message-form">
					<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">
						<div class="message-form__header">
							<div class="board-input-date">
								<div class="input-datetime-container">
									<input type="text" class="input-startdate" name="startdate" oninput="checkBoard(this)" autocomplete="off">
								</div> 
								<div class="input-datetime-container time">
									<input type="text" class="input-starttime" name="starttime" placeholder="시작 시간" oninput="checkBoard(this)" autocomplete="off">
								</div>
								  -  
								<div class="input-datetime-container">
									<input type="text" class="input-enddate" name="enddate" oninput="checkBoard(this)" autocomplete="off">
								</div> 
								<div class="input-datetime-container time">
									<input type="text" class="input-endtime" name="endtime" placeholder="종료 시간" oninput="checkBoard(this)" autocomplete="off">
								</div>
								<div class="input-date-type">
									<div>
										<label class="schedule-form__label">
											<span class="ra-checkbox">
												<input type="checkbox" name="allYN" onchange="checkDateType(this)">
												<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
											</span>
											 종일 
										</label>
									</div>
								</div>
							</div>
							<div class="board-input-title">
								<input type="text" maxlength="30" name="title" id="board-insert-title" placeholder="일정 제목 입력" oninput="checkBoard(this)" autocomplete="off">
							</div>
						</div>
						<div class="message-form__footer">
							<div class="message-form-submit-control">
	 							<button type="button" onclick="$('.input-schedule').hide();" class="ra-button message-form-submit-control__cancel-button">취소</button>
	 							<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
	 						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<script>
$(document).ready(function(){
	$(".schedule-list li").hover(function(){
		$(this).find(".schedule-info").removeClass("hide");
	})
	$(".schedule-list li").mouseover(function(){
		$(this).find(".schedule-info").removeClass("hide");
	})
	$(".schedule-list li").mouseout(function(){
		$(this).find(".schedule-info").addClass("hide");
	})
	
	$("#insertBoardForm input[name='startdate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$("#insertBoardForm input[name='enddate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$("#insertBoardForm input[name='starttime']").timepicker({
	});
	
	$("#insertBoardForm input[name='endtime']").timepicker({
	});
	
})

function openInputSchedule(date){
	$("#insertBoardForm input[name='startdate']").datepicker('setDate', date);
	
	$("#insertBoardForm input[name='enddate']").datepicker('setDate', date);
	
	$(".input-schedule").show();
}

function checkBoard(obj){
	var check = checkBoardValue(obj);
	if(check){
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", false);
	} else {
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", true);
	}
}

function checkBoardValue(obj){
	var form = $(obj).closest("form");
	var board_type = form.find("input[name='type']").val();
	if(board_type == 'schedule'){
		if($.trim(form.find("input[name='title']").val()) == ''){
			return false;
		}
		
		if($.trim(form.find("input[name='startdate']").val()) == ''){
			return false;
		}
		
		if($.trim(form.find("input[name='enddate']").val()) == ''){
			return false;
		}
	}
	
	
	return true;
}

function insertBoard(){
	var url = $("#insertBoardForm").attr("action");
	var data = new FormData();
	var formData = $("#insertBoardForm").serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
	})
	
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

function moveMonth(year, month){
	if(month < 1) {
		month = 12;
		year--;
	}
	
	if(month > 12) {
		month = 1;
		year++;
	}
	showLoading();
	location.href='/work/group/${group_seq}/schedule?month=' + month + '&year=' + year;
}
</script>
</body>
</html>