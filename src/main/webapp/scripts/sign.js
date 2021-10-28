function checkSignup() {
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
	
	if($("#duplYN").val() != 'Y'){
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
	
	if($("#sign-name").val() == ''){
		return false;
	}
	
	if($("#sign-department").val() == ''){
		return false;
	}
	
	if(!$("#agree-term").is(":checked")){
		return false;
	}
	
	if(!$("#agree-privacy-nec").is(":checked")){
		return false;
	}
	
	return true;
}

function validateEmail(){
	var emailReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
	if(!emailReg.test($("#sign-email").val())){
		$("#field-email").addClass("field-error");
		$("#field-email .error-msg").show();
		return false;
	} else {
		$("#field-email").removeClass("field-error");
		$("#field-email .error-msg").hide();
		return true;
	}
	
}

function sendAuthCode(){
	if(!validateEmail()){
		return;
	}
	
	var email = $("#sign-email").val();
	
	$.ajax({
		url : "/sign/get_auth",
		method : "post",
		data : {email : email},
		dataType : "json",
		success : function(res){
			alert("발송되었습니다.");
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nmessage : " + request.responseText + "\nerror : " + error);
		}
	})
}

function checkAuthCode(){
	var authcode = $("#sign-authcode").val();
	
	$.ajax({
		url : "/sign/check_auth",
		method : "post",
		data : {value : authcode},
		dataType : "json",
		success : function(res){
			if(res.res == 1){
				$("#field-auth").removeClass("field-error");
				$("#auth-msg").removeClass("error-msg");
				
				$("#field-auth").addClass("field-success");
				$("#auth-msg").addClass("success-msg");
				$("#auth-msg").html("인증되었습니다.");
				$("#authYN").val("Y");
			} else {
				$("#field-auth").removeClass("field-success");
				$("#auth-msg").removeClass("success-msg");
				
				$("#field-auth").addClass("field-error");
				$("#auth-msg").addClass("error-msg");
				$("#auth-msg").html("인증코드가 다릅니다.");
				$("#authYN").val("N");
			}
			$("#auth-msg").show();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nmessage : " + request.responseText + "\nerror : " + error);
		}
	})
}

function checkDuplication(){
	var id = $("#sign-id").val();
	
	if(id == ""){
		$("#field-id").addClass("field-error");
		$("#dupl-msg").addClass("error-msg");
		$("#dupl-msg").html("아이디를 입력하세요.");
		$("#duplYN").val("N");
		$("#dupl-msg").show();
		return;
	}
	
	$.ajax({
		url : "/sign/check_dupl",
		method : "post",
		data : {id : id},
		dataType : "json",
		success : function(res){
			if(res.count == 0){
				$("#field-id").removeClass("field-error");
				$("#dupl-msg").removeClass("error-msg");
				
				$("#field-id").addClass("field-success");
				$("#dupl-msg").addClass("success-msg");
				$("#dupl-msg").html("사용 가능한 아이디입니다.");
				$("#duplYN").val("Y");
			} else {
				$("#field-id").removeClass("field-success");
				$("#dupl-msg").removeClass("success-msg");
				
				$("#field-id").addClass("field-error");
				$("#dupl-msg").addClass("error-msg");
				$("#dupl-msg").html("이미 존재하는 아이디입니다.");
				$("#duplYN").val("N");
			}
			$("#dupl-msg").show();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nmessage : " + request.responseText + "\nerror : " + error);
		}
	})
}

function validatePassword(){
	var passwordReg = /^[0-9a-zA-Z!@#$%&]{8,}$/;
	var bool = false;
	if(!passwordReg.test($("#sign-password").val())){
		$("#field-password").addClass("field-error");
		$("#field-password .error-msg").show();
		bool = false;
	} else {
		$("#field-password").removeClass("field-error");
		$("#field-password .error-msg").hide();
		bool = true;
	}
	
	if($("#sign-password-re").val() != ''){
		var res = validateRePassword();
	}
	
	return bool;
}

function validateRePassword(){
	var password = $("#sign-password").val();
	var rePassword = $("#sign-password-re").val();
	
	if(password != rePassword){
		$("#field-password-re").addClass("field-error");
		$("#field-password-re .error-msg").show();
		return false;
	} else {
		$("#field-password-re").removeClass("field-error");
		$("#field-password-re .error-msg").hide();
		return true;
	}
	
}

function agreeAll(obj){
	if($(obj).is(":checked")){
		$(".field-agreements li input[type='checkbox']").prop("checked", true);
	} else {
		$(".field-agreements li input[type='checkbox']").prop("checked", false);
	}
}


