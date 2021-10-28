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
				<form action="" id="signupForm" method="post">
					<fieldset>
						<h3 class="group-label">프로젝트 참여</h3>
						<fieldset class="field-input">
							<label for="sign-title">
								참여 코드
							</label>
							<input type="text" id="sign-title" name="code" maxlength="6" placeholder="프로젝트 참여 코드 입력"/>						
						</fieldset>
						
						<h3 class="group-label">이메일 인증</h3>
						<fieldset class="field-input" id="field-email">
							<label for="sign-email">
								이메일
							</label>
							<input type="email" id="sign-email" name="email" placeholder="업무용 이메일 입력" onchange="validateEmail();"/>	
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
						
						<h3 class="group-label">아이디 만들기</h3>
						<fieldset class="field-input" id="field-id">
							<label for="sign-id">
								아이디
							</label>
							<input type="text" id="sign-id" name="id" maxlength="15" placeholder="영문이름, 사번 등 고유정보" oninput="this.value = this.value.replace(/[^0-9a-zA-Z]/g, '');"/>	
							<input type="button" class="btn" id="duplication-btn" value="중복 확인" onclick="checkDuplication();">
							<div id="dupl-msg" class="error-msg" style="display: none;">이미 존재하는 아이디입니다.</div>
							<input type="hidden" id="duplYN" name="duplYN" value="N">
						</fieldset>
						<fieldset class="field-input" id="field-password">
							<label for="sign-password">
								비밀번호
							</label>
							<input type="password" id="sign-password" name="password" placeholder="숫자 혹은 특수문자 포함 8자 이상" onchange="validatePassword();"/>	
							<div id="password-msg" class="error-msg" style="display: none;">올바르지 않은 비밀번호 형식입니다.</div>	
						</fieldset>
						<fieldset class="field-input" id="field-password-re">
							<label for="sign-password-re">
								비밀번호 확인
							</label>
							<input type="password" id="sign-password-re" placeholder="비밀번호 재입력" onchange="validateRePassword();"/>	
							<div id="password-msg-re" class="error-msg" style="display: none;">비밀번호가 다릅니다.</div>	
						</fieldset>
						
						<h3 class="group-label"></h3>
						<fieldset class="field-input">
							<label for="sign-name">
								이름
							</label>
							<input type="text" id="sign-name" name="name" placeholder="이름 입력"/>		
						</fieldset>
						<fieldset class="field-input">
							<label for="sign-department">
								소속
							</label>
							<input type="text" id="sign-department" name="department" placeholder="팀 혹은 부서 소속 입력"/>		
						</fieldset>
						
						<h3 class="group-label"></h3>
						<fieldset class="field-agree-all">
							<input type="checkbox" id="agree-all" onchange="agreeAll(this);">
							<label class="label-text" for="agree-all">모든 항목에 동의</label>
						</fieldset>
						
						<fieldset class="field-agreements">
							<ul>
								<li>
									<input type="checkbox" id="agree-term">
									<label class="label-text" for="agree-term">잡콜이야 서비스 이용약관에 동의(필수)</label>
								</li>
								<li>
									<input type="checkbox" id="agree-privacy-nec">
									<label class="label-text" for="agree-privacy-nec">개인정보 수집이용 동의(필수)</label>
								</li>
								<!-- <li>
									<input type="checkbox" id="agree-privacy-opt">
									<label class="label-text" for="agree-privacy-opt">개인정보 수집이용 동의(선택)</label>
								</li> -->
							</ul>
						</fieldset>
						
						<fieldset class="field-submit">
							<input type="submit" id="sign-submit" class="submit-btn" value="참여하기" disabled>
						</fieldset>
					</fieldset>
					
				</form>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#signupForm fieldset[class^='field']").on('focusout', function(){
		var check = checkSignup();
		if(check){
			$("#sign-submit").attr("disabled", false);
		} else {
			$("#sign-submit").attr("disabled", true);
		}
	})
	
	$("#signupForm input").on('change', function(){
		var check = checkSignup();
		if(check){
			$("#sign-submit").attr("disabled", false);
		} else {
			$("#sign-submit").attr("disabled", true);
		}
	})
});
</script>
</body>
</html>