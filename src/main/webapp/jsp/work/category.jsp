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
	<section class="category-page">
		<header class="page-header">
			<div class="tab">
				<a class="tab__item tab__item--active">그룹 카테고리 설정</a>
				<!-- <a class="tab__item" href="#">웹 푸시 설정</a>
				<a class="tab__item" href="#">모바일 푸시 설정</a>
				<a class="tab__item" href="#">구독 및 피드 설정</a> -->
			</div>
		</header>
		<div class="tmp-cate-editor">
			<div class="tmp-cate-editor-cates">
				<div class="tmp-cate-editor-cates_header">
					나의 카테고리
					<button type="button" id="category_add_btn" class="icon-button tmp-cate-editor-cates__header-button-add" onclick="addCategoryInput();">
						<i class="ico ico-plus" aria-hidden="true"><svg width="12px" height="12px" viewBox="0 0 12 12" version="1.1"><g id="plus" stroke="none" stroke-width="1" fill="#FAFBFC" fill-rule="evenodd"><path d="M7,5 L7,1.00247329 C7,0.455760956 6.55228475,0 6,0 C5.44386482,0 5,0.448822582 5,1.00247329 L5,5 L1.00247329,5 C0.455760956,5 0,5.44771525 0,6 C0,6.55613518 0.448822582,7 1.00247329,7 L5,7 L5,10.9975267 C5,11.544239 5.44771525,12 6,12 C6.55613518,12 7,11.5511774 7,10.9975267 L7,7 L10.9975267,7 C11.544239,7 12,6.55228475 12,6 C12,5.44386482 11.5511774,5 10.9975267,5 L7,5 Z"></path></g></svg></i>
					</button>
				</div>
				<div class="tmp-cate-editor-cates_content">
					<c:forEach items="${LnbWorkCategoryList}" var="category" varStatus="status">
						<div class="tmp-cate-editor-cates__item ${status.index == 0? 'tmp-cate-editor-cates__item--selected':''}" id="category-${category.seq}" onclick="setCatrgoryGroupList(this)">
							<input type="hidden" name="seq" value="${category.seq}" />
							<div class="tmp-cate-editor-cates__item-body">
								<div class="tmp-cate-editor-cates__item-name">${category.title}</div>
								<c:if test="${category.defaultyn ne 'Y'}">
									<button type="button" class="icon-button tmp-cate-editor-cates__item-button-edit" onclick="modifyCatrgoryInput(${category.seq}, '${category.title}')">
										<i class="ico ico-mode_edit" aria-hidden="true"><svg width="14px" height="14px" viewBox="0 0 14 14" version="1.1"><g id="mode_edit" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M8.33333333,2.86666667 L11.1333333,5.66666667 L2.8,14 L0,14 L0,11.2 L8.33333333,2.86666667 Z M11.2,0 L14,2.8 L12.0666667,4.73333333 L9.26666667,1.93333333 L11.2,0 Z"></path></g></svg></i>
									</button>
									<button type="button" class="icon-button tmp-cate-editor-cates__item-button-delete" onclick="deleteCategory(${category.seq})">
										<i class="ico ico-delete_" aria-hidden="true"><svg width="12px" height="14px" viewBox="0 0 12 14" version="1.1"><g id="delete_" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M12,0.988162635 L12,2.64796706 L0,2.64796706 L0,0.988162635 L4.01073826,0.988162635 L7.98926174,0.988162635 L12,0.988162635 Z M1,4 L11,4 L11,12.000385 C11,13.1047419 10.1125667,14 9.00038502,14 L2.99961498,14 C1.89525812,14 1,13.1125667 1,12.000385 L1,4 Z M4,0 L8,0 L8,0.988162635 L4,0.988162635 L4,0 Z"></path></g></svg></i>
									</button>
								</c:if>
							</div>
							<c:if test="${category.defaultyn ne 'Y'}">
								<div class="tmp-cate-editor-cates__item-handle" draggable="true">
									<i class="ico ico-menu" aria-hidden="true"><svg width="24px" height="24px" viewBox="0 0 24 24"><g id="menu"><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></g></svg></i>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="tmp-cate-editor-groups">
				<div class="tmp-cate-editor-groups_header">
					<span class="ra-checkbox">
						<input type="checkbox" id="groupCheckAll" onchange="checkCategoryGroupAll();"/>
						<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
					</span>
					<div class="tmp-cate-editor-groups__header-select">
						<div class="Select Select--light has-value Select--single">
							<select id="categorySelect">
								<c:forEach items="${LnbWorkCategoryList}" var="category" varStatus="status">
									<option value='${category.seq}'>${category.title}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<button class="ra-button tmp-cate-editor-groups__header-button-move" onclick="moveGroupCategory()">이동</button>
				</div>
				<div class="tmp-cate-editor-groups__content" id="group-list">
					<!-- <div class="tmp-cate-editor-groups__item tmp-cate-editor-groups__item--private">
						<span class="ra-checkbox tmp-cate-editor-groups__item-check-box">
							<input type="checkbox" value="" /><i class="ico ico-check" aria-hidden="true"></i>
						</span>
						<span class="tmp-cate-editor-groups__item-body">[공통] 자유게시판</span>
						<i class="ico ico-lock" aria-hidden="true"><svg width="8px" height="10px" viewBox="0 0 8 10" version="1.1"><g id="lock" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M6.93177579,4.00166776 L6.93177579,2.96834236 C6.93177579,1.33357103 5.60056952,0.00832702498 3.9658879,0.00832702498 C2.32787324,0.00832702498 1,1.33901285 1,2.96834236 L1,4.00638348 C0.43643723,4.05812741 0,4.41813387 0,4.85503827 L0,9.14496173 C0,9.61718633 0.510070171,10 1.14005102,10 L6.85994898,10 C7.48958177,10 8,9.61744737 8,9.14496173 L8,4.85503827 C8,4.40089775 7.52824857,4.02945121 6.93177579,4.00166776 Z M2,4 L2,2.99011614 C2,1.89521499 2.8973316,1 4,1 C5.10293921,1 6,1.89311649 6,2.99011614 L6,4 L2,4 Z"></path></g></svg></i>
					</div>
					<div class="tmp-cate-editor-groups__item">
						<span class="ra-checkbox tmp-cate-editor-groups__item-check-box">
							<input type="checkbox" value="" /><i class="ico ico-check" aria-hidden="true"></i>
						</span>
						<span class="tmp-cate-editor-groups__item-body">[공통] 자유게시판</span>
					</div> -->
				</div>
			</div>
		</div>
	</section>
</article>
<script>
var tempHtml = "";

//set group list
var groupArray = new Array();
<c:forEach items="${LnbWorkGroupList}" var="group">
	var json = new Object();
	json.seq="${group.seq}";
	json.work_seq="${group.work_seq}";
	json.member_seq="${group.member_seq}";
	json.category_seq="${group.category_seq}";
	json.name="${group.name}";
	json.access="${group.access}";
	json.useyn="${group.useyn}";
	groupArray.push(json);
</c:forEach>

$(document).ready(function(){
	$(".tmp-cate-editor-cates__item").not(".input").mouseover(function(){
		if($(".tmp-cate-editor-cates__item.input").length == 0){
			$(this).find(".icon-button").show();
		}
	});
	
	$(".tmp-cate-editor-cates__item").not(".input").mouseout(function(){
		$(this).find(".icon-button").hide();
	});
	
	//set group list
	var defaultCategory = document.getElementsByClassName('tmp-cate-editor-cates__item--selected')[0];
	setCatrgoryGroupList(defaultCategory);
})

function addCategoryInput(){
	if($(".tmp-cate-editor-cates__item.input").length == 0){
		var inputHtml = "";
		inputHtml += '<div class="tmp-cate-editor-cates__item input">';
		inputHtml += '<input class="tmp-cate-editor-cates__item-input" type="text" value="">';
		inputHtml += '<button type="button" onclick="insertCategory()" class="icon-button tmp-cate-editor-cates__item-button-submit">';
		inputHtml += '<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
		inputHtml += '</button>';
		inputHtml += '<button type="button" onclick="removeCategoryInput(this)" class="icon-button tmp-cate-editor-cates__item-button-cancel"><i class="ico ico-x_clear" aria-hidden="true"><svg width="9px" height="9px" viewBox="0 0 9 9" version="1.1"><g id="x_clear" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.49994883,3.64908503 L7.97209478,0.176939075 C8.20424418,-0.055210324 8.59190552,-0.0615821696 8.82707773,0.173590043 C9.05537218,0.401884487 9.06075054,0.791551162 8.8237287,1.02857299 L5.35158275,4.50071895 L8.8237287,7.97286491 C9.06075054,8.20988674 9.05537218,8.59955342 8.82707773,8.82784786 C8.59190552,9.06302007 8.20424418,9.05664823 7.97209478,8.82449883 L4.49994883,5.35235287 L1.02780287,8.82449883 C0.795653469,9.05664823 0.40799213,9.06302007 0.172819918,8.82784786 C-0.0554745266,8.59955342 -0.060852883,8.20988674 0.176168949,7.97286491 L3.64831491,4.50071895 L0.176168949,1.02857299 C-0.060852883,0.791551162 -0.0554745266,0.401884487 0.172819918,0.173590043 C0.40799213,-0.0615821696 0.795653469,-0.055210324 1.02780287,0.176939075 L4.49994883,3.64908503 L4.49994883,3.64908503 Z"></path></g></svg></i>';
		inputHtml += '</button></div>';

		$(".tmp-cate-editor-cates_content").append(inputHtml);
		
		$("#category_add_btn").hide();
	}
}

function removeCategoryInput(obj){
	$(obj).parent(".input").remove();
	$("#category_add_btn").show();
}

function modifyCatrgoryInput(seq, title){
	if($(".tmp-cate-editor-cates__item.input").length == 0){
		var categoryDiv = $("#category-"+seq);
		tempHtml = categoryDiv.html();
		categoryDiv.html("");
		
		var inputHtml = "";
		inputHtml += '<div class="tmp-cate-editor-cates__item input">';
		inputHtml += '<input class="tmp-cate-editor-cates__item-input" type="text" value="' + title + '">';
		inputHtml += '<button type="button" onclick="updateCategory(' + seq + ')" class="icon-button tmp-cate-editor-cates__item-button-submit">';
		inputHtml += '<i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
		inputHtml += '</button>';
		inputHtml += '<button type="button" onclick="cancelModifyCategoryInput(' + seq + ')" class="icon-button tmp-cate-editor-cates__item-button-cancel"><i class="ico ico-x_clear" aria-hidden="true"><svg width="9px" height="9px" viewBox="0 0 9 9" version="1.1"><g id="x_clear" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.49994883,3.64908503 L7.97209478,0.176939075 C8.20424418,-0.055210324 8.59190552,-0.0615821696 8.82707773,0.173590043 C9.05537218,0.401884487 9.06075054,0.791551162 8.8237287,1.02857299 L5.35158275,4.50071895 L8.8237287,7.97286491 C9.06075054,8.20988674 9.05537218,8.59955342 8.82707773,8.82784786 C8.59190552,9.06302007 8.20424418,9.05664823 7.97209478,8.82449883 L4.49994883,5.35235287 L1.02780287,8.82449883 C0.795653469,9.05664823 0.40799213,9.06302007 0.172819918,8.82784786 C-0.0554745266,8.59955342 -0.060852883,8.20988674 0.176168949,7.97286491 L3.64831491,4.50071895 L0.176168949,1.02857299 C-0.060852883,0.791551162 -0.0554745266,0.401884487 0.172819918,0.173590043 C0.40799213,-0.0615821696 0.795653469,-0.055210324 1.02780287,0.176939075 L4.49994883,3.64908503 L4.49994883,3.64908503 Z"></path></g></svg></i>';
		inputHtml += '</button></div>';

		categoryDiv.append(inputHtml);
		
		$("#category_add_btn").hide();
	}
}

function cancelModifyCategoryInput(seq) {
	if($(".tmp-cate-editor-cates__item input").length > 0){
		var categoryDiv = $("#category-"+seq);
		categoryDiv.html("");
		categoryDiv.append(tempHtml);
	}
}

function setCatrgoryGroupList(obj){
	$(".tmp-cate-editor-cates__item").removeClass("tmp-cate-editor-cates__item--selected");
	$(obj).addClass("tmp-cate-editor-cates__item--selected");
	
	var categoryseq = $(obj).find("input[name=seq]").val();
	
	$("#group-list").empty();
	
	for(var i=0; i<groupArray.length; i++){
		if(groupArray[i].category_seq == categoryseq){
			var html = "";
			
			var itemClass = "tmp-cate-editor-groups__item";
			if(groupArray[i].access == 'private'){
				itemClass += ' tmp-cate-editor-groups__item--private';
			}
			
			html += '<div class="' + itemClass + '" >';
			html += '<span class="ra-checkbox tmp-cate-editor-groups__item-check-box">';
			html += '<input type="checkbox" value="' + groupArray[i].seq + '" /><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
			html += '</span>';
			html += '<span class="tmp-cate-editor-groups__item-body">' + groupArray[i].name + '</span>';
			
			if(groupArray[i].access == 'private'){
				html += '<i class="ico ico-lock" aria-hidden="true"><svg width="8px" height="10px" viewBox="0 0 8 10" version="1.1"><g id="lock" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M6.93177579,4.00166776 L6.93177579,2.96834236 C6.93177579,1.33357103 5.60056952,0.00832702498 3.9658879,0.00832702498 C2.32787324,0.00832702498 1,1.33901285 1,2.96834236 L1,4.00638348 C0.43643723,4.05812741 0,4.41813387 0,4.85503827 L0,9.14496173 C0,9.61718633 0.510070171,10 1.14005102,10 L6.85994898,10 C7.48958177,10 8,9.61744737 8,9.14496173 L8,4.85503827 C8,4.40089775 7.52824857,4.02945121 6.93177579,4.00166776 Z M2,4 L2,2.99011614 C2,1.89521499 2.8973316,1 4,1 C5.10293921,1 6,1.89311649 6,2.99011614 L6,4 L2,4 Z"></path></g></svg></i>';
			}
			
			html += '</div>';
			
			$("#group-list").append(html);
		}
	}
}

</script>
</body>
</html>