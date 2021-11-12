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
		<header class="group-header">
			<div class="group-header__image">
				<div style="background-image: url('https://t1.daumcdn.net/agit_resources/images/background/9.png');"></div>
			</div>
			
			<div class="group-header__body">
				<div class="group-header__info">
					<h2 class="group-header__title">
						<a class="group-header__title-link" href="#">${WorkGroup.name}</a>
					</h2>
					<p class="group-header__short-desc">${WorkGroup.name} 업무 협업방입니다.</p>
					<div class="group-header__meta">
						<c:if test="${WorkGroup.access eq 'private'}">
							<span class="group-header__private-group" title="이 그룹은 초대를 받은 아지트 멤버들에게만 보입니다.">
								<i class="ico ico-lock" aria-hidden="true">
									<svg width="8px" height="10px" viewBox="0 0 8 10" version="1.1"><g id="lock" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M6.93177579,4.00166776 L6.93177579,2.96834236 C6.93177579,1.33357103 5.60056952,0.00832702498 3.9658879,0.00832702498 C2.32787324,0.00832702498 1,1.33901285 1,2.96834236 L1,4.00638348 C0.43643723,4.05812741 0,4.41813387 0,4.85503827 L0,9.14496173 C0,9.61718633 0.510070171,10 1.14005102,10 L6.85994898,10 C7.48958177,10 8,9.61744737 8,9.14496173 L8,4.85503827 C8,4.40089775 7.52824857,4.02945121 6.93177579,4.00166776 Z M2,4 L2,2.99011614 C2,1.89521499 2.8973316,1 4,1 C5.10293921,1 6,1.89311649 6,2.99011614 L6,4 L2,4 Z"></path></g></svg>
								</i>
								비공개 그룹
							</span>
							<span class="middle-dot"> · </span>
						</c:if>
						<span class="group-header__master-nickname">${WorkGroup.register} (마스터명)</span>
						<span class="middle-dot"> · </span>
						<span class="group-header__members-count">${WorkGroup.member_count}명</span>
					</div>
				</div>
				<div class="group-header__controls">
					<c:if test="${WorkGroup.member_seq eq member.seq}">
						<span class="ra-popover__trigger group-header__config-menu-button-wraper" title="">
							<button class="ra-config__button group-header__config-menu-button" onclick="goGroupSetting(${WorkGroup.seq})">
								<i class="ico ico-setting" aria-hidden="true"><svg width="12px" height="12px" viewBox="0 0 12 12" version="1.1"><g id="setting" stroke="none" stroke-width="1" fill="#5A86DD" fill-rule="evenodd"><path d="M5,2.12601749 L5,0.999807492 C5,0.447629061 5.44386482,0 6,0 C6.55228475,0 7,0.443716645 7,0.999807492 L7,2.12601749 C7.36702099,2.22048216 7.71365561,2.36572819 8.03196735,2.55381909 L8.82856325,1.75722319 C9.21901236,1.36677408 9.84939373,1.36411236 10.2426407,1.75735931 C10.633165,2.1478836 10.6359924,2.77822114 10.2427768,3.17143675 L9.44618091,3.96803265 C9.63427181,4.28634439 9.77951784,4.63297901 9.87398251,5 L11.0001925,5 C11.5523709,5 12,5.44386482 12,6 C12,6.55228475 11.5562834,7 11.0001925,7 L9.87398251,7 C9.77951784,7.36702099 9.63427181,7.71365561 9.44618091,8.03196735 L10.2427768,8.82856325 C10.6332259,9.21901236 10.6358876,9.84939373 10.2426407,10.2426407 C9.8521164,10.633165 9.22177886,10.6359924 8.82856325,10.2427768 L8.03196735,9.44618091 C7.71365561,9.63427181 7.36702099,9.77951784 7,9.87398251 L7,11.0001925 C7,11.5523709 6.55613518,12 6,12 C5.44771525,12 5,11.5562834 5,11.0001925 L5,9.87398251 C4.63297901,9.77951784 4.28634439,9.63427181 3.96803265,9.44618091 L3.17143675,10.2427768 C2.78098764,10.6332259 2.15060627,10.6358876 1.75735931,10.2426407 C1.36683502,9.8521164 1.36400758,9.22177886 1.75722319,8.82856325 L2.55381909,8.03196735 C2.36572819,7.71365561 2.22048216,7.36702099 2.12601749,7 L0.999807492,7 C0.447629061,7 0,6.55613518 0,6 C0,5.44771525 0.443716645,5 0.999807492,5 L2.12601749,5 C2.22048216,4.63297901 2.36572819,4.28634439 2.55381909,3.96803265 L1.75722319,3.17143675 C1.36677408,2.78098764 1.36411236,2.15060627 1.75735931,1.75735931 C2.1478836,1.36683502 2.77822114,1.36400758 3.17143675,1.75722319 L3.96803265,2.55381909 C4.28634439,2.36572819 4.63297901,2.22048216 5,2.12601749 Z M6,8 C7.1045695,8 8,7.1045695 8,6 C8,4.8954305 7.1045695,4 6,4 C4.8954305,4 4,4.8954305 4,6 C4,7.1045695 4.8954305,8 6,8 Z"></path></g></svg></i>
								<span>그룹관리</span>
							</button>
						</span>
					</c:if>
				</div>
			</div>
			
			<div class="group-header__footer group-header__desc--open">
				<pre class="group-header__desc group-header__desc--premode">나만의 그룹에서 내 업무와 관련된 다양한 생각들을 정리하고 기록을 남겨보세요</pre>
				<button class="group-header__desc-button">설명 접기</button>
				<strong class="screen-out">그룹 탭 메뉴</strong>
				<ul class="ra-tab-menu tab-menu__group" role="tablist">
					<li class="ra-tab-menu__item ra-tab-menu__item--active" role="tab" aria-selected="true">
						<a href="#">전체</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">멤버</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">사진</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">파일</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">일정</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">노트</a>
					</li>
					<li class="ra-tab-menu__item" role="tab" aria-selected="false">
						<a href="#">요청</a>
					</li>
				</ul>
			</div>
		</header>
		
	<form action="/work/board" id="insertBoardForm" method="post">
		<div class="wall-list-page">
			<div class="message-form-group message-form-group--PLAIN">
				<div class="message-form-group__header">
					<ul class="message-form-group__tabs">
						<li class="message-form-group__tab message-form-group__tab--active">
							<button>
								<i class="ico ico-wall_form_plain" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_plain"><path d="M4.84456465,13.6099463 C5.03399088,13.5213435 5.21151614,13.3986953 5.3680596,13.2421518 L13.4644334,5.145778 C14.1751621,4.43504933 14.1823793,3.26136717 13.4629255,2.54191344 C12.7384559,1.8174438 11.5776819,1.8217846 10.859061,2.54040555 L2.76268715,10.6367794 C2.60721175,10.7922548 2.48540199,10.9698842 2.39750031,11.1600664 L2.22570384,11.1737627 L2,14.004839 L4.8310763,13.7791351 L4.84456465,13.6099463 L4.84456465,13.6099463 Z M9.73653905,3.66292745 L12.3419115,6.26829991 L11.5777165,7.03249494 L8.97234401,4.42712249 L9.73653905,3.66292745 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>글쓰기</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_schedule" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_schedule"><path transform="translate(0, -1)" d="M1,17 C0.4,17 0,16.6 0,16 L0,4 C0,3.4 0.4,3 1,3 L3,3 L3,2 C3,1.4 3.4,1 4,1 C4.6,1 5,1.4 5,2 L5,3 L11,3 L11,2 C11,1.4 11.4,1 12,1 C12.6,1 13,1.4 13,2 L13,3 L15,3 C15.6,3 16,3.4 16,4 L16,16 C16,16.6 15.6,17 15,17 L1,17 Z M2,6 L14,6 L14,15 L2,15 L2,6 Z M10,8 L12,8 L12,10 L10,10 L10,8 Z M4,8 L6,8 L6,10 L4,10 L4,8 Z M4,11 L6,11 L6,13 L4,13 L4,11 Z M7,8 L9,8 L9,10 L7,10 L7,8 Z M10,11 L12,11 L12,13 L10,13 L10,11 Z M7,11 L9,11 L9,13 L7,13 L7,11 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>일정</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_task" aria-hidden="true"><svg width="16px" height="16px" viewBox="0 0 16 16" version="1.1"><g id="wall_form_task"><path d="M1.00087166,0 L14.9991283,0 C15.5518945,0 16,0.444630861 16,1.00087166 L16,14.9991283 C16,15.5518945 15.5553691,16 14.9991283,16 L1.00087166,16 C0.448105505,16 0,15.5553691 0,14.9991283 L0,1.00087166 C0,0.448105505 0.444630861,0 1.00087166,0 Z M2,2 L14,2 L14,14 L2,14 L2,2 Z M7.12238198,8.12173857 L9.94873775,5.29538279 C10.340406,4.90371453 10.9717757,4.90006449 11.3650227,5.29331144 C11.755547,5.68383574 11.7625006,6.3100471 11.3629513,6.70959635 L7.83156011,10.2409876 C7.83121477,10.2413329 7.83086924,10.2416779 7.83052353,10.2420227 C7.83017914,10.242368 7.8298341,10.2427136 7.82948876,10.2430589 C7.43896446,10.6335832 6.80862693,10.6364106 6.41541132,10.243195 L4.29381873,8.12160244 C3.90336961,7.73115333 3.9007079,7.10077196 4.29395485,6.70752501 C4.68447914,6.31700071 5.31481668,6.31417327 5.70803229,6.70738888 L7.12238198,8.12173857 Z" stroke="none" stroke-width="1" fill-rule="evenodd"></path></g></svg>
								</i>
								<span>요청</span>
							</button>
						</li>
						<li class="message-form-group__tab">
							<button>
								<i class="ico ico-wall_form_poll" aria-hidden="true"><svg width="16" height="16" viewBox="0 0 16 16"><path fill="#828282" fill-rule="evenodd" d="M0 8h4.058v8H0V8zm6-6h4.058v14H6V2zm6 9h4.058v5H12v-5z"></path></svg>
								</i>
								<span>투표</span>
							</button>
						</li>
					</ul>
				</div>
				<div class="message-form-group__body">
					<div class="plain-message-form">
						<div class="message-form message-form--editing message-form--mode-wysiwyg" aria-disabled="false">
							<div class="message-form__body">
								<div class="message-form__text-wrap">
									<div class="react-measure-wrap">
										<textarea rows="8" cols="" name="content" id="contentTextArea"></textarea>
   									</div>
	    						</div>
	    						<div class="message-form__footer">
	    							<div class="message-form__footer-leftalign">
	    								<span class="message-form__attach-file" onclick="$('#attachFiles').click();">
	    									<button type="button" class="icon-button" aria-label="[object Object]">
	    										<i class="ico ico-attach" aria-hidden="true"><svg width="12px" height="13px" viewBox="0 0 12 13" version="1.1"><g id="attach" stroke="none" stroke-width="1" fill="#A0A0A0" fill-rule="evenodd"><path d="M12,6.82441256 L6.84573271,11.8390279 C6.05830882,12.605117 5.1142178,12.9920643 4.01343133,12.9998816 C2.91264486,13.0076988 1.96855384,12.6285686 1.18112994,11.8624795 C0.393706043,11.0963904 -6.03961325e-14,10.1739704 -6.03961325e-14,9.09519189 C-6.03961325e-14,8.01641338 0.393706043,7.09399342 1.18112994,6.32790433 L6.84159577,0.820805635 C7.40404141,0.273599142 8.09503569,0 8.91459934,0 C9.73416299,0 10.4251573,0.273599142 10.9876029,0.820805635 C11.5500485,1.36801213 11.8272497,2.03637575 11.8192148,2.82591654 C11.8111799,3.61545734 11.5259439,4.28382096 10.9634982,4.83102745 L5.56404706,10.0841835 C5.2105098,10.4281419 4.78466449,10.6001185 4.28649835,10.6001185 C3.78833221,10.6001185 3.3624869,10.4281419 3.00894964,10.0841835 C2.65541238,9.74022514 2.47462899,9.32200931 2.46659405,8.82952347 C2.45855912,8.33703763 2.63130769,7.91882179 2.98484495,7.57486343 L7.87809756,2.81419075 L8.64944772,3.56464161 L3.75619511,8.32531429 C3.61156623,8.46602453 3.54327029,8.63409258 3.55130522,8.82952347 C3.55934016,9.02495436 3.63567093,9.1930224 3.7802998,9.33373264 C3.92492868,9.47444288 4.09365984,9.54479695 4.28649835,9.54479695 C4.47933686,9.54479695 4.64806802,9.47444288 4.7926969,9.33373264 L10.1921481,4.08057658 C10.5456853,3.73661822 10.7264687,3.31840238 10.7345036,2.82591654 C10.7425386,2.3334307 10.56979,1.91521487 10.2162527,1.5712565 C9.86271548,1.22729813 9.42883535,1.05532153 8.91459934,1.05532153 C8.40036333,1.05532153 7.9664832,1.22729813 7.61294594,1.5712565 L1.95248011,7.07835519 C1.39003446,7.62556168 1.10881586,8.29783386 1.10881586,9.09519189 C1.10881586,9.89254993 1.39003446,10.5648221 1.95248011,11.1120286 C2.51492575,11.6592351 3.20190262,11.9289257 4.01343133,11.9211084 C4.82496004,11.9132912 5.51193691,11.6357835 6.07438255,11.088577 L11.2286498,6.0739617 L12,6.82441256 Z"></path></g></svg></i>
	    									</button>
	    									<span class="message-form__attach-file-label">파일첨부</span>
	    								</span>
	    							</div>
	    							<div class="message-form-submit-control">
	    								<button class="ra-button message-form-submit-control__cancel-button">취소</button>
	    								<button type="button" id="insert-submit" onclick="insertBoard()" disabled="" class="ra-button message-form-submit-control__submit-button ra-button--accent">작성하기</button>
	    							</div>
	    						</div>
	    					</div>
	    					<input id="attachFiles" name="attachFiles" type="file" multiple="" autocomplete="off" style="display: none;">
	    				</div>
	    			</div>
    			</div>
			</div>
		</form>
			<div class="scroll-container scroll-container--window wall__wall-message-list" tabindex="-1">
				<div class="wall-list-wrap">
				
				</div>
			</div>
		</div>
	</section>
</article>
<script>
$(document).ready(function(){
	$("#contentTextArea").on('focusin focusout propertychange change keyup paste input', function(){
		var check = checkBoardValue();
		if(check){
			$("#insert-submit").attr("disabled", false);
		} else {
			$("#insert-submit").attr("disabled", true);
		}
	});
})

function checkBoardValue(){
	if($.trim($("#contentTextArea").val()) == ''){
		return false;
	}
	
	return true;
}

function goGroupSetting(groupseq){
	location.href = '/work/group/' + groupseq + '/setting';
}

function insertBoard(){
	var url = $("#insertBoardForm").attr("action");
	var data = new FormData();
	var formData = $("#insertBoardForm").serializeArray();
	console.log(formData)
	$(formData).each(function(index, obj){
		data.append(obj.name, obj.value);
	})
	
	
	var attachFileArr = new FormData($("#insertBoardForm")[0]).getAll("attachFiles");
	console.log(attachFileArr)
	for(var i=0; i<attachFileArr.length; i++){
		data.append("attachFiles", attachFileArr[i]);
		console.log(attachFileArr[i]);
	}
	
	data.append("type", "plain");
	
	$.ajax({
		url : url,
		type : 'POST',
		enctype: 'multipart/form-data',
		data : data,
		processData: false,
		contentType : false,
		dataType : 'JSON',
		success : function(res){
			//location.reload();
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\nresponseText : " + request.responseText + "\nerror" + error);
		}
	})
	
}

</script>
</body>
</html>