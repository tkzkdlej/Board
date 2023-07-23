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
#tblList {
     border-collapse: collapse;
     width: 100%;
     text-align : center;
     margin-top: 2%;
}
#tblList td {
     padding: 10px;
     border: 1px solid #A9F5E1;
}
#tblList tr{
	transition: all 0.3s;
}
#tblList tr:hover { background-color: #E0F8F1 }
#tblList th {
 	 padding: 10px;
     border: 1px solid black;
     background-color: #E6E6E6;
}
#wrap {
    width: 1300px;
	margin:auto;
}
#btnNew {
	font-size:12px;
	text-align : center;
	border:1px solid #A9F5E1;
	padding:5px;
	width:15%;
	margin-bottom:1%;
	border-radius:5px;
	background:#A9F5E1;
	color:#000000;
	transition: all 0.3s;
	cursor:pointer;
}
#btnNew:hover {
	background:#58FAD0;
}
a {
	text-decoration: none; /* 밑줄 제거 */
 	color: inherit; /* 기본 링크 색상 유지 */
}
#h2title {
	margin-top: 5%;
}
#logout:hover {
	color:#A9F5E1;
	transition: all 0.3s;
}



/* 페이지네이션 */
.off-screen {
	display: none;
}

#nav1 {
	width: 100%;
	text-align:center;
	padding-top: 15px;
}

#nav1 a {
	display: inline-block;
	padding: 3px 5px;
	margin-right: 10px;
	margin-left: 1px;
	margin-right: 5px;
	font-family: Tahoma;
	background:#fff;
	color: #000;
	text-decoration: none;
	transition: all 0.3s;
	cursor:pointer;
}
#nav1 a:hover {
	background:#58FAD0;
}

#nav1 a.active {
	background: #A9F5E1;
	color: #000;
}
#nav1 a.active:hover {
	background:#58FAD0;
}

.btnNew {
	position: relative;
	left: 38%; 
	top: 15px;
	background-color: #7ca8c2;
	padding: 7px 11px;
    border: none;
    border-radius: 10px;
    color: #fff;
    cursor: pointer;
}
    .btnNew:hover {
	background-color: #0056b3;
}


/* ----------- */
</style>
<body>

<div id=wrap>
<h2 id=h2title>게시판</h2>
<table>
<tr><td style="border:none; width:500px;" align="left">${login}</td></tr>
</table>
<table border=1 id=tblList frame=void>
<tr><th style="width:10%">일련번호</th><th style="width:25%">제목</th><th style="width:20%">작성일</th><th style="width:20%">수정일</th><th style="width:18%">작성자</th><th style="width:7%">조회수</th></tr>
<c:forEach items="${bbs}" var="b">
	<tr><td>${b.seqno}</td>
	<td>${b.title}</td>
	<td>${b.created}</td>
	<td>${b.updated}</td>
	<td>${b.writer}</td>
	<td>${b.readcount}</td></tr>
</c:forEach>
</table>
<caption>
	<form action="" id="setRows">
		<p><input type="hidden" name="rowPerPage" value="5"></p>
	</form>
</caption>
<div class="bSearch"></div>
<br>
<div id=divlist></div>
</div>
<input type=hidden name=seqno id=seqno>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)

.ready(function(){
	let str = "<h3 style='text-align:center;'>로그인 후 이용해주세요.</h3>";
	if("${login}" === "<a href='/login' id=login>로그인</a>&nbsp;&nbsp;<a href='/signin'>회원가입</a>") {
		$("#divlist").append(str);
	}
})
.on('click', '#btnNew', function(){
	document.location='/new';
	return false;
})
.on('click','#tblList tr:not(:first-child)',function(){
	let seqno=$(this).find('td:eq(0)').text();
	$('#seqno').val(seqno);
	document.location='/view/'+$('#seqno').val();
})
.on('click','#logout',function(){
	alert('로그아웃 되었습니다.');
})



/*  페이지네이션  */
var $setRows = $('#setRows');

$setRows.submit(function (e) {
	e.preventDefault();
	var rowPerPage = $('[name="rowPerPage"]').val() * 1;// 1 을  곱하여 문자열을 숫자형로 변환

//		console.log(typeof rowPerPage);

	var zeroWarning = 'Sorry, but we cat\'t display "0" rows page. + \nPlease try again.'
	if (!rowPerPage) {
		alert(zeroWarning);
		return;
	}
	$('#nav1').remove();
	var $tblList = $('#tblList');

	$('.bSearch').after('  <div id="nav1">');


	var $tr = $('#tblList tr').not(':first-child');
	var rowTotals = $tr.length;
//	console.log(rowTotals);

	var pageTotal = Math.ceil(rowTotals/ rowPerPage);
	var i = 0;

	for (; i < pageTotal; i++) {
		$('<a href="#"></a>')
				.attr('rel', i)
				.html(i + 1)
				.appendTo('#nav1');
	}

	$tr.addClass('off-screen')
			.slice(0, rowPerPage)
			.removeClass('off-screen');

	var $pagingLink = $('#nav1 a');
	$pagingLink.on('click', function (evt) {
		evt.preventDefault();
		var $this = $(this);
		if ($this.hasClass('active')) {
			return;
		}
		$pagingLink.removeClass('active');
		$this.addClass('active');

		// 0 => 0(0*4), 4(0*4+4)
		// 1 => 4(1*4), 8(1*4+4)
		// 2 => 8(2*4), 12(2*4+4)
		// 시작 행 = 페이지 번호 * 페이지당 행수
		// 끝 행 = 시작 행 + 페이지당 행수

		var currPage = $this.attr('rel');
		var startItem = currPage * rowPerPage;
		var endItem = startItem + rowPerPage;

		$tr.css('opacity', '0.0')
				.addClass('off-screen')
				.slice(startItem, endItem)
				.removeClass('off-screen')
				.animate({opacity: 1}, 300);

	});

	$pagingLink.filter(':first').addClass('active');

});


$setRows.submit();

</script>
</html>