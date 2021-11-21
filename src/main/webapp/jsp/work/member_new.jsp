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
			<h2 class="page-header__title">멤버 초대하기</h2>
		</header>
		
		<form id="insertMemberForm" action="/work/member/invite" method="post">
			<div class="ibox group-new-page__body">
				<table class="tbl-group-new">
					<tbody>
						<tr class="group-new-page__title-row">
							<th scope="row">
								<label for="groupNewName">
									<span>이메일 주소</span>
								</label>
							</th>
							<td>
								<input type="text" id="email" class="ra-input" name="email" autocomplete="off" placeholder="name@example.com">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="group-new-page__controls">
					<button type="button" id="insert-submit" class="ra-button ra-button--accent" disabled><span>초대하기</span></button>
				</div>
			</div>
		</form>
	</section>
</article>
<script>
$(document).ready(function(){
	//입력시 확인 버튼 활성화
	$("#email").on('focusin focusout propertychange change keyup paste input', function(){
		if($.trim($(this).val()).length > 0){
			$("#insert-submit").attr("disabled", false);
		} else {
			$("#insert-submit").attr("disabled", true);
		}
	});
})

</script>
</body>
</html>