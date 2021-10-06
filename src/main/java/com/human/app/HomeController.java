package com.human.app;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private SqlSession sqlSession;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
	
	//list.jsp를 리턴해 보여주는 코드
	@RequestMapping(value ="/list", method = RequestMethod.GET)
	public String selectBBS(HttpServletRequest hsr, Model model) {
		//화면에 DB에 저장된 데이터를 뿌려줘야하기 때문에 model에 값을 담는다
		iBBS bbs=sqlSession.getMapper(iBBS.class);
		ArrayList<BBSrec> bbsList = bbs.getList();
		//로그인 관련 코드
		  HttpSession session = hsr.getSession(); 
		  String userid=(String)session.getAttribute("userId");  //session.setAttribute("userId", userId);에서 설정한 값을 가져옴
		  if(userid == null || userid.equals("")) { //로그인 아닐때는 로그인 버튼 보여주기
		  	model.addAttribute("loginCheck", "0"); 
		  }else { //로그인일 때는 로그인 버튼 사라지고 새글쓰기 버튼 나오게 하기 jsp 파일 코드랑 같이 살펴보기
		  	model.addAttribute("loginCheck", "1");
		  	model.addAttribute("userid", userid);
		  }
		//모델에 값을 담아줌 (아래)
		model.addAttribute("BBSList", bbsList);
		return "list";
	}
	//login.jsp를 리턴해 보여주는 코드
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginView() {
		return "login";
	}
	//login submit 구현하기
	@RequestMapping(value = "/checkLogin", method = RequestMethod.POST)
	public String userLogin(HttpServletRequest hsr) {
		String userId = hsr.getParameter("uId"); //login.jsp input태그 name값
		String passcode = hsr.getParameter("uPw");
		iMember member = sqlSession.getMapper(iMember.class);
		int n =member.checkUser(userId, passcode);
		if(n>0) {
			HttpSession session = hsr.getSession();
			session.setAttribute("userId", userId);
			return "redirect:/list";
		}else {
			return "redirect:/login";
		}
	}
	//logout
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest hsr) {
		HttpSession session=hsr.getSession();
		session.invalidate();
		return "redirect:list";
	}
	//signin.jsp를 리턴해 보여주는 코드
	@RequestMapping(value = "/singUp", method = RequestMethod.GET)
	public String singin() {
		
		return "singUp";
	}
	//회원가입 submit구현하기
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String newJoin(HttpServletRequest hsr) {
		String realName = hsr.getParameter("realName"); //singUp input태그 name값 가져오는것
		String newId = hsr.getParameter("newId");
		String pw1 = hsr.getParameter("pw1");
		//위에 입력한 파라미터 값을 제대로 가져왔는지 확인하기 위한 디버깅 코드
		System.out.println("name["+realName+"] id["+newId+"] passcode["+pw1+"]");
		iMember member = sqlSession.getMapper(iMember.class);
		member.newUser(realName, newId, pw1);
		return "redirect:/login";
	}
	//view.jsp를 리턴해 보여주는 코드
	@RequestMapping(value = "/view/{bbs_id}", method = RequestMethod.GET)
	public String selectOneBBS(@PathVariable("bbs_id") int bbs_id, Model model) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		BBSrec post = bbs.getPost(bbs_id);
		model.addAttribute("post", post);
		return "view";
	}
	//new.jsp를 리턴해 보여주는 코드
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String brandNew(HttpServletRequest hsr) {
		if(loginUser(hsr)) return "new";
		return "redirect:/list";
	}
	//수정 화면
	@RequestMapping(value = "/update_view/{bbs_id}", method = RequestMethod.GET)
	public String updateView(@PathVariable("bbs_id") int bbs_id, Model model) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		UpdateRec post2 = bbs.getUpdate(bbs_id);
		model.addAttribute("post", post2);
		return "update";
	}
	//게시글 추가
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String insertBBS(HttpServletRequest hsr) {
		//로그인이 안되어있으면 접근을 못하게 만드는 메서드를 호출
		if(!loginUser(hsr)) return "redirect:/list";
		
		HttpSession s = hsr.getSession();
		String userid=(String)s.getAttribute("userid");
		String ntitle = hsr.getParameter("title"); //new.jsp form 태그 안에 있는 name의 값을 파라미터로 가져옴
		String nContent = hsr.getParameter("content");
		String nWriter = hsr.getParameter("writer");
		String nPasscode = hsr.getParameter("passcode");
		//여기까진 단순히 값을 가져와 변수에 대입하는 코드
		/*mybatis를 사용하려면 Interface와 xml파일이 필요하다
		 * xml파일에는 입력한 값을 DB에 저장하기 위한 SQL문을 작성해야한다 <insert id=""></insert> 
		 * 인터페이스에는 xml에서 지정한 id명을 추상메서드 이름으로 사용하고 받아오는 값의 수에 맞춰서 매개변수를 입력해줘야한다 ({param}의 갯수)
		 * 이때 인터페이스와 xml파일 이름은 똑같이 써주는 것이 가독성이 좋고
		 * xml에 어느 인터페이스와 연동이 되는지 정보를 주기 위해 <mapper>태그 안에 namespace="com.human.app.인터페이스이름"을 적어준다*/
		//위에 입력한 파라미터 값을 제대로 가져왔는지 확인하기 위한 디버깅 코드
		System.out.println("title["+ntitle+"] content["+nContent+"] write["+nWriter+"] passcode["+nPasscode+"]");
		//Interface를 호출해 사용 (DB에 저장)
		iBBS bbs= sqlSession.getMapper(iBBS.class);
		bbs.writebbs(ntitle, nContent, nWriter, nPasscode);
		//(이때 호출한 함수안에 넣어줄 변수는 위에 파라미터로 받아서 저장한 변수를 넣어주는데 인터페이스 변수 순서와 맞게 알맞은 변수를 넣어줘야함)
		return "redirect:/list";
		//redirect -> 입력한 곳으로 방향을 돌림 즉, list.jsp화면으로 돌아감
	}
	//게시글 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateBBS(HttpServletRequest hsr) {
		if(!loginUser(hsr)) return "redirect:/list";
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		String title = hsr.getParameter("title");
		String content = hsr.getParameter("content");
		iBBS bbs=sqlSession.getMapper(iBBS.class);
		bbs.updateBBS(bbs_id, title, content);
		return "redirect:/list";
	}
	
	//게시글 삭제
	@RequestMapping(value = "/delete/{bbs_id}", method = RequestMethod.GET)
	public String deleteBBS(@PathVariable("bbs_id") int bbs_id) {
		iBBS bbs=sqlSession.getMapper(iBBS.class);
		bbs.deleteBBS(bbs_id);
		return "redirect:/list";
	}
	//댓글 아이작스
	@RequestMapping(value = "/ReplyControl", method = RequestMethod.POST)
	@ResponseBody
	public String doReplyControl(HttpServletRequest hsr) {
		//여기에 댓글에 관련된 CRUD를 모두 구현할 예정
		
		String result="";
		try {
			String optype=hsr.getParameter("optype");
			String reply_content=hsr.getParameter("reply_content");
			int bbs_id=Integer.parseInt(hsr.getParameter("bbs_id"));
			HttpSession s=hsr.getSession();
			String userid=(String)s.getAttribute("userId");
			if(optype.equals("add")) {
				//댓글등록 MyBatis 호출
				iReply reply =sqlSession.getMapper(iReply.class);
				reply.addReply(bbs_id, reply_content, userid);
			} else if(optype.equals("delete")) {
				//댓글삭제
			} else if(optype.equals("update")) {
				//댓글 수정
			}
			result="ok";
		} catch(Exception e) {
			result="fail";
		} finally {
			return result;
		}
	}
	//로그인 관련 해킹 방지 코드 -> 로그인이 안된 상태로 다른 페이지 url복사할 경우 팅겨나가게 하기
	public boolean loginUser(HttpServletRequest hsr) {
		HttpSession s=hsr.getSession();
		String userid=(String) s.getAttribute("userId");
		if(userid==null || userid.equals("")) {
			return false;
		} else {
			return true;
		}
	}
}
