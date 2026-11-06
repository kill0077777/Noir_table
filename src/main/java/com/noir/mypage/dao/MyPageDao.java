package com.noir.mypage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.mypage.vo.CustomerReservationVO;
import com.noir.mypage.vo.NoirMemberVO;
import com.noir.mypage.vo.NotificationVO;
import com.noir.reservation.vo.AdminCheckSeatVO;

@Repository
public class MyPageDao {
    
	@Autowired
    private SqlSession sqlSession;
    
	public List<AdminCheckSeatVO> getReservedIdByDate(String date, String time) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("date", date);
	    paramMap.put("time", time);
	    
		return sqlSession.selectList("mappers.adminReserve.getReservedIdByDate", paramMap);
	}
	
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
	public int getRefundMoney(int customerId) {
		return sqlSession.selectOne("mappers.adminReserve.getRefundMoney", customerId);
	}
	
	// 거래 내역 추가(환불용)
	public void insertRefundTransaction(int accountId, String refund, int refundMoney, int customerId) {
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("accountId", accountId);
	    paramMap.put("refund", refund);
	    paramMap.put("refundMoney", refundMoney);
	    paramMap.put("customerId", customerId);

	    sqlSession.insert("mappers.adminReserve.insertRefundTransaction", paramMap);
		
	}
	// 환불금액 차감
	public void updateRefundBalance(int refundMoney) {
		sqlSession.update("mappers.adminReserve.updateBalance", refundMoney);
		
	}
	// 예약 취소하기
	public void adminReserveDelete(int customerId) {
		sqlSession.delete("mappers.adminReserve.adminReserveDelete", customerId);
	}
	
	// ----------------------------------------------------------------------------------------------------
	//                                                  고객
	// ----------------------------------------------------------------------------------------------------
	
	// 내 예약 보기
	public List<CustomerReservationVO> getReserveCustomer(Integer memberId) {
		return sqlSession.selectList("mappers.myPage.getReserveCustomer", memberId);
	}
	// 회원 정보 조회
	public NoirMemberVO getMemberInfo(Integer memberId) {
		return sqlSession.selectOne("mappers.myPage.getMemberInfo", memberId);
	}
	// 회원 정보 수정
	public void updateMemberInfo(NoirMemberVO noirMemberVO) {
		sqlSession.update("mappers.myPage.updateMemberInfo", noirMemberVO);
	}
	// 알림 조회
	public List<NotificationVO> getNotification(Integer memberId) {
		return sqlSession.selectList("mappers.myPage.getNotification", memberId);
	}

	public void updateNotificationRead(Integer memberId) {
		sqlSession.update("mappers.myPage.updateNotificationRead", memberId);
	}
}
