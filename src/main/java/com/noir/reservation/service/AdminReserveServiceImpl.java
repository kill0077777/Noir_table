package com.noir.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noir.reservation.dao.AdminReserveDAO;
import com.noir.reservation.vo.AdminCheckSeatVO;
import com.noir.reservation.vo.AdminReservationVO;
import com.noir.reservation.vo.AdminReserveAddVO;
import com.noir.reservation.vo.CustomerGetReserveInfoVO;
import com.noir.reservation.vo.CustomerReserveFirstVO;
import com.noir.reservation.vo.RestaurantSeatVO;
import com.noir.reservation.vo.SeatVO;


@Service
public class AdminReserveServiceImpl implements AdminReserveService {
	@Autowired
	private AdminReserveDAO adminReserveDAO;
	
	//private static final Logger logger = Logger.getLogger(AdminReserveServiceImpl.class);
	
	// 관리자 예약 등록하기
	@Override
	public void adminReserveAddDb(AdminReserveAddVO reserve) {
		adminReserveDAO.adminReserveAddDb(reserve);
	}
	
	@Override
	public List<AdminCheckSeatVO> getReservedIdByDate(String date, String time) {
		return adminReserveDAO.getReservedIdByDate(date, time);
	}
	
	// 관리자가 예약 취소
	@Transactional
	@Override
	public void adminReserveDelete(int seatId, int customerId, int memberId, String content, String time, String date) {
		int accountId = 1;
		
		// 1. 알림 테이블에 저장하기(예약취소사유)
		adminReserveDAO.adminAddDeleteMessage(customerId, time, date, seatId , content);

		// 2. 환불 금액 조회
		int refundMoney = adminReserveDAO.getRefundMoney(customerId);
				
	    // 3. 거래 내역 테이블에 환불 내역 추가
		adminReserveDAO.insertRefundTransaction(accountId, "REFUND", refundMoney, customerId);

	    // 4. 계좌 잔액 복원
		adminReserveDAO.updateRefundBalance(refundMoney);
		
		// 5. 예약 취소하기
		adminReserveDAO.adminReserveDelete(customerId);
	}
	// -------------------------------------------------------------------------------------------------------------------------
	




	// 고객 첫번째 예약 화면 요청
	@Override
	public List<CustomerReserveFirstVO> customerReserveFirst() {
		return adminReserveDAO.customerReserveFirst();
	}



	// 좌석 테이블 모두 조회
	@Override
	public List<RestaurantSeatVO> getAllSeats() {
		
		return adminReserveDAO.getAllSeats();
	}
	
	// 모든 예약한 테이블 조회
	@Override
	public List<Integer> getReservedSeats(Integer reserveId) {
		return adminReserveDAO.getReservedSeats(reserveId);
	}


	// 결제하고 결제정보 저장
	@Override
	@Transactional
	public void reserveAndPay(int seatId, int reserveId, int totalPrice, Integer memberId) {
		int accountId = 1;
		
	    // 중복 결제 방지
	    int existing = adminReserveDAO.countReservation(reserveId, seatId);
	    if (existing > 0) {
	        throw new IllegalStateException("이미 결제된 예약입니다.");
	    }
		
		// 1. 잔액 확인 및 추가
		Integer currentBalance = adminReserveDAO.getBalance(accountId);
		//logger.info("현재 잔액: " + currentBalance + ", 결제 금액: " + totalPrice);
		
		/*
		 * 환불 기능 추가시
		 * if (currentBalance < totalPrice) { throw new
		 * IllegalArgumentException("잔액 부족"); }
		 */
		adminReserveDAO.updateBalance(accountId, totalPrice);
		
		// 2. 예약 정보 저장
		adminReserveDAO.insertCustomerReservation(reserveId, seatId, memberId);
		
		// 3. 거래 아이디 조회
		int customerId = adminReserveDAO.getCustomerId(reserveId, seatId, memberId);
		
		// 4. 거래 내역 저장
		adminReserveDAO.insertTransaction(accountId, "DEPOSIT", totalPrice, customerId);
		
		
		
	}

	// 아이디로 좌석 조회
	@Override
	public SeatVO getSeatById(int seatId) {
		return adminReserveDAO.getSeatById(seatId);
	}

	// 아이디로 해당 예약 조회
	@Override
	public AdminReservationVO getAdminReservationById(int reserveId) {
		return adminReserveDAO.getAdminReservationById(reserveId);
	}



	// 결제 정보 조회
	@Override
	public CustomerGetReserveInfoVO selectPayInfo(Integer memberId, Integer reserveId, Integer seatId) {
		return adminReserveDAO.selectPayInfo(memberId, reserveId, seatId);
	}
	
}
