<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ page import="com.poozim.jobcall.util.StringUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.dim {
	width: 100%;
	height: 100%;
	z-index: 888;
	background-color: rgba(0,0,0,0.8);
	position: fixed;
	top: 0;
	left: 0;
}
</style>
</head>
<body>
<article class="work-basic-layout-body">
	<section class="wall-page">
		<%@include file="/jsp/include/group_header.jsp" %>	
		<c:choose>
			<c:when test="${empty FileList}">
				<jsp:include page="/jsp/include/empty_content.jsp" />
			</c:when>
			<c:otherwise>
				<div class="group-image-page">
					<div class="group-image-page-header">
					
					</div>
					<div class="group-image-page-body">
						<div class="group-image-list">
							<c:forEach items="${FileList}" var="image" varStatus="status">
								<div class="group-image-item ${status.last? 'observed':''}" 
									onclick="openImageViewer(${status.index})">
									<img src="${image.src}">
									<input type="hidden" name="src" value="${image.src}">
									<input type="hidden" name="name" value="${image.name}">
									<input type="hidden" name="member_id" value="${image.member_id}">
									<input type="hidden" name="member_name" value="${image.member_name}">
									<input type="hidden" name="object_name" value="${image.object_name}">
									<input type="hidden" name="board_seq" value="${image.board_seq}">
									<input type="hidden" name="regdate" value="${image.regdate}">
								</div>
							</c:forEach>
							
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</section>
</article>
<div class="dim imageViewer hide">
	<div class="viewer">
		<button class="viewer-prevBtn">&lt;</button>
		<div class="viewer-content">
			<div class="viewer-content-header">
				<span class="viewer-content-name">name</span>
				<button title="다운로드" class="download-btn">
					<i class="ico ico-viewer_download" aria-hidden="true">
						<svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink"><g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g id="이미지뷰어개선" transform="translate(-1523.000000, -245.000000)" fill="#FFFFFF" fill-rule="nonzero"><g id="Group-6" transform="translate(1523.000000, 245.000000)"><path d="M14,7.16666667 L8,13 L2,7.16666667 L6.6,7.16666667 L6.6,0 L9.4,0 L9.4,7.16666667 L14,7.16666667 Z M0,14 L16,14 L16,16 L0,16 L0,14 Z" id="Combined-Shape"></path></g></g></g>
						</svg>
					</i>
				</button>
				<button title="닫기" class="close-btn" onclick="closeImageViewer()">
					<i class="ico ico-viewer_close" aria-hidden="true">
						<svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink"><g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g id="이미지뷰어개선" transform="translate(-1551.000000, -245.000000)" fill="#FFFFFF"><g id="Group-5" transform="translate(1551.000000, 245.000000)"><path d="M7.98684007,6.16854469 L14.1290649,0.0263198642 L15.9364582,1.8337132 L9.7942334,7.97593802 L16,14.1817046 L14.1926067,15.989098 L7.98684007,9.78333136 L1.80739333,15.9627781 L-1.687539e-13,14.1553848 L6.17944674,7.97593802 L0.0109020447,1.80739333 L1.81829538,1.19904087e-14 L7.98684007,6.16854469 Z" id="Combined-Shape"></path></g></g></g>
						</svg>
					</i>
				</button>
			</div>
			<div class="viewer-content-body">
				<div>
					<a href="">
						<img class="viewer-content-image" alt="" src="">
					</a>
				</div>
			</div>
			<div class="viewer-content-footer">
				<span class="viewer-content-member">memberid (membername) • regdate</span>
				<a class="viewer-content-origin" href="">원글보기</a>
			</div>
		</div>
		<button class="viewer-nextBtn">&gt;</button>
	</div>
</div>
<form action="" id="pagingForm">
	<input type="hidden" name="limit" value="${limit}">
	<input type="hidden" name="offset" value="${limit + offset}">
	<input type="hidden" name="group_seq" value="${WorkGroup.seq}">
	<input type="hidden" name="file_type" value="image">
</form>
<script>
$(document).ready(function(){
	
})

$(document).scroll(function() {
	if($(".observed").length > 0){
		var observed = $(".observed");
		
		var current_scroll = $(this).scrollTop();
		var event_scroll = observed.offset().top - observed.outerHeight();
		
		var appendObj = $(".group-image-page-body .group-image-list");
		var scrollBottom = $(document).height() - current_scroll;
		console.log("scrollBottom : " + scrollBottom + " / event_scroll : " + event_scroll);
		if(scrollBottom <= event_scroll){
			
			//paging 호출
			$(".observed").removeClass("observed");
			scrollPaging(appendObj);
		}
	}
});

function openImageViewer(idx){
	var viewer = $(".imageViewer .viewer");
	
	var image = $(".group-image-list .group-image-item").eq(idx);
	
	var src = image.find("input[name='src']").val();
	var name = image.find("input[name='name']").val();
	var member_id = image.find("input[name='member_id']").val();
	var member_name = image.find("input[name='member_name']").val();
	var object_name = image.find("input[name='object_name']").val();
	var board_seq = image.find("input[name='board_seq']").val();
	var regdate = image.find("input[name='regdate']").val();
		
	viewer.find(".viewer-content-name").html(name);
	viewer.find(".viewer-content-image").attr("src", src);
	viewer.find(".viewer-content-member").html(member_id + " (" + member_name + ") • " + regdate);
	viewer.find(".viewer-content-origin").attr("href", "/work/group/${WorkGroup.seq}/" + board_seq);
	viewer.find(".download-btn").attr("onclick", "downLoadFile('"+object_name+"')");
	
	if(idx == 0){
		viewer.find(".viewer-prevBtn").html("&nbsp;&nbsp;");
	} else {
		viewer.find(".viewer-prevBtn").html("&lt;");
	}
	
	var image_length = $(".group-image-list .group-image-item").length;
	
	if(idx == (image_length-1)){
		viewer.find(".viewer-nextBtn").html("&nbsp;&nbsp;");
	} else {
		viewer.find(".viewer-nextBtn").html("&gt;");
	}
	
	viewer.find(".viewer-nextBtn").attr("onclick", "openImageViewer("+(Number(idx)+1)+")");
	viewer.find(".viewer-prevBtn").attr("onclick", "openImageViewer("+(Number(idx)-1)+")");
	
	hideWorkHeader();
	$(".imageViewer").removeClass("hide");
}

function closeImageViewer(){
	showWorkHeader();
	$(".imageViewer").addClass("hide");
}

function scrollPaging(obj){
	var data = $("#pagingForm").serialize();
	var group_seq = "${WorkGroup.seq}";
	var image_length = $(".group-image-list .group-image-item").length;
	
	showLoading();
	$.ajax({
		url : '/work/group/' + group_seq + "/fileList",
		method : 'GET',
		data : data,
		dataType : 'JSON',
		success : function(res){
			if(res.fileList.length > 0){
				for(var i=0; i<res.fileList.length; i++){
					var html = getImageFileHtml(res.fileList[i], (i==(res.fileList.length-1)? "observed" : ""), image_length + i);
					console.log(obj.length);
					obj.append(html);
				}
				
				var offset = $("#pagingForm input[name='offset']").val();
				$("#pagingForm input[name='offset']").val(Number(offset) + Number(res.fileList.length));
			} else {
				$(".observed").removeClass("observed");
			}
			hideLoading();
		},
		error : function(request, status, error){
			//alert(request);
			hideLoading();
		}
	});
}

function getImageFileHtml(image, coverClass, idx){
	var html = "";
	
	html += '<div class="group-image-item ' + coverClass + '" ';
	html += 'onclick="openImageViewer(' + idx + ')">';
	html += '<img src="' + image.src + '">';
	html += '<input type="hidden" name="src" value="' + image.src + '">';
	html += '<input type="hidden" name="name" value="' + image.name + '">';
	html += '<input type="hidden" name="member_id" value="' + image.member_id + '">';
	html += '<input type="hidden" name="member_name" value="' + image.member_name + '">';
	html += '<input type="hidden" name="object_name" value="' + image.object_name + '">';
	html += '<input type="hidden" name="board_seq" value="' + image.board_seq + '">';
	html += '<input type="hidden" name="regdate" value="' + image.regdate + '">';
	html += '</div>';
	
	return html;
}

function downLoadFile(object_name){
	window.open("/work/file_down?object_name=" + object_name);
} 
</script>
</body>
</html>