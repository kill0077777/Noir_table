package com.noir.reservation.service;

import java.util.List;
import java.util.Map;

import com.noir.reservation.vo.AdminCheckSeatVO;
import com.noir.reservation.vo.AdminReservationVO;
import com.noir.reservation.vo.AdminReserveAddVO;
import com.noir.reservation.vo.CustomerGetReserveInfoVO;
import com.noir.reservation.vo.CustomerReserveFirstVO;
import com.noir.reservation.vo.RestaurantSeatVO;
import com.noir.reservation.vo.SeatVO;


public interface AdminReserveService {
	// 관리자 예약 등록하기
	void adminReserveAddDb(AdminReserveAddVO reserve);
	
	// 관리자가 예약 조회시 사용(예약된 좌석 확인) => 날짜와 시간으로 예약된 좌석 아이디 조회 
	List<AdminCheckSeatVO> getReservedIdByDate(String date, String time);
	
	// 관리자가 예약 취소
	void adminReserveDelete(int seatId, int customerId, int memberId, String content, String time, String date);
	// ---------------------------------------------------------------------------------------------------------------
	
	// 고객 예약 첫번째 화면 요청
	List<CustomerReserveFirstVO> customerReserveFirst();

	// 모든 좌석 테이블 정보 조회
	List<RestaurantSeatVO> getAllSeats();
	
	// 모든 예약한 테이블 번호 조회
	List<Integer> getReservedSeats(Integer reserveId);
	
	// 결제하고 결제정보 저장
	void reserveAndPay(int seatId, int reserveId, int totalPrice, Integer memberId);

	// 아이디로 해당 좌석 조회
	SeatVO getSeatById(int seatId);
	
	// 아이디로 해당 예약 조회
	AdminReservationVO getAdminReservationById(int reserveId);

	// 결제 정보 조회
	CustomerGetReserveInfoVO selectPayInfo(Integer memberId, Integer reserveId, Integer seatId);



	

	
	

}
