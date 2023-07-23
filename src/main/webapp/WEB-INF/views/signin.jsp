<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<style>
.tblsignin {
    border-collapse: collapse;
    margin-top:150px;
    margin-left:730px;
}
.tblsignin td, th {
    text-align: center;
    padding: 10px;
}
.tblsignin td{ text-align: left }
.tblsignin th { 
	background: rgb(221, 221, 221);
	width: 80px;
}
#wrap {
    width: 800px;
	margin:auto;
}
#submit{
   border:1px solid #A9F5E1;
   padding:10px;
   width:40%;
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
   width:40%;
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
#logout:hover {
	color:#A9F5E1;
	transition: all 0.3s;
}
#id, #pwd, #pwd1, #nickname {
	outline: none;
	border: none;
	border-bottom: 1px solid #A9F5E1;
	width: 276px;
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
#showPwd1 {
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
<form action="/doSignin" method="post" id=frmSignin>
<table align="center" class=tblsignin>
<tr><td><h2>회원가입</h2></td></tr>
<tr><td>아이디</td><td><input type=text name=id id=id placeholder="아이디를 입력해주세요" class=input_id></td><td><font id="checkid" for="id" style="font-size: 10px; font-weight:bold;">[영문대소문자/숫자, 4~20자]</font></td></tr>
<tr><td>비밀번호</td><td class="form-group"><input type=password name=pwd id=pwd class=input_pwd placeholder="비밀번호를 입력해주세요"><img src="/img/free-icon-eye-show.jpg" id="showPwd"></td><td><font id="checkpwd" for="pwd" style="font-size: 10px; font-weight:bold;">[영문대소문자/숫자/특수문자(@$!%*#?&), 8~22자]</font></td></tr>
<tr><td>비밀번호 확인</td><td colspan=2 class="form-group"><input type=password name=pwd1 class=input_pwd id=pwd1 placeholder="비밀번호 확인"><img src="/img/free-icon-eye-show.jpg" id="showPwd1"></td></tr>
<tr><td>닉네임</td><td><input type=text name=nickname id=nickname placeholder="닉네임을 입력해주세요"></td><td><font id="checkNick" for="nickname" style="font-size: 10px; font-weight:bold;"></font></td></tr>
<tr><td>성별</td><td colspan=2 ><input type=radio name=gender id=gender value=male>남성
						<input type=radio name=gender id=gender value=female>여성</td></tr>
<tr><td>관심분야</td>
	<td colspan=2 ><table>
	<tr>
		<td><input type=checkbox name=interest id=interest value='politics'>정치</td>
		<td><input type=checkbox name=interest id=interest value='economy'>경제</td>
		<td><input type=checkbox name=interest id=interest value='society'>사회</td>
	</tr>
	<tr>
		<td><input type=checkbox name=interest id=interest value='IT'>정보통신</td>
		<td><input type=checkbox name=interest id=interest value='sports'>스포츠</td>
		<td><input type=checkbox name=interest id=interest value='finace'>금융</td>
	</tr>
	<tr>
		<td><input type=checkbox name=interest id=interest value='realty'>부동산</td>
		<td><input type=checkbox name=interest id=interest value='healthy'>건강</td>
		<td><input type=checkbox name=interest id=interest value='entertainment'>연예</td>
	</tr>
	</table></td>
</tr>
<tr><td colspan=2 style="text-align:center;" align=center>
	<input type=submit id=submit value='가입'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type=reset id=reset value='비우기'><br><br>
	<a href='/list' id=logout>가입취소</a></td></tr>
</table>
</form>
</body>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
//by ChatGPT
.ready(function() {
// ID 정규 표현식
var idPattern = /^[a-zA-Z0-9]{4,20}$/;

// 비밀번호 정규 표현식
var pwPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,22}$/;

// ID 입력 필드
var idField = $('#id');

// 비밀번호 입력 필드
var pwField = $('#pwd');

// ID 입력 필드의 값이 변경될 때마다 정규 표현식 패턴에 맞는지 확인
idField.on('change', function() {
	var id = idField.val();
	if (!idPattern.test(id)) {
		alert('ID는 영어 소문자, 대문자, 숫자만 사용하여 4~20자 이내로 입력해주세요.');
	    idField.val('');
	    $('#checkid').text('');
	    
	    idField.focus(); // 커서를 idField로 이동시킴
	}
});

// 비밀번호 입력 필드의 값이 변경될 때마다 정규 표현식 패턴에 맞는지 확인
pwField.on('change', function() {
	var pw = pwField.val();
	if (!pwPattern.test(pw)) {
  		alert('비밀번호는 영어 소문자, 대문자, 숫자, 특수문자(@$!%*#?&) 중 최소 1개 이상을 포함하여 8~22자 이내로 입력해주세요.');
   		$('#checkpwd').attr('color', 'red');
   		$('#checkpwd').text('영어 소문자, 대문자, 숫자, 특수문자(@$!%*#?&)를 포함하여 8~22자 이내로 입력해주세요.');
  		pwField.val('');
  
   		pwField.focus(); // 커서를 pwField로 이동시킴
 	}
});

})



$(document)
// 비밀번호 체크
.on('blur','.input_pwd',function(){
	if($(".input_pwd").val().trim() == "") {
		$('#checkpwd').html('비밀번호를 입력해주세요.');
		$('#checkpwd').attr('color', 'red');
	} else {
		if($('input[name=pwd]').val() != $('input[name=pwd1]').val()) {
			$('#checkpwd').html('비밀번호가 일치하지 않습니다.');
			$('#checkpwd').attr('color', 'red');
			return false; //submit 중단
		} else {
			$('#checkpwd').html('비밀번호가 일치합니다.');
			$('#checkpwd').attr('color', 'green');
		}
		return true; // submit 계속 진행(데이터를 컨트롤러에 전송)
	}
})

// 아이디 체크
.on('blur', '.input_id', function(){
	if($(".input_id").val().trim() == "") {
		$('#checkid').html('아이디를 입력해주세요.');
		$('#checkid').attr('color', 'red');
	} else {
		$.ajax({url:'/check_id', type:'post', data:{id:$('#id').val()}, dataType:'text',
			success:function(result){
				if(result=="ok"){
					$('#checkid').html('사용 불가능한 아이디입니다.');
					$('#checkid').attr('color', 'red');
				} else {
					$('#checkid').html('사용가능한 아이디입니다.');
					$('#checkid').attr('color', 'green');
				}
			}
		})
	}
})

// 닉네임 체크
.on('blur', '#nickname', function(){
	if($("#nickname").val().trim() == "") {
		$('#checkNick').html('닉네임을 입력해주세요.');
		$('#checkNick').attr('color', 'red');
	} else {
		$.ajax({url:'/check_nick', type:'post', data:{nickname:$('#nickname').val()}, dataType:'text',
			success:function(result){
				if(result=="ok"){
					$('#checkNick').html('사용 불가능한 닉네임입니다.');
					$('#checkNick').attr('color', 'red');
				} else {
					$('#checkNick').html('사용가능한 닉네임입니다.');
					$('#checkNick').attr('color', 'green');
				}
			}
		})
	}
})



// 회원가입 정보들을 제출할때 비교 코드
.on('submit','#frmSignin', function(){
	let id = $('#id').val();
	let pwd = $('#pwd').val();
	let pwd1 = $('#pwd1').val();
	let name = $('#nickname').val();
	let radio = $('input[type=radio][name=gender]:checked').val();
	let interest = $('input[type=checkbox][name=interest]:checked').val();
	let chkId = $('#checkid').text();
	let chkPwd = $('#checkpwd').text();
	let chkNick = $('#checkNick').text();
	
	if(id=='' || id==null) {
		alert('아이디를 입력하세요.');
		$('#id').focus();
		return false;
	}
	else if(pwd=='' || pwd==null) {
		alert('비밀번호를 입력하세요.');
		$('#pwd').focus();
		return false;
	}
	else if(pwd1=='' || pwd1==null) {
		alert('비밀번호 확인을 입력하세요.');
		$('#pwd1').focus();
		return false;
	}
	else if(name=='' || name==null) {
		alert('닉네임을 입력하세요.');
		$('#nickname').focus();
		return false;
	}
	else if(radio=='' || radio==null) {
		alert('성별을 선택하세요.');
		return false;
	}
	else if(interest=='' || interest==null) {
		alert('관심 분야를 하나 이상 선택해주세요.');
		return false;
	}
	
	if (chkId === '사용 불가능한 아이디입니다.' || chkId === '아이디를 입력해주세요.' ||
		chkPwd === '비밀번호를 입력해주세요.' || chkPwd === '비밀번호가 일치하지 않습니다.' ||
		chkNick === '사용 불가능한 닉네임입니다.' || chkNick === '닉네임을 입력해주세요.') {
		
	    $("#submit").prop("disabled", true);
	    alert('아이디,비밀번호 혹은 닉네임을 확인해주세요.');
	    
	    $('#id').val('');
	    $('#pwd').val('');
	    $('#pwd1').val('');	   
	    $('#nickname').val('');
	    
	    $('#checkid').html('[영문대소문자/숫자, 4~20자]');
		$('#checkid').attr('color', 'black');
		$('#checkpwd').html('[영문대소문자/숫자/특수문자(@$!%*#?&), 8~22자]');
		$('#checkpwd').attr('color', 'black');
		$('#checkNick').text('');
	    return false;
	    
	} else {
	    $("#submit").prop("disabled", false);
	    return true;
	}
	
})

// 비우기 코드 이벤트
.on('click','#reset',function(){
	$('#checkid').html('[영문대소문자/숫자, 4~20자]');
	$('#checkid').attr('color', 'black');
	$('#checkpwd').html('[영문대소문자/숫자/특수문자(@$!%*#?&), 8~22자]');
	$('#checkpwd').attr('color', 'black');
	$('#checkNick').text('');
})


// 비밀번호 보게 해주는 코드
$(document)
// password
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
// password check
document.getElementById("showPwd1").addEventListener("click", function() {
		var passwordInput = document.getElementById("pwd1");
		var eyeIcon = document.getElementById("showPwd1");
		
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