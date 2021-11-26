function insertCategory(){
	var title = $(".tmp-cate-editor-cates__item-input").val();
	
	$.ajax({
		url : '/work/category',
		method : 'POST',
		data : {title : title},
		dataType : 'JSON',
		success : function(res) {
			location.reload();
		},
		error : function(xhr, status, error){
			alert("카테고리 추가를 실패했습니다.")
		}
	})
}

//server.xml 에 추가 <Connector parseBodyMethods="POST,PUT,DELETE" />

function updateCategory(seq){
	var title = $(".tmp-cate-editor-cates__item-input").val();
	
	$.ajax({
		url : '/work/category',
		method : 'PUT',
		data : {seq : seq, title : title},
		dataType : 'JSON',
		success : function(res) {
			location.reload();
		},
		error : function(xhr, status, error){
			alert("카테고리 수정을 실패했습니다.")
		}
	})
}

function deleteCategory(seq){
	if(confirm("카테고리를 삭제하시겠습니까?")){
		$.ajax({
			url : '/work/category',
			method : 'DELETE',
			data : {seq : seq},
			dataType : 'JSON',
			success : function(res) {
				location.reload();
			},
			error : function(xhr, status, error){
				alert("카테고리 삭제를 실패했습니다.")
			}
		})
	}
}


function moveGroupCategory(){
	var categoryseq = $("#categorySelect").val();
	var groupseqArr = new Array();
	
	$("#group-list").find("input[type=checkbox]:checked").each(function(index, item){
		groupseqArr.push(Number(item.value));
	});
	
	
	$.ajax({
		url : '/work/category_move',
		method : 'POST',
		data : {category_seq : categoryseq, groupSeqList : groupseqArr},
		dataType : 'JSON',
		success : function(res) {
			if(res.res > 0){
				location.reload();
			}
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
}

function checkCategoryGroupAll(){
	if($("#groupCheckAll").is(":checked")){
		$("#group-list").find("input[type=checkbox]").prop("checked", true);
	} else {
		$("#group-list").find("input[type=checkbox]").prop("checked", false);
	}
}

function uncheckCategoryGroupAll(){
	$("#groupCheckAll").prop("checked", false);
	$("#group-list").find("input[type=checkbox]").prop("checked", false);
}

function checkGroupValue() {
	if($.trim($("input[name='access']:checked")).length < 1){
		return false;
	}
	
	if($.trim($("#group_name").val()) == ''){
		return false;
	}
	
	if($.trim($("#group_content").val()) == ''){
		return false;
	}
	
	return true;
}

function checkBoardValue(obj){
	var form = $(obj).closest("form");
	var board_type = form.find("input[name='type']").val();
	var content = form.find("textarea[name='content']").val();
	
	if($.trim(content) == ''){
		return false;
	}
	
	if(board_type == 'request'){
		if($.trim(form.find("input[name='worker']").val()) == ''){
			return false;
		}
		
		if($.trim(form.find("input[name='status']").val()) == ''){
			return false;
		}
	}
	
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
	
	if(board_type == 'schedule'){
		if($.trim(form.find("input[name='title']").val()) == ''){
			return false;
		}
		
		if($.trim(form.find("input[name='status']").val()) == ''){
			return false;
		}
		
		form.find("input[name='vote']").each(function(index, item){
			if($.trim(item.value) == ''){
				return false;
			}
		})
	}
	
	
	return true;
}

function goGroupSetting(groupseq){
	location.href = '/work/group/' + groupseq + '/setting';
}

function actionCheck(obj, action, target, target_seq, seq){
	var parentObj = $(obj).parent();
	var brother = parentObj.siblings('.feedback-button')
	var brotherBtn = brother.find('.feedback-button__thumb');
	
	if(parentObj.hasClass("on")){
		deleteActionLog(target, target_seq, seq, obj);
	} else {
		if(brother.hasClass("on")){
			updateActionLog(target, target_seq, seq, action, obj);
		} else {
			insertActionLog(target, target_seq, action, obj);
		}
	}
	
	//parentObj.toggleClass("on");
}

function insertActionLog(target, target_seq, action, obj){
	showLoading();
	$.ajax({
		url : '/work/action',
		method : 'POST',
		data : {target : target, target_seq : target_seq, action : action},
		dataType : 'JSON',
		success : function(res) {
			if(target == 'board'){
				reloadBoard(target_seq, $(obj).closest(".wall-board-item"), false);
			} else {
				$.ajax({
					url : '/work/comment/' + target_seq,
					method : 'GET',
					data : {seq : target_seq},
					dataType : 'JSON',
					success : function(res) {
						var html = getCommentHtml(res.Comment, false);
						$(obj).closest(".wall-comment").html(html);
					},
					error : function(request, status, error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				})
			}
			
			hideLoading();
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			hideLoading();
		}
	})
}

function updateActionLog(target, target_seq, seq, action, obj){
	if(seq > 0){
		showLoading();
		$.ajax({
			url : '/work/action/' + seq,
			method : 'PUT',
			data : {seq : seq, action : action},
			dataType : 'JSON',
			success : function(res) {
				if(target == 'board'){
					reloadBoard(target_seq, $(obj).closest(".wall-board-item"), false);
				} else {
					$.ajax({
						url : '/work/comment/' + target_seq,
						method : 'GET',
						data : {seq : target_seq},
						dataType : 'JSON',
						success : function(res) {
							var html = getCommentHtml(res.Comment, false);
							$(obj).closest(".wall-comment").html(html);
						},
						error : function(request, status, error){
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					})
				}
				
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	} else {
		alert("seq 정보가 없습니다.");
	}
	
}

function deleteActionLog(target, target_seq, seq, obj){
	if(seq > 0){
		showLoading();
		$.ajax({
			url : '/work/action/' + seq,
			method : 'DELETE',
			data : {seq : seq},
			dataType : 'JSON',
			success : function(res) {
				if(target == 'board'){
					reloadBoard(target_seq, $(obj).closest(".wall-board-item"), false);
				} else {
					$.ajax({
						url : '/work/comment/' + target_seq,
						method : 'GET',
						data : {seq : target_seq},
						dataType : 'JSON',
						success : function(res) {
							var html = getCommentHtml(res.Comment, false);
							$(obj).closest(".wall-comment").html(html);
						},
						error : function(request, status, error){
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					})
				}
				
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	} else {
		alert("seq 정보가 없습니다.");
	}
}

function reloadBoard(board_seq, parent, commentPagingBool){
	
	var prev_comment = parent.find(".prev-comment");
	var form = prev_comment.find(".comment_paging_form");
	var offset = form.find("input[name='offset']").val();
	
	if(commentPagingBool == true){
		
		var comment_offset = (Number(offset) > 5? Number(offset)-5 : 0);
		var comment_limit = Number(prev_comment.siblings(".wall-comment-list").children().length) + 5;
		var data = {comment_offset : comment_offset, comment_limit : comment_limit, seq : board_seq};
	}
	else {
		var comment_limit = Number(prev_comment.siblings(".wall-comment-list").children().length) + 5;
		var data = {comment_offset : offset, comment_limit : comment_limit, seq : board_seq};
	}
	
	$.ajax({
		url : '/work/board/' + board_seq,
		method : 'GET',
		data : data,
		dataType : 'JSON',
		success : function(res) {
			var html = getBoardHtml(res.Board, false, "");
			parent.html(html);
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}

function getBoardHtml(board, coverFlag, coverClass){
	var memberseq = $("#member_seq").val();
	var html = "";
	if(coverFlag){ //가장 바깥 태그 포함 여부
		html += '<div class="wall-board-item ' + coverClass + '">';
	}
	html += '<form action="/work/board/"' + board.seq + ' class="updateBoardForm" method="post">';
	html += '<input type="hidden" name="seq" value="' + board.seq + '" />';
	html += '<div class="wall-board"><div class="board-header"><div class="board-header-profile">';
	html += '<span class="avatar" style="width: 50px; height: 50px; background-image: url(&quot;';
	
	html += (board.member_profile == '' || board.member_profile == undefined? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png' : board.member_profile);
		
	html += '&quot;);"></span>';
	html += '</div><div class="board-header-meta">';
	html += '<div class="board-header-meta-id">' + board.member_id + ' (' + board.member_name + ')</div>';
	html += '<div class="board-header-meta-date">' + board.regdate + '</div></div></div>';
	html += '<div class="board-body">';
	html += '<div class="board-body-meta">';
	if(board.type == 'request'){
		html += '<div class="worker-info">';
		html += '<span>담당자 : </span>';
		if(board.worker != ''){
			var workerArr = board.worker.split(',');
			for(var i=0; i<workerArr.length; i++){
				html += '<span class="worker-id">'+workerArr[i]+'</span>';
			}
		}
		html += '</div>';
		html += '<div class="status-info">';
		html += '<span class="request ';
		if(board.status == 'request'){
			html += 'on"';
		} else {
			html += '" onclick="updateBoardStatus(' + board.seq + ', \'request\', this)"';
		}
		html +='>요청</span> ';
		
		html += '<span class="process ';
		if(board.status == 'process'){
			html += 'on"';
		} else {
			html += '" onclick="updateBoardStatus(' + board.seq + ', \'process\', this)"';
		}
		html +='>진행</span> ';
		
		html += '<span class="complete ';
		if(board.status == 'complete'){
			html += 'on"';
		} else {
			html += '" onclick="updateBoardStatus(' + board.seq + ', \'complete\', this)"';
		}
		html +='>완료</span> ';
		html += '</div>';
	} 
	else if(board.type == 'schedule'){
		var monthday = board.startdate.split("-");
		html += '<div class="schedule-info">';
		html += '<div class="schedule-calendar">';
		html += '<div class="month">' + monthday[1] + '</div>';
		html += '<div class="day">' + monthday[2] + '</div>';
		html += '</div>';
		html += '<div class="schedule-text">';
		html += '<div class="schedule-title">' + board.title + '</div>';
		html += '<div class="schedule-date">' + board.startdate + ' ' + board.starttime + ' - ' + board.enddate + ' ' + board.endtime + '</div>';
		html += '</div></div>';
	
	}
	else if(board.type == 'vote'){
		html += '<div class="vote-info">';
		html += '<div class="vote-info-header">';
		html += '<div class="vote-info-header-q">Q</div>';
		html += '<div class="vote-info-header-title">' + board.title;
		html += '</div>';
		html += '<div class="vote-info-header-desc"> ' + (board.status == 'process'? '진행 중인':'마감된') + '투표 ';
		html += '</div>';
		if(board.status == 'process' && board.member_seq == memberseq){
			html += '<button type="button" onclick="deadLineVote(' + board.seq + ', this)" class="vote-deadline-btn">투표 마감하기</button>';
		}
		html += '</div>';
		html += '<div class="vote-info-body">';
		for(var i=0; i<board.boardVoteList.length; i++){
			var vote = board.boardVoteList[i];
			html += '<div class="vote-info-body-content">';
			html += '<div class="vote-info-body-item ';
			if(vote.voteyn == 'Y'){
				html += 'on';
			}
			html += '">';
			html += '<div class="poll-attachment__item-no-seq" ';
				if(board.status == 'process'){
					html += 'onclick="voteCheck('+vote.seq+', '+board.seq+', this)"';
				}
			html += '><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i></div>';
			html += '<span class="vote-info-body-item-name" ';
				if(board.status == 'process'){
					html += 'onclick="voteCheck('+vote.seq+', '+board.seq+', this)"';
				}
			html += '>'+vote.name+'</span>';
			html += '<span class="vote-info-body-item-count" onclick="$(this).parent().siblings(\'.vote-member-list\').toggleClass(\'hide\')">'+vote.boardVoteMemberList.length+'</span>';
			html += '</div>';
			html += '<div class="vote-member-list hide">';
			html += '<div class="vote-member-list-header">';
			html += ' 이 항목에 투표한 사람 ';
			html += '<button type="button" class="vote-member-list-close" onclick="$(this).closest(\'.vote-member-list\').addClass(\'hide\')">X</button>';
			html += '</div>';
			html += '<div class="vote-member-list-body">';
			html += '<ul>';
				for(var j=0; j<vote.boardVoteMemberList.length; j++){
					html += '<li>'+vote.boardVoteMemberList[j].member_id+' ('+vote.boardVoteMemberList[j].member_name+')</li>';
				}
			html += '</ul>';
			html += '</div></div></div>';
		}
		html += '</div></div>';
	}
	else {
		
	}
	
	html += '</div>';
	html += '<div class="board-body-content">' + board.content + '</div>';
	if(board.workBoardFileList.length > 0){
		html += '<div class="board-body-attach"><div class="board-body-attach-header">';
		html += '<label class=""><span class="ra-checkbox">';
		html += '<input type="checkbox" value=""><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
		html += '</span> 전체 선택 </label></div>';
		html += '<ul class="attach-list">';
		for(var i=0; i<board.workBoardFileList.length; i++){
			html += '<li><span class="ra-checkbox">';
			html += '<input type="checkbox" value="' + board.workBoardFileList[i].src + '"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
			html += '</span> <a class="file-name" href="' + board.workBoardFileList[i].src + '">' + board.workBoardFileList[i].name + ' (' + board.workBoardFileList[i].size + ')</a></li>';
		}
		html += '</ul></div>';
	}
	html += '<div class="board-body-modify hide">';
	if(board.type == 'request'){
		html += '<input type="hidden" name="worker" value="' + board.worker + '">';
		html += '<div class="request-message-form">';
		html += '<div class="board-input-title">';
		if(board.worker != ''){
			var workerArr = board.worker.split(',');
			for(var i=0; i<workerArr.length; i++){
				html += '<div class="worker-label">';
				html += '<span class="worker-label-id">' + workerArr[i] + '</span>';
				html += '<span class="worker-label-cancel" onclick="removeRequestBoardWorker(this, \'' + workerArr[i] + '\')">X</span></div>';
				
			}
		}
		html += '<input type="text" maxlength="30" name="input-worker" class="board-modify-worker" oninput="checkWorker(this)" placeholder="담당자 ID 입력"></div>';
		html += '<div class="mention-list hide">';
		html += '<ul></ul>';
		html += '</div></div>';
	}
	else if(board.type == 'schedule'){
		html += '<div class="board-input-date">';
		html += '<div class="input-datetime-container">';
		html += '<input type="text" class="input-startdate" name="startdate" value="' + board.startdate + '">';
		html += '</div> ';
		html += '<div class="input-datetime-container time ';
		if(board.starttime != ''){
			html += 'hide';
		}
		html += '">';
		html += '<input type="text" class="input-starttime" name="starttime" value="' + board.starttime + '" placeholder="시작 시간">';
		html += '</div>';
		html += ' - ';
		html += '<div class="input-datetime-container">';
		html += '<input type="text" class="input-enddate" name="enddate" value="' + board.enddate + '" >';
		html += '</div> ';
		html += '<div class="input-datetime-container time ';
		if(board.endtime != ''){
			html += 'hide';
		}
		html += '">';
		html += '<input type="text" class="input-endtime" name="endtime" value="' + board.endtime + '" placeholder="종료 시간">';
		html += '</div>';
		html += '<div class="input-date-type">';
		html += '<div>';
		html += '<label class="schedule-form__label">';
		html += '<span class="ra-checkbox">';
		html += '<input type="checkbox" name="allYN" onchange="checkDateType(this)" ';
			if(board.starttime == '' && board.endtime == ''){
				html += 'checked';
			}
		html += '>';
		html += '<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
		html += '</span>';
		html += ' 종일 ';
		html += '</label>';
		html += '</div></div></div>';
		html += '<div class="board-input-title">';
		html += '<input type="text" maxlength="30" name="title" id="board-insert-title" value="' + board.title + '" placeholder="일정 제목 입력">';
		html += '</div>';
	} else {
		
	}
	html += '<textarea rows="8" cols="" name="content" id="" class="board-modify-textArea">' + board.content + '</textarea>';
	html += '<ul class="board-modify-attach-list">';
	for(var i=0; i<board.workBoardFileList.length; i++){
		html += '<li><span class="file-name">' + board.workBoardFileList[i].name + ' (' + board.workBoardFileList[i].size + ')</span>';
		html += '<span class="file-delete" onclick="addDeleteAttacheFiles(' + board.workBoardFileList[i].seq + ', this)"> X </span></li>';
	
	}
	html += '</ul></div></div><div class="board-footer">';
	html += '<span class="msg-button"><span class="text-info">댓글</span><span class="num-count">' + board.commentList.length + '</span></span>';
	html += ' <span class="feedback-button feedback-button--like ';
	if(board.action == 'like'){
		html += 'on';
	}
	html += '">';
	html += '<button type="button" class="icon-button feedback-button__thumb" aria-label="좋아요" onclick="actionCheck(this, \'like\', \'board\', ' + board.seq + ', ' + board.actionLog_seq + ')">';
	html += '<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>';
	html += '</button> <span class="ra-popover__trigger" title="" onclick="$(this).siblings(\'.like-list\').removeClass(\'hide\')">';
	html += '<span class="feedback-button__count" role="button" title="이 글을 좋아한 사람">' + board.likeList.length + '</span></span>';
	html += '<div class="like-list hide"><div class="like-list-header"> 이 글을 좋아한 사람 ';
	html += '<button type="button" class="like-list-close" onclick="$(this).closest(\'.like-list\').addClass(\'hide\')">X</button>';
	html += '</div><div class="like-list-body"><ul>';
	for(var i=0; i<board.likeList.length; i++){
		html += '<li>' + board.likeList[i].member_id + ' (' + board.likeList[i].member_name + ')</li>';
	}
	html += '</ul></div></div></span>';
	html += ' <span class="feedback-button feedback-button--dislike ';
	if(board.action == 'dislike'){
		html += 'on';
	}
	html += '">';
	html += '<button type="button" class="icon-button feedback-button__thumb" aria-label="싫어요" onclick="actionCheck(this, \'dislike\', \'board\', ' + board.seq + ', ' + board.actionLog_seq + ')">';
	html += '<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="ra-popover__trigger" title="" onclick="$(this).siblings(\'.like-list\').removeClass(\'hide\')">';
	html += '<span class="feedback-button__count" role="button" title="이 글을 싫어한 사람">' + board.dislikeList.length + '</span></span>';
	html += '<div class="like-list hide"><div class="like-list-header"> 이 글을 싫어한 사람 ';
	html += '<button type="button" class="like-list-close" onclick="$(this).closest(\'.like-list\').addClass(\'hide\')">X</button></div>';
	html += '<div class="like-list-body"><ul>';
	for(var i=0; i<board.dislikeList.length; i++){
		html += '<li>' + board.dislikeList[i].member_id + ' (' + board.dislikeList[i].member_name + ')</li>';
	}					
	html += '</ul></div></div></span>';
	html += '<span class="float-right"><button type="button" class="link-copy-btn" aria-label="링크 복사">';
	html += '<i class="ico ico-linkcopy" aria-hidden="true"><svg width="16px" height="7px" viewBox="0 0 16 7" version="1.1"><g id="linkcopy" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd" transform="translate(8.000000, 3.500000) scale(1, -1) translate(-8.000000, -3.500000)"><path d="M9,1 L12.5,1 C13.8704373,1 15,2.12608684 15,3.5 C15,4.87364425 13.870712,6 12.5,6 L9,6 L9,7 L12.5,7 C14.4224156,7 16,5.42651184 16,3.5 C16,1.573111 14.4220333,0 12.5,0 L9,0 L9,1 Z M7,1 L3.5,1 C2.12956271,1 1,2.12608684 1,3.5 C1,4.87364425 2.12928797,6 3.5,6 L7,6 L7,7 L3.5,7 C1.57758439,7 0,5.42651184 0,3.5 C0,1.573111 1.5779667,0 3.5,0 L7,0 L7,1 Z M5,3 L11,3 L11,4 L5,4 L5,3 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<button type="button" id="" class="board-setting-btn" onclick="$(this).parent().next().toggleClass(\'hide\');">';
	html += '<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>';
	html += '</button></span>';
	html += '<ul class="board-setting-menu hide">';
	if(board.member_seq == memberseq){
		html += '<li><button type="button" onclick="modifyBoardForm(this)">수정하기</button></li>';
		html += '<li><button type="button" onclick="deleteBoard(' + board.seq + ')">삭제하기</button></li>';
	}
	html += '</ul></div>';
	html += '<div class="board-footer-modify message-form__footer hide">';
	html += '<div class="message-form__footer-leftalign">';
	html += '<span class="message-form__attach-file" onclick="$(this).closest(\'.updateBoardForm\').find(\'.board-modify-attach\').click();" style="border: 1px solid #e3e3e3; cursor: pointer; padding: 2px 10px 3px 7px; border-radius: 3px;">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span></span></div>';
	html += '<div class="message-form-submit-control">';
	html += '<button type="button" class="ra-button message-form-submit-control__cancel-button" onclick="cancelModifyBoard(this)">취소</button>';
	html += '<button type="button" id="update-submit" onclick="modifyBoard(this)" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">수정하기</button>';
	html += '</div>';
	html += '<input type="file" onchange="boardModifyAttach(this)" class="board-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">';
	html += '</div></div></form>';
	
	if(board.commentList.length > 0 && board.first_comment_seq < board.commentList[0].seq){
		html += '<div class="prev-comment">';
		html += '<button type="button" onclick="scrollPaging(\'comment\', $(this).closest(\'.wall-board-item\').find(\'.wall-comment-list\'))">이전 댓글 더보기</button>';
		html += '<form action="" class="comment_paging_form">';
		html += '<input type="hidden" name="limit" value="' + board.comment_limit + '" />';
		html += '<input type="hidden" name="offset" value="' + board.comment_offset + '" />';
		html += '<input type="hidden" name="board_seq" value="' + board.seq + '" />';
		html += '<input type="hidden" name="first_comment_seq" value="' + board.first_comment_seq + '" />';
		html += '</form></div>';
	}
	//start comment
	html += '<div class="wall-comment-list">';
	for(var i=0; i<board.commentList.length; i++){
		html += getCommentHtml(board.commentList[i], true);
	}
	html += '</div>';
	//end comment
	
	html += '<form action="/work/comment" class="comment-insert-form" method="post">';
	html += '<input type="hidden" name="board_seq" value="' + board.seq + '">';
	html += '<div class="comment-input">';
	html += '<textarea rows="5" cols="" class="comment-input-textArea" oninput="checkComment(this)" name="content"></textarea>';
	html += '<ul class="comment-insert-attach-list"></ul>';
	html += '<div class="comment-input-footer">';
	html += '<span class="message-form__attach-file" onclick="$(this).siblings(\'.comment-input-attach\').click();">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span>';
	html += '</span><div class="float-right">';
	html += '<button type="button" class="comment-input-btn" disabled="disabled" onclick="insertComment(this)">작성하기</button></div>';
	html += '<input type="file" onchange="commentInsertAttach(this)" class="comment-input-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">';
	html += '</div></div></form>';
	if(coverFlag){
		html += '</div>';
	}
	return html;
}

function getCommentHtml(comment, coverFlag){
	var memberseq = $("#member_seq").val();
	var html = "";
	if(coverFlag){
		html += '<div class="wall-comment">';
	}
	html += '<form action="/work/comment/' + comment.seq + '" class="updateCommentForm" method="post">';
	html += '<div class="comment-header">';
	html += '<div class="comment-header-profile">';
	html += '<span class="avatar" style="width: 36px; height: 36px; background-image: url(&quot;';
	html += (comment.member_profile == '' || comment.member_profile == undefined? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png' : comment.member_profile);
	html += '&quot;);"></span>';
	
	html += '</div>';
	html += '<div class="comment-header-meta">';
	html += '<div class="comment-header-meta-id">' + comment.member_id + ' (' + comment.member_name + ')</div>';
	html += '<div class="comment-header-meta-date">' + comment.regdate + '</div>';
	html += '</div></div>';
	html += '<div class="comment-body">';
	html += '<div class="comment-body-content">' + comment.content + '</div>';
	if(comment.noticeyn == 'N'){
		html += '<br>';
		if(comment.commentFileList.length > 0){
			html += '<div class="comment-body-attach">';
			html += '<div class="comment-body-attach-header">';
			html += '<label class=""><span class="ra-checkbox">';
			html += '<input type="checkbox" value=""><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
			html += '</span> 전체 선택 </label></div>';
			html += '<ul class="attach-list">';
			for(var i=0; i<comment.commentFileList.length; i++){
				html += '<li><span class="ra-checkbox">';
				html += '<input type="checkbox" value="' + comment.commentFileList[i].src + '"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
				html += '</span> <a class="file-name" href="' + comment.commentFileList[i].src + '">' + comment.commentFileList[i].name + ' (' + comment.commentFileList[i].size + ')</a></li>';
			}
			html += '</ul></div>';
		}
		html += '<div class="comment-body-modify hide">';
		html += '<textarea rows="8" cols="" name="content" id="" class="comment-modify-textArea">' + comment.content + '</textarea>';
		html += '<ul class="comment-modify-attach-list">';
		for(var i=0; i<comment.commentFileList.length; i++){
			html += '<li><span class="file-name">' + comment.commentFileList[i].name + ' (' + comment.commentFileList[i].size + ')</span>';
			html += '<span class="file-delete" onclick="addCommentDeleteAttacheFiles(' + comment.commentFileList[i].seq + ', this)"> X </span></li>';
		}
		html += '</ul></div>';
	}
	html += '</div>';
	if(comment.noticeyn == 'N'){
		html += '<div class="comment-footer">';
		html += '<span class="feedback-button feedback-button--like ';
		if(comment.action == 'like'){
			html += 'on';
		}
		html += '">';
		html += '<button type="button" class="icon-button feedback-button__thumb" aria-label="좋아요" onclick="actionCheck(this, \'like\', \'comment\', ' + comment.seq + ', ' + comment.actionLog_seq + ')">';
		html += '<i class="ico ico-like" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="like" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z"></path></g></svg></i>';
		html += '</button> ';
		html += '<span class="ra-popover__trigger" title="" onclick="$(this).siblings(\'.like-list\').removeClass(\'hide\')">';
		html += '<span class="feedback-button__count" role="button" title="이 글을 좋아한 사람">' + comment.likeList.length + '</span>';
		html += '</span>';
		html += '<div class="like-list hide">';
		html += '<div class="like-list-header">';
		html += ' 이 글을 좋아한 사람 ';
		html += '<button type="button" class="like-list-close" onclick="$(this).closest(\'.like-list\').addClass(\'hide\')">X</button>';
		html += '</div>';
		html += '<div class="like-list-body">';
		html += '<ul>';
		for(var i=0; i<comment.likeList.length; i++){
			html += '<li>' + comment.likeList[i].member_id + ' (' + comment.likeList[i].member_name + ')</li>';
		}
		html += '</ul></div></div></span> ';
		
		html += '<span class="feedback-button feedback-button--dislike ';
		if(comment.action == 'dislike'){
			html += 'on';
		}
		html += '">';
		html += '<button type="button" class="icon-button feedback-button__thumb" aria-label="싫어요" onclick="actionCheck(this, \'dislike\', \'comment\', ' + comment.seq + ', ' + comment.actionLog_seq + ')">';
		html += '<i class="ico ico-dislike" aria-hidden="true"><svg width="16px" height="15px" viewBox="0 0 16 15" version="1.1"><g id="dislike" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M4.89196889,6.67062302 C4.72886199,6.34429351 4.38840627,6.1193634 3.99565689,6.1193634 L0.998914224,6.1193634 C0.448013029,6.1193634 0,6.56191512 0,7.1061008 L0,14.0132626 C0,14.5574483 0.448013029,15 0.998914224,15 L3.99565689,15 C4.54373386,15 4.98997488,14.5619742 4.99453584,14.0216239 L4.99734022,14.1183898 C4.99734022,14.1183898 5.50304517,14.3283551 5.77172638,14.4597613 C6.31463626,14.7251936 6.8755266,15 7.49185668,15 L12.2366992,15 C13.2346145,15 13.980304,14.218504 13.980304,13.5198939 C13.980304,13.3852042 13.9658198,13.2623554 13.9423453,13.1513475 C14.5596743,12.9253846 14.9817155,12.4088276 14.9817155,11.7931034 C14.9817155,11.4995491 14.9292725,11.2449708 14.8208903,11.0209814 C15.1984799,10.7575225 15.5810641,10.3268117 15.5810641,9.81962865 C15.5810641,9.54334218 15.4517047,9.21327851 15.2614115,8.98830239 C15.6959392,8.66662599 15.9806298,8.19151194 15.9806298,7.72281167 C15.9806298,6.67440318 15.1500326,6.1193634 13.9847991,6.1193634 L10.6369381,6.1193634 C10.8701846,5.21501857 10.9880565,4.38714589 10.9880565,3.65251989 C10.9880565,0.798381963 10.1734419,0.198938992 9.48968512,0.198938992 C9.01669924,0.198938992 8.69305103,0.247782493 8.23654723,0.514201592 C8.11168295,0.587220159 8.02527687,0.709575597 7.9993051,0.850679045 L7.50733985,3.52276393 C7.06207036,4.70788119 5.0317596,6.56169963 5.0317596,6.56169963 L4.89196889,6.67062302 L4.89196889,6.67062302 L4.89196889,6.67062302 Z M14.1800869,8.7248435 C14.0886862,9.05885411 14.5841477,9.19255703 14.5841477,9.77867905 C14.5841477,10.3953899 13.8304669,10.3879894 13.7270793,10.7062122 C13.6052117,11.0836393 13.97481,11.1867533 13.97481,11.7931034 C13.97481,11.8310928 13.9708143,11.8676021 13.9583279,11.903618 C13.8554397,12.4108011 13.0917698,12.4246154 12.9604126,12.6333103 C12.8200651,12.8568064 12.9803909,12.9959363 12.9803909,13.5198939 C12.9803909,13.8075279 12.652747,14.0132626 12.2366992,14.0132626 L7.49185668,14.0132626 C7.10927253,14.0132626 6.6752443,13.8006207 6.2152443,13.5756446 C5.82267101,13.3837241 5.42010858,13.18687 4.99457112,13.0926366 L4.99457112,7.85404775 C6.23322476,6.91714058 7.83997828,5.52485411 8.46130293,3.81977188 C8.47029316,3.79411671 8.47778502,3.7674748 8.48277959,3.74083289 L8.93828447,1.26412202 C9.08912052,1.20097082 9.2279696,1.18567639 9.48968512,1.18567639 C9.60006515,1.18567639 9.98914224,1.77623873 9.98914224,3.65251989 C9.98914224,4.36987798 9.85978284,5.1987374 9.6040608,6.1193634 L9.48019544,6.1193634 C9.20449511,6.1193634 8.98073833,6.3398992 8.98073833,6.6127321 C8.98073833,6.88556499 9.20449511,7.1061008 9.48019544,7.1061008 L13.9847991,7.1061008 C14.4762649,7.1061008 14.9337676,7.33749072 14.9337676,7.72281167 C14.9337676,8.34741645 14.2624973,8.42142175 14.1800869,8.7248435 L14.1800869,8.7248435 Z M0.998914224,7.1061008 L0.998914224,14.0132626 L3.99415852,14.0132626 L3.99565689,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 L0.998914224,7.1061008 Z" transform="translate(7.990315, 7.599469) rotate(-180.000000) translate(-7.990315, -7.599469)"></path></g></svg></i>';
		html += '</button> ';
		html += '<span class="ra-popover__trigger" title="" onclick="$(this).siblings(\'.like-list\').removeClass(\'hide\')">';
		html += '<span class="feedback-button__count" role="button" title="이 글을 싫어한 사람">' + comment.dislikeList.length + '</span>';
		html += '</span>';
		html += '<div class="like-list hide">';
		html += '<div class="like-list-header">';
		html += ' 이 글을 싫어한 사람 ';
		html += '<button type="button" class="like-list-close" onclick="$(this).closest(\'.like-list\').addClass(\'hide\')">X</button>';
		html += '</div>';
		html += '<div class="like-list-body">';
		html += '<ul>';
		for(var i=0; i<comment.dislikeList.length; i++){
			html += '<li>' + comment.dislikeList[i].member_id + ' (' + comment.dislikeList[i].member_name + ')</li>';
		}
		html += '</ul></div></div></span>';
		if(comment.member_seq == memberseq){
			html += '<span class="float-right">';
			html += '<button type="button" id="" class="comment-setting-btn" onclick="$(this).parent().next().toggleClass(\'hide\');">';
			html += '<i class="ico ico-more_vert" aria-hidden="true"><svg width="13px" height="3px" viewBox="0 0 13 3" version="1.1"><g id="more_vert" stroke="none" stroke-width="1" fill="#7A858D" fill-rule="evenodd"><path d="M1.5,3 C2.32842712,3 3,2.32842712 3,1.5 C3,0.671572875 2.32842712,0 1.5,0 C0.671572875,0 0,0.671572875 0,1.5 C0,2.32842712 0.671572875,3 1.5,3 Z M6.5,3 C7.32842712,3 8,2.32842712 8,1.5 C8,0.671572875 7.32842712,0 6.5,0 C5.67157288,0 5,0.671572875 5,1.5 C5,2.32842712 5.67157288,3 6.5,3 Z M11.5,3 C12.3284271,3 13,2.32842712 13,1.5 C13,0.671572875 12.3284271,0 11.5,0 C10.6715729,0 10,0.671572875 10,1.5 C10,2.32842712 10.6715729,3 11.5,3 Z"></path></g></svg></i>';
			html += '</button></span>';
			html += '<ul class="comment-setting-menu hide">';
			html += '<li><button type="button" onclick="modifyCommentForm(this)">수정하기</button></li>';
			html += '<li><button type="button" onclick="deleteComment(' + comment.seq + ')">삭제하기</button></li></ul>';
		}
		html += '</div>';
		html += '<div class="comment-footer-modify message-form__footer hide">';
		html += '<div class="message-form__footer-leftalign">';
		html += '<span class="message-form__attach-file" onclick="$(this).closest(\'.updateCommentForm\').find(\'.comment-modify-attach\').click();" style="border: 1px solid #e3e3e3; cursor: pointer; padding: 2px 10px 3px 7px; border-radius: 3px;">';
		html += '<button type="button" class="icon-button" aria-label="[object Object]">';
		html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
		html += '</button> ';
		html += '<span class="message-form__attach-file-label">파일첨부</span>';
		html += '</span></div>';
		html += '<div class="message-form-submit-control">';
		html += '<button type="button" class="ra-button message-form-submit-control__cancel-button" onclick="cancelModifyComment(this)">취소</button>';
		html += '<button type="button" id="update-comment-submit" onclick="modifyComment(this)" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">수정하기</button>';
		html += '</div>';
		html += '<input type="file" class="comment-modify-attach hide" multiple="multiple" autocomplete="off" name="attachFiles">';
		html += '</div>';
	}
	
	html += '</form>';
	if(coverFlag){
		html += '</div>';
	}
	return html;
}

function setInsertBoardForm(type){
	obj = $("#insertBoardForm .message-form-group__body");
	var html = "";
	$("#insertBoardForm .message-form-group__tab").removeClass("message-form-group__tab--active");
	
	if(type == 'plain'){
		html = getInsertPlainBoardHtml();
	}
	else if(type == 'schedule'){
		html = getInsertScheduleBoardHtml();
	}
	else if(type == 'request'){
		html = getInsertRequestBoardHtml();	
	}
	else if(type == 'vote'){
		html = getInsertVoteBoardHtml();
	}
	
	$("#insertBoardForm .message-form-group__tab." + type).addClass("message-form-group__tab--active");
	$("#insertBoardForm #type").val(type);
	obj.html(html);
	
	// date time picker
	$("#insertBoardForm input[name='startdate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$("#insertBoardForm input[name='startdate']").datepicker('setDate', 'today');
	
	$("#insertBoardForm input[name='enddate']").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$("#insertBoardForm input[name='enddate']").datepicker('setDate', 'today');
	
	$("#insertBoardForm input[name='starttime']").timepicker({
	});
	
	$("#insertBoardForm input[name='endtime']").timepicker({
	});
}

function getInsertPlainBoardHtml(){
	var html = "";
	html += '<div class="plain-message-form">';
	html += '<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">';
	html += '<div class="message-form__body">';
	html += '<div class="message-form__text-wrap">';
	html += '<div class="react-measure-wrap">';
	html += '<textarea rows="8" cols="" name="content" id="contentTextArea" oninput="checkBoard(this)"></textarea>';
	html += '</div></div>';
	html += '<ul class="board-insert-attach-list" id="board-insert-attach-list"></ul>';
	html += '<div class="message-form__footer">';
	html += '<div class="message-form__footer-leftalign">';
	html += '<span class="message-form__attach-file" onclick="$(\'#attachFiles\').click();">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span></span></div>';
	html += '<div class="message-form-submit-control">';
	html += '<button class="ra-button message-form-submit-control__cancel-button">취소</button> ';
	html += '<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>';
	html += '</div></div></div>';
	html += '<input id="attachFiles" onchange="boardInsertAttach(this)" name="attachFiles" type="file" multiple="multiple" class="hide">';
	html += '</div></div>';
	return html;
}

function getInsertScheduleBoardHtml(){
	var html = "";
	html += '<div class="schedule-message-form">';
	html += '<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">';
	
	html += '<div class="message-form__header">';
	html += '<div class="board-input-date">';
	html += '<div class="input-datetime-container">';
	html += '<input type="text" class="input-startdate" name="startdate" oninput="checkBoard(this)">';
	html += '</div> ';
	html += '<div class="input-datetime-container time">';
	html += '<input type="text" class="input-starttime" name="starttime" placeholder="시작 시간" oninput="checkBoard(this)">';
	html += '</div> ';
	html += ' - ';
	html += ' <div class="input-datetime-container">';
	html += '<input type="text" class="input-enddate" name="enddate" oninput="checkBoard(this)">';
	html += '</div> ';
	html += '<div class="input-datetime-container time">';
	html += '<input type="text" class="input-endtime" name="endtime" placeholder="종료 시간" oninput="checkBoard(this)">';
	html += '</div>';
	html += '<div class="input-date-type">';
	html += '<div>';
	html += '<label class="schedule-form__label">';
	html += '<span class="ra-checkbox">';
	html += '<input type="checkbox" name="allYN" onchange="checkDateType(this)"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
	html += '</span>';
	html += ' 종일 ';
	html += '</label></div></div></div>';
	html += '<div class="board-input-title">';
	html += '<input type="text" maxlength="30" name="title" id="board-insert-title" placeholder="일정 제목 입력" oninput="checkBoard(this)">';
	html += '</div></div>';

	html += '<div class="message-form__body">';
	html += '<div class="message-form__text-wrap">';
	html += '<div class="react-measure-wrap">';
	html += '<textarea rows="8" cols="" name="content" id="contentTextArea" oninput="checkBoard(this)"></textarea>';
	html += '</div></div>';
	html += '<ul class="board-insert-attach-list" id="board-insert-attach-list"></ul>';
	html += '<div class="message-form__footer">';
	html += '<div class="message-form__footer-leftalign">';
	html += '<span class="message-form__attach-file" onclick="$(\'#attachFiles\').click();">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span></span></div>';
	html += '<div class="message-form-submit-control">';
	html += '<button class="ra-button message-form-submit-control__cancel-button">취소</button> ';
	html += '<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>';
	html += '</div></div></div>';
	html += '<input id="attachFiles" onchange="boardInsertAttach(this)" name="attachFiles" type="file" multiple="multiple" class="hide">';
	html += '</div></div>';
	return html;
}

function getInsertRequestBoardHtml(){
	var html = "";
	html += '<div class="request-message-form">';
	html += '<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">';
	html += '<div class="message-form__header">';
		html += '<div class="board-input-title">';
	html += '<input type="text" maxlength="30" name="input-worker" id="board-insert-worker" oninput="checkWorker(this)" placeholder="담당자 ID 입력">';
	html += '</div>';
	html += '<div class="mention-list hide">';
	html += '<ul></ul>';
					
	html += ' </div>';
	html += '<div class="board-insert-status">';
	html += '<span><label>요청</label></span>';
	html += '</div></div>';
	html += '<div class="message-form__body">';
	html += '<div class="message-form__text-wrap">';
	html += '<div class="react-measure-wrap">';
	html += '<textarea rows="8" cols="" name="content" id="contentTextArea" oninput="checkBoard(this)"></textarea>';
	html += '</div></div>';
				
	html += '<ul class="board-insert-attach-list" id="board-insert-attach-list">';
	html += '</ul>';
	html += '<div class="message-form__footer">';
	html += '<div class="message-form__footer-leftalign">';
	html += '<span class="message-form__attach-file" onclick="$(\'#attachFiles\').click();">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span>';
	html += '</span></div>';
				
	html += '<div class="message-form-submit-control">';
	html += '<button class="ra-button message-form-submit-control__cancel-button">취소</button>';
	html += '<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>';
	html += '</div></div></div>';
	
	html += '<input id="attachFiles" onchange="boardInsertAttach(this)" name="attachFiles" type="file" multiple="multiple" class="hide">';
	html += '<input type="hidden" name="status" value="request" />';
	html += '<input type="hidden" name="worker" id="worker">';
	html += '</div></div>';

	return html;
}

function getInsertVoteBoardHtml(){
	var html = "";
	html += '<div class="vote-message-form">';
	html += '<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">';
	html += '<div class="message-form__header">';
	html += '<div class="board-input-title">';
	html += '<input type="text" maxlength="30" name="title" id="board-insert-title" oninput="checkBoard(this)" placeholder="투표 제목 입력">';
	html += '</div>';
	html += '<div class="vote-list">';
	html += '<div class="board-input-vote">';
	html += '<span class="poll-message-form__form-poll-item-seq"><i class="ico ico-check_circle" aria-hidden="true"><svg width="18" height="18" viewBox="0 0 18 18"><path fill="#E0E0E0" fill-rule="evenodd" d="M7.183 13.522l8.113-8.113-1.277-1.32-6.836 6.858L3.98 7.724 2.704 9l4.479 4.522zM9 0c1.644 0 3.166.411 4.565 1.233a8.53 8.53 0 0 1 3.202 3.202A8.851 8.851 0 0 1 18 9a8.851 8.851 0 0 1-1.233 4.565 8.53 8.53 0 0 1-3.202 3.202A8.851 8.851 0 0 1 9 18a8.851 8.851 0 0 1-4.565-1.233 8.691 8.691 0 0 1-3.202-3.224A8.812 8.812 0 0 1 0 9c0-1.63.411-3.144 1.233-4.543a8.858 8.858 0 0 1 3.224-3.224A8.812 8.812 0 0 1 9 0z"></path></svg></i></span>';
	html += '<input type="text" class="board-insert-vote" oninput="checkBoard(this)" name="vote" placeholder="선택 사항 입력">';
	html += '</div>';
	html += '<div class="board-input-vote">';
	html += '<span class="poll-message-form__form-poll-item-seq"><i class="ico ico-check_circle" aria-hidden="true"><svg width="18" height="18" viewBox="0 0 18 18"><path fill="#E0E0E0" fill-rule="evenodd" d="M7.183 13.522l8.113-8.113-1.277-1.32-6.836 6.858L3.98 7.724 2.704 9l4.479 4.522zM9 0c1.644 0 3.166.411 4.565 1.233a8.53 8.53 0 0 1 3.202 3.202A8.851 8.851 0 0 1 18 9a8.851 8.851 0 0 1-1.233 4.565 8.53 8.53 0 0 1-3.202 3.202A8.851 8.851 0 0 1 9 18a8.851 8.851 0 0 1-4.565-1.233 8.691 8.691 0 0 1-3.202-3.224A8.812 8.812 0 0 1 0 9c0-1.63.411-3.144 1.233-4.543a8.858 8.858 0 0 1 3.224-3.224A8.812 8.812 0 0 1 9 0z"></path></svg></i></span>';
	html += '<input type="text" class="board-insert-vote" oninput="checkBoard(this)" name="vote" placeholder="선택 사항 입력">';
	html += '</div>';
	html += '</div>';
	
	html += '<a class="board-add-vote-btn" onclick="addInputVote(this)">+ 선택 항목 추가</a>';
	html += '</div>';
	html += '<div class="message-form__body">';
	html += '<div class="message-form__text-wrap">';
	html += '<div class="react-measure-wrap">';
	html += '<textarea rows="8" cols="" name="content" id="contentTextArea" oninput="checkBoard(this)"></textarea>';
	html += '</div></div>';
				
	html += '<ul class="board-insert-attach-list" id="board-insert-attach-list">';
	html += '</ul>';
	html += '<div class="message-form__footer">';
	html += '<div class="message-form__footer-leftalign">';
	html += '<span class="message-form__attach-file" onclick="$(\'#attachFiles\').click();">';
	html += '<button type="button" class="icon-button" aria-label="[object Object]">';
	html += '<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>';
	html += '</button> ';
	html += '<span class="message-form__attach-file-label">파일첨부</span>';
	html += '</span></div>';
				
	html += '<div class="message-form-submit-control">';
	html += '<button class="ra-button message-form-submit-control__cancel-button">취소</button>';
	html += '<button type="button" id="insert-submit" onclick="insertBoard()" disabled class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>';
	html += '</div></div></div>';
	
	html += '<input id="attachFiles" onchange="boardInsertAttach(this)" name="attachFiles" type="file" multiple="multiple" class="hide">';
	html += '<input type="hidden" name="status" value="request" />';
	html += '</div></div>';

	return html;
}

function addRequestBoardWorker(member_seq, member_id, obj){
	var form = $(obj).closest('form');
	var worker_value = form.find("input[name='worker']").val();
	if(worker_value.indexOf(member_id) > -1){
		alert('이미 존재하는 담당자입니다.');
		form.find("input[name='input-worker']").val('');
		return;
	}
	var html = "";
	html += '<div class="worker-label"> ';
	html += '<span class="worker-label-id">' + member_id+ '</span> ';
	html += '<span class="worker-label-cancel" onclick="removeRequestBoardWorker(this, \''+ member_id +'\')">X</span> ';
	html += '</div> ';
	
	form.find(".request-message-form .board-input-title").prepend(html);
	
	form.find("input[name='worker']").val(worker_value + (worker_value==''?'':',') + member_id);
	
	form.find("input[name='input-worker']").val('');
	form.find(".request-message-form .mention-list").addClass("hide");
	
}

function removeRequestBoardWorker(obj, member_id){
	$(obj).closest('.worker-label').remove();
	var worker_value = $("#insertBoardForm #worker").val();
	worker_value = replaceAll(worker_value, member_id, '');
	
	//remove coma
	if(worker_value.substring(0,1) == ','){
		worker_value = worker_value.substring(1);
	}
	
	if(worker_value.substring(worker_value.length - 1) == ','){
		worker_value = worker_value.substring(0, worker_value.length - 1);
	}
	
	$("#insertBoardForm #worker").val(worker_value);
	
}

function getRequestWorkerList(str){
	var html = "";
	$("#worker_list li[class^='" + str + "']").each(function(index, item){
		html += $(item).prop("outerHTML");
	});
	return html;
}

function checkWorker(obj){
	var worker = $.trim($(obj).val());
	var form = $(obj).closest('form');
	if(worker != ''){
		var html = getRequestWorkerList(worker);
		if(html.length > 0){
			form.find(".request-message-form .mention-list ul").html(html);
			form.find(".request-message-form .mention-list").removeClass("hide");
		}
	}
	
	//visible mention list
	if(form.find(".request-message-form .mention-list li").not(".hide").length == 0){
		form.find(".request-message-form .mention-list").hide();
	} else {
		form.find(".request-message-form .mention-list").show();
	}
}

function updateBoardStatus(board_seq, status, obj){
	if(confirm($(obj).html() + " 상태로 바꾸시겠습니까?")){
		showLoading();
		
		var data = new FormData();
		data.append("seq", board_seq);
		data.append("status", status);
		
		$.ajax({
			url : '/work/board/' + board_seq,
			method : 'PUT',
			enctype: 'multipart/form-data',
			data : data,
			processData: false,
			contentType : false,
			dataType : 'JSON',
			success : function(res) {
				reloadBoard(board_seq, $(obj).closest(".wall-board-item"), false);
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	}
}

function checkRequestBoard(obj){
	var check = checkBoardValue(obj);
	if(check){
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", false);
	} else {
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", true);
	}
}

function checkBoard(obj){
	var check = checkBoardValue(obj);
	if(check){
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", false);
	} else {
		$(obj).closest('form').find(".message-form-submit-control__submit-button").attr("disabled", true);
	}
}

function checkDateType(obj){
	var form = $(obj).closest("form");
	if($(obj).is(":checked")){
		form.find("div.time input[name='starttime']").val("");
		form.find("div.time input[name='endtime']").val("");
		form.find("div.time").addClass("hide");
	} else {
		form.find("div.time").removeClass("hide");
	}
	
}

function toggleGroupDesc(obj){
	if($(obj).html() == '설명 접기'){
		$(obj).siblings('pre.group-header__desc').hide();
		$(obj).html("설명 보기");
	} else {
		$(obj).siblings('pre.group-header__desc').show();
		$(obj).html("설명 접기");
	}
	
}

function checkComment(obj){
	var form = $(obj).closest("form");
	if($.trim(form.find(".comment-input-textArea").val()).length > 0){
		form.find(".comment-input-btn").attr("disabled", false);
	} else {
		form.find(".comment-input-btn").attr("disabled", true);
	}
}

function addInputVote(obj){
	var form = $(obj).closest("form");
	var list = form.find(".vote-list");
	var html = "";
	
	html += '<div class="board-input-vote">';
	html += '<span class="poll-message-form__form-poll-item-seq"><i class="ico ico-check_circle" aria-hidden="true"><svg width="18" height="18" viewBox="0 0 18 18"><path fill="#E0E0E0" fill-rule="evenodd" d="M7.183 13.522l8.113-8.113-1.277-1.32-6.836 6.858L3.98 7.724 2.704 9l4.479 4.522zM9 0c1.644 0 3.166.411 4.565 1.233a8.53 8.53 0 0 1 3.202 3.202A8.851 8.851 0 0 1 18 9a8.851 8.851 0 0 1-1.233 4.565 8.53 8.53 0 0 1-3.202 3.202A8.851 8.851 0 0 1 9 18a8.851 8.851 0 0 1-4.565-1.233 8.691 8.691 0 0 1-3.202-3.224A8.812 8.812 0 0 1 0 9c0-1.63.411-3.144 1.233-4.543a8.858 8.858 0 0 1 3.224-3.224A8.812 8.812 0 0 1 9 0z"></path></svg></i></span>';
	html += ' <input type="text" class="board-insert-vote" oninput="checkBoard(this)" name="vote" placeholder="선택 사항 입력"></div>';

	list.append(html);
}

function voteCheck(vote_seq, board_seq, obj){
	if($(obj).closest(".vote-info-body-item").hasClass("on")){
		deleteVoteMember(vote_seq, board_seq, obj);
	} else {
		insertVoteMember(vote_seq, board_seq, obj);
	}
}

function insertVoteMember(vote_seq, board_seq, obj){
	showLoading();
	$.ajax({
		url : '/work/vote',
		method : 'POST',
		data : {vote_seq : vote_seq, board_seq : board_seq},
		dataType : 'JSON',
		success : function(res) {
			if(res.res == 1){
				reloadBoard(board_seq, $(obj).closest(".wall-board-item"), false);
			} else {
				alert(res.msg)
			}
			hideLoading();
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			hideLoading();
		}
	})
}

function deleteVoteMember(vote_seq, board_seq, obj){
	showLoading();
	$.ajax({
		url : '/work/vote/' + vote_seq,
		method : 'DELETE',
		dataType : 'JSON',
		success : function(res) {
			if(res.res == 1){
				reloadBoard(board_seq, $(obj).closest(".wall-board-item"), false);
			} else {
				alert(res.msg)
			}
			hideLoading();
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			hideLoading();
		}
	})
}

function deadLineVote(board_seq, obj){
	if(confirm("투표를 마감 하시겠습니까?")){
		showLoading();
		
		var data = new FormData();
		data.append("seq", board_seq);
		data.append("status", "complete");
		
		$.ajax({
			url : '/work/board/' + board_seq,
			method : 'PUT',
			enctype: 'multipart/form-data',
			data : data,
			processData: false,
			contentType : false,
			dataType : 'JSON',
			success : function(res) {
				if(res.res == 1){
					reloadBoard(board_seq, $(obj).closest(".wall-board-item"), false);
				}
				else {
					alert((res.msg == ''? '업데이트 에러' : res.msg));
				}
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	}
}
