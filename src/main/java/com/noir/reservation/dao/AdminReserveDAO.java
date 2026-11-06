package com.noir.reservation.dao;

import java.util.List;
import java.util.Map;

import com.noir.reservation.vo.AdminCheckSeatVO;
import com.noir.reservation.vo.AdminReservationVO;
import com.noir.reservation.vo.AdminReserveAddVO;
import com.noir.reservation.vo.CustomerGetReserveInfoVO;
import com.noir.reservation.vo.CustomerReserveFirstVO;
import com.noir.reservation.vo.RestaurantSeatVO;
import com.noir.reservation.vo.SeatVO;



public interface AdminReserveDAO {
	// 관리자 예약 등록하기
	void adminReserveAddDb(AdminReserveAddVO reserve);
	
	// 관리자가 예약 조회시 사용(예약된 좌석 확인) => 날짜와 시간으로 예약된 좌석 아이디 조회 
	List<AdminCheckSeatVO> getReservedIdByDate(String date, String time);
	
	// 알림 테이블에 추가(삭제 사유)
	void adminAddDeleteMessage(int customerId, String time, String date, int seatId, String content);
	
	// 예약 취소
	void adminReserveDelete(int customerId);
	
	// 거래 금액 조회(환불용)
	int getRefundMoney(int customerId);
	
	// 거래 내역 추가(환불용)
	void insertRefundTransaction(int accountId, String refund, int refundMoney, int customerId);
	
	// 환불금액 차감
	void updateRefundBalance(int refundMoney);
	
	// ------------------------------------------------------------------------------
	// 고객 예약 첫번째 화면
	List<CustomerReserveFirstVO> customerReserveFirst();
	
	// 좌석 테이블 모두 조회
	List<RestaurantSeatVO> getAllSeats();
	
	// 모든 예약한 테이블 번호 조회
	List<Integer> getReservedSeats(Integer reserveId);
	
	// 예약 정보 저장
	void insertCustomerReservation(int reserveId, int seatId , Integer memberId);
	
	// 잔액 확인
	int getBalance(int accountId);

	// 잔액 차감
	void updateBalance(int accountId, int i);
	
	// 거래 내역 저장
	void insertTransaction(int accountId, String string, int totalPrice, Integer customerId);
	
	// 아이디로 해당 좌석 조회
	SeatVO getSeatById(int seatId);

	// 아이디로 해당 에약 조회
	AdminReservationVO getAdminReservationById(int reserveId);
	
	// 중복 결제 방지
	int countReservation(int reserveId, int seatId);
	
	// 결제 정보 조회
	CustomerGetReserveInfoVO selectPayInfo(Integer memberId, Integer reserveId, Integer seatId);

	// 결제 아이디 조회
	int getCustomerId(int reserveId, int seatId, Integer memberId);

	
	

	
	


	

	

	

	

}
