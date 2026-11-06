package com.noir.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.noir.member.vo.MemberVO;
import com.noir.reservation.service.AdminReserveService;
import com.noir.reservation.vo.CustomerGetReserveInfoVO;
import com.noir.reservation.vo.CustomerReserveFirstVO;
import com.noir.reservation.vo.RestaurantSeatVO;


@Controller
@RequestMapping("/reservationUser")
public class ReservationUserController {
	@Autowired
	private AdminReserveService adminReserveService;
	//static Logger logger = Logger.getLogger(AdminReserveControllerImpl.class);
	
		@RequestMapping("/customerReserveFirstFloor.do")
	    public ModelAndView moveToSecondStepFirst(
	            @RequestParam("floor") String floor,
	            @RequestParam("location") String location,
	            @RequestParam("headCount") String headCount,
	            @RequestParam("date") String date,
	            @RequestParam("time") String time,
	            @RequestParam("reserveId") int reserveId,
	            HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			MemberVO member = (MemberVO) session.getAttribute("member");
			Integer memberId = member.getId();
			
	        ModelAndView mav = new ModelAndView(); // JSP: /WEB-INF/views/customer/customerReserveFirst.jsp
	        
	        List<RestaurantSeatVO> restaurantSeatVOs = adminReserveService.getAllSeats();

	        // 전체 좌석 목록
	        mav.addObject("seatList", restaurantSeatVOs);
	        
	        List<Integer> reservedSeatsId = adminReserveService.getReservedSeats(reserveId); 
	        mav.addObject("reservedSeatsId", reservedSeatsId);
	        
	        mav.addObject("floor", floor);
	        mav.addObject("location", location);
	        mav.addObject("headCount", headCount);
	        mav.addObject("date", date);
	        mav.addObject("time", time);
	        mav.addObject("reserveId", reserveId);
	        
			String viewName=(String)request.getAttribute("viewName");
			mav.setViewName(viewName);
			
	        return mav;
		}
		@RequestMapping("/customerReserveSecondFloor.do")
	    public ModelAndView moveToSecondStepSecond(
	            @RequestParam("floor") String floor,
	            @RequestParam("location") String location,
	            @RequestParam("headCount") String headCount,
	            @RequestParam("date") String date,
	            @RequestParam("time") String time,
	            @RequestParam("reserveId") int reserveId,
	            HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			MemberVO member = (MemberVO) session.getAttribute("member");
			Integer memberId = member.getId();
			
			ModelAndView mav = new ModelAndView(); // JSP: /WEB-INF/views/customer/customerReserveSecond.jsp

			List<RestaurantSeatVO> restaurantSeatVOs = adminReserveService.getAllSeats();

	        mav.addObject("seatList", restaurantSeatVOs);

	        List<Integer> reservedSeatsId = adminReserveService.getReservedSeats(reserveId); 
	        mav.addObject("reservedSeatsId", reservedSeatsId);
	        
	        mav.addObject("floor", floor);
	        mav.addObject("location", location);
	        mav.addObject("headCount", headCount);
	        mav.addObject("date", date);
	        mav.addObject("time", time);
	        mav.addObject("reserveId", reserveId);

			String viewName=(String)request.getAttribute("viewName");
			mav.setViewName(viewName);
			
	        return mav;
		}
		// 세 번째 화면으로(결제화면)
		@RequestMapping("customerReserveThird.do")
		public ModelAndView customerReserveThird(
				@RequestParam("seatId") int seatId,
			    @RequestParam("floor") String floor,
			    @RequestParam("location") String location,
			    @RequestParam("headCount") String headCount,
			    @RequestParam("date") String date,
			    @RequestParam("time") String time,
				@RequestParam("reserveId") int reserveId,
				HttpServletRequest request) {
		    
			ModelAndView mav = new ModelAndView(); // JSP: /WEB-INF/views/customer/customerReserveThird.jsp
			mav.addObject("seatId", seatId);
			mav.addObject("floor", floor);
			mav.addObject("location", location);
			mav.addObject("headCount", headCount);
			mav.addObject("date", date);
			mav.addObject("time", time);
			mav.addObject("reserveId", reserveId);
			
			String viewName=(String)request.getAttribute("viewName");
			mav.setViewName(viewName);
			
			return mav;
		}
		// 결제하기(성공시 결제정보 화면)
		@RequestMapping(value = "customerReservePay.do", method = RequestMethod.POST)
		public String customerReserveFour(
				@RequestParam("seatId") int seatId,
				@RequestParam("reserveId") int reserveId,
				@RequestParam("totalPrice") int totalPrice,
				HttpServletRequest request) {
			
			try {
				HttpSession session = request.getSession();
				session.setAttribute("reserveId", reserveId);
				session.setAttribute("seatId", seatId);
				MemberVO member = (MemberVO) session.getAttribute("member");
				Integer memberId = member.getId();
				
				// 트랜잭션
				adminReserveService.reserveAndPay(seatId, reserveId, totalPrice, memberId);
		        
		        return "redirect:/reservationUser/customerReserveFour.do";
				
			} catch (IllegalStateException  e) {
		        // 중복 결제 등 사용자 실수에 의한 예외
		        request.setAttribute("message", e.getMessage());
		        request.setAttribute("redirectUrl", request.getContextPath() + "/reservationUser.do");
		        return "common/alert";
			} catch (Exception e) {
		        e.printStackTrace();
		        return "redirect:/errorPage.jsp";
			}
		}
		// adminReserveService.getSeatById(seatId)
		// adminReserveService.getAdminReservationById(reserveId)
		@RequestMapping("customerReserveFour.do")
		public ModelAndView customerReserveFour(HttpServletRequest request) {
			
			
			HttpSession session = request.getSession();
			MemberVO member = (MemberVO) session.getAttribute("member");
			Integer memberId = member.getId();
		    Integer reserveId = (Integer) session.getAttribute("reserveId");
		    Integer seatId = (Integer) session.getAttribute("seatId");
		    //logger.info("memberId : " + memberId);
		    //logger.info("reserveId : " + reserveId);
		    //logger.info("seatId : " + seatId);
		    
		    CustomerGetReserveInfoVO infoVo = adminReserveService.selectPayInfo(memberId, reserveId, seatId);
		    
		    ModelAndView mav = new ModelAndView();
		    
		    mav.addObject("info", infoVo);
		    
			String viewName=(String)request.getAttribute("viewName");
			mav.setViewName(viewName);
			
		    return mav;
		}
	
}
