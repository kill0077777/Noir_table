package com.noir.reservation.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.noir.reservation.service.AdminReserveService;
import com.noir.reservation.vo.AdminReserveAddVO;


@Controller
@RequestMapping("/reservationAdmin")
public class ReservationAdminController {
	@Autowired
	private AdminReserveService adminReserveService;
	//static Logger logger = Logger.getLogger(AdminReserveControllerImpl.class);
	
	// 관리자 예약 등록 처리
	@RequestMapping(value="/addReserve.do", method=RequestMethod.POST)
	public ModelAndView adminReserveAdd(@ModelAttribute("reserve") AdminReserveAddVO reserve, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	    response.setContentType("text/html; charset=UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    
	    try {
	        adminReserveService.adminReserveAddDb(reserve);
	        return new ModelAndView("redirect:/reservationAdmin.do");
	    } catch (Exception e) {
	        e.printStackTrace(); 
	        PrintWriter out = response.getWriter();
	        
	        // 중복 예약 예외일 경우
	        if (e instanceof org.springframework.dao.DuplicateKeyException) {
	            out.println("<script>alert('⚠ 이미 예약된 날짜/시간/층입니다.'); history.back();</script>");
	            return null;
	        } 
	        
	        out.println("<script>alert('예약 등록 중 오류가 발생했습니다.'); history.back();</script>");
	        out.flush();
	        return null;
	    } 
	}	
}
