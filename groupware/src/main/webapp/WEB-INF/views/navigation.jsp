<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(document).ready(function() {

		var depth_1 = $('.sideBar .depth-1');
		var sideButn = $('.sideBar-btn');
		var sideMenu = $('.sideBar');
		var content = $('.sideBar + div');
		var side_width = sideMenu.outerWidth();

		depth_1.click(function() {
			$(this).toggleClass('active');
		});

		sideButn.click(function() {
			sideMenu.toggleClass('active');

			if (sideMenu.hasClass('active') == true) {
				TweenLite.to(sideMenu, 0.5, {
					ease : Power2.easeOut,
					marginLeft : -side_width
				});
				content.addClass('col-12').removeClass('col-10');
				
			} else {
				TweenLite.to(sideMenu, 0.5, {
					ease : Power2.easeOut,
					marginLeft : 0
				});
				content.addClass('col-10').removeClass('col-12');
			}
		});

	});
</script>

<div class="col-2 sideBar">
	<h1 class="logo">
		<a href="<%=application.getContextPath()%>"> <img src="${pageContext.request.contextPath}/resources/images/logo.png"/></a>
	</h1>
	<ul class="list-group list-group_1">
		<li class="depth-1 list-group-item"><a data-toggle="collapse" href="#pc-menu01" role="button" aria-expanded="false" aria-controls="menu01">결재</a>
			<div class="depth-2 collapse" id="pc-menu01">
				<ul class="list-group">
					<li class="list-group-item"><a href="#">새문서함</a></li>
					<li class="list-group-item"><a href="#">결재문서함</a></li>
					<li class="list-group-item"><a href="#">진행문서</a></li>
					<li class="list-group-item"><a href="#">반려문서</a></li>
					<li class="list-group-item"><a href="#">완료문서</a></li>
					<li class="list-group-item"><a href="#">참조문서</a></li>

				</ul>

			</div></li>
		<li class="depth-1 list-group-item"><a data-toggle="collapse" href="#pc-menu02" role="button" aria-expanded="false" aria-controls="menu02">휴가</a>
			<div class="depth-2 collapse" id="pc-menu02">
				<ul class="list-group">
					<li class="list-group-item"><a href="<%=application.getContextPath()%>/dayoff/dayoff_writeform">휴가 신청</a></li>
					<li class="list-group-item"><a href="#">2-2</a></li>
				</ul>

			</div></li>
		<li class="depth-1 list-group-item"><a data-toggle="collapse" href="#pc-menu03" role="button" aria-expanded="false" aria-controls="menu03">3</a>
			<div class="depth-2 collapse" id="pc-menu03">
				<ul class="list-group ">
					<li class="list-group-item"><a href="#">3-1</a></li>
					<li class="list-group-item"><a href="#">3-2</a></li>
					<li class="list-group-item"><a href="#">3-3</a></li>
				</ul>
			</div>
		</li>
		<li class="list-group-item"><a href="#">4</a></li>
		<li class="depth-1 list-group-item"><a data-toggle="collapse" href="#pc-menu05" role="button" aria-expanded="false" aria-controls="menu05">게시판</a>
			<div class="depth-2 collapse" id="pc-menu05">
				<ul class="list-group ">
					<li class="list-group-item"><a href="#">커뮤니티</a></li>
					<li class="list-group-item"><a href="#">공지사항</a></li>
				</ul>
			</div></li>
	</ul>
	
	<ul class="list-group sub-list">
		<li class="list-group-item"><a href="#">sub1</a></li>
		<li class="list-group-item"><a href="#">sub2</a></li>
		<li class="list-group-item"><a href="#">sub3</a></li>
		<li class="list-group-item"><a href="#">sub4</a></li>
	</ul>
	<button type="button" class="sideBar-btn">
		<span></span>
	</button>
</div>

