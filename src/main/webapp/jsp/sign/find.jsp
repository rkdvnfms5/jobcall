<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="background-color: #fafafa">
	<div class="sign-contents">
		<div class="sign-container">
			<div class="">
				<form action="" id="findForm" method="post">
					<fieldset>
						<h3 class="group-label">비밀번호 찾기</h3>
						<fieldset class="field-input" id="field-id">
							<label for="sign-id">
								아이디
							</label>
							<input type="text" id="sign-id" name="id" maxlength="15" placeholder="비밀번호 재설정할 아이디" oninput="this.value = this.value.replace(/[^0-9a-zA-Z]/g, '');"/>	
						</fieldset>
						
						<h3 class="group-label">이메일 인증</h3>
						<fieldset class="field-input" id="field-email">
							<label for="sign-email">
								이메일
							</label>
							<input type="email" id="sign-email" name="email" placeholder="가입한 이메일 입력" onchange="validateEmail();"/>	
							<div class="error-msg" style="display: none;">올바르지 않은 이메일 형식입니다.</div>
							<input type="button" class="btn" id="authcode-btn" value="인증코드 발송" onclick="sendAuthCode();">					
						</fieldset>
						<fieldset class="field-input" id="field-auth">
							<label for="sign-authcode">
								인증코드
							</label>
							<input type="text" id="sign-authcode" placeholder="인증코드 6자리 입력"/>		
							<div id="auth-msg" class="error-msg" style="display: none;">인증코드가 다릅니다.</div>
							<input type="button" class="btn" id="authconfirm-btn" value="인증 확인" onclick="checkAuthCode();">					
						</fieldset>
						<input type="hidden" id="authYN" name="authYN" value="N">
						
						<h3 class="group-label">새 비밀번호 설정</h3>
						<fieldset class="field-input" id="field-password">
							<label for="sign-password">
								새 비밀번호
							</label>
							<input type="password" id="sign-password" name="new_password" placeholder="숫자 혹은 특수문자 포함 8자 이상" onchange="validatePassword();"/>	
							<div id="password-msg" class="error-msg" style="display: none;">올바르지 않은 비밀번호 형식입니다.</div>	
						</fieldset>
						<fieldset class="field-input" id="field-password-re">
							<label for="sign-password-re">
								새 비밀번호 확인
							</label>
							<input type="password" id="sign-password-re" placeholder="새 비밀번호 재입력" onchange="validateRePassword();"/>	
							<div id="password-msg-re" class="error-msg" style="display: none;">비밀번호가 다릅니다.</div>	
						</fieldset>
						
						<fieldset class="field-submit">
							<input type="button" id="find-submit" class="submit-btn" value="설정완료" disabled onclick="modifyPassword()">
						</fieldset>
					</fieldset>
					
				</form>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#findForm fieldset[class^='field']").on('focusout', function(){
		var check = checkFind();
		if(check){
			$("#find-submit").attr("disabled", false);
		} else {
			$("#find-submit").attr("disabled", true);
		}
	})
	
	$("#findForm input").on('change', function(){
		var check = checkFind();
		if(check){
			$("#find-submit").attr("disabled", false);
		} else {
			$("#find-submit").attr("disabled", true);
		}
	})
});

function checkFind() {
	if($("#sign-title").val() == ''){
		return false;
	}
	
	if($("#sign-email").val() == ''){
		return false;
	}
	
	if(!validateEmail()){
		return false;
	}
	
	if($("#authYN").val() != 'Y'){
		return false;
	}
	
	if($("#sign-id").val() == ''){
		return false;
	}
	
	if($("#sign-password").val() == ''){
		return false;
	}
	
	if($("#sign-password").val().length < 8){
		return false;
	}
	
	if($("#sign-password-re").val() == ''){
		return false;
	}
	
	if($("#sign-password").val() != $("#sign-password-re").val()){
		return false;
	}
	
	if(!validatePassword() || !validateRePassword()){
		return false;
	}
	
	return true;
}

function modifyPassword(){
	var data = $("#findForm").serialize();
	
	showLoading();
	$.ajax({
		url : "/sign/password/modify",
		method : "POST",
		data : data,
		dataType : "json",
		success : function(res){
			if(res.res == 1){
				alert("설정 완료");
				location.href = '/sign/login';
			} else {
				alert((res.msg == ''? "설정을 실패했습니다." : res.msg));
			}
			
			hideLoading();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nmessage : " + request.responseText + "\nerror : " + error);
			hideLoading();
		}
	})
}

</script>
</body>
</html>