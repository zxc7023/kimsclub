<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>ZTREE DEMO - noLine</TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/demo.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/zTreeStyle.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/zTree.js"></script>
<SCRIPT type="text/javascript">
$(document).ready(function() {
/* 나중에 수정
	var root = document.getElementById("rootOfTree");
	var arr = ${dlist};
	var kNode = {
			name : "",	//node의 이름
			no : "",		//node의 번호		
			pNo : "",	//부모 node의 번호
			isDorE : "",	//노드의 타입이 department인지 Employee인지 확인
			position : "",	//사원의 직위
			setKNode : function(object){
				this.name = object.department_name;	//node의 이름
				this.no = object.department_no;		//node의 번호		
				this.pNo = object.department_parent_no;	//부모 node의 번호
				this.isDorE = "D";	//노드의 타입이 department인지 Employee인지 확인
				this.position = "";	//사원의 직위
				return this;
			}
	}
	 kNodes =[];
	
	for(var x in arr){
		kNodes.push(arr[x]);
	}
	function makeNode(kNodes){
		for(var x in kNodes){
			kNodes[x].department_parent_no=='0'? insertRoot(kNodes[x]) : insertNode(kNodes[x]);
		}
	}
	function insertNode(kNode){
		alert("node 삽입");	
	}
	function insertRoot(kNode){
		alert("Root 삽입");
	}
	makeNode(kNodes);
	root.innerHTML = "<li><span>"+kNodes[0].name+"</span></li>"; 
}) */

function initMenu(){
    //트리 생성
    var el = makeMenu(makeNode(menus[0]));
    $("#rootOfTree").append(el);
}

//event -- add
// group -> type 파라미터 변경. by moki81.2012.03.24 
function setInValue(id, name, class1, type)
{
    //값 입력전 확인
    var ts = insertCheckLine('setInValue');
    if(ts == 'stop'){
        return 0;
    }
    var checkVal = checkUser(id);
    for(var x=1; x<25; x++){
        var tmp = $('#div_rname'+x).html();
        //다음 순서에 입력
        if(tmp == ''){
            $('#div_uid'+x).val(id);
            $('#div_class'+x).val(class1);
            $('#div_rname'+x).html(name);

            // 현재라인 캐싱 기능 추가에 따른 라디오 선택 추가 by moki81.
            var radio = $('input[name="radio_btn'+x+'"]');
            if ( type ) {
                radio.filter('input[value="' + type + '"]').attr('checked', 'checked');
            }
            else {
                radio.filter('input[value="sign"]').attr('checked', 'checked');
            }

            $('#div_radio'+x).css('display','block');
            $('#div_move'+x).css('display','block');
            $('#div_delete'+x).css('display','block');

            break;
        }
    }

}

//event -- delete
function setDelValue(no){
    //해당  칸 삭제
    $('#div_uid'+no).val();
    $('#div_class'+no).val();
    $('#div_rname'+no).html('');
    $('input[name="radio_btn'+no+'"]').filter('input[value="sign"]').attr('checked', 'checked');
    resetList(no);
    //라디오버튼 출력 정렬
    setRadioBtn(no);
    return;
}

//event -- up
function setUpValue(no){
    no *= 1; //형변환
    x = no-1;

    //origin
    var tUid = $('#div_uid'+no).val();
    var tClass = $('#div_class'+no).val();
    var tRname = $('#div_rname'+no).html();
    var tType = $('input[name="radio_btn'+no+'"]:radio:checked').val();

    //target
    var tUid2 = $('#div_uid'+x).val();
    var tClass2 = $('#div_class'+x).val();
    var tRname2 = $('#div_rname'+x).html();
    var tType2 = $('input[name="radio_btn'+x+'"]:radio:checked').val();

    //origin
    $('#div_uid'+no).val(tUid2);
    $('#div_class'+no).val(tClass2);
    $('#div_rname'+no).html(tRname2);
    $('input[name="radio_btn'+no+'"]').filter('input[value="'+tType2+'"]').attr('checked', 'checked');

    //target
    $('#div_uid'+x).val(tUid);
    $('#div_class'+x).val(tClass);
    $('#div_rname'+x).html(tRname);
    $('input[name="radio_btn'+x+'"]').filter('input[value="'+tType+'"]').attr('checked', 'checked');

    //radio 버튼 출력 조정
    setRadioBtn(no);
}

//event -- down
function setDownValue(no){
	no *= 1; //형변환
	x = no+1;

	var tUid = $('#div_uid'+no).val();
	var tClass = $('#div_class'+no).val();
	var tRname = $('#div_rname'+no).html();
	var tType = $('input[name="radio_btn'+no+'"]:radio:checked').val();

	var tUid2 = $('#div_uid'+x).val();
	var tClass2 = $('#div_class'+x).val();
	var tRname2 = $('#div_rname'+x).html();
	var tType2 = $('input[name="radio_btn'+x+'"]:radio:checked').val();

	if(tRname2 == ''){
		alert('변경 할 수 없습니다.');
		return;
	}

	$('#div_uid'+no).val(tUid2);
	$('#div_class'+no).val(tClass2);
	$('#div_rname'+no).html(tRname2);
	$('input[name="radio_btn'+no+'"]').filter('input[value="'+tType2+'"]').attr('checked', 'checked');

	$('#div_uid'+x).val(tUid);
	$('#div_class'+x).val(tClass);
	$('#div_rname'+x).html(tRname);
	$('input[name="radio_btn'+x+'"]').filter('input[value="'+tType+'"]').attr('checked', 'checked');

	//라디오버튼 출력 정렬
	setRadioBtn(x);
}

//라디오 버튼 재정렬
function setRadioBtn(no){
    return 0;
    for(var x=no+1; x>1; x--){
        var x_ = x-1;
        var tType = $('input[name="radio_btn'+x_+'"]:radio:checked').val();

        if(tType == 'sign'){
                $('#radio_ref'+x).css('display','block');
                $('#radio_agr'+x).css('display','block');
        }
        else if(tType == 'ref'){
                $('#radio_ref'+x).css('display','block');
                $('#radio_agr'+x).css('display','none');
        }
        else{
                $('#radio_ref'+x).css('display','none');
                $('#radio_agr'+x).css('display','block');
        }
    }
}


//event -- checkLine
function checkLine(no, type){
	return 0;
	no *= 1;
	var no_ = no + 1;
	var _no = no - 1;

	//결재-하위버튼 모두 출력
	if(type == 'sign'){
		//radio 출력
		$('#radio_ref'+no_).css('display','block');
		$('#radio_agr'+no_).css('display','block');
		$('input[name="radio_btn'+no_+'"]').filter('input[value="sign"]').attr('checked', 'checked');
	}
	else if(type == 'ref'){
		//협조-하위:결재, 협조만 출력
		$('#radio_ref'+no_).css('display','block');
		$('#radio_agr'+no_).css('display','none');
		$('input[name="radio_btn'+no_+'"]').filter('input[value="sign"]').attr('checked', 'checked');
	}
	else if(type == 'agr'){
		//합 의-하위:결재, 합의만 출력
		$('#radio_ref'+no_).css('display','none');
		$('#radio_agr'+no_).css('display','block');
		$('input[name="radio_btn'+no_+'"]').filter('input[value="sign"]').attr('checked', 'checked');
	}
	else{
		return 0;
	}
}

/**********************  function  **********************************/
//삭제후 재배열
function resetList(no){
	no *= 1; //형변환
	for(var x=no, y=no+1; x<25; x++, y++){
		var tUid = $('#div_uid'+y).val();
		var tClass = $('#div_class'+y).val();
		var tRname = $('#div_rname'+y).html();
		var tType = $('input[name="radio_btn'+y+'"]:radio:checked').val();

		$('#div_uid'+x).val(tUid);
		$('#div_class'+x).val(tClass);
		$('#div_rname'+x).html(tRname);
		$('input[name="radio_btn'+x+'"]').filter('input[value="'+tType+'"]').attr('checked', 'checked');

		if(tRname == ''){
			$('#div_uid'+x).val('');
			$('#div_class'+x).val('');
			$('#div_rname'+x).html('');

			$('#div_radio'+x).css('display','none');
			$('#div_move'+x).css('display','none');
			$('#div_delete'+x).css('display','none');
			return;
		}
	}
}

//사용자 중복 검사
function checkUser(uid){
	for(var x=1;x<25; x++){
		var tUid = $('#div_uid'+x).val();
		if(tUid == uid){
			return "no";
			break;
		}
	}

	return "yes";
}

//초기화
function setClear(){
	for(var x=2; x<25; x++){
		$('#div_uid'+x).val('');
		$('#div_class'+x).val('');
		$('#div_rname'+x).html('');

		$('#div_radio'+x).css('display','none');
		$('#div_move'+x).css('display','none');
		$('#div_delete'+x).css('display','none');

		$('input[name="radio_btn'+x+'"]').filter('input[value="sign"]').attr('checked', 'checked');
	}
}

function insertCheckLine(type){
	//마지막이 결재 인지 확인	
	for(var x=24; x>0; x--){
		var tUid = $('#div_uid'+x).val();
		if(tUid != ""){ 
			var tType = $('input[name="radio_btn'+x+'"]:radio:checked').val();
			if(tType != 'sign'){
				alert("마지막 결재자의 구분란은 '결재'로 지정하시기 바랍니다.");
				return "stop";
			}
			else{
				break;
			}
		}
	}

	//결재자가 최대 8명인지 확인
	var tSign = 0;
	var tRef = 0;
	var tAgr = 0;
	for(var x=24; x>0; x--){
		var tUid = $('#div_uid'+x).val();
		var tType = $('input[name="radio_btn'+x+'"]:radio:checked').val();
		if(tUid != '' && tType == 'sign'){ 
			tSign++;
		}
		else if(tUid != '' && tType == 'ref'){
			tRef++;
		}
		else if(tUid != '' && tType == 'agr'){
			tAgr++;
		}
	}
        if(type ==="setInValue"){
            tSign++;
            tRef++;
            tAgr++;
        }
        
	if(tSign > 8){
		alert('결재자는 최대 8명까지 입력가능 합니다.');
		return 'stop';
	}
	else if(tRef > 8){
		alert('협조자는 최대 8명까지 입력가능 합니다.');
		return 'stop';
	}
	else if(tAgr > 8){
		alert('합의자는 최대 8명까지입력가능 합니다.');
		return 'stop';
	}
	else{
		return 'go';
	}
}

//적용
function setValue(){
	//값 입력전 확인
        var ts = insertCheckLine('setValue');
        if (ts == 'stop') {
            return 0;
        }

	//기존 결재선 초기화
	for(var i=1; i<9; i++){
		if(i != 1){
			window.opener.valueClear('sign', '', '', '', i, '');
		}
		window.opener.valueClear('ref', '', '', '', i, '');
		window.opener.valueClear('agr', '', '', '', i, '');
	}

	window.opener.initAppLineArray();

	//결재선 입력
	for(var x=2, y=2, z=1, u=1, order=1; x<25; x++){
		//y-결재, z-협조, u-합의 order-결재순서
		var tUid = $('#div_uid'+x).val();
		var tClass = $('#div_class'+x).val();
		var tName = $('#div_rname'+x).html();

		if(tUid == ''){
			break;
		}
		else{
			//값 입력
			var x_ = x-1;
			var tType = $('input[name="radio_btn'+x+'"]:radio:checked').val();

			if(tType == 'sign'){no = y;}
			else if(tType == 'ref'){no = z;}
			else if(tType == 'agr'){no = u;}
			else{}

			var tt = $('input[name="radio_btn'+x_+'"]:radio:checked').val();
			if(tt != tType || tType=='sign'){
				order++;
			}
			tClass += ' '+order;
			window.opener.setValue(tType, tUid, tName, tClass, no, order);

			//입력 순서 조정
			if(tType == 'sign'){y++;}
			else if(tType == 'ref'){z++;}
			else if(tType == 'agr'){u++;}
			else{}
		}
	}

	window.close();
}

// add by Anuradha On:2015-01-25  for search user id and name
$("#btn_search").live("click", function () {
        search_tree();
});
$('#fstr').live('keydown',function(e) {
    if (e.keyCode == 13) {
        search_tree();
        return false;
    } 
});


//트리 검색
function search_tree(){
    var url = 'groupware_tree_user.php';
    var fstr=$.trim($("#fstr").val());
        /*if(/^[a-zA-Z0-9- ]*$/.test(fstr) == false) {
            alert('Your search string contains illegal characters.');
            return false;
        } */
        if(fstr) {
            url += '?fstr='+encodeURIComponent(fstr);
        } 
        $("#div_org").load(url);
}

//]]>
</script>

</head>
<body>
<div class="app2_org_zone">
    <form id="lineform" method="post" action="/segio/works/approval/make_myapp_line.php" target="zero_366080">
        <input type="hidden" name="mode" id="mode" value="" />
        <input type="hidden" name="no" id="no" value="" />
        <div class="app2_org_top">
        <h2>조직도 [결재선 정보]</h2>
        </div>

        <div class="app2_org_bg">

        <!-- 테이블 시작-->
        <div class="app2_con_wrap">
            <!-- 조직도 -->
        <div id="div_org" class="app2_con_table1">
             <script type="text/javascript">
    //<![CDATA[
    /**********************          조직도 구성        **********************************/
var menus = [
	[1,0,'조직도','1','','group','',''],
	[2,1,'CEO','2','','group','',''],
	[16,2,'sysop','sysop','관리자','user','1','on'],
	[10,2,'최민수','test6','CEO','user','3','on'],
	[15,1,'영업2부','5','','group','',''],
	[9,15,'이정재','test5','부장','user','2','on'],
	[6,15,'이병헌','test2','과장','user','1','on'],
	[13,15,'김수현','test9','인턴','user','1','on'],
	[4,1,'관리부','4','','group','',''],
	[12,4,'하정우','test8','과장','user','2','on'],
	[8,4,'하지원','test4','사원','user','1','on'],
	[3,1,'영업부','3','','group','',''],
	[14,3,'이영애','test10','부장','user','2','on'],
	[5,3,'정우성','test1','과장','user','1','on'],
	[11,3,'김래원','test7','대리','user','1','on'],
	[7,3,'손예진','test3','사원','user','1','on'],

];

$(document).ready(function () {
        //결재선 생성
    initMenu();
    setRadioBtn('24');
  });
var tmpGroup;
function makeNode(item, group) {
	var el = document.createElement('li');
	el.setAttribute('index', item[0]);
	el.setAttribute('parent', item[1]);
	el.className = 'part_depth1';
        //user
        var cmp_str="";
        if(item[5] == 'user') {
                var img = document.createElement('img');
                if(item[7] != 'on') {
                        img.setAttribute('src', '/segio/works/common/image/tree_user0.gif');	
                        img.setAttribute('alt', '미승인');
                }
                else {
                        if(item[6] == '1') {
                                img.setAttribute('src', '/segio/works/common/image/tree_user1.gif');	
                                img.setAttribute('alt', '');
                        }
                        else if(item[6] == '2') {
                                img.setAttribute('src', '/segio/works/common/image/tree_user2.gif');	
                                img.setAttribute('alt', '');
                        }
                        else if(item[6] == '3') {
                                img.setAttribute('src', '/segio/works/common/image/tree_user3.gif');	
                                img.setAttribute('alt', '');
                        }
                }
                el.appendChild(img);
                var a = document.createElement('label');
                var text = document.createTextNode(' ' + item[2] + '(' + item[3] + ') ' + item[4]); // 이름 + 직책
                    a.setAttribute('style', 'cursor:pointer;');



                a.onclick = function() {
                        setInValue(item[3], item[2], item[4]);
                }

                a.appendChild(text);
                el.appendChild(a);
        }
        //그룹
        else {
                var img = document.createElement('img');
                img.setAttribute('src', '/segio/works/common/image/tree_group.gif');
                img.setAttribute('alt', '부서');

                var text = document.createTextNode(' ' + item[2]);

                el.appendChild(img);
                el.appendChild(text);
        }
    return el;
}

function makeMenu(node) {
    for(var i=1; i < menus.length; i++) {
        if (typeof(node.tagName) == 'undefined') continue;
        if ( menus[i] != null ) {
            if(menus[i][5] == 'group')
            {
                tmpGroup = menus[i][2];
            }
            if(node.getAttribute('index') == menus[i][1]) {
                node.appendChild(makeNode(menus[i], tmpGroup));
            }
        }
    }
    for(var i=2; i<node.childNodes.length; i++) {
        makeMenu(node.childNodes[i]);
    }
    return node;
}

</SCRIPT>

</HEAD>

<BODY>
	<h1>Don't Show Line</h1>
	<h6>[ File Path: core/noline.html ]</h6>
	<div class="content_wrap">
		<div class="zTreeDemoBackground left">
			<ul id="rootOfTree" class="kTree">
				<li id="cDemo"></li>
			</ul>
		</div>
	</div>
</BODY>
</HTML>