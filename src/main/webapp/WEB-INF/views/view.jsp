<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

</head>
<style>
#tblview {
    width: 100%;
    border-collapse: collapse;
    line-height: 24px;
    text-align: center;
    margin-top: 5%;
}
#tblview th {
    border-top:1px solid black;
    border-bottom:1px solid black;
    border-collapse: collapse;
    text-align: center;
    padding: 10px;
}
#tblview td{ 
	text-align: left;
	border-top:1px solid black;
    border-bottom:1px solid black;
    border-collapse: collapse;
    padding: 10px;
}
#tblview th { 
	background: rgb(221, 221, 221);
	width: 80px;
}
/* tr:hover { background-color: #F6CECE; } */
#wrap {
    width: 800px;
	margin:auto;
}
#h2title {
	margin-top: 5%;
}
#btnDelete, #modify, #btnList {
	font-size:12px;
	text-align : center;
	border:1px solid #A9F5E1;
	padding:5px;
	width:10%;
	border-radius:5px;
	background:#A9F5E1;
	color:#000000;
	transition: all 0.3s;
}
#btnDelete:hover, #modify:hover, #btnList:hover {
	background:#58FAD0;
}
#title {
/* 	outline: none; */
	border:none;
	border-radius:5px;
	height:30px;
	width: 70%;
}
a {
	text-decoration: none; /* 밑줄 제거 */
 	color: inherit; /* 기본 링크 색상 유지 */
}
</style>
<body>

<div id=wrap>
<h2 id=h2title>게시글</h2>
<c:choose>
	<c:when test="${nickname == writer.writer}">
		<form action="Modify" method="post" id="modify1">
			<table id=tblview>
				<c:forEach items="${bbs}" var="bbs">
					<tr><th>제목</th><td><input type=text id=title name=title value='${bbs.title}'></td></tr>
					<tr><th>조회수</th><td>${bbs.readcount}</td></tr>
					<tr><th>내용</th><td><textarea rows="20" cols="92" name=content id=content class="summernote">${bbs.content}</textarea></td></tr>
					<tr><th>작성일</th><td>${bbs.created}</td></tr>
					<tr><th>수정일</th><td>${bbs.updated}<input type=hidden name=seqno id=seqno value="${bbs.seqno}"></td></tr>
					<tr><th>작성자</th><td>${bbs.writer}</td></tr>
				</c:forEach>
			</table>
			<br>
			<div>
				<button type="button" id="btnDelete">삭제</button>
			    <input type="submit" id="modify" value="수정">
			    <button type="button" id="btnList">목록보기</button>
			</div>
		</form>
	</c:when>
	<c:otherwise>
		<table id=tblview>
			<c:forEach items="${bbs}" var="bbs">
				<tr><th>제목</th><td><input type=text id=title name=title value='${bbs.title}' readonly></td></tr>
				<tr><th>조회수</th><td>${bbs.readcount}</td></tr>
				<tr><th>내용</th><td><textarea rows="20" cols="92" name=content id=content class="summernote1" readonly>${bbs.content}</textarea></td></tr>
				<tr><th>작성일</th><td>${bbs.created}</td></tr>
				<tr><th>수정일</th><td>${bbs.updated}<input type=hidden name=seqno id=seqno value="${bbs.seqno}"></td></tr>
				<tr><th>작성자</th><td>${bbs.writer}</td></tr>
			</c:forEach>
		</table>
		<br>
		<div>
			<button type="button" id="btnList">목록보기</button>
		</div>
	</c:otherwise>
</c:choose>
</div>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script>
$(document)
.ready(function() {
   $('#content').summernote({
        height: 250,                 
        width: 700,         
        focus: true,                  
        lang: "ko-KR",               
        placeholder: '<br>내용을 입력하시오. <br> 최대 2000자까지 입력할 수 있습니다', 
        toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['image',['picture']]
           ],
           fontNames: 
              ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
        
    })          
})
 
.on('click', '#btnList', function(){
	document.location='/list';
	return false;
})

.on('click', '#btnDelete', function(){
	document.location='/delete/'+$('#seqno').val();
	return false;
})

.on('submit','#modify1', function(){
	let title = $.trim($('#title').val());
	let content = $.trim($('#content').val());
	
	if((title==null) || (title=='')){
		alert('제목을 입력하세요.');
		return false;
	}
	if((content==null) || (content=='')){
		alert('내용을 입력하세요.');
		return false;
	}
	
	return true;
})



$(document)
.ready(function() {
  // Summernote 에디터 초기화
  $('.summernote1').summernote({
    // 옵션 설정
  });
  
  // 에디터를 읽기 전용으로 설정
  var editor = $('.summernote1').siblings('.note-editor').find('.note-editable');
  editor.attr('contenteditable', 'false');
});

</script>
</html>