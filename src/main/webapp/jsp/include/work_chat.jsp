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
						<li>
							<input type="hidden" name="chat_seq" value="${chat.chat_seq}">
							<div class="chat-profile" >
								<span class="avatar" style="width: 36px; height: 36px; background-image:
								 url('${empty chat.target_profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile.png':chat.target_profile}');"></span>
							</div>
							<div class="chat-meta">
								<div class="chat-member">${chat.title}</div>
								<div class="chat-last-msg">${chat.last_msg}</div>
							</div>
						</li>
					</c:forEach>
					<!-- <li>
						<div class="chat-profile" >
							<span class="avatar" style="width: 36px; height: 36px; background-image:
							 url('https://t1.daumcdn.net/agit_resources/images/empty_profile.png');"></span>
						</div>
						<div class="chat-meta">
							<div class="chat-member">rkdvnfms5 (강푸른) 부서부서</div>
							<div class="chat-last-msg">마지막 메세지</div>
						</div>
					</li>
					<li>
						<div class="chat-profile" >
							<span class="avatar" style="width: 36px; height: 36px; background-image:
							 url('https://t1.daumcdn.net/agit_resources/images/empty_profile.png');"></span>
						</div>
						<div class="chat-meta">
							<div class="chat-member">rkdvnfms5 (강푸른) 부서부서</div>
							<div class="chat-last-msg new">마지막 메세지</div>
						</div>
					</li> -->
				</ul>
			</div>
			<div class="chat-list-add">
				<div class="add-list-area">
					<ul class="add-list">
						<!-- <li>
							rkdvnfms5 (강푸른)
						</li>
						<li>
							rkdvnfms5 (강푸른)
						</li>
						<li>
							rkdvnfms5 (강푸른)
						</li> -->
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
				rkdvnfms5
			</div>
			<div class="chat-view-content">
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
						
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
						
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
						
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block">
					<div class="chat-msg-frame">
						<div class="text-msg">
							여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상여어 히사시부리상
						</div>
						<span class="msg-meta">
							3:34 PM
						</span>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
					</div>
				</div>
				<div class="chat-msg-block me">
					<div class="chat-msg-frame">
						<span class="msg-meta">
							3:34 PM
						</span>
						<div class="text-msg">
							여어 히사시부리상
						</div>
						
					</div>
				</div>
			</div>
			<div class="chat-view-footer">
				<div class="chat-input-area">
					<input type="text" name="chat_text" id="chat-input-text" class="chat-input-text" placeholder="메시지를 입력하세요" autocomplete="off">
					<button type="button" class="chat-send-btn" onclick="">전송</button>
				</div>
				<div class="chat-input-options">
					<button type="button" class="attach-btn">
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/scripts/libs/sockjs.min.js"></script>
<script type="text/javascript" src="/scripts/libs/stomp.min.js"></script>
<script>
var socket = null;
var stompClient = null;

$(document).ready(function(){
	connect();
})

function connect() {
	socket = new SockJS('/jc');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame){
		$("chat-list-content-ul li").each(function(index, item){
			var chat_seq = $(item).find("input[name='chat_seq']").val();
			stompClient.subscribe('/topic/send/' + chat_seq, function(msg){
				receiveMsg(JSON.parse(msg.body));
			});
		})
		
		stompClient.subscribe('/topic/start/${member.seq}', function(msg){
			alert("ㅇㅋ");
		});
	});
	
}

$("#search-chat-member").on("keyup", function(e){
	if(e.keyCode==13) {
		searchChatMember();
    }
})

function closeChatView(){
	$("#chat-view-layer").hide();
}

function searchChatMember(){
	var search = $("#search-chat-member").val();
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
						html += '<li> ' + res.list[i].id + ' (' + res.list[i].name + ') </li>';
					}
					$(".add-list").html(html);
				}
			}
		})
	}
	
}

function startChat(){
	
}

function receiveMsg(msg) {
	alert(msg);
}

</script>
