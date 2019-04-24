<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- ckeditor -->
<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<title>양식 생성</title>
<script>
$(document).ready(function() {
	 $(function(){
      	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
	            width:'100%',
	            height:'400px',
	            filebrowserUploadUrl: '${pageContext.request.contextPath}/file/ckeditorImageUpload'
	        });
	    });
});//ready end
</script>
<style type="text/css">
.form-label-group {
  position: relative;
  margin: 4px 0px 4px;
  
}

.form-label-group > input{
  padding: var(--input-padding-y) var(--input-padding-x);
  height: 44px;
}
.form-label-group > label {
  padding: var(--input-padding-y) var(--input-padding-x);
  height: auto;
}

.form-label-group > label {
	padding-top:10px;
  position: absolute;
  top: 0;
  left: 0;
  display: block;
  width: 100%;
  margin-bottom: 0;
  /* Override default `<label>` margin */
  line-height: 1.5;
  color: #495057;
  border: 1px solid transparent;
  border-radius: 0.25rem;
  -webkit-transition: all 0.1s ease-in-out;
  transition: all 0.1s ease-in-out;
}

.form-label-group input::-webkit-input-placeholder {
  color: transparent;
}

.form-label-group input:-ms-input-placeholder {
  color: transparent;
}

.form-label-group input::-ms-input-placeholder {
  color: transparent;
}

.form-label-group input::placeholder {
  color: transparent;
}

.form-label-group input:not(:placeholder-shown) {
  padding-top: calc(var(--input-padding-y) + var(--input-padding-y) * (2 / 3));
  padding-bottom: calc(var(--input-padding-y) / 3);
}

.form-label-group input:not(:placeholder-shown) ~ label {
  padding-top: calc(var(--input-padding-y) / 3);
  padding-bottom: calc(var(--input-padding-y) / 3);
  font-size: 12px;
  color: #777;
}
</style>
</head>
<body>
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper" style="min-height: 927px;">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">양식</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-primary">
						<div class="panel-heading">양식 생성</div>
						<div class="panel-body">
							<form action="/groupware/form/createForm" method="post">
								<div class="form-group">
									<div class="row">
										<div class="col-lg-8">
											<div class="form-label-group">
												<input type="text" id="form_name" name="form_name" class="form-control" required="required" autofocus="autofocus" value="${fvo.form_name}"> <label for="form_name">양식 이름</label>
											</div>
										</div>
										<div class="col-lg-2">
											<div class="form-label-group">
												<label><input type="radio" name="form_activation" value="활성화" <c:if test="${fvo.form_activation=='활성화'}">checked="checked"</c:if>>양식 활성화</label>
											</div>
										</div>
										<div class="col-lg-2">
											<div class="form-label-group">
												<label><input type="radio" name="form_activation" value="비활성화" <c:if test="${fvo.form_activation=='비활성화'}">checked="checked"</c:if>>양식 비활성화</label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<div class="form-label-group">
												<input type="text" id="form_desc" name="form_desc" class="form-control" placeholder="양식 설명" required="required" maxlength="150" value="${fvo.form_desc}"> <label for="form_desc">양식 설명</label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<textarea name="form_contents" id="ckeditor">${fvo.form_contents}</textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<input type="hidden" name="form_no" value="${fvo.form_no}" />
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<input type="submit" class="btn-primary btn-block" value="확인">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>