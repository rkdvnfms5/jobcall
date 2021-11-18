function insertCategory(){
	var title = $(".tmp-cate-editor-cates__item-input").val();
	
	$.ajax({
		url : '/work/category',
		method : 'POST',
		data : {title : title},
		dataType : 'JSON',
		success : function(res) {
			location.reload();
		},
		error : function(xhr, status, error){
			alert("카테고리 추가를 실패했습니다.")
		}
	})
}

//server.xml 에 추가 <Connector parseBodyMethods="POST,PUT,DELETE" />

function updateCategory(seq){
	var title = $(".tmp-cate-editor-cates__item-input").val();
	
	$.ajax({
		url : '/work/category',
		method : 'PUT',
		data : {seq : seq, title : title},
		dataType : 'JSON',
		success : function(res) {
			location.reload();
		},
		error : function(xhr, status, error){
			alert("카테고리 수정을 실패했습니다.")
		}
	})
}

function deleteCategory(seq){
	if(confirm("카테고리를 삭제하시겠습니까?")){
		$.ajax({
			url : '/work/category',
			method : 'DELETE',
			data : {seq : seq},
			dataType : 'JSON',
			success : function(res) {
				location.reload();
			},
			error : function(xhr, status, error){
				alert("카테고리 삭제를 실패했습니다.")
			}
		})
	}
}


function moveGroupCategory(){
	var categoryseq = $("#categorySelect").val();
	var groupseqArr = new Array();
	
	$("#group-list").find("input[type=checkbox]:checked").each(function(index, item){
		groupseqArr.push(Number(item.value));
	});
	
	
	$.ajax({
		url : '/work/category_move',
		method : 'POST',
		data : {category_seq : categoryseq, groupSeqList : groupseqArr},
		dataType : 'JSON',
		success : function(res) {
			if(res.res > 0){
				location.reload();
			}
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
}

function checkCategoryGroupAll(){
	if($("#groupCheckAll").is(":checked")){
		$("#group-list").find("input[type=checkbox]").prop("checked", true);
	} else {
		$("#group-list").find("input[type=checkbox]").prop("checked", false);
	}
}

function uncheckCategoryGroupAll(){
	$("#groupCheckAll").prop("checked", false);
	$("#group-list").find("input[type=checkbox]").prop("checked", false);
}

function checkGroupValue() {
	if($.trim($("input[name='access']:checked")).length < 1){
		return false;
	}
	
	if($.trim($("#group_name").val()) == ''){
		return false;
	}
	
	if($.trim($("#group_content").val()) == ''){
		return false;
	}
	
	return true;
}

function checkBoardValue(){
	if($.trim($("#contentTextArea").val()) == ''){
		return false;
	}
	
	return true;
}

function goGroupSetting(groupseq){
	location.href = '/work/group/' + groupseq + '/setting';
}

function actionCheck(obj, action, target, target_seq, seq){
	var parentObj = $(obj).parent();
	var brother = parentObj.siblings('.feedback-button')
	var brotherBtn = brother.find('.feedback-button__thumb');
	
	if(parentObj.hasClass("on")){
		deleteActionLog(seq, obj);
	} else {
		if(brother.hasClass("on")){
			updateActionLog(seq, action, obj);
		} else {
			insertActionLog(target, target_seq, action, obj);
		}
	}
	
	//parentObj.toggleClass("on");
}

function insertActionLog(target, target_seq, action, obj){
	showLoading();
	$.ajax({
		url : '/work/action',
		method : 'POST',
		data : {target : target, target_seq : target_seq, action : action},
		dataType : 'JSON',
		success : function(res) {
			location.reload();
			hideLoading();
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			hideLoading();
		}
	})
}

function updateActionLog(seq, action, obj){
	if(seq > 0){
		showLoading();
		$.ajax({
			url : '/work/action/' + seq,
			method : 'PUT',
			data : {seq : seq, action : action},
			dataType : 'JSON',
			success : function(res) {
				location.reload();
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	} else {
		alert("seq 정보가 없습니다.");
	}
	
}

function deleteActionLog(seq, obj){
	if(seq > 0){
		showLoading();
		$.ajax({
			url : '/work/action/' + seq,
			method : 'DELETE',
			data : {seq : seq},
			dataType : 'JSON',
			success : function(res) {
				location.reload();
				hideLoading();
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				hideLoading();
			}
		})
	} else {
		alert("seq 정보가 없습니다.");
	}
}
