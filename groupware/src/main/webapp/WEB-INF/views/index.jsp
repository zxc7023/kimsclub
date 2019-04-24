<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		if('${map.unReadMsgCnt}'>0){
			$(".unReadMsgCnt").css("color","yellow")
		}
	});
</script>
<title>Kim's Club</title>
</head>

<body>

	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper"  >

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">KIM'S CLUB</h1>
				</div>
			</div>

			<div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa  fa-envelope fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge unReadMsgCnt">${map.unReadMsgCnt}</div>
                                    <div>읽지않은 쪽지</div>
                                </div>
                            </div>
                        </div>
                        <a href="messageList?box=inBox">
                            <div class="panel-footer">
                                <span class="pull-left">받은쪽지함</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-file-signature fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${apdCnt}</div>
                                    <div>결재해야 하는 문서</div>
                                </div>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/approvalDocList">
                            <div class="panel-footer">
                                <span class="pull-left">결재 문서함</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="far fa-file-alt fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${pdCnt}(${pMydCnt})</div>
                                    <div>진행중인 문서(내가 기안한 문서)</div>
                                </div>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/proceedDocList">
                            <div class="panel-footer">
                                <span class="pull-left">진행 문서함</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
		</div>
	</div>
</body>
</html>
