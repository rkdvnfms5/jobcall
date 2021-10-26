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
				<form action="/sign/signup" id="signupForm" method="post" onsubmit="checkSignup();">
					<fieldset>
						<h3 class="group-label">업무 프로젝트 정보</h3>
						<fieldset class="field-input">
							<label for="sign-title">
								프로젝트명
							</label>
							<input type="text" id="sign-title" name="title" maxlength="15" placeholder="회사명 또는 프로젝트명을 15자 이내로 입력"/>						
						</fieldset>
						
						<h3 class="group-label">이메일 인증</h3>
						<fieldset class="field-input">
							<label for="sign-email">
								이메일
							</label>
							<input type="text" id="sign-email" name="email" placeholder="업무용 이메일 입력"/>	
							<input type="button" class="btn" id="authcode-btn" value="인증코드 발송" onclick="sendAuthCode();">					
						</fieldset>
						<fieldset class="field-input">
							<label for="sign-authcode">
								인증코드
							</label>
							<input type="text" id="sign-authcode" placeholder="인증코드 6자리 입력"/>		
							<input type="button" class="btn" id="authconfirm-btn" value="인증 확인">					
						</fieldset>
						<input type="hidden" id="authYN" value="Y">
						
						<h3 class="group-label">아이디 만들기</h3>
						<fieldset class="field-input">
							<label for="sign-id">
								아이디
							</label>
							<input type="text" id="sign-id" name="id" maxlength="20" placeholder="영문이름, 사번 등 고유정보"/>	
						</fieldset>
						<fieldset class="field-input">
							<label for="sign-password">
								비밀번호
							</label>
							<input type="password" id="sign-password" name="password" placeholder="숫자 혹은 특수문자 포함 8자 이상"/>		
						</fieldset>
						<fieldset class="field-input">
							<label for="sign-password-re">
								비밀번호 확인
							</label>
							<input type="password" id="sign-password-re" placeholder="비밀번호 재입력"/>		
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
							<input type="checkbox" id="agree-all">
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
							<input type="submit" id="sign-submit" class="submit-btn" value="개설하기" disabled>
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
		}
	})
	
	$("#signupForm input").on('change', function(){
		var check = checkSignup();
		if(check){
			$("#sign-submit").attr("disabled", false);
		}
	})
});
</script>
</body>
</html>