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
							<span class="groups-item-count">(0)</span>
							<span class="groups-folding-icon"></span>
						</a>
						<ul class="groups-category-list">
							<c:forEach items="${LnbWorkGroupList}" var="group">
								<c:if test="${group.category_seq eq category.seq}">
									<li class="category-item">
									<a class="" href="#">
											<span class="category-item-title">
												<span class="text-name">${group.name}</span>
											</span>
										</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
				<!-- <li class="groups-item">
					<a class="groups-item-title" href="#">
						<strong class="groups-item-name">따란</strong>
						<span class="groups-item-count">(0)</span>
						<span class="groups-folding-icon"></span>
					</a>
				</li>
				<li class="groups-item">
					<a class="groups-item-title" href="#">
						<strong class="groups-item-name">미분류 그룹</strong>
						<span class="groups-item-count">(6)</span>
						<span class="groups-folding-icon"></span>
					</a>
					<ul class="groups-category-list">
						<li class="category-item">
							<a class="" href="#">
								<span class="category-item-title">
									<span class="text-name">나만의 그룹</span>
								</span>
							</a>
						</li>
						<li class="category-item">
							<a class="" href="#">
								<span class="category-item-title">
									<span class="text-name">[공통] 자유게시판</span>
								</span>
							</a>
						</li>
					</ul>
				</li> -->
			</ul>
		</div>
	</div>
</div>
