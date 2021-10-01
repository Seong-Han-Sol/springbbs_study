package com.human.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String selectBBS(Model model) {
		//화면에 DB에 저장된 데이터를 뿌려줘야하기 때문에 model에 값을 담는다
		iBBS bbs=sqlSession.getMapper(iBBS.class);
		ArrayList<BBSrec> bbsList = bbs.getList();
		for (int i = 0; i < bbsList.size(); i++) {
			System.out.println(i);
		}
		model.addAttribute("BBSList", bbsList);
		return "list";
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
	public String brandNew() {
		return "new";
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
}
