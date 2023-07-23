<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<title>로그인</title>
</head>
<style>
#tbllogin {
    border-collapse: collapse;
    margin-top:230px;
    width:23%;
}
#tbllogin th {
    text-align: center;
    padding: 10px;
}
#tbllogin td{
	text-align: left;
	 padding: 10px;
}
#tbllogin th { 
	background: rgb(221, 221, 221);
	width: 150px;
}

#wrap {
    width: 800px;
	margin:auto;
}
#submit{
   border:1px solid #A9F5E1;
   padding:10px;
   width:68%;
   border-radius:5px;
   background:#A9F5E1;
   color:#FFFFFF;
   transition: all 0.3s;
   cursor:pointer;
}
#submit:hover {
	background:#58FAD0;
}
#reset{
   border:1px solid #A9F5E1;
   padding:10px;
   width:30%;
   border-radius:5px;
   background:#A9F5E1;
   color:#FFFFFF;
   transition: all 0.3s;
   cursor:pointer;
}
#reset:hover {
	background:#58FAD0;
}
a {
	text-decoration: none; /* 밑줄 제거 */
 	color: inherit; /* 기본 링크 색상 유지 */
}
.logout {
	text-align:center;
}
.logout:hover {
	color:#A9F5E1;
	transition: all 0.3s;
}
#id, #pwd {
	outline: none;
	border: none;
	border-bottom: 1px solid #A9F5E1;
	width: 100%;
}

/* 비밀번호 보게 해주는 css */
#showPwd {
	position: absolute;
	border: none;
	background-color: white;
	padding-right: 10px;
	width: 22px;
	right: 1px;
	margin-bottom: 3%;
}
.form-group {
 	display: flex; 
 	align-items: center; 
	position: relative;
}
</style>
<body>

<form action='/dologin' method='post' id=frmlogin>
<table align=center id=tbllogin>
<tr><td><h2>로그인</h2></td></tr>
<tr><td>아이디</td><td><input type="text" name=id id=id placeholder="아이디를 입력해 주세요."></td></tr>
<tr><td>비밀번호</td><td class="form-group"><input type="password" name=pwd id=pwd placeholder="비밀번호를 입력해 주세요."><img src="/img/free-icon-eye-show.jpg" id="showPwd"></td></tr>
<tr><td colspan=2 align=center>
		<input type=submit id=submit value='로그인'>
		<input type=reset id=reset value='비우기'>
</td></tr>
<tr><td colspan=2 style="text-align:center;" ><a href="/signin" class="logout">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/list" class="logout">취소</a></td></tr>
</table>
</form>
${alert}
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.on('submit', '#frmlogin', function(){	
	if(($('#id').val()=='') || ($('#id').val()==null)) {
		alert('아이디를 입력하세요.');
		return false;
		}
	else if(($('#pwd').val()=='') || ($('#pwd').val()==null)) {
			alert('비밀번호를 입력하세요.');
			return false;
		}
})

// 비밀번호 보게 해주는 코드
$(document)
document.getElementById("showPwd").addEventListener("click", function() {
		var passwordInput = document.getElementById("pwd");
		var eyeIcon = document.getElementById("showPwd");
		
		if (passwordInput.type === "password") {
			passwordInput.type = "text";
			eyeIcon.src = "/img/free-icon-eye-hidden.jpg";
		} else {
			passwordInput.type = "password";
			eyeIcon.src = "/img/free-icon-eye-show.jpg";
		}
	})
</script>
</html>