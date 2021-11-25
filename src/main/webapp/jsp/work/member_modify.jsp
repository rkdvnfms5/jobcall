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
		</header>
		
		<form id="profileForm" action="/member/${member.seq}" method="post">
			<div class="ibox group-new-page__body">
				<table class="tbl-group-new">
					<tbody>
						<tr>
							<th>
								<span class="avatar" url="https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png" aria-label="프로필 사진" style="width: 160px; height: 160px; background-image: url(&quot;https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png&quot;);"></span>
							</th>
							<td>
								<input type="file" id="profileUpload" accept="image/png, image/jpg, image/gif" class="user-edit-form__file-input">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>이름 <em>(필수)</em></span>
								</label>
							</th>
							<td>
								<input type="text" id="name" class="ra-input" name="email" autocomplete="off" placeholder="홍길동">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>소속 <em>(필수)</em></span>
								</label>
							</th>
							<td>
								<input type="text" id="email" class="ra-input" name="email" autocomplete="off" placeholder="부서명, 팀명">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>호칭</span>
								</label>
							</th>
							<td>
								<input type="text" id="email" class="ra-input" name="email" autocomplete="off" placeholder="대리, 과장, 디자이너, 개발자, 매니저">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>연락처</span>
								</label>
							</th>
							<td>
								<input type="text" id="email" class="ra-input" name="email" autocomplete="off" placeholder="유선 또는 무선">
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>근무시간</span>
								</label>
							</th>
							<td>
								<input type="text" class="input-starttime" id="starttime" name="starttime" autocomplete="off" placeholder="시작 시간" />
								<input type="text" class="input-endtime" id="endtime" name="endtime" autocomplete="off" placeholder="종료 시간" />
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>자기소개</span>
								</label>
							</th>
							<td>
								<textarea name="description" id="description" rows="" cols=""></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="group-new-page__controls">
					<button type="button" onclick="history.back();" class="ra-button"><span>취소</span></button>
					<button type="button" id="insert-submit" class="ra-button ra-button--accent" onclick="modifyProfile();" disabled><span>확인</span></button>
				</div>
			</div>
		</form>
	</section>
</article>
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
})

function checkProfileValue(){
	
}

function modifyProfile(){
	
}

</script>
</body>
</html>