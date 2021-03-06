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
			<h2 class="page-header__title">그룹 관리</h2>
		</header>
		
		<form id="updateGroupForm" action="/work/group/${WorkGroup.seq}" method="post">
			<div class="ibox group-new-page__body">
				<table class="tbl-group-new">
					<caption class="screen-hide"><span>그룹 정보</span></caption>
					<tbody>
						<tr class="group-new-page__is-public-row">
							<th scope="row"><span>그룹 설정</span></th>
							<td>
								<label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox ra-radiobox--active">
										<input type="radio" name="access" value="public" ${WorkGroup.access eq 'public'? 'checked':''} >
										<span class="ico-check"></span>
									</span>
									<span>공개그룹</span>
									<p><span>${Work.title} 멤버라면 누구나 이 그룹을 볼 수 있습니다</span></p>
								</label>
								<label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox">
										<input type="radio" name="access" value="private" ${WorkGroup.access eq 'private'? 'checked':''} >
										<span class="ico-check"></span>
									</span>
									<span>비공개그룹</span>
									<p><span>초대를 받은 사람만 이 그룹을 볼 수 있습니다</span></p>
								</label>
							</td>
						</tr>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>그룹명</span>
								</label>
							</th>
							<td>
								<input type="text" id="group_name" class="ra-input" name="name" autocomplete="off" maxlength="20" value="${WorkGroup.name}" disabled>
								<span class="ra-input-hint group-new-page__text-count">
									<span class="screen-out">
										<span>입력된 글자수 :</span>
									</span>
									<span class="group-new-page__text-byte" id="text-length">${fn:length(WorkGroup.name)}</span><span>/20자</span>
								</span>
							</td>
						</tr>
						<tr class="group-new-page__description-row">
							<th scope="row">
								<label for="groupNerDescription"><span>그룹 설명</span></label>
							</th>
							<td>
								<div class="ra-textfield ra-textarea">
									<div class="ra-textfield__overlay" style="visibility: hidden;"></div>
									<textarea id="group_content" class="ra-textfield__textarea" name="content" spellcheck="false">${WorkGroup.content}</textarea>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="group-new-page__controls">
					<button type="button" onclick="history.back();" class="ra-button"><span>취소</span></button>
					<button type="button" id="update-submit" class="ra-button ra-button--accent" onclick="updateGroup()" disabled><span>확인</span></button>
					<!-- <button type="button" class="ra-button group-new-page__preview-button"><span>미리 보기</span></button> -->
				</div>
			</div>
		</form>
	</section>
</article>
<script>
$(document).ready(function(){
	//입력시 확인 버튼 활성화
	$("#updateGroupForm input, textarea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkGroupValue();
		if(check){
			$("#update-submit").attr("disabled", false);
		} else {
			$("#update-submit").attr("disabled", true);
		}
	});
	
	//그룹명 글자수 표시
	$("#updateGroupForm #group_name").on('propertychange change keyup paste input', function(){
		$("#text-length").html($(this).val().length);
	});
	
	//접근권한 토글
	$("#updateGroupForm input[name='access']").on("click", function(){
		$(".group-new-page__is-public-row .ra-radiobox").removeClass("ra-radiobox--active");
		$(this).parent(".ra-radiobox").addClass("ra-radiobox--active");
	})
})

function updateGroup(){
	var updateForm = $("#updateGroupForm")
	var data = updateForm.serialize();
	var url = updateForm.attr("action");
	
	showLoading();
	
	$.ajax({
		url : url,
		type : 'PUT',
		data : data,
		dataType : 'JSON',
		success : function(res){
			if(res.res == 1){
				location.href = url;
			} else {
				alert(res.msg);
				hideLoading();
			}
			
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
			hideLoading();
		}
	})
}
</script>
</body>
</html>