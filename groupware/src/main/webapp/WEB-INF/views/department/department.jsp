<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.kimsclub.groupware.vo.DepartmentVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% %>
<title>Insert title here</title>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		var row=0;
		var level=0;
		<c:forEach items="${dlist}" var="dvo">
		
			if('${dvo.leaf}'==0){
				row++;
			}
			
			$('.${dvo.department_parent_no}').html('${dvo.department_name}');
			$('.${dvo.department_parent_no}').addClass('base');
			$('.base').next().addClass('${dvo.department_no}');
			$('.base').parent().parent().children().eq(row+${dvo.leaf}).children().eq(${dvo.level}-1).addClass('${dvo.department_parent_no}');
			$('.base').removeClass('${dvo.department_parent_no}');
			$('.base').removeClass('base');
		</c:forEach>
	});//ready end
</script>
<style>
  td {
    width: 100%;
    border: 1px solid #444444;
  }
</style>

</head>
<body>
<h1>${max_leaf} test			${max_level}</h1>
	<table >
		<thead></thead>
		<tbody>
			<c:forEach begin="1" end="${max_leaf}" varStatus="leaf">
			<tr >
				<c:forEach begin="1" end="${max_level}" varStatus="level"><td <c:if test="${leaf.current=='1'&&level.current=='1'}">class="0"</c:if>></td></c:forEach>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="insa_container">
		<ol id="orgMapHeader" class="org_map_header">
			<c:forEach begin="1" end="${max_level}" varStatus="level">
				<li style="display: list-item;">레벨${level.current}</li>	
			</c:forEach>
		</ol>

		<ol id="orgMap" class="org_map">
			<li class="1depth"><div class="wrap1" style="z-index: 0;" depth="0" no="819" loc="2" childs="99" no_depth="0" ori_name="hiworks">
					<span class="name" title="hiworks">hiworks</span>
					<div class="menu">
						<a href="javascript:void(0)" class="people" onclick="orgmanage.member(819)">36</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span></span></a>
					</div>
					<div class="move_group" style="display: none;">
						<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
					</div>
					<div class="name_modify" style="display: none;">
						<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
					</div>
				</div>
				<ol>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5423" loc="3" childs="4" no_depth="0" ori_name="관리운영위원회">
							<span class="name" title="관리운영위원회">관리운영위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5423)">5</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="4817" loc="5" childs="6" no_depth="0" ori_name="제도개선위원회">
							<span class="name" title="제도개선위원회">제도개선위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(4817)">3</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5572" loc="7" childs="8" no_depth="0" ori_name="사업개발위원회">
							<span class="name" title="사업개발위원회">사업개발위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5572)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5671" loc="9" childs="10" no_depth="0" ori_name="교육연수위원회">
							<span class="name" title="교육연수위원회">교육연수위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5671)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5673" loc="11" childs="34" no_depth="0" ori_name="사무총장">
							<span class="name" title="사무총장">사무총장</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5673)">9</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div>
						<ol>
							<li><div class="wrap1" style="z-index: 0;" depth="2" no="5674" loc="12" childs="23" no_depth="0" ori_name="사무차장1">
									<span class="name" title="사무차장1">사무차장1</span>
									<div class="menu">
										<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5674)">4</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
									</div>
									<div class="move_group" style="display: none;">
										<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
									</div>
									<div class="name_modify" style="display: none;">
										<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
									</div>
								</div>
								<ol>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5676" loc="13" childs="14" no_depth="0" ori_name="관리회계팀">
											<span class="name" title="관리회계팀">관리회계팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5676)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5677" loc="15" childs="16" no_depth="0" ori_name="사업팀">
											<span class="name" title="사업팀">사업팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5677)">1</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5680" loc="17" childs="18" no_depth="0" ori_name="제도개선연구실">
											<span class="name" title="제도개선연구실">제도개선연구실</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5680)">2</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5764" loc="19" childs="22" no_depth="0" ori_name="하위조직4">
											<span class="name" title="하위조직4">하위조직4</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5764)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5765" loc="20" childs="21" no_depth="0" ori_name="하위조직1">
													<span class="name" title="하위조직1">하위조직1</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5765)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
								</ol></li>
							<li><div class="wrap1" style="z-index: 0;" depth="2" no="5675" loc="24" childs="33" no_depth="0" ori_name="사무차장2">
									<span class="name" title="사무차장2">사무차장2</span>
									<div class="menu">
										<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5675)">4</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
									</div>
									<div class="move_group" style="display: none;">
										<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
									</div>
									<div class="name_modify" style="display: none;">
										<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
									</div>
								</div>
								<ol>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5678" loc="25" childs="28" no_depth="0" ori_name="교육팀">
											<span class="name" title="교육팀">교육팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5678)">1</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5772" loc="26" childs="27" no_depth="0" ori_name="교육운영팀">
													<span class="name" title="교육운영팀">교육운영팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5772)">1</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5679" loc="29" childs="30" no_depth="0" ori_name="전산팀">
											<span class="name" title="전산팀">전산팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5679)">2</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5776" loc="31" childs="32" no_depth="0" ori_name="하위조직3">
											<span class="name" title="하위조직3">하위조직3</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5776)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
								</ol></li>
						</ol></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5672" loc="35" childs="36" no_depth="0" ori_name="대외협력홍보위원회">
							<span class="name" title="대외협력홍보위원회">대외협력홍보위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5672)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5681" loc="37" childs="38" no_depth="0" ori_name="윤리위원회">
							<span class="name" title="윤리위원회">윤리위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5681)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5682" loc="39" childs="40" no_depth="0" ori_name="선거관리위원회">
							<span class="name" title="선거관리위원회">선거관리위원회</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5682)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5688" loc="41" childs="42" no_depth="0" ori_name="하위조직9">
							<span class="name" title="하위조직9">하위조직9</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5688)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5689" loc="43" childs="90" no_depth="0" ori_name="대표이사">
							<span class="name" title="대표이사">대표이사</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5689)">6</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div>
						<ol>
							<li><div class="wrap1" style="z-index: 0;" depth="2" no="5690" loc="44" childs="87" no_depth="0" ori_name="상무이사">
									<span class="name" title="상무이사">상무이사</span>
									<div class="menu">
										<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5690)">6</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
									</div>
									<div class="move_group" style="display: none;">
										<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
									</div>
									<div class="name_modify" style="display: none;">
										<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
									</div>
								</div>
								<ol>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5710" loc="45" childs="48" no_depth="0" ori_name="이사">
											<span class="name" title="이사">이사</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5710)">4</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5717" loc="46" childs="47" no_depth="0" ori_name="총무팀">
													<span class="name" title="총무팀">총무팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5717)">3</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5711" loc="49" childs="56" no_depth="0" ori_name="C.F.O">
											<span class="name" title="C.F.O">C.F.O</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5711)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5722" loc="50" childs="51" no_depth="0" ori_name="IR팀">
													<span class="name" title="IR팀">IR팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5722)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5723" loc="52" childs="53" no_depth="0" ori_name="해외사업팀">
													<span class="name" title="해외사업팀">해외사업팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5723)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5724" loc="54" childs="55" no_depth="0" ori_name="중국YINSI법인">
													<span class="name" title="중국YINSI법인">중국YINSI법인</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5724)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5714" loc="57" childs="60" no_depth="0" ori_name="제조부장">
											<span class="name" title="제조부장">제조부장</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5714)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5725" loc="58" childs="59" no_depth="0" ori_name="제조팀">
													<span class="name" title="제조팀">제조팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5725)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5715" loc="61" childs="74" no_depth="0" ori_name="공장장">
											<span class="name" title="공장장">공장장</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5715)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div>
										<ol>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5726" loc="62" childs="63" no_depth="0" ori_name="품질관리팀">
													<span class="name" title="품질관리팀">품질관리팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5726)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5727" loc="64" childs="65" no_depth="0" ori_name="생산팀">
													<span class="name" title="생산팀">생산팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5727)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5728" loc="66" childs="67" no_depth="0" ori_name="생산관리팀">
													<span class="name" title="생산관리팀">생산관리팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5728)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5729" loc="68" childs="69" no_depth="0" ori_name="물류팀">
													<span class="name" title="물류팀">물류팀</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5729)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5730" loc="70" childs="71" no_depth="0" ori_name="전산">
													<span class="name" title="전산">전산</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5730)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
											<li><div class="wrap1" style="z-index: 0;" depth="4" no="5777" loc="72" childs="73" no_depth="0" ori_name="하위조직6">
													<span class="name" title="하위조직6">하위조직6</span>
													<div class="menu">
														<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5777)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
													</div>
													<div class="move_group" style="display: none;">
														<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
													</div>
													<div class="name_modify" style="display: none;">
														<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
													</div>
												</div></li>
										</ol></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5716" loc="75" childs="76" no_depth="0" ori_name="이사 2">
											<span class="name" title="이사 2">이사 2</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5716)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5718" loc="77" childs="78" no_depth="0" ori_name="경영기획팀">
											<span class="name" title="경영기획팀">경영기획팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5718)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5719" loc="79" childs="80" no_depth="0" ori_name="영업마케팅팀">
											<span class="name" title="영업마케팅팀">영업마케팅팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5719)">1</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5720" loc="81" childs="82" no_depth="0" ori_name="디자인팀">
											<span class="name" title="디자인팀">디자인팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5720)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5721" loc="83" childs="84" no_depth="0" ori_name="연구개발팀">
											<span class="name" title="연구개발팀">연구개발팀</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5721)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
									<li><div class="wrap1" style="z-index: 0;" depth="3" no="5731" loc="85" childs="86" no_depth="0" ori_name="TF팀(겸임)">
											<span class="name" title="TF팀(겸임)">TF팀(겸임)</span>
											<div class="menu">
												<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5731)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
											</div>
											<div class="move_group" style="display: none;">
												<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
											</div>
											<div class="name_modify" style="display: none;">
												<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
											</div>
										</div></li>
								</ol></li>
							<li><div class="wrap1" style="z-index: 0;" depth="2" no="5713" loc="88" childs="89" no_depth="0" ori_name="C. F. O">
									<span class="name" title="C. F. O">C. F. O</span>
									<div class="menu">
										<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5713)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
									</div>
									<div class="move_group" style="display: none;">
										<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
									</div>
									<div class="name_modify" style="display: none;">
										<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
									</div>
								</div></li>
						</ol></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5732" loc="91" childs="92" no_depth="0" ori_name="1111">
							<span class="name" title="1111">1111</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5732)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5733" loc="93" childs="94" no_depth="0" ori_name="1112">
							<span class="name" title="1112">1112</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5733)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5766" loc="95" childs="96" no_depth="0" ori_name="하위조직13">
							<span class="name" title="하위조직13">하위조직13</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5766)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
					<li><div class="wrap1" style="z-index: 0;" depth="1" no="5770" loc="97" childs="98" no_depth="0" ori_name="하위조직14">
							<span class="name" title="하위조직14">하위조직14</span>
							<div class="menu">
								<a href="javascript:void(0)" class="people" onclick="orgmanage.member(5770)">0</a><a href="javascript:void(0)" class="menu_all"><span class="sub" style="display: none;"><span class="ggori"></span><span class="ss v1">하위조직 생성</span><span class="ss v2" onclick="orgmanage.moveToSubNodeLayer(this)">이동</span><span class="ss v4">순서변경</span><span class="ss v3">삭제</span></span></a>
							</div>
							<div class="move_group" style="display: none;">
								<a href="javascript:void(0)" class="left"></a><a href="javascript:void(0)" class="right"></a><a href="javascript:void(0)" class="top"></a><a href="javascript:void(0)" class="bottom"></a>
							</div>
							<div class="name_modify" style="display: none;">
								<input type="text"><a href="javascript:void(0)" class="btn_enter"></a>
							</div>
						</div></li>
				</ol></li>
		</ol>
	</div>
	
	
</body>
</html>