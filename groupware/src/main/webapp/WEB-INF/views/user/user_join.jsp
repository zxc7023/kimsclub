<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<script type="text/javascript">
var idcheck=0;
var pwcheck=0;
$(document).ready(function() {
	var globalTimeout = null;
	$('#id').keyup(function() {
		if (globalTimeout != null){
		    clearTimeout(globalTimeout);
		}
		globalTimeout = setTimeout(function() {
		globalTimeout = null;  
		$.ajax({
			url : "ajax_idcheck.jsp",
			type : 'get',
			data : {"id" : $('#id').val()},
			success : function(server_result) {
				var json = JSON.parse(server_result);
		        if(json.result=="success"&&$('#id').val()!="") {
			       	$("#idResult").html("<h3 style=\"display: inline;\">사용 가능한 아이디 입니다.</h3>");
			       	$("#idResult").css("color", "rgb(72,212,211)");
			       	idcheck=0;
				} else if (json.result == "fail") {
			       	$("#idResult").html("<h3 style=\"display: inline;\">중복된 아이디 입니다.</h3>");
			       	$("#idResult").css("color", "red");
			       	idcheck=1;
				} else if (json.result=="success"&&$('#id').val()==""){
			      	$("#idResult").html("<h3 style=\"display: inline;\">아이디를 입력하세요.</h3>");
			      	$("#idResult").css("color", "black");
			      	idcheck=0;
			    }
			}
		});
	},200);
	});
	
	$('#pwcheck').keyup(function() {
		if (globalTimeout != null){
		    clearTimeout(globalTimeout);
		}
		globalTimeout = setTimeout(function() {
		globalTimeout = null;
		var ui = document.userinfo;
		if(ui.pw.value != ui.pwcheck.value&&ui.pwcheck.value!=""){
			$('#pwResult').html("<h3 style=\"display: inline;\">비밀번호가 다릅니다.</h3>")
			$("#pwResult").css("color", "red");
		}
		else if(ui.pw.value == ui.pwcheck.value){
	       	$("#pwResult").html("<h3 style=\"display: inline;\">비밀번호가 확인되었습니다.</h3>");
	       	$("#pwResult").css("color", "rgb(72,212,211)");
		}
	},200);
	});
});
function checkvalue(){
	var ui = document.userinfo;
	if(ui.name.value == ""){
	alert("이름을 입력해주세요");
	ui.name.focus();
	return false;
	}
	if(ui.id.value == ""){
		alert("아이디를 입력해주세요");
		ui.id.focus();
		return false;
	}
	if(idcheck==1){
		alert("아이디 중복입니다.")
		return false;
	}
	if(ui.pw.value == ""){
		alert("비밀번호를 입력해주세요");
		ui.pw.focus();
		return false;
	}
	if(ui.pw.value != ui.pwcheck.value){
		alert("비밀번호가 일치하지않습니다.");
		ui.pwcheck.focus();
		return false;
	}
	if(ui.addr.value == ""){
		alert("주소를 입력해주세요");
		ui.addr.focus();
		return false;
	}
	if(ui.email.value == ""){
		alert("이메일을 입력해주세요");
		ui.email.focus();
		return false;
	}
	if(ui.hp1.value == ""){
		alert("휴대폰번호를 입력해주세요");
		ui.hp1.focus();
		return false;
	}
	if(ui.hp2.value == ""){
		alert("전부 입력해주세요");
		ui.hp2.focus();
		return false;
	}
	if(ui.hp3.value == ""){
		alert("전부 입력해주세요");
		ui.hp3.focus();
		return false;
	}
	alert("회원가입이 완료되었습니다.");
	location.href="main.jsp";
}

function cancle(){
	location.href="main.jsp";
}
</script>

</head>
<body>

	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper"  >

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">회원가입</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-primary">
					<div class="panel-heading">회원가입</div>
					<div class="panel-body">
						<form class="myForm" id="userinfoForm" action="UserJoinServlet" method="post" onsubmit="return checkvalue()" name=userinfo>
							<input type="hidden" name="num">
							<h3 >이름:</h3><input type="text" class="myFormInput" name="name"><br>
							<h3 style="display: inline;">아이디:</h3><div id="idResult" style="display: inline;"></div><input type="text" class="myFormInput" name="id" id ="id"><br>
							<h3>비밀번호:</h3><input type="password" class="myFormInput" name="pw"><br>
							<h3 style="display: inline;">비밀번호 확인:</h3><div id="pwResult" style="display: inline;"></div><input type="password" class="myFormInput" name="pwcheck" id="pwcheck"><br>
							<h3 style="display: inline;">주소:</h3>
							<input type="button" class="postcode" onclick="sample6_execDaumPostcode()" value="주소 찾기">
							<input type="text" class="myFormInput" name="addr" id="addr" readonly="readonly"><br>
							<h3>이메일:</h3><input type="text" name="email" class="myFormInput" placeholder="example@example.com"><br>
							<h3>휴대폰번호:</h3><br><input type="text" class="myFormHpInput" name="hp1" pattern="[0-9]{2,3}" size="1" maxlength="3" oninvalid="this.setCustomValidity('010,011,012중에 입력해주세요')"><h3 id="mid">-</h3>
							<input type="text" class="myFormHpInput" name="hp2" pattern="[0-9]{3,4}" size="1" maxlength="4" oninvalid="this.setCustomValidity('3자리및4자리숫자를 입력하세요')"><h3 id="mid">-</h3>
							<input type="text" class="myFormHpInput" name="hp3" pattern="[0-9]{3,4}" size="1" maxlength="4" oninvalid="this.setCustomValidity('3자리및4자리숫자를 입력하세요')"><br>
							<input type="submit" class="myFormButton" value="회원가입">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullAddr;
					
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr').focus();
            }
        }).open();
    }
</script>
</body>
</html>