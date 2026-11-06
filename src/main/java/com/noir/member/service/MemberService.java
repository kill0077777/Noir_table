package com.noir.member.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.noir.member.dao.MemberDAO;
import com.noir.member.vo.GoogleProfile;
import com.noir.member.vo.KakaoProfile;
import com.noir.member.vo.MemberProfileVO;
import com.noir.member.vo.MemberRole;
import com.noir.member.vo.MemberVO;
import com.noir.member.vo.NaverProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {


	@Autowired
	MemberDAO memberDAO;
	
	//회원 등록
	public void register(HttpServletRequest req) {
		
		String loginId = req.getParameter("loginId");
		String password = req.getParameter("password");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setLogin_id(loginId);
		memberVO.setPassword(password);
		memberVO.setName(name);
		memberVO.setPhone(phone);
		memberVO.setRole(MemberRole.USER);
		
		//회원등록
		memberDAO.register(memberVO);
		
		//회원 상세 프로필
		MemberVO member = memberDAO.findByLoginId(loginId);
		
		memberDAO.registerProfile(member);
		
	}
	
	//로그인 처리
	public MemberVO login(HttpServletRequest req) {
		
		String loginId = req.getParameter("login_id");
		String password = req.getParameter("password");
		
		MemberVO member = memberDAO.login(loginId, password);
		

		if(!memberDAO.countByLoginId(loginId)) {
			req.setAttribute("errorMsg", "아이디가 존재하지 않습니다.");
			return null;
		}
		
		if(member==null) {
			req.setAttribute("errorMsg", "비밀번호가 틀렸습니다.");
		}
		
		
		return member;
		
	}
	
	//카카오 고유 ID로 회원 찾기
	public MemberVO findByKakaoId(HttpServletRequest req, KakaoProfile kakaoProfile) {
		
		String kakaoId = kakaoProfile.getId()+"";
		
		return memberDAO.findBySnsId(kakaoId);
	}
	
	
	//카카오 로그인 -> 로컬 회원가입 처리
	public MemberVO registerKakaoLogin(HttpServletRequest req, KakaoProfile kakaoProfile) {
		
		MemberVO member = new MemberVO();
		
		member.setLogin_id(kakaoProfile.getKakao_account().getEmail());
		member.setPassword("Social_login");
		member.setName(kakaoProfile.getProperties().getNickname());
		member.setProfileImage(kakaoProfile.getKakao_account().getProfile().getProfile_image_url());
		member.setPhone(kakaoProfile.getKakao_account().getPhone_number());
		member.setSocial_type("KAKAO");
		member.setSns_id(kakaoProfile.getId()+"");
		member.setRole(MemberRole.USER);
		
		System.out.println(member.getPhone());
		
		memberDAO.registerKakao(member);
		
		member = memberDAO.findByLoginId(kakaoProfile.getKakao_account().getEmail());
				
		memberDAO.registerProfile(member);
		
		return member;
	}


	//네이버 고유 ID로 회원찾기
	public MemberVO findByNaverId(HttpServletRequest req, NaverProfile naverProfile) {
		
		String naverId = naverProfile.getResponse().getId();
		
		return memberDAO.findBySnsId(naverId);
	}
	
	//네이버 로그인 -> 로컬 회원가입 처리
	public MemberVO registerNaverLogin(HttpServletRequest req, NaverProfile naverProfile) {
		
		MemberVO member = new MemberVO();
		
		member.setLogin_id(naverProfile.getResponse().getEmail());
		member.setPassword("Social_login");
		member.setName(naverProfile.getResponse().getNickname());
		member.setProfileImage(naverProfile.getResponse().getProfile_image());
		member.setPhone(naverProfile.getResponse().getMobile());
		member.setSocial_type("NAVER");
		member.setSns_id(naverProfile.getResponse().getId());;
		member.setRole(MemberRole.USER);
		
		//카카오 로그인이랑 로직이 동일하므로 카카오 로그인 메소드 사용
		memberDAO.registerKakao(member); 
		
		member = memberDAO.findByLoginId(naverProfile.getResponse().getEmail());
		
		memberDAO.registerProfile(member);
		
		return member;
	}

	public MemberVO findByGoogleId(HttpServletRequest req, GoogleProfile googleProfile) {
		
		String snsId = googleProfile.getId();
	
		return memberDAO.findBySnsId(snsId);
	}

	public MemberVO registerGoogleLogin(HttpServletRequest req, GoogleProfile googleProfile) {
		
		MemberVO member = new MemberVO();
		
		member.setLogin_id(googleProfile.getEmail());
		member.setPassword("Social_login");
		member.setName(googleProfile.getName());
		member.setProfileImage(googleProfile.getPicture());
		member.setSocial_type("Google");
		member.setSns_id(googleProfile.getId());;
		member.setRole(MemberRole.USER);
		
		memberDAO.registerGoogle(member);
		
		member = memberDAO.findByLoginId(googleProfile.getEmail());
		
		memberDAO.registerProfile(member);
		
		return member; 
	}

	public MemberVO saveGooglePhone(HttpServletRequest req, String phone) {
		
		HttpSession session = req.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		String snsId = member.getSns_id();
		
		memberDAO.saveGooglePhone(phone,snsId);
		
		member.setPhone(phone);
		
		return member;
		
	}

	public void updateMember(MemberVO member) {
		
		memberDAO.updateMember(member);
		
	}
	
	//카카오 소셜 로그인 연동
	public MemberVO registerKakaolink(MemberVO member, KakaoProfile kakaoProfile) {

		member.setProfileImage(kakaoProfile.getKakao_account().getProfile().getProfile_image_url());
		member.setSocial_type("KAKAO");
		member.setSns_id(kakaoProfile.getId()+"");
		
		memberDAO.snslink(member);
		
		return member;
	}
	
	//네이버 소셜 로그인 연동
	public MemberVO registerNaverlink(MemberVO member, NaverProfile naverProfile) {
		
		member.setProfileImage(naverProfile.getResponse().getProfile_image());
		member.setSocial_type("NAVER");
		member.setSns_id(naverProfile.getResponse().getId());;
		
		memberDAO.snslink(member);
		
		return member;
	}
	
	//구글 소셜 로그인 연동
	public MemberVO registerGooglelink(MemberVO member, GoogleProfile googleProfile) {
		
		member.setProfileImage(googleProfile.getPicture());
		member.setSocial_type("Google");
		member.setSns_id(googleProfile.getId());;
		
		memberDAO.snslink(member);
		
		return member;
	}

	public List<MemberVO> getMemberList(int pageSize, int startRow) {
		
		return memberDAO.getMemberList(pageSize,startRow);
	}

	public MemberProfileVO findProfileById(int id) {
		
		return memberDAO.findProfileById(id);
	}

	public List<MemberProfileVO> getMemberProfileList() {
		
		return memberDAO.getMemberProfileList();
	}

	public List<MemberProfileVO> updateCustomerInfo() {
		
		List<MemberProfileVO> profileList = memberDAO.getMemberProfileList();
		
		//등급업 조건 충족 되면 등급업
		for(MemberProfileVO profile : profileList) {
			int profile_id = profile.getProfile_id();
			int visitCount = profile.getVisit_count();
			int totalSpent = profile.getTotal_spent();
			String grade = profile.getGrade();
			
			// 방문회수 50 회 이상 이거나 총 소비 금액 천만원 이상인 경우 VIP
			if(visitCount >= 50 || totalSpent >= 10000000) {
				profile.setGrade("VIP");
				memberDAO.upGradeCustomer(profile);
			} 
			// 한번이라도 방문 했다면 REGULAR로 등급업
			else if( visitCount < 50 && visitCount >= 1) {
				profile.setGrade("REGULAR");
				memberDAO.upGradeCustomer(profile);
			}		
		}
		
		profileList = memberDAO.getMemberProfileList();
		
		return profileList;
	}

	public List<MemberVO> getVIPMemberList() {
		
		return memberDAO.getVIPMemberList();
	}

	public int countAllExceptAdmin() {
		
		return memberDAO.countAllExceptAdmin();
	}


	public List<MemberVO> searchMemberListPaged(Map<String, Object> paramMap) {
		
		return memberDAO.searchMemberListPaged(paramMap);
	}

	public int countSearchMember(String trim) {
		
		return memberDAO.countSearchMember(trim);
	}

	public boolean isIdDuplicate(String loginId) {
		
		return memberDAO.selectCountByLoginId(loginId) > 0;
	}
}
