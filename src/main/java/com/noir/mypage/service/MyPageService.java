package com.noir.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noir.mypage.dao.MyPageDao;
import com.noir.mypage.vo.CustomerReservationVO;
import com.noir.mypage.vo.NoirMemberVO;
import com.noir.mypage.vo.NotificationVO;
import com.noir.reservation.vo.AdminCheckSeatVO;

@Service
public class MyPageService {
	
	@Autowired
	MyPageDao myPageDao;
	
	public List<AdminCheckSeatVO> getReservedIdByDate(String date, String time) {
		return myPageDao.getReservedIdByDate(date, time);
	}
	
	// 관리자가 예약 취소
	@Transactional
	public void adminReserveDelete(int seatId, int customerId, int memberId, String content, String time, String date) {
		int accountId = 1;
		
		// 1. 알림 테이블에 저장하기(예약취소사유)
		myPageDao.adminAddDeleteMessage(customerId, time, date, seatId , content);

		// 2. 환불 금액 조회
		int refundMoney = myPageDao.getRefundMoney(customerId);
				
	    // 3. 거래 내역 테이블에 환불 내역 추가
		myPageDao.insertRefundTransaction(accountId, "REFUND", refundMoney, customerId);

	    // 4. 계좌 잔액 복원
		myPageDao.updateRefundBalance(refundMoney);
		
		// 5. 예약 취소하기
		myPageDao.adminReserveDelete(customerId);
	}
	
	// ----------------------------------------------------------------------------------------------------
	//                                                  고객
	// ----------------------------------------------------------------------------------------------------
	
	// 내 예약 보기
	public List<CustomerReservationVO> getReserveCustomer(Integer memberId) {
		return myPageDao.getReserveCustomer(memberId);
	}
	// 회원 정보 조회
	public NoirMemberVO getMemberInfo(Integer memberId) {
		return myPageDao.getMemberInfo(memberId);
	}

	public void updateMemberInfo(NoirMemberVO noirMemberVO) {
		myPageDao.updateMemberInfo(noirMemberVO);
		
	}
	// 알림 조회
	public List<NotificationVO> getNotification(Integer memberId) {
		return myPageDao.getNotification(memberId);
	}
	// 알림 읽음처리
	public void updateNotificationRead(Integer memberId) {
		myPageDao.updateNotificationRead(memberId);
	}
}
