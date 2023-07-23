package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyController {
	@Autowired
	private IDAO idao;
	
	@GetMapping("/")
	public String doRoot() {
		return "redirect:/list";
	}
	
	
	@GetMapping("/list")
	public String doList(HttpServletRequest req, Model model) {
		HttpSession sinfo = req.getSession();
    	
    	if (sinfo == null || sinfo.getAttribute("id") == null) {
            // 아이디 세션이 만료되었을 때 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
    	
		String n = (String) sinfo.getAttribute("id");
		if(sinfo.getAttribute("id")==null) {
			model.addAttribute("login", "<a href='/login' id=login>로그인</a>&nbsp;&nbsp;<a href='/signin'>회원가입</a>");
		} else {
			String nickname=idao.nickname(n);
			sinfo.setAttribute("nickname", nickname);
			model.addAttribute("login", "<b>"+nickname+"</b>"+"&nbsp;&nbsp;<a href='/logout' id=logout>로그아웃</a>&nbsp;&nbsp;&nbsp;<input type=button id=btnNew value='새글쓰기'>");
			model.addAttribute("bbs", idao.doList());
		}
		return "list";
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String dologout(HttpServletRequest req) {
		HttpSession si=req.getSession();
		si.invalidate();
		return "redirect:/list";
	}
	
	// 새 게시글 쓰기
	@GetMapping("/new")
	public String doNew() {
		return "new";		
	}
	@PostMapping("/AddNew")
	public String doAddNew(HttpServletRequest req) {
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		String nickname=req.getParameter("nickname");
		idao.doNewInsert(title, content, nickname);
		return "redirect:/list";
	}
	
	// 게시글 보기
	@GetMapping("/view")
	public String doView() {
		return "view";		
	}
	@GetMapping("/view/{seqno}")
	public String doview(@PathVariable("seqno") int seqno, Model model,HttpServletRequest req) {
		HttpSession sinfo = req.getSession();
		String n = (String) sinfo.getAttribute("id");
		String nickname=idao.nickname(n);

		idao.doviewList(seqno);
		idao.doreadcount(seqno);
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("writer", idao.showButton(seqno));
		model.addAttribute("bbs", idao.doView(seqno));
		return "view";
	}
	
	// 게시글 수정
	@PostMapping("view/Modify")
	public String doModify(HttpServletRequest req) {
		String title1=req.getParameter("title");
		String content1=req.getParameter("content");
		int seqno1=Integer.parseInt(req.getParameter("seqno"));

		idao.doupdated(seqno1);
		idao.doModify(title1, content1, seqno1);
		return "redirect:/list";
	}
	
	// 게시글 삭제
	@GetMapping("/delete/{seqno}")
	public String doDelete(@PathVariable("seqno") int seqno) {
		idao.doDelete(seqno);
		return "redirect:/list";
	}

	// 회원가입
	@GetMapping("/signin")
	public String dosignon() {
		return "signin";
	}
	@PostMapping("/doSignin")
	public String doSignin(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String nickname = req.getParameter("nickname");
		String gender = req.getParameter("gender");
		String[] interest = req.getParameterValues("interest");
		String str=new String();
		for(int i=0; i<interest.length;i++) {
			if(!str.equals("")) {
				str+=", ";
			}
			str += interest[i];
		}		

		idao.signinsert(id, pwd, nickname, gender, str);
		return "redirect:/list";
	}
	
	// 로그인
	@GetMapping("/login")
	public String dologon() {
		return "login";
	}
	@PostMapping("/dologin")
	public String dologin(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		HttpSession session=req.getSession();
		
		int n=idao.login(id, pwd);
		if(n==1) {
			session.setAttribute("id", id);
			session.setAttribute("pwd", pwd);
			return "redirect:/list";
		} else {
			String alert = "<script>alert('아이디나 비밀번호가 옳바르지 않습니다.')</script>";
			model.addAttribute("alert",alert);
			return "login";
		}
	}
	
	// 아이디 중복체크
	@PostMapping("/check_id")
	@ResponseBody
	public String docheck(HttpServletRequest req) {
		String checkval = null;
		try {
			String id = req.getParameter("id");
			int n = idao.checkid(id);
			if(n==1) {
				checkval = "ok";
			} else {
				checkval = "not ok";
			}
		} catch(Exception e) {
			checkval="val";
		}
		return checkval;
	}
	
	// 닉네임 중복체크
	@PostMapping("/check_nick")
	@ResponseBody
	public String docheck2(HttpServletRequest req) {
		String checkval = null;
		try {
			String nickname = req.getParameter("nickname");
			int n = idao.checkNickname(nickname);
			if(n==1) {
				checkval = "ok";
			} else {
				checkval = "not ok";
			}
		} catch(Exception e) {
			checkval="val";
		}
		return checkval;
	}
}
