package com.noir.mypage.vo;

import java.sql.Timestamp;

public class NotificationVO {
    private int notificationId;   // 알림 고유 ID (PK)
    private int customerId;       // 예약 ID (CUSTOMER_RESERVATION 참조)
    private String reserveDate;     // 예약 날짜
    private String timeSlot;      // 시간대 (예: "12:00 ~ 13:00")
    private String message;       // 알림 메시지
    private int isRead;           // 읽음 여부 (0: 안읽음, 1: 읽음)
    private Timestamp createdAt;  // 알림 생성 시간
	private int seatId;
    
    public NotificationVO() {
	}

	public NotificationVO(int notificationId, int customerId, String reserveDate, String timeSlot, String message,
			int isRead, Timestamp createdAt, int seatId) {
		this.notificationId = notificationId;
		this.customerId = customerId;
		this.reserveDate = reserveDate;
		this.timeSlot = timeSlot;
		this.message = message;
		this.isRead = isRead;
		this.createdAt = createdAt;
		this.seatId = seatId;
	}



	public int getSeatId() {
		return seatId;
	}

	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	public int getNotificationId() {
		return notificationId;
	}


	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}


	public int getCustomerId() {
		return customerId;
	}


	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}


	public String getReserveDate() {
		return reserveDate;
	}


	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}


	public String getTimeSlot() {
		return timeSlot;
	}


	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public int getIsRead() {
		return isRead;
	}


	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}


	public Timestamp getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
