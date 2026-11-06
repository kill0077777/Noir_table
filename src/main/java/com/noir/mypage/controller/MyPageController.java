package com.noir.mypage.controller;

import java.io.PrintWriter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.noir.member.vo.MemberVO;
import com.noir.mypage.service.MyPageService;
import com.noir.mypage.vo.CustomerReservationVO;
import com.noir.mypage.vo.NoirMemberVO;
import com.noir.mypage.vo.NotificationVO;
import com.noir.reservation.vo.AdminCheckSeatVO;


@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	// ----------------------------------------------------------------------------------------------------
	//                                                  관리자
	// ----------------------------------------------------------------------------------------------------
	
	// 예약 현황 화면 요청
	@RequestMapping(value="/getReserve.do")
	public ModelAndView loginForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	// 날짜와 시간에 해당하는 예약 조회
	@RequestMapping(value="/adminReserveCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public List<AdminCheckSeatVO> checkReserve (
	        @RequestParam("date") String date,
	        @RequestParam("time") String time) {
		
		//logger.info("date : " + date);
		//logger.info("time : " + time);
		
	    // 1. 예약한 고객예약 아이디와 좌석번호 조회
		List<AdminCheckSeatVO> reservedId = myPageService.getReservedIdByDate(date, time);
	    //logger.info("관리자 예약된 좌석 확인용 reservedId : " + reservedId);

	    return reservedId;  
	}
	// 예약 취소
	@RequestMapping(value="/adminReserveDelete.do", method= RequestMethod.POST)
	public String adminReserveDelete(
			@RequestParam("seatId") int seatId,
            @RequestParam("customerId") int customerId,
            @RequestParam("memberId") int memberId,
            @RequestParam("content") String content,
            @RequestParam("time") String time,
            @RequestParam("date") String date) {
		
		//logger.info("예약삭제 customerId : " + customerId);
		//logger.info("예약삭제 seatId : " + seatId);
		//logger.info("예약삭제 memberId : " + memberId);
		//logger.info("예약삭제 content : " + content);
		
		try {
			// 트랜잭션
			myPageService.adminReserveDelete(seatId, customerId, memberId, content, time, date);
			
			
		} catch (Exception e) {
			//logger.error("예약 삭제 중 오류 발생", e);
			e.printStackTrace();
		}
		return "redirect:/mypage/getReserve.do";
	}
	
	
	
	// ----------------------------------------------------------------------------------------------------
	//                                                  고객
	// ----------------------------------------------------------------------------------------------------
	
	// 내 예약 보기
	@RequestMapping(value="/getReserveCustomer.do", method = RequestMethod.GET)
	public ModelAndView getReserveCustomer(HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		Integer memberId = member.getId();
		
		List<CustomerReservationVO> customerResrevationVO = myPageService.getReserveCustomer(memberId);
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)request.getAttribute("viewName");
		mav.setViewName(viewName);

		mav.addObject("customerReservationList", customerResrevationVO);
		return mav;
		
	}

	// 회원 정보 수정
	@RequestMapping(value="/mypage/updateMember.do", method=RequestMethod.POST)
	public void updateMemberInfo(
	        @ModelAttribute("noirMemberVO") NoirMemberVO noirMemberVO,
	        HttpServletRequest request,
	        HttpServletResponse response) throws Exception {

	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    String contextPath = request.getContextPath();
	    
	    try {
	        myPageService.updateMemberInfo(noirMemberVO);

	        out.println("<script>");
	        out.println("alert('수정되었습니다.');");
	        out.println("location.href='" + contextPath + "/main.do';"); // 페이지 이동
	        out.println("</script>");
	    } catch (Exception e) {
	        e.printStackTrace(); 

	        out.println("<script>");
	        out.println("alert('오류가 발생했습니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	    }

	    out.flush();
	}
	// 알림 확인
	@ResponseBody
	@RequestMapping(value="/notification.do", method=RequestMethod.GET)
	public Map<String, Integer> getUnreadNotificationCount(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		Integer memberId = member.getId();
		
	    List<NotificationVO> notificationVOs = myPageService.getNotification(memberId);
	    // 안 읽은 알림 수 계산 (isRead == 0)
	    long unreadCount = notificationVOs.stream()
	        .filter(n -> n.getIsRead() == 0)
	        .count();

	    Map<String, Integer> result = new HashMap<>();
	    result.put("unreadCount", (int) unreadCount);
	    return result;
	}
	// 알림 조회
	@ResponseBody
	@RequestMapping(value="notificationList.do", method=RequestMethod.GET)
	public List<NotificationVO> getUnreadNotifications(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		Integer memberId = member.getId();
	    
	    List<NotificationVO> all = myPageService.getNotification(memberId);

	    return all.stream()
	              .filter(n -> n.getIsRead() == 0)
	              .collect(Collectors.toList());
	}
	// 알림 읽음 처리
	@ResponseBody
	@RequestMapping(value = "/mypage/notificationRead.do", method = RequestMethod.POST)
	public String markNotificationsAsRead(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		Integer memberId = member.getId();

	    myPageService.updateNotificationRead(memberId);
	    return "success";
	}
}
