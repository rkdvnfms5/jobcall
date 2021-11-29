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
	<section class="wall-page">
		<%@include file="/jsp/include/group_header.jsp" %>	
	
		<div class="group-file-page">
			<div class="group-file-page-header">
				<div class="">
					<button type="button" class="ra-button" onclick="downLoadFiles()">
						다운로드
					</button>
				</div>
			</div>
			<div class="group-file-page-body">
				<table class="table-list">
					<colgroup>
						<col width="5%">
						<col width="*">
						<col width="25%">
						<col width="8%">
						<col width="13%">
						<col width="9%">
					</colgroup>
					<tr class="title">
						<td></td>
						<td>파일명</td>
						<td>작성자</td>
						<td>확장자</td>
						<td>등록일</td>
						<td></td>
					</tr>
					<c:forEach items="${FileList}" var="file" varStatus="status">
						<tr class="${status.last? 'observed':''}">
							<td>
								<span class="ra-checkbox" style="margin-left: 7px;">
									<input type="checkbox" name="donwload_file" value="${file.object_name}"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>
								</span>
							</td>
							<td>
								<span class="file-icon">
									<i class="ico ico-file_others" aria-hidden="true"><svg width="22px" height="28px" viewBox="0 0 22 28" version="1.1"><g id="file_others" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><path d="M0,0 L14,0 L22,8 L22,28 L0,28 L0,0 L0,0 Z" fill="#BFBFBF"></path><path d="M14,0 L22,8 L14,8 L14,0 L14,0 Z" fill="#A2A2A2"></path></g></svg></i>
								</span>
								<div class="file-name"><a href="${file.src}" target="_blank">${file.name}</a></div>
								<div class="file-size">${file.size}</div>
							</td>
							<td>
								${file.member_id} (${file.member_name})
							</td>
							<td>
								<c:set var="fileNameArr" value="${fn:split(file.name, '.')}" />
								${fileNameArr[fn:length(fileNameArr)-1]}
							</td>
							<td>
								<fmt:parseDate value='${file.regdate}' var='regdate' pattern='yyyy-MM-dd'/>
                 				<fmt:formatDate value="${regdate}" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								<a class="ra-button file-origin" href="/work/group/${WorkGroup.seq}/${file.board_seq}">
									원문
								</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
</article>
<form action="" id="pagingForm">
	<input type="hidden" name="limit" value="${limit}">
	<input type="hidden" name="offset" value="${limit + offset}">
	<input type="hidden" name="group_seq" value="${WorkGroup.seq}">
</form>
<script>
$(document).ready(function(){
	
})

$(document).scroll(function() {
	if($(".observed").length > 0){
		var observed = $(".observed").prev()
		
		var current_scroll = $(this).scrollTop();
		var event_scroll = observed.offset().top - observed.outerHeight();
		
		var appendObj = $("group-file-page-body table.table-list");
		var scrollBottom = $(document).height() - current_scroll;
		console.log("scrollBottom : " + scrollBottom + " / event_scroll : " + event_scroll);
		if(scrollBottom >= event_scroll){
			
			//paging 호출
			$(".observed").removeClass("observed");
			scrollPaging(appendObj);
		}
	}
});

function scrollPaging(obj){
	console.log("d");
	var data = $("#pagingForm").serialize();
	var group_seq = data.get("group_seq");
	
	showLoading();
	$.ajax({
		url : '/work/group/' + group_seq + "/fileList",
		method : 'GET',
		data : data,
		dataType : 'JSON',
		success : function(res){
			if(res.workBoardList.length > 0){
				for(var i=0; i<res.fileList.length; i++){
					var html = getGroupFileHtml(res.fileList[i], (i==(res.fileList.length-1)? "observed" : ""));
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
	html += '<tr class="' + coverClass + '">';
	html += '<td>';
	html += '<span class="ra-checkbox" style="margin-left: 7px;">';
	html += '<input type="checkbox" name="donwload_file" value="' + file.object_name + '"><i class="ico ico-check" aria-hidden="true"><svg width="12px" height="8px" viewBox="0 0 12 8" version="1.1"><g id="check" stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd"><path d="M4.99685372,5.64132619 L1.61869009,2.25464234 C1.259796,1.89484307 0.651211121,1.88667968 0.280403287,2.25748751 C-0.0929897504,2.63088055 -0.0924314174,3.2282198 0.275876144,3.59745629 L4.08495948,7.4161467 C4.13085975,7.51742555 4.19562932,7.61248776 4.27936567,7.69622411 C4.44997063,7.86682907 4.66946164,7.95907209 4.89305305,7.97277496 C5.18344924,8.01973365 5.49472442,7.93409508 5.71900915,7.70981034 C5.8131187,7.61570079 5.88347352,7.50736538 5.93017291,7.39204159 L11.7236352,1.62112119 C12.0958712,1.25033354 12.0996142,0.651736824 11.7262211,0.278343786 C11.3554133,-0.0924640472 10.7536654,-0.0930861494 10.3808213,0.278307242 L4.99685372,5.64132619 L4.99685372,5.64132619 Z"></path></g></svg></i>';
	html += '</span>';
	html += '</td>';
	html += '<td>';
	html += '<span class="file-icon">';
	html += '<i class="ico ico-file_others" aria-hidden="true"><svg width="22px" height="28px" viewBox="0 0 22 28" version="1.1"><g id="file_others" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><path d="M0,0 L14,0 L22,8 L22,28 L0,28 L0,0 L0,0 Z" fill="#BFBFBF"></path><path d="M14,0 L22,8 L14,8 L14,0 L14,0 Z" fill="#A2A2A2"></path></g></svg></i>';
	html += '</span>';
	html += '<div class="file-name"><a href="' + file.src + '" target="_blank">' + file.name + '</a></div>';
	html += '<div class="file-size">' + file.size + '</div>';
	html += '</td>';
	html += '<td>';
	html += '' + file.member_id + ' (' + file.member_name + ')';
	html += '</td>';
	html += '<td>';
	var fileNameArr = file.name.split(".");
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

function downLoadFiles(){
	var checkArr = new Array();
	
	$("input[name='donwload_file']:checked").each(function(index, item){
		checkArr.push(item.value);
	});
	
	for(var i=0; i<checkArr.length; i++){
		downLoadFile(checkArr[i]);
	}
	
	$("input[name='donwload_file']").prop("checked", false);
} 

function downLoadFile(object_name){
	window.open("/work/file_down?object_name=" + object_name);
} 
</script>
</body>
</html>