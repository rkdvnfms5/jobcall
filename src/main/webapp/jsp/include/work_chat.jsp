<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="work-basic-layout-chat" id="chat-list-layer">
	<div class="chatbar">
		<div class="chat-list">
			<div class="chat-list-title">
				대화 목록
			</div>
			<div class="chat-list-content">
				<ul class="chat-list-content-ul">
					<c:forEach items="${WorkChatList}" var="chat">
						<li ondblclick="openChatView(${chat.chat_seq},'${fn:split(chat.title, ' ')[0]}')">
							<input type="hidden" name="chat_seq" value="${chat.chat_seq}">
							<div class="chat-profile" >
								<span class="avatar" style="width: 36px; height: 36px; background-image:
								 url('${empty chat.target_profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':chat.target_profile}');"></span>
							</div>
							<div class="chat-meta">
								<div class="chat-member">${chat.title}</div>
								<div class="chat-last-msg">${not empty chat.last_src? '파일':chat.last_msg}</div>
								<c:if test="${chat.no_confirm_count gt 0}">
									<div class="no-confirm-count">${chat.no_confirm_count}</div>
								</c:if>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="chat-list-add">
				<div class="add-list-area">
					<ul class="add-list">
					</ul>
				</div>
				<div class="search-input">
					<div class="search-field">
						<input type="text" id="search-chat-member" name="" class="search-chat" title="검색어 입력" placeholder="이름 또는 아지트 아이디 검색" accesskey="s" autocomplete="off" value="">
						<button class="search-chat-btn" onclick="searchChatMember()"><i class="ico ico-search" aria-hidden="true"><svg width="15px" height="14px" viewBox="0 0 15 14" version="1.1"><g id="search" stroke="none" stroke-width="1" fill="#565A5F" fill-rule="evenodd"><path d="M9.9603736,10.3329493 C8.91643607,11.0870077 7.60676898,11.5357143 6.18487913,11.5357143 C2.77379116,11.5357143 0.00855799453,8.95335668 0.00855799453,5.76785714 C0.00855799453,2.5823576 2.77379116,0 6.18487913,0 C9.5959671,0 12.3612003,2.5823576 12.3612003,5.76785714 C12.3612003,7.09571193 11.8807175,8.31876567 11.0732587,9.29366358 L15,12.9607143 L13.8871149,14 L9.9603736,10.3329493 Z M6.18487913,10.3214286 C8.87784331,10.3214286 11.0609221,8.2827252 11.0609221,5.76785714 C11.0609221,3.25298909 8.87784331,1.21428571 6.18487913,1.21428571 C3.49191494,1.21428571 1.30883613,3.25298909 1.30883613,5.76785714 C1.30883613,8.2827252 3.49191494,10.3214286 6.18487913,10.3214286 Z"></path></g></svg></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="work-basic-layout-chat" id="chat-view-layer" style="display: none;">
	<div class="chatbar">
		<div class="chat-view">
			<div class="chat-view-header">
				<button class="prev-btn" onclick="closeChatView()">&lt;</button> 
				<span class="chat-view-header-title"></span>
			</div>
			<div class="chat-view-content">
			</div>
			<div class="chat-view-footer">
				<div class="chat-input-area">
					<input type="text" name="chat_text" id="chat-input-text" class="chat-input-text" placeholder="메시지를 입력하세요" autocomplete="off">
					<button type="button" class="chat-send-btn" onclick="sendMsg()">전송</button>
				</div>
				<div class="chat-input-options">
					<button type="button" class="attach-btn" onclick="$('#file_upload_form input[name=file]').click();">
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="chat_view_form">
	<input type="hidden" name="chat_seq" value="0">
	<input type="hidden" name="limit" value="0">
	<input type="hidden" name="offset" value="0">
</form>
<form id="file_upload_form" action="" enctype="multipart/form-data">
	<input type="file" class="hide" name="file" onchange="uploadFile(this.files[0])">
</form>

<div class="work-basic-layout-chat" id="chat-loading-dim" style="display: none;">
	<div class="loading" style="left: 90%;"></div>
</div>

<script type="text/javascript" src="/scripts/libs/sockjs.min.js"></script>
<script type="text/javascript" src="/scripts/libs/stomp.min.js"></script>
<script>
var socket = null;
var stompClient = null;

var pagingFlag = true;
var week = ['일', '월', '화', '수', '목', '금', '토'];

var scroll_date;

$(document).ready(function(){
	connect();
	setChatViewInfo();
	setChatNotifies();
})

function connect() {
	socket = new SockJS('/jc');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame){
		$(".chat-list-content-ul li").each(function(index, item){
			var chat_seq = $(item).find("input[name='chat_seq']").val();
			stompClient.subscribe('/topic/send/' + chat_seq, function(msg){
				receiveMsg(JSON.parse(msg.body));
			}, {id : "chat"+chat_seq});
		})
		
		stompClient.subscribe('/topic/start/${member.seq}', function(msg){
			var res = JSON.parse(msg.body);
			//구독 추가
			stompClient.unsubscribe("chat"+res.chat_seq);
			stompClient.subscribe('/topic/send/' + res.chat_seq, function(msg){
				receiveMsg(JSON.parse(msg.body));
			}, {id : "chat"+res.chat_seq});
		});
	});
	
}

$("#search-chat-member").on("keyup", function(e){
	if(e.keyCode==13) {
		searchChatMember();
    }
})

$("#chat-input-text").on("keyup", function(e){
	if(e.keyCode==13) {
		sendMsg();
    }
})

//드래그 엔 드롭 업로드
$(".chat-view-content").on('dragleave dragover dragenter', function(e){
	e.stopPropagation();
	e.preventDefault();
})

$(".chat-view-content").on('dragdrop drop', function(e){
	e.stopPropagation();
	e.preventDefault();
	var files = e.originalEvent.dataTransfer.files;
	uploadFile(files[0]);
})

//스크롤 페이징
$(".chat-view-content").scroll(function(){
	var current_scroll = $(this).scrollTop();
	if(current_scroll == 0 && pagingFlag == true){
		chatScrollPaging();
	}
});

function chatScrollPaging(){
	var chat_seq = $("#chat_view_form input[name='chat_seq']").val();
	var limit = $("#chat_view_form input[name='limit']").val();
	var offset = $("#chat_view_form input[name='offset']").val();
	
	showChatLoading();
	
	$.ajax({
		url : '/chat/logs',
		method : 'GET',
		data : {chat_seq : chat_seq, limit : limit, offset : offset},
		dataType : 'JSON',
		success : function(res) {
			if(res.list.length > 0){
				var html = "";
				for(var i=res.list.length-1; i>-1; i--){
					html += getMsgHtml(res.list[i])+"";
					
				}
				//스크롤 유지
				var first_object = $(".chat-view-content").children().first();
				var before_scroll = first_object.offset().top;
				
				//채팅 내용 붙이기
				$(".chat-view-content").prepend(html);
				
				//스크롤 유지
				var after_scroll = first_object.offset().top;
				$('.chat-view-content').scrollTop(after_scroll-before_scroll);
				
				//페이징 파라미터 설정
				$("#chat_view_form input[name='limit']").val(res.WorkChatLog.limit);
				var temp_offset = (res.list.length < res.WorkChatLog.limit? res.WorkChatLog.offset + res.list.length : res.WorkChatLog.offset + res.WorkChatLog.limit)
				$("#chat_view_form input[name='offset']").val(temp_offset);
			} else {
				pagingFlag = false;
			}
			hideChatLoading();
		},
		error : function(error){
			hideChatLoading();
		}
	})
}

function closeChatView(){
	$("#chat-view-layer").hide();
	$("#chat_view_form input[name='chat_seq']").val(0);
	$("#chat_view_form input[name='limit']").val(0);
	$("#chat_view_form input[name='offset']").val(0);
	$(".chat-view-content").empty();
	pagingFlag = true;
	scroll_date = null;
	sessionStorage.removeItem("chat_view_info");
}

function searchChatMember(){
	var search = $("#search-chat-member").val();
	
	showChatLoading();
	
	if(search.length > 0){
		$.ajax({
			url : '/chat/search',
			method : 'GET',
			data : {search : search},
			dataType : 'JSON',
			success : function(res){
				if(res.list.length > 0){
					var html = '';
					for(var i=0; i<res.list.length; i++){
						html += '<li ondblclick="startChat('+ res.list[i].seq +', \''+ res.list[i].id +'\')"> ' + res.list[i].id + ' (' + res.list[i].name + ') </li>';
					}
					$(".add-list").html(html);
				}
				hideChatLoading();
			},
			error : function(error){
				hideChatLoading();
			}
		})
	}
	
}

function startChat(member_seq, title){
	var my_member_seq = '${member.seq}';
	var work_seq = '${WorkInfo.seq}';
	var data = JSON.stringify({'target_member_seq' : member_seq, 'member_seq' : my_member_seq, 'work_seq' : work_seq});
	stompClient.send("/chat/start/"+member_seq, {}, data);
	$.ajax({
		url : '/chat/one',
		method : 'GET',
		data : {target_member_seq : member_seq, member_seq : my_member_seq},
		dataType : 'JSON',
		success : function(res) {
			if(res.WorkChat.seq > 0){
				//구독 추가
				stompClient.unsubscribe("chat"+res.WorkChat.seq);
				stompClient.subscribe('/topic/send/' + res.WorkChat.seq, function(msg){
					receiveMsg(JSON.parse(msg.body));
				}, {id : "chat"+res.WorkChat.seq});
				
				openChatView(res.WorkChat.seq, title);
			}
		}
	})
	
}

function openChatView(chat_seq, title){
	//저장된 메세지 개수가 있으면 
	
	if(sessionStorage.chat_view_info != null){
		var data = {chat_seq : chat_seq, limit : JSON.parse(sessionStorage.chat_view_info).limit};
	} else {
		var data = {chat_seq : chat_seq};
	}
	
	//var data = {chat_seq : chat_seq};
	$.ajax({
		url : '/chat/logs',
		method : 'GET',
		data : data,
		dataType : 'JSON',
		success : function(res) {
			var member_seq = '${member.seq}';
			
			//채팅방 제목 설정
			$(".chat-view .chat-view-header-title").html(title.split(" ")[0] + "님과 대화");
			
			//채팅창 보이기
			$("#chat-view-layer").show();
			$("#chat_view_form input[name='chat_seq']").val(chat_seq);
			
			if(res.list.length > 0){
				var html = "";
				for(var i=res.list.length-1; i>-1; i--){
					html += getMsgHtml(res.list[i])+"";
					
				}
				//채팅 내용 붙이기
				$(".chat-view-content").empty();
				$(".chat-view-content").append(html);
				
				//채팅내용 스크롤 맨 아래로
				$('.chat-view-content').scrollTop($('.chat-view-content').prop('scrollHeight'));
				
				//반짝이던 채팅방이면 반짝임, 안 읽은 메세지 수 삭제
				var target_li = $(".chat-list-content-ul input[value="+chat_seq+"]").closest("li");
				target_li.removeClass("notify");
				target_li.find(".no-confirm-count").remove();
				saveChatNotifies();
				
				//페이징 파라미터 설정
				$("#chat_view_form input[name='limit']").val(res.WorkChatLog.limit);
				var temp_offset = (res.list.length < res.WorkChatLog.limit? res.WorkChatLog.offset + res.list.length : res.WorkChatLog.offset + res.WorkChatLog.limit);
				$("#chat_view_form input[name='offset']").val(temp_offset);
				
				//스크롤시 노출 날짜 설정
				scroll_date = getScrollDateForm(res.list[res.list.length-1].regdate);
			} else {
				pagingFlag = false;
			}
			
			//update confirmyn Y
			updateChatLog(chat_seq, 0, Number(member_seq));
			
			//save chat_view_info
			saveChatViewInfo();
		}
	})
}

function receiveMsg(msg) {
	
	var current_chat_seq = $("#chat_view_form input[name='chat_seq']").val();
	if(msg.chat_seq == current_chat_seq){ //받은 메세지의 채팅창이 열려있을 경우
		//그날 첫 메세지 확인
		/*
		if($(".chat-view-content .chat-date-block." + msg.regdate.split(" ")[0]).length == 0) {
			msg.firstyn = 'Y';
		}
		*/
		var msgHtml = getMsgHtml(msg);
		$(".chat-view-content").append(msgHtml);
		$('.chat-view-content').scrollTop($('.chat-view-content').prop('scrollHeight'));
		
		var target_li = $(".chat-list-content-ul input[value="+msg.chat_seq+"]").closest("li");
		var last_msg = (msg.src == null || msg.src == undefined? msg.message:'파일');
		target_li.find(".chat-last-msg").html(last_msg);
		var tempHtml = target_li.prop("outerHTML");
		target_li.remove();
		$(".chat-list-content-ul").prepend(tempHtml);
		
		//update confirm Y
		updateChatLog(msg.chat_seq, msg.seq, Number('${member.seq}'));
		
		//update chat view info
		saveChatViewInfo();
	}
	else { //그렇지 않은 경우
		var target_li = $(".chat-list-content-ul input[value="+msg.chat_seq+"]").closest("li");
		if(target_li.length > 0){	//채팅방 목록에 방이 있으면
			
			target_li.addClass("notify");
			var last_msg = (msg.src == null || msg.src == undefined? msg.message:'파일');
			target_li.find(".chat-last-msg").html(last_msg);
			
			//안읽은 숫자 ++
			if(target_li.find(".no-confirm-count").length > 0){
				var no_count = Number(target_li.find(".no-confirm-count").html());
				target_li.find(".no-confirm-count").html((no_count+1));
			} else {
				var no_count_html = '<div class="no-confirm-count">1</div>';
				target_li.find(".chat-meta").append(no_count_html);
			}
			
			var tempHtml = target_li.prop("outerHTML");
			target_li.remove();
			$(".chat-list-content-ul").prepend(tempHtml);
			
			
		} else {	//채팅방 목록에 방이 없으면
			$.ajax({
				url : '/chat/members',
				method : 'GET',
				data : {chat_seq : msg.chat_seq},
				dataType : 'JSON',
				success : function(res) {
					if(res.list.length > 0){
						var html = getChatListHtml(res.list[0], "notify") + "";
						$(".chat-list-content-ul").prepend(html);
					}
				}
			})
		}
		saveChatNotifies();
	}
}

function getMsgHtml(chatMsg) {
	var member_seq = '${member.seq}';
	var html = "";
	if(chatMsg.firstyn == "Y"){
		html += '<div class="chat-date-block ' + chatMsg.regdate.split(' ')[0] + '"><div class="chat-date-frame"> ';
		html += getNewDateStr(chatMsg.regdate);
		html += ' </div></div>';
	}
	if(chatMsg.member_seq == member_seq){
		html += '<div class="chat-msg-block me"><div class="chat-msg-frame">';
		html += '<span class="msg-meta"> ' + getMsgDateForm(chatMsg.regdate) + ' </span>';
		html += '<div class="text-msg"> ' + chatMsg.message + ' </div></div></div>';
	} else {
		html += '<div class="chat-msg-block"><div class="chat-msg-frame">';
		html += '<div class="text-msg"> ' + chatMsg.message + ' </div>';
		html += '<span class="msg-meta"> ' + getMsgDateForm(chatMsg.regdate) + ' </span></div></div>';
	}
	
	return html;
}

function sendMsg(){
	var chat_seq = $("#chat_view_form input[name='chat_seq']").val();
	var member_seq = '${member.seq}';
	var msg = $("#chat-input-text").val();
	if(msg != ''){
		var data = JSON.stringify({'chat_seq' : chat_seq, 'member_seq' : member_seq, 'message' : msg});
		stompClient.send("/chat/send/"+chat_seq, {}, data);
	}
	$("#chat-input-text").val("");
}

function getChatListHtml(chatMember, classStr){
	var url = 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png';
	if(chatMember.target_profile.length > 0){
		url = chatMember.target_profile;
	}
	var last_msg = (chatMember.last_src.length > 0? '파일':chatMember.last_msg);
	var html = "";
	html += '<li class="'+classStr+'" ondblclick="openChatView(' + chatMember.chat_seq + ',\'' + chatMember.title.split(' ')[0] + '\')">';
	html += '<input type="hidden" name="chat_seq" value="' + chatMember.chat_seq + '">';
	html += '<div class="chat-profile" >';
	html += '<span class="avatar" style="width: 36px; height: 36px; background-image: url(\'' + url + '\');"></span></div>';
	
	html += '<div class="chat-meta">';
	html += '<div class="chat-member">' + chatMember.title + '</div>';
	html += '<div class="chat-last-msg">' + last_msg + '</div>';
	if(chatMember.no_confirm_count > 0){
		html += '<div class="no-confirm-count">' + chatMember.no_confirm_count + '</div>';
	}
	html += '</div></li>';

	return html;
}

function uploadFile(file){
	if(file.name.indexOf('.') == -1){
		alert("올바르지 않은 파일 형식입니다.");
		return;
	}
	
	var data = new FormData();
	data.append("file", file);
	
	$.ajax({
		url : '/chat/upload',
		type : 'POST',
		enctype: 'multipart/form-data',
		data : data,
		processData: false,
		contentType : false,
		dataType : 'JSON',
		success : function(res){
			if(res.res == 1){
				var src = res.src;
				var file_name = res.file_name;
				var object_name = res.object_name;
				var ext = file_name.substring(file_name.lastIndexOf('.') + 1);
				var icon_name = getIconName(ext);
				//console.log(res);
				
				var chat_seq = $("#chat_view_form input[name='chat_seq']").val();
				var member_seq = '${member.seq}';
				var msg = "";
				
				if(icon_name == 'image'){
					msg += '<a href="/work/file_down?object_name=' + object_name + '" target="_blank">';
					msg += '<img alt="" src="' + src + '"></a>';
				} else {
					msg += '<a href="/work/file_down?object_name=' + object_name + '" target="_blank">';
					msg += '<img class="file_icon" src="/images/icon_' + icon_name + '.png"> ' + file_name;
					msg += '</a>';
				}
				
				
				var data = JSON.stringify({'chat_seq' : chat_seq, 'member_seq' : member_seq, 'message' : msg
					, 'src' : src, 'file_name' : file_name, 'object_name' : object_name});
				stompClient.send("/chat/send/"+chat_seq, {}, data);
			}
		},
		error : function(request, status, error){
			alert("파일 업로드를 실패했습니다.");
		} 
	})
}

function getMsgDateForm(regdate){
	var date = new Date(regdate);
	var ampm = (date.getHours() >= 12? 'PM':'AM');
	var hour = (date.getHours() > 12? date.getHours()-12:date.getHours());
	return hour + ":" + (date.getMinutes() < 10? "0"+date.getMinutes():date.getMinutes()) + " " + ampm;
}

function getNewDateStr(regdate){
	regdate = regdate.split(" ")[0];
	var regdateArr = regdate.split("-");
	var date = new Date(regdate);
	var dayofweek = week[date.getDay()];
	return regdateArr[0] + "년 " + regdateArr[1] + "월 " + regdateArr[2] + "일 " + dayofweek + "요일";
}

function getScrollDateForm(regdate){
	regdate = regdate.split(" ")[0];
	var regdateArr = regdate.split("-");
	var date = new Date(regdate);
	var dayofweek = week[date.getDay()];
	return regdateArr[1] + ". " + regdateArr[2] + ". " + dayofweek;
}

function updateChatLog(chat_seq, log_seq, member_seq){
	$.ajax({
		url : '/chat/log',
		method : 'PUT',
		data : {seq : log_seq, chat_seq : chat_seq, member_seq : member_seq},
		dataType : 'JSON',
		success : function(res){
			
		}
	})
}

function saveChatViewInfo(){
	var sessionData = 
	{
		chat_seq : $("#chat_view_form input[name='chat_seq']").val(),
		limit : $(".chat-view-content div.chat-msg-block").length
	};
	sessionStorage.setItem("chat_view_info", JSON.stringify(sessionData));
}

function setChatViewInfo(){
	if(sessionStorage.chat_view_info != null){
		var data = JSON.parse(sessionStorage.chat_view_info);
		$(".chat-list-content ul input[value="+data.chat_seq+"]").closest("li").dblclick();
	}
}

function saveChatNotifies(){
	//기존 정보 삭제
	if(sessionStorage.chat_notifies != null){
		sessionStorage.removeItem("chat_notifies");
	}
	
	var notifies = new Array();
	$(".chat-list-content-ul li.notify").each(function(index, item){
		notifies.push($(item).find("input[name='chat_seq']").val());
	})
	
	var sessionData = 
	{
		notifies : notifies
	};
	sessionStorage.setItem("chat_notifies", JSON.stringify(sessionData));
}

function setChatNotifies(){
	if(sessionStorage.chat_notifies != null){
		var notifies = JSON.parse(sessionStorage.chat_notifies).notifies;
		for(var i=0; i<notifies.length; i++){
			$(".chat-list-content-ul li input[value="+ notifies[i] +"]").closest("li").addClass("notify");
		}
	}
}

</script>
