function checkSignup() {
	if($("#sign-title").val() == ''){
		return false;
	}
	
	if($("#sign-email").val() == ''){
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
	
	if($("#sign-password-re").val() == ''){
		return false;
	}
	
	if($("#sign-password").val() != $("#sign-password-re").val()){
		return false;
	}
	
	if($("#sign-name").val() == ''){
		return false;
	}
	
	if($("#sign-department").val() == ''){
		return false;
	}
	
	return true;
}

function sendAuthCode(){
	$.ajax({
		url : "/sign/get_auth",
		method : "post",
		dataType : "json",
		success : function(res){
			console.log(res);
			alert("발송되었습니다.");
		}
	})
}



