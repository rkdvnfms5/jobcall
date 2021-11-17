<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="work-basic-layout-lnb">
	<div class="navbar">
		<div class="navbar-myprofile">
			<div class="navbar-myprofile-wrap">
				<a class="navbar-myprofile-image">
					<span class="avatar navbar-myprofile-avatar" style="width:54px; height: 54px; background-image: url('https://t1.daumcdn.net/agit_resources/images/empty_profile_large.png');">
					
					</span>
				</a>
				<div class="navbar-myprofile-name">
					<a href="#">
						<div class="navbar-myprofile-id">${member.id}</div>
						<div class="navbar-myprofile-nickname">
							<a href="#">프로필 입력하기</a>
						</div>
					</a>
				</div>
			</div>
			<ul class="navbar-mylist">
				<li>
					<a><span class="mylist-item-text">내글</span></a>
				</li>
				<li>
					<a><span class="mylist-item-text">내글</span></a>
				</li>
				<li>
					<a><span class="mylist-item-text">내글</span></a>
				</li>
				<li>
					<a><span class="mylist-item-text">내글</span></a>
				</li>
			</ul>
		</div>
		<c:if test="${member.auth eq 'master' || member.auth eq 'manager'}">
			<ul class="navbar-member-buttons transparent">
				<li>
					<a>멤버 초대하기</a>
				</li>
			</ul>
		</c:if>
		<ul class="navbar-member-buttons navbar-member-buttons-dual">
			<li>
				<a href="#">멤버 &amp; 팀</a>
			</li>
			<li>
				<a href="#">참여가능한 그룹</a>
			</li>
		</ul>
		<div class="navbar-groups">
			<div class="navbar-groups-new">
				<a class="groups-new" href="/work/group/new">
					새로운 그룹만들기
				</a>
			</div>
			<div class="navbar-groups-option">
				<em class="screen-out">내 그룹목록 설정</em>
				<a href="/work/category">그룹 카테고리 설정</a>
				<button>새글읽음처리</button>
			</div>
			<strong class="screen-out">내 그룹목록</strong>
			<ul class="navbar-groups-list">
				<c:forEach items="${LnbWorkCategoryList}" var="category">
					<li class="groups-item">
						<a class="groups-item-title" href="#">
							<strong class="groups-item-name">${category.title}</strong>
							<span class="groups-item-count">(${category.group_count})</span>
							<span class="groups-folding-icon"></span>
						</a>
						<ul class="groups-category-list">
							<c:forEach items="${LnbWorkGroupList}" var="group">
								<c:if test="${group.category_seq eq category.seq}">
									<li class="category-item">
									<a class="" href="/work/group/${group.seq}">
											<span class="category-item-title">
												<span class="text-name">${group.name}</span>
												<c:if test="${group.access eq 'private'}">
													<i class="ico ico-lock" aria-hidden="true"><svg width="8px" height="10px" viewBox="0 0 8 10" version="1.1"><g id="lock" stroke="none" stroke-width="1" fill="#A8A8A8" fill-rule="evenodd"><path d="M6.93177579,4.00166776 L6.93177579,2.96834236 C6.93177579,1.33357103 5.60056952,0.00832702498 3.9658879,0.00832702498 C2.32787324,0.00832702498 1,1.33901285 1,2.96834236 L1,4.00638348 C0.43643723,4.05812741 0,4.41813387 0,4.85503827 L0,9.14496173 C0,9.61718633 0.510070171,10 1.14005102,10 L6.85994898,10 C7.48958177,10 8,9.61744737 8,9.14496173 L8,4.85503827 C8,4.40089775 7.52824857,4.02945121 6.93177579,4.00166776 Z M2,4 L2,2.99011614 C2,1.89521499 2.8973316,1 4,1 C5.10293921,1 6,1.89311649 6,2.99011614 L6,4 L2,4 Z"></path></g></svg></i>
												</c:if>
											</span>
										</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
