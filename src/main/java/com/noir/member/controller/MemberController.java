package com.noir.member.controller;

import java.io.File;
import java.net.URLEncoder;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.support.HttpRequestHandlerServlet;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.noir.member.service.MemberService;
import com.noir.member.vo.GoogleProfile;
import com.noir.member.vo.KakaoProfile;
import com.noir.member.vo.MemberProfileVO;
import com.noir.member.vo.MemberRole;
import com.noir.member.vo.MemberVO;
import com.noir.member.vo.NaverProfile;
import com.noir.member.vo.OAuthToken;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	//멤버 로그인 화면 요청
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//멤버 회원가입 화면 요청
	@RequestMapping(value="/registerForm.do")
	public ModelAndView registerForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//구글 로그인 회원 전화번호 입력 요청폼
	@RequestMapping(value="/googleForm.do")
	public ModelAndView googleForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//구글 회원 전화번호 저장
	@RequestMapping(value="/saveGooglePhone",method=RequestMethod.POST)
	public ModelAndView saveGooglePhone(@RequestParam("phone")String phone,
			HttpServletRequest req,HttpServletResponse resp)throws Exception {
				
		MemberVO member = memberService.saveGooglePhone(req,phone);
		
		req.setAttribute("member", member);
				
		return new ModelAndView("forward:/WEB-INF/views/member/saveSuccess.jsp");
	}
	
	//멤버 회원가입 처리
	@RequestMapping(value="/register.do",method=RequestMethod.POST)
	public ModelAndView register(HttpServletRequest req, HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//회원가입 폼 값 받아오기
		String loginId = req.getParameter("loginId");
		String password = req.getParameter("password");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String agreePolicy = req.getParameter("agreePolicy");
		
		boolean hasError = false;
		
		//값 유효성 검사
	    if (loginId == null || loginId.trim().isEmpty()) {
	        req.setAttribute("loginIdError", "아이디를 입력해주세요.");
	        hasError = true;
	    }
	    if (password == null || password.trim().isEmpty()) {
	        req.setAttribute("passwordError", "비밀번호를 입력해주세요.");
	        hasError = true;
	    }
	    if (name == null || name.trim().isEmpty()) {
	        req.setAttribute("nameError", "이름을 입력해주세요.");
	        hasError = true;
	    }
	    if (phone == null || phone.trim().isEmpty()) {
	    	req.setAttribute("phoneError", "전화번호를 입력해주세요.");
	    	hasError = true;
	    }
	    
	    if (agreePolicy==null|| agreePolicy.isEmpty()) {
	    	req.setAttribute("agreePolicyError", "개인정보 처리방침 동의는 필수 선택입니다.");
	    	hasError =true;
	    }

	    if (hasError) {
	        mav.setViewName("/member/registerForm");
	        return mav;
	    }
	    
	    memberService.register(req);
	    
	    return new ModelAndView("forward:/WEB-INF/views/member/registerSuccess.jsp");
		
	}
	
	//로그인
	@RequestMapping(value="/login.do",method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest req, HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		//로그인 사용자 정보 받아오기
		MemberVO member = memberService.login(req);
		
		if(member==null) {
			mav.setViewName("/member/loginForm");
			return mav;
		}

		if(member.getRole() == MemberRole.USER) {
			MemberProfileVO memberProfile = memberService.findProfileById(member.getId());
			session.setAttribute("memberProfile", memberProfile);
		}

		session.setAttribute("member", member);

		MemberVO members = (MemberVO) session.getAttribute("member");
		Integer memberId = members.getId();
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();
		
		//세션 무효화
		session.invalidate();
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	
	//카카오 로그인
	@RequestMapping(value="/KakaoCallback",
					produces="application/json;charset=utf-8",
					method=RequestMethod.GET)
	public ModelAndView kakaoCallback(String code,
			HttpServletRequest req,
			HttpServletResponse resp) throws Exception{
		
		String errorMsg = "이미 다른 계정에 연동된 소셜로그인 계정입니다.";
		String encodedMsg = URLEncoder.encode(errorMsg, "UTF-8");
		
		ModelAndView mav = new ModelAndView();
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		
		LinkedMultiValueMap<String,String> params = new LinkedMultiValueMap<String, String>();
		
		params.add("grant_type", "authorization_code");
		params.add("client_id", "f21e91b25c99a317f8ac6471ac3f3c5a");
		params.add("redirect_uri", "http://localhost:8090/noir/member/KakaoCallback");
		params.add("code", code);
		
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		ResponseEntity<String> respEntity = rt.exchange("https://kauth.kakao.com/oauth/token",
												HttpMethod.POST,
												kakaoTokenRequest,
												String.class
											);
		
		ObjectMapper objMapper = new ObjectMapper();
		
		OAuthToken oAuthToken = objMapper.readValue(respEntity.getBody(),OAuthToken.class);
		
		RestTemplate rt2 = new RestTemplate();
		
		HttpHeaders header2 = new HttpHeaders();
					header2.add("Authorization", "Bearer "+oAuthToken.getAccess_token());
					header2.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(header2);
					
		ResponseEntity<String> respEntity2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest2,
				String.class);
		
		ObjectMapper objMapper2 = new ObjectMapper();
		
		KakaoProfile kakaoProfile = objMapper2.readValue(respEntity2.getBody(),KakaoProfile.class);
		
		HttpSession session = req.getSession();
			
	    MemberVO sessionMember = (MemberVO) session.getAttribute("member");

	    if (sessionMember == null) {
	        // (1) 비로그인 상태 → 카카오 계정으로 로그인 시도
	        MemberVO member = memberService.findByKakaoId(req, kakaoProfile);
	        if (member == null) {
	            member = memberService.registerKakaoLogin(req, kakaoProfile); // 신규 가입
	        }
	        
			MemberProfileVO memberProfile = memberService.findProfileById(member.getId());
			session.setAttribute("memberProfile", memberProfile);
	        session.setAttribute("member", member);
	        
	    } else {
	        // (2) 로그인 상태인데 카카오 연동이 안 돼 있음
	        if (sessionMember.getSns_id() == null) {
	        	
	        	MemberVO existing = memberService.findByKakaoId(req, kakaoProfile);
	        	
	            if (existing != null) {
	                // 이미 다른 계정과 연동된 상태이므로 연동 불가
	            	mav.setViewName("redirect:/member/snslink.do?errorMsg="+encodedMsg);
	                return mav;
	            }
	        	
	            sessionMember = memberService.registerKakaolink(sessionMember, kakaoProfile); // 연동 처리
	            session.setAttribute("member", sessionMember);
	    		MemberProfileVO memberProfile = memberService.findProfileById(sessionMember.getId());
	    		session.setAttribute("memberProfile", memberProfile);
	            
	        }
	    }
	    				
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//네이버 로그인
	@RequestMapping(value="/NaverCallback")
	public ModelAndView naverCallback(String code,String state,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		//1.AccessToken 요청
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		LinkedMultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "EcRl77o5MKP8XONskdgt");
		params.add("client_secret", "YOUR_NAVER_CLIENT_SECRET");
		params.add("code", code);
		params.add("state", state);
		
		HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<MultiValueMap<String,String>>(params,headers);
		
		ResponseEntity<String> tokenResponse = rt.exchange(
				"https://nid.naver.com/oauth2.0/token",
				HttpMethod.POST,
				tokenRequest,
				String.class
		);
		
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken naverToken = objectMapper.readValue(tokenResponse.getBody(), OAuthToken.class);
		
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders profileHeaders = new HttpHeaders();
		profileHeaders.add("Authorization", "Bearer " + naverToken.getAccess_token());

		HttpEntity<String> profileRequest = new HttpEntity<>(profileHeaders);

		ResponseEntity<String> profileResponse = rt2.exchange(
			"https://openapi.naver.com/v1/nid/me",
			HttpMethod.GET,
			profileRequest,
			String.class
		);
		
		NaverProfile naverProfile = objectMapper.readValue(profileResponse.getBody(), NaverProfile.class);
		
		HttpSession session = req.getSession();
		
	    MemberVO sessionMember = (MemberVO) session.getAttribute("member");

	    if (sessionMember == null) {
	        // (1) 비로그인 상태 → 네이버 계정으로 로그인 시도
	        MemberVO member = memberService.findByNaverId(req, naverProfile);
	        if (member == null) {
	            member = memberService.registerNaverLogin(req, naverProfile); // 신규 가입
	        }
			MemberProfileVO memberProfile = memberService.findProfileById(member.getId());
			session.setAttribute("memberProfile", memberProfile);
	        session.setAttribute("member", member);
	    } else {
	        // (2) 로그인 상태인데 네이버 연동이 안 돼 있음
	        if (sessionMember.getSns_id() == null) {
	        	
	        	MemberVO existing = memberService.findByNaverId(req, naverProfile);
	        	
	            if (existing != null) {
	                // 이미 다른 계정과 연동된 상태이므로 연동 불가

					String errorMsg = "이미 다른 계정에 연동된 소셜로그인 계정입니다.";
					String encodedMsg = URLEncoder.encode(errorMsg, "UTF-8");
					
					mav.setViewName("redirect:/member/snslink.do?errorMsg=" + encodedMsg);
	                return mav;
	            }
	        	
	            sessionMember = memberService.registerNaverlink(sessionMember, naverProfile); // 연동 처리
	            session.setAttribute("member", sessionMember);
	    		MemberProfileVO memberProfile = memberService.findProfileById(sessionMember.getId());
	    		session.setAttribute("memberProfile", memberProfile);
	        }
	    }

		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//구글 로그인
	@RequestMapping(value="/GoogleCallback")
	public ModelAndView googleCallback(String code,String state,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		// 1. Access Token 요청
	    RestTemplate rt = new RestTemplate();

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	    params.add("code", code);
	    params.add("client_id", "1094665047278-252f9pu3h7e9547j7e39tjcnq83r6a2p.apps.googleusercontent.com");
	    params.add("client_secret", "YOUR_GOOGLE_CLIENT_SECRET");
	    params.add("redirect_uri", "http://localhost:8090/noir/member/GoogleCallback");
	    params.add("grant_type", "authorization_code");

	    HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(params, headers);

	    ResponseEntity<String> tokenResponse = rt.exchange(
	        "https://oauth2.googleapis.com/token",
	        HttpMethod.POST,
	        tokenRequest,
	        String.class
	    );
	    
	    ObjectMapper mapper = new ObjectMapper();
	    OAuthToken token = mapper.readValue(tokenResponse.getBody(), OAuthToken.class);

	    // 2. 사용자 정보 요청
	    HttpHeaders profileHeader = new HttpHeaders();
	    profileHeader.add("Authorization", "Bearer " + token.getAccess_token());

	    HttpEntity<String> profileRequest = new HttpEntity<>(profileHeader);

	    ResponseEntity<String> profileResponse = rt.exchange(
	        "https://www.googleapis.com/oauth2/v2/userinfo",
	        HttpMethod.GET,
	        profileRequest,
	        String.class
	    );
	    
	    GoogleProfile googleProfile = mapper.readValue(profileResponse.getBody(), GoogleProfile.class);
		
		HttpSession session = req.getSession();
		
	    MemberVO sessionMember = (MemberVO) session.getAttribute("member");

	    if (sessionMember == null) {
	        // (1) 비로그인 상태 → 구글 계정으로 로그인 시도
	        MemberVO member = memberService.findByGoogleId(req, googleProfile);
	        if (member == null) {
	            member = memberService.registerGoogleLogin(req, googleProfile); // 신규 가입
	        }
	        
			MemberProfileVO memberProfile = memberService.findProfileById(member.getId());
			session.setAttribute("memberProfile", memberProfile);
	        session.setAttribute("member", member);
	        
	        if(member.getPhone() == null) {
	        	mav.setViewName("redirect:/member/googleForm.do");
	        	return mav;
	        }
	        	mav.setViewName("redirect:/main.do");
	        
	        return mav;
	    } else {
	        // (2) 로그인 상태인데 구글 연동이 안 돼 있음
	        if (sessionMember.getSns_id() == null) {
	        	
	        	MemberVO existing = memberService.findByGoogleId(req, googleProfile);
	        	
	            if (existing != null) {
	                // 이미 다른 계정과 연동된 상태이므로 연동 불가

					String errorMsg = "이미 다른 계정에 연동된 소셜로그인 계정입니다.";
					String encodedMsg = URLEncoder.encode(errorMsg, "UTF-8");
					
					mav.setViewName("redirect:/member/snslink.do?errorMsg=" + encodedMsg);
					
	                return mav;
	            }
	        	
	            sessionMember = memberService.registerGooglelink(sessionMember, googleProfile); // 연동 처리
	            session.setAttribute("member", sessionMember);
	    		MemberProfileVO memberProfile = memberService.findProfileById(sessionMember.getId());
	    		session.setAttribute("memberProfile", memberProfile);
	        }
	    }
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//멤버 개인정보 수정 페이지
	@RequestMapping("/editPage.do")
	public ModelAndView editPage(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();

	
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@RequestMapping("/update.do")
	public ModelAndView updateMember(HttpServletRequest req,
									 @RequestParam("name") String name,
									 @RequestParam("password") String password,
	                                 @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
	                                 HttpSession session) throws Exception{
		
	    ModelAndView mav = new ModelAndView();

	    // 세션에서 현재 멤버 가져오기
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    
	    // 비밀번호 변경
	    if (password != null && !password.trim().isEmpty()) {
	        member.setPassword(password);
	    }
	    
	    // 이름 변경
	    member.setName(name);
	    
	    // 프로필 이미지 업로드 처리
	    if (profileImage != null && !profileImage.isEmpty()) {
	        String uploadDir = "C:/upload/noir/profile/";
	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs(); // 디렉토리 없으면 생성

	        String originalFilename = profileImage.getOriginalFilename();
	        String uuid = UUID.randomUUID().toString();
	        String savedName = uuid + "_" + originalFilename;

	        File target = new File(uploadDir + savedName);
	        profileImage.transferTo(target);

	        // DB에는 파일 이름만 저장 (경로는 저장 안 함)
	        member.setProfileImage(savedName);
	    }
	    
	    // TODO: 서비스 호출해서 DB 업데이트
	    memberService.updateMember(member);
	    
	    // 세션도 갱신
	    session.setAttribute("member", member);
	    
	    mav.setViewName("redirect:/member/editPage.do"); // 예: 마이페이지로 이동
	    
	    return mav;
	}
	
	//소셜네트워크 서비스 연동하기 페이지
	@RequestMapping("/snslink.do")
	public ModelAndView snslinkPage(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();

	
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
	}
	
	//관리자 - 고객 관리 페이지
	@RequestMapping("/memberlist.do")
	public ModelAndView memberlist(@RequestParam(value = "page", defaultValue = "1") int page,
	                               @RequestParam(value = "searchId", required = false) String searchId,
	                               HttpServletRequest req, HttpServletResponse resp) {

	    ModelAndView mav = new ModelAndView();
	    int pageSize = 10;
	    int startRow = (page - 1) * pageSize;
	    int endRow = page * pageSize;
	    
	    List<MemberVO> memberList;
	    int totalCount;

	    if (searchId != null && !searchId.trim().isEmpty()) {
	        // 🔍 검색어가 있으면 페이징까지 적용해서 DAO에서 조회
	        Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("searchId", "%" + searchId.trim() + "%");
	        paramMap.put("startRow", startRow);
	        paramMap.put("endRow", endRow);

	        memberList = memberService.searchMemberListPaged(paramMap);
	        totalCount = memberService.countSearchMember(searchId.trim());
	    } else {
	        memberList = memberService.getMemberList(pageSize, startRow);
	        totalCount = memberService.countAllExceptAdmin();
	    }

	    List<MemberProfileVO> memberProfileList = memberService.getMemberProfileList();

	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    req.setAttribute("memberList", memberList);
	    req.setAttribute("memberProfileList", memberProfileList);
	    req.setAttribute("currentPage", page);
	    req.setAttribute("totalPages", totalPages);
	    req.setAttribute("searchId", searchId);

	    mav.setViewName("/member/memberlist");
	    return mav;
	}
	
	//전체 고객 등급/정보 갱신
	@RequestMapping("/updateCustomerInfo.do")
	public ModelAndView updateCustomerInfo(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();
		
		List<MemberProfileVO> memberProfileList = memberService.updateCustomerInfo();
				
		mav.setViewName("redirect:/member/memberlist.do");
		
		return mav;
		
	}
	
	@RequestMapping("/vipList.do")
	public ModelAndView getVipList(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();
		
		List<MemberVO> memberList = memberService.getVIPMemberList();
		
		req.setAttribute("memberList", memberList);
		
		List<MemberProfileVO> memberProfileList = memberService.getMemberProfileList();
		
		req.setAttribute("memberProfileList", memberProfileList);
		
		mav.setViewName("/member/memberlist");
		
		return mav;
		
	}
	
	
	@RequestMapping("/checkId.do")
	@ResponseBody
	public Map<String, Object> checkId(@RequestParam("loginId") String loginId) {
		
		Map<String, Object> result = new HashMap<>();
		
	    boolean isDuplicate = memberService.isIdDuplicate(loginId); // 아이디 존재 여부 확인
	    
	    result.put("isDuplicate", isDuplicate);
	    
	    return result;
	}
	
	
}
