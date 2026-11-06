package com.noir.reservation.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.reservation.vo.AdminCheckSeatVO;
import com.noir.reservation.vo.AdminReservationVO;
import com.noir.reservation.vo.AdminReserveAddVO;
import com.noir.reservation.vo.CustomerGetReserveInfoVO;
import com.noir.reservation.vo.CustomerReserveFirstVO;
import com.noir.reservation.vo.RestaurantSeatVO;
import com.noir.reservation.vo.SeatVO;


@Repository
public class AdminReserveDAOImpl implements AdminReserveDAO {
    @Autowired
    private SqlSession sqlSession;
    
	// 관리자 예약 등록하기
	@Override
	public void adminReserveAddDb(AdminReserveAddVO reserve) {
		sqlSession.insert("mappers.adminReserve.insertReserve", reserve);
	}
	
	@Override
	public List<AdminCheckSeatVO> getReservedIdByDate(String date, String time) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("date", date);
	    paramMap.put("time", time);
	    
		return sqlSession.selectList("mappers.adminReserve.getReservedIdByDate", paramMap);
	}
	
	@Override
	public void adminAddDeleteMessage(int customerId, String time, String date, int seatId, String content) {
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("customerId", customerId);
	    params.put("time", time);
	    params.put("date", date);
	    params.put("seatId", seatId);
	    params.put("content", content);

	    sqlSession.insert("mappers.adminReserve.adminAddDeleteMessage", params);
	}

	// 거래 금액 조회(환불용)
	@Override
	public int getRefundMoney(int customerId) {
		return sqlSession.selectOne("mappers.adminReserve.getRefundMoney", customerId);
	}
	
	// 거래 내역 추가(환불용)
	@Override
	public void insertRefundTransaction(int accountId, String refund, int refundMoney, int customerId) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("accountId", accountId);
	    paramMap.put("refund", refund);
	    paramMap.put("refundMoney", refundMoney);
	    paramMap.put("customerId", customerId);

	    sqlSession.insert("mappers.adminReserve.insertRefundTransaction", paramMap);
		
	}
	// 환불금액 차감
	@Override
	public void updateRefundBalance(int refundMoney) {
		sqlSession.update("mappers.adminReserve.updateBalance", refundMoney);
		
	}
	// 예약 취소하기
	@Override
	public void adminReserveDelete(int customerId) {
		sqlSession.delete("mappers.adminReserve.adminReserveDelete", customerId);
	}
	// ------------------------------------------------------------------------------------------------
	






	// 고객 예약 첫번째 화면 요청
	@Override
	public List<CustomerReserveFirstVO> customerReserveFirst() {
		return sqlSession.selectList("mappers.customerReserve.selectAllReservations");
	}

	// 좌석 테이블 모두 조회
	@Override
	public List<RestaurantSeatVO> getAllSeats() {
		return sqlSession.selectList("mappers.customerReserve.selectAllSeats");
	}
	
	// 예약한 좌석 테이블 번호 조회
	@Override
	public List<Integer> getReservedSeats(Integer reserveId) {
		return sqlSession.selectList("mappers.customerReserve.selectAllReservedSeats", reserveId);
	}

	// 잔액 확인
	@Override
	public int getBalance(int accountId) {
		//return sqlSession.selectOne("mappers.customerReserve.getBalance", accountId);
	    Integer balance = sqlSession.selectOne("mappers.customerReserve.getBalance", accountId);
	    if (balance == null) {
	        throw new IllegalArgumentException("해당 계좌의 잔액 정보를 찾을 수 없습니다. (accountId: " + accountId + ")");
	    }
	    return balance;
	}
	// 잔액 추가
	@Override
	public void updateBalance(int accountId, int amount) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("accountId", accountId);
	    paramMap.put("amount", amount);
	    
		sqlSession.update("mappers.customerReserve.updateBalance", paramMap);
	}
	// 거래 내역 저장
	@Override
	public void insertTransaction(int accountId, String type, int totalPrice, Integer customerId) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("accountId", accountId);
	    paramMap.put("type", type);
	    paramMap.put("totalPrice", totalPrice);
	    paramMap.put("customerId", customerId);
	    
		sqlSession.insert("mappers.customerReserve.insertTransaction", paramMap);
	}
	// 예약 정보 저장
	@Override
	public void insertCustomerReservation(int reserveId, int seatId, Integer memberId) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("reserveId", reserveId);
	    paramMap.put("seatId", seatId);
	    paramMap.put("memberId", memberId);
		
		sqlSession.insert("mappers.customerReserve.insertCustomerReservation", paramMap);
	}
	// 아이디로 해당 좌석 조회
	@Override
	public SeatVO getSeatById(int seatId) {
		return sqlSession.selectOne("mappers.customerReserve.selectSeatById", seatId);
	}

	// 아이디로 해당 예약 조회
	@Override
	public AdminReservationVO getAdminReservationById(int reserveId) {
		return sqlSession.selectOne("mappers.customerReserve.selectAdminReservationById", reserveId);
	}
	// 결제 아이디 조회
	@Override
	public int getCustomerId(int reserveId, int seatId, Integer memberId) {
		Map<String, Integer> paramMap = new HashMap<String, Integer>();
		paramMap.put("reserveId", reserveId);
		paramMap.put("seatId", seatId);
		paramMap.put("memberId", memberId);
	    return sqlSession.selectOne("mappers.customerReserve.getCustomerId", paramMap);
	}

	// 중복 결제 방지
	@Override
	public int countReservation(int reserveId, int seatId) {
		Map<String, Integer> paramMap = new HashMap<String, Integer>();
		paramMap.put("reserveId", reserveId);
		paramMap.put("seatId", seatId);
		return sqlSession.selectOne("mappers.customerReserve.countReservation", paramMap);
	}
	
	// 결제 정보 조회
	@Override
	public CustomerGetReserveInfoVO selectPayInfo(Integer memberId, Integer reserveId, Integer seatId) {
		Map<String, Integer> paramMap = new HashMap<String, Integer>();
		paramMap.put("memberId", memberId);
		paramMap.put("reserveId", reserveId);
		paramMap.put("seatId", seatId);
		
		return sqlSession.selectOne("mappers.customerReserve.selectPayInfo", paramMap);
	}
	
	
	
}