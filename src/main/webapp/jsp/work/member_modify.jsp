<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<article class="work-basic-layout-body">
	<section class="group-new-page">
		<header class="page-header group-new-page__header">
			<h2 class="page-header__title">프로필 관리</h2>
			<button type="button" class="password-modify-btn" onclick="openPasswordModify()">비밀번호 변경</button>
		</header>
		
		<form id="profileForm" action="/member/${member.seq}" method="post">
			<div class="ibox group-new-page__body">
				<table class="tbl-group-new">
					<tbody>
						<tr>
							<th>
								<span class="avatar" aria-label="프로필 사진" 
								style="width: 160px; height: 160px; background-image: url('${empty member.profile? 'https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png':member.profile}');"></span>
							</th>
							<td>
								<input type="file" id="profileUpload" accept="image/png, image/jpg, image/gif" class="user-edit-form__file-input">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="">
									<span>이름 <em style="font-weight: bold; color: red;">(필수)</em></span>
								</label>
							</th>
							<td>
								<input type="text" id="name" class="ra-input" name="name" autocomplete="off" placeholder="홍길동" value="${member.name}">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="">
									<span>소속 <em style="font-weight: bold; color: red;">(필수)</em></span>
								</label>
							</th>
							<td>
								<input type="text" id="department" class="ra-input" name="department" autocomplete="off" placeholder="부서명, 팀명" value="${member.department}">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>호칭</span>
								</label>
							</th>
							<td>
								<input type="text" id="position" class="ra-input" name="position" autocomplete="off" placeholder="대리, 과장, 디자이너, 개발자, 매니저" value="${member.position}">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>연락처</span>
								</label>
							</th>
							<td>
								<input type="text" id="tel" class="ra-input" name="tel" autocomplete="off" placeholder="유선 또는 무선" value="${member.tel}">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>근무시간</span>
								</label>
							</th>
							<td>
								<c:set var="worktimeArr" value="${fn:split(member.worktime, '-')}" />
								<input type="text" class="ra-input width100px" id="starttime" name="starttime" autocomplete="off" placeholder="시작 시간" style="width: 100px;" value="${worktimeArr[0]}"/>
								-
								<input type="text" class="ra-input width100px" id="endtime" name="endtime" autocomplete="off" placeholder="종료 시간" style="width: 100px;" value="${worktimeArr[1]}"/>
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row" style="vertical-align: top;">
								<label for="groupNewName">
									<span>자기소개</span>
								</label>
							</th>
							<td>
								<div class="ra-textfield ra-textarea" style="width: 400px; height: 100px;">
									<div class="ra-textfield__overlay" style="visibility: hidden;"></div>
									<textarea id="description" class="ra-textfield__textarea" name="description" spellcheck="false">${member.description}</textarea>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="group-new-page__controls">
					<button type="button" onclick="history.back();" class="ra-button"><span>취소</span></button>
					<button type="button" id="insert-submit" class="ra-button ra-button--accent" onclick="modifyProfile();" ${empty member.name or empty member.department? 'disabled' : '' }><span>확인</span></button>
				</div>
			</div>
		</form>
	</section>
</article>
<div class="dim password-modify" style="display: none;">
	<div class="password-modfiy-layer">
		<div class="password-modfiy-content">
			<form class="password-modify-form" id="password-modify-form">
				<div class="password-modfiy-content-header">
					<span>비밀번호 변경</span>
					<button type="button" class="close-btn" onclick="closePasswordModify()"> X </button>
				</div>
				<div class="password-modfiy-content-body">
					<div class="info" style="margin-bottom: 20px;">
						연속하는 숫자, 생일, 전화번호 등 추측하기 쉬운 개인정보 및 아이디와 유사한 비밀번호는 사용하지 마시기 바랍니다.
					</div>
					<div class="password-form">
						<div class="input-item">
							<input type="password" name="current_password" placeholder="현재 비밀번호">
						</div>
						<div class="input-item">
							<input type="password" name="new_password" placeholder="새 비밀번호">
						</div>
						<div class="input-item">
							<input type="password" name="re-new_password" placeholder="새 비밀번호 확인">
						</div>
					</div>
				</div>
				<div class="password-modfiy-content-footer">
					<button type="button" class="cancel-btn ra-button" onclick="closePasswordModify()">취소</button>
					<button type="button" class="submit-btn ra-button" disabled="disabled" onclick="modifyPassword()">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	//입력시 확인 버튼 활성화
	$("#profileForm input, textarea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkProfileValue();
		if(check){
			$("#insert-submit").attr("disabled", false);
		} else {
			$("#insert-submit").attr("disabled", true);
		}
	});
	
	$("input[name='starttime']").timepicker({
	});
	
	$("input[name='endtime']").timepicker({
	});
	
	//비밀번호 변경
	$(".password-form input").on("focusin focusout propertychange change keyup paste input", function(){
		var check = checkPasswordModify(this);
		if(check){
			$(".password-modify-form .submit-btn").attr("disabled", false);
		} else {
			$(".password-modify-form .submit-btn").attr("disabled", true);
		}
	})
})

function checkProfileValue(){
	if($.trim($("input[name='name']").val()) == ''){
		return false;
	}
	
	if($.trim($("input[name='department']").val()) == ''){
		return false;
	}
	
	return true;
}

function modifyProfile(){
	var url = $("#profileForm").attr("action");
	var data = new FormData();
	var formData = $("#profileForm").serializeArray();
	
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
	})
	
	if($("#profileUpload").val() != ''){
		data.append("profileImage", $("#profileUpload")[0].files[0]);
	}
	
	var worktime = "";
	
	if($.trim($("input[name='starttime']").val()) != ''){
		worktime += $("input[name='starttime']").val();
	}
	
	if($.trim($("input[name='endtime']").val()) != ''){
		worktime += ('-' + $("input[name='endtime']").val());
	}
	
	data.append("worktime", worktime);
	
	showLoading();
	$.ajax({
		url : url,
		type : 'PUT',
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

function openPasswordModify(){
	$(".password-modify").show();
	hideWorkHeader();
}

function closePasswordModify(){
	$(".password-modify").hide();
	showWorkHeader();
}

function checkPasswordModify(obj){
	var form = $(obj).closest('form');
	var current = form.find("input[name='current_password']").val();
	var new_password = form.find("input[name='new_password']").val();
	var re_password = form.find("input[name='re-new_password']").val();
	
	if($.trim(current) == ''){
		return false;
	}
	if($.trim(new_password) == ''){
		return false;
	}
	if($.trim(re_password) == ''){
		return false;
	}
	
	if(!validatePassword(new_password) || !validatePassword(new_password, re_password)){
		
		return false;
	}
	
	return true;
}

function validatePassword(value){
	var passwordReg = /^[0-9a-zA-Z!@#$%&]{8,}$/;
	var bool = false;
	if(!passwordReg.test(value)){
		bool = false;
	} else {
		bool = true;
	}
	
	return bool;
}

function validateRePassword(password, re_password){
	if(password == re_password){
		return true;
	} else {
		return false;
	}
}

function modifyPassword(){
	var data = $("#password-modify-form").serialize();
	
	showLoading();
	$.ajax({
		url : "/sign/password/modify",
		method : "POST",
		data : data,
		dataType : "json",
		success : function(res){
			if(res.res == 1){
				alert("설정 완료");
				location.reload();
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