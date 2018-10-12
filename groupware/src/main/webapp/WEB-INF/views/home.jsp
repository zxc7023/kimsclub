<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>메인화면</title>
    <link rel="stylesheet" href="resources/css/default.css">
    <link rel="stylesheet" href="resources/css/sidebar.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
</head>
<body>
<section>
    <div class="container-fluid">
        <div class="row">
            <!--pc-->
            <div class="col-3  d-sm-none d-md-block sideBar-pc">
               <ul class="list-group">
                     <li class="depth-1 list-group-item">
                       <a data-toggle="collapse" href="#menu02" role="button" aria-expanded="false" aria-controls="menu02">결재 관리</a>
                       <div class="depth-2 collapse" id="menu02">
                           <ul class="list-group">
                               <li class="list-group-item"><a href="#">새문서함</a></li>
                               <li class="list-group-item"><a href="#">결재문서함</a></li>
                               <li class="list-group-item"><a href="#">진행문서</a></li>
                               <li class="list-group-item"><a href="#">반려문서</a></li>
                               <li class="list-group-item"><a href="#">완료문서</a></li>
                               <li class="list-group-item"><a href="#">참조문서</a></li>
                               
                           </ul>

                       </div>
                   </li>
                   <li class="depth-1 list-group-item">
                       <a data-toggle="collapse" href="#menu02" role="button" aria-expanded="false" aria-controls="menu02">화이팅</a>
                       <div class="depth-2 collapse" id="menu02">
                           <ul class="list-group">
                               <li class="list-group-item"><a href="#">김준기</a></li>
                               <li class="list-group-item"><a href="#">김준기</a></li>
                           </ul>

                       </div>
                   </li>
                   <li class="depth-1 list-group-item">
                       <a data-toggle="collapse" href="#menu03" role="button" aria-expanded="false" aria-controls="menu03">김준기</a>
                       <div class="depth-2 collapse" id="menu03">
                           <ul class="list-group ">
                               <li class="list-group-item"><a href="#">김준기</a></li>
                               <li class="list-group-item"><a href="#">김준기</a></li>
                               <li class="list-group-item"><a href="#">김준기</a></li>
                           </ul>

                       </div>
                   </li>
                   <li class="list-group-item">
                       <a href="#">김준기</a>
                   </li>
                   <li class="depth-1 list-group-item">
                       <a data-toggle="collapse" href="#menu05" role="button" aria-expanded="false" aria-controls="menu05">김준기</a>
                       <div class="depth-2 collapse" id="menu05">
                           <ul class="list-group ">
                               <li class="list-group-item"><a href="#">김준기</a></li>
                               <li class="list-group-item"><a href="#">김준기</a></li>
                               <li class="list-group-item"><a href="#">김준기</a></li>
                           </ul>
                       </div>
                   </li>
               </ul>

                <ul class="list-group sub-list">
                    <li class="list-group-item">
                        <a href="#">sub1</a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">sub2</a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">sub3</a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">sub4</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</section>
</body>
</html>