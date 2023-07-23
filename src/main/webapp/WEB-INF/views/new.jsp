<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<style>
#tblnew {
    width: 100%;
    border-collapse: collapse;
    line-height: 24px;
    margin-top: 5%;
}
#tblnew th {
    border-top:1px solid black;
    border-bottom:1px solid black;
    border-collapse: collapse;
    text-align: center;
    padding: 10px;
}
#tblnew td{ 
	text-align: left;
	border-top:1px solid black;
    border-bottom:1px solid black;
    border-collapse: collapse;
    padding: 10px;
}
#tblnew th { 
	background: rgb(221, 221, 221);
	width: 80px;
}
#wrap {
    width: 800px;
	margin:auto;
}
#title {
	border:none;
	border-bottom: 1px solid #A9F5E1;
	outline: none;
	height:20px;
	width: 70%;
}
#nickname {
	border: none;
	outline: none;
}
#h2title {
	margin-top: 5%;
}
#btnSubmit, #btnReset {
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
#btnSubmit:hover, #btnReset:hover {
	background:#58FAD0;
}
a {
	text-decoration: none; /* 밑줄 제거 */
 	color: inherit; /* 기본 링크 색상 유지 */
}

#tblnew tr:nth-child(3) td {
  border-bottom: 1px solid black;
}

</style>
<body>

<div id=wrap>
<h2 id=h2title>게시글 작성</h2>
<form action="/AddNew" method="post" id=frmNew>
<table align=center frame=void id=tblnew>
<tr><th>제목</th><td><input type=text name=title id=title></td></tr>
<tr><th>내용</th><td><textarea rows="20" cols="92" name=content id=content></textarea></td></tr>
<tr><th>작성자</th><td><input type=text name=nickname id=nickname readonly value=<%=session.getAttribute("nickname") %>></td></tr>
</table>
<br>
<div>
	<input type=submit id=btnSubmit value='등록'>
    <input type=button id=btnReset value='취소'>
</div>
</form>
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
.on('click', '#btnReset', function(){
	document.location='/list';
	return false;
})
.on('submit','#frmNew', function(){
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
</script>
</html>