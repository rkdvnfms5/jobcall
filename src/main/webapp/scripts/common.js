function showLoading(){
	$(".lodingDim").removeClass('hide');
}

function hideLoading(){
	$(".lodingDim").addClass('hide');
}

function replaceAll(str, searchStr, replaceStr) {
	return str.split(searchStr).join(replaceStr);
}