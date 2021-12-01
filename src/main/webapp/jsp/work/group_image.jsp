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
	background-color: rgba(0,0,0,0.5);
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
	
		<div class="group-image-page">
			<div class="group-image-page-header">
			
			</div>
			<div class="group-image-page-body">
				<div class="group-image-list">
					<c:forEach items="${FileList}" var="image" varStatus="status">
						<div class="group-image-item ${fn:length(FileList) gt limit and status.last? 'observed':''}" onclick="openImageViewer()">
							<img src="${image.src}">
						</div>
					</c:forEach>
					
				</div>
			</div>
		</div>
	</section>
</article>
<div class="dim imageViewer hide">
	<div class="viewer">
		<button class="viewer-prevBtn">&lt;</button>
		<div class="viewer-content">
			<div class="viewer-content-header">
				02_256x96.png
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
					<a href="${FileList[0].src}">
						<img alt="" src="${FileList[0].src}">
					</a>
				</div>
			</div>
			<div class="viewer-content-footer">
			
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
	/* if($(".observed").length > 0){
		var observed = $(".observed");
		
		var current_scroll = $(this).scrollTop();
		var event_scroll = observed.offset().top - observed.outerHeight();
		
		var appendObj = $(".group-file-page-body table.table-list");
		var scrollBottom = $(document).height() - current_scroll;
		console.log("scrollBottom : " + scrollBottom + " / event_scroll : " + event_scroll);
		if(scrollBottom <= event_scroll){
			
			//paging 호출
			$(".observed").removeClass("observed");
			scrollPaging(appendObj);
		}
	} */
});

function openImageViewer(){
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
	
	showLoading();
	$.ajax({
		url : '/work/group/' + group_seq + "/fileList",
		method : 'GET',
		data : data,
		dataType : 'JSON',
		success : function(res){
			if(res.fileList.length > 0){
				for(var i=0; i<res.fileList.length; i++){
					var html = getGroupFileHtml(res.fileList[i], (i==(res.fileList.length-1)? "observed" : ""));
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
			alert(request);
			hideLoading();
		}
	});
}

function getGroupFileHtml(file, coverClass){
	var html = "";
	var fileNameArr = file.name.split(".");
	html += '<tr class="' + coverClass + '">';
	html += '<td>';
	html += '<span class="ra-checkbox" style="margin-left: 7px;">';
	html += '<input type="checkbox" name="donwload_file" value="' + file.object_name + '"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
	html += '</span>';
	html += '</td>';
	html += '<td>';
	html += '<span class="file-icon">';
	html += '<img src="/images/icon_' + getIconName(fileNameArr[fileNameArr.length-1]) + '.png">';
	html += '</span>';
	html += '<div class="file-name"><a href="' + file.src + '" target="_blank">' + file.name + '</a></div>';
	html += '<div class="file-size">' + file.size + '</div>';
	html += '</td>';
	html += '<td>';
	html += '' + file.member_id + ' (' + file.member_name + ')';
	html += '</td>';
	html += '<td>';
	html += fileNameArr[fileNameArr.length-1];
	html += '</td>';
	html += '<td>';
	html += file.regdate.substring(0, 11);
	html += '</td>';
	html += '<td>';
	html += '<a class="ra-button file-origin" href="/work/group/${WorkGroup.seq}/' + file.board_seq + '">';
	html += '원문';
	html += '</a>';
	html += '</td></tr>';

	return html;
}
</script>
</body>
</html>