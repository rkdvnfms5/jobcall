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
	<div class="login-contents">
		<div class="login-container">
			<h3 class="login-title">로그인</h3>
			<div class="login-help guide-msg">로그인을 위해 아래에 정보를 입력해주세요.</div>
			<form id="loginForm" action="/sign/login" method="post" onsubmit="showLoading()">
				<input type="hidden" name="rtnUrl" value="${rtnUrl}">
				<fieldset class="fieldset-group">
					<fieldset class="field-input field-id">
						<label for="login-id">아이디</label>
						<input type="text" name="id" id="login-id" value="" placeholder="아이디를 입력해주세요.">
					</fieldset>
					<fieldset class="field-input field-password">
						<label for="login-password">비밀번호</label>
						<input type="password" name="password" id="login-password" value="" placeholder="비밀번호를 입력해주세요.">
					</fieldset>
					<fieldset class="field-submit">
						<input type="submit" id="login-submit" class="submit-btn" value="로그인" disabled>
					</fieldset>
				</fieldset>
			</form>
			
			<a href="javascript:alert('잘하는 짓이다 :(');" class="find-password">
				비밀번호를 잊어버리셨나요?
			</a>
			<div class="join-help guide-msg">
				ID를 잊어버리셨다면,<br>
				잡콜센터 동료들을 통해 입력된 계정을 확인해주세요.
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#loginForm input").on('input', function(){
		var check = checkLogin();
		if(check){
			$("#login-submit").attr("disabled", false);
		} else {
			$("#login-submit").attr("disabled", true);
		}
	})
	
});

function checkLogin(){
	if($("#login-id").val() == ''){
		return false;
	}
	
	if($("#login-password").val() == ''){
		return false;
	}
	
	return true;
}

</script>
</body>
</html>