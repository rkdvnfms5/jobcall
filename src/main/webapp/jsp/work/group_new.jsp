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
		
		<div class="ibox group-new-page__body">
			<table class="tbl-group-new">
				<caption class="screen-hide"><span>그룹 정보</span></caption>
				<tbody>
					<tr class="group-new-page__is-public-row">
						<th scope="row"><span>그룹 설정</span></th>
						<td>
							<label class="ra-choicebox-label">
								<span class="ra-radiobox ra-radiobox ra-radiobox--active">
									<input type="radio" name="isPublic" value="true" checked="">
									<span class="ico-check"></span>
								</span>
								<span>공개그룹</span>
								<p><span>푸짐 아지트 멤버라면 누구나 이 그룹을 볼 수 있습니다</span></p>
							</label>
							<label class="ra-choicebox-label">
								<span class="ra-radiobox ra-radiobox">
									<input type="radio" name="isPublic" value="false">
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
							<input type="text" id="groupNewName" class="ra-input" name="name" autocomplete="off" maxlength="20" value="">
							<span class="ra-input-hint group-new-page__text-count">
								<span class="screen-out">
									<span>입력된 글자수 :</span>
								</span>
								<span class="group-new-page__text-byte">0</span><span>/20자</span>
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
								<textarea id="groupNerDescription" class="ra-textfield__textarea" name="name" spellcheck="false"></textarea>
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
				<button disabled class="ra-button ra-button--accent"><span>확인</span></button>
				<button class="ra-button group-new-page__preview-button"><span>미리 보기</span></button>
			</div>
		</div>
	</section>
</article>
</body>
</html>