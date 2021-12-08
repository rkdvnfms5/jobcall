function showLoading(){
	$(".lodingDim").removeClass('hide');
}

function hideLoading(){
	$(".lodingDim").addClass('hide');
}

function showWorkHeader(){
	$(".work-header").css("z-index", 10);
}

function hideWorkHeader(){
	$(".work-header").css("z-index", 0);
}

function replaceAll(str, searchStr, replaceStr) {
	return str.split(searchStr).join(replaceStr);
}

function getIconName(ext){
	switch (ext.toLowerCase()) {
	case "docx":
		ext = "docx";
		break;
	case "png":
	case "jpg":
	case "jpeg":
	case "gif":
		ext = "image";
		break;
	case "pdf":
		ext = "pdf";
		break;
	case "zip":
		ext = "zip";
		break;
	case "ppt":
	case "pptx":
		ext = "ppt";
		break;
	default:
		ext = "etc";
		break;
	}
	
	return ext;
}

function decryptXSSHtml(html){
	html = html.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&#40;/g, "(").replace(/&#41;/g, ")");
	return html;
}

