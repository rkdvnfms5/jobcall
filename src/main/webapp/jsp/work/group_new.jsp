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
			<h2 class="page-header__title">그룹 만들기</h2>
		</header>
		
		<form id="insertGroupForm" action="/work/group" method="post">
			<div class="ibox group-new-page__body">
				<table class="tbl-group-new">
					<caption class="screen-hide"><span>그룹 정보</span></caption>
					<tbody>
						<tr class="group-new-page__is-public-row">
							<th scope="row"><span>그룹 설정</span></th>
							<td>
								<label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox ra-radiobox--active">
										<input type="radio" name="access" value="public" checked>
										<span class="ico-check"></span>
									</span>
									<span>공개그룹</span>
									<p><span>${Work.title} 멤버라면 누구나 이 그룹을 볼 수 있습니다</span></p>
								</label>
								<label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox">
										<input type="radio" name="access" value="private">
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
								<input type="text" id="group_name" class="ra-input" name="name" autocomplete="off" maxlength="20" value="">
								<span class="ra-input-hint group-new-page__text-count">
									<span class="screen-out">
										<span>입력된 글자수 :</span>
									</span>
									<span class="group-new-page__text-byte" id="text-length">0</span><span>/20자</span>
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
									<textarea id="group_content" class="ra-textfield__textarea" name="content" spellcheck="false"></textarea>
								</div>
								<!-- <label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox">
										<input type="radio" name="is_permanent_show_description" value="true">
										<span class="ico-check"></span>
									</span>
									<span>항상 펼침</span>
								</label>
								<label class="ra-choicebox-label">
									<span class="ra-radiobox ra-radiobox ra-radiobox--active">
										<input type="radio" name="is_permanent_show_description" value="false" checked="">
										<span class="ico-check"></span>
									</span>
									<span>수정되면 펼침</span>
								</label> -->
							</td>
						</tr>
					</tbody>
				</table>
				<div class="group-new-page__controls">
					<button class="ra-button"><span>취소</span></button>
					<button id="insert-submit" class="ra-button ra-button--accent" disabled><span>확인</span></button>
					<!-- <button class="ra-button group-new-page__preview-button"><span>미리 보기</span></button> -->
				</div>
			</div>
		</form>
	</section>
</article>
<script>
$(document).ready(function(){
	//입력시 확인 버튼 활성화
	$("#insertGroupForm input, textarea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkGroupValue();
		if(check){
			$("#insert-submit").attr("disabled", false);
		} else {
			$("#insert-submit").attr("disabled", true);
		}
	});
	
	//그룹명 글자수 표시
	$("#insertGroupForm #group_name").on('propertychange change keyup paste input', function(){
		$("#text-length").html($(this).val().length);
	});
	
	//접근권한 토글
	$("#insertGroupForm input[name='access']").on("click", function(){
		$(".group-new-page__is-public-row .ra-radiobox").removeClass("ra-radiobox--active");
		$(this).parent(".ra-radiobox").addClass("ra-radiobox--active");
	})
})
</script>
</body>
</html>