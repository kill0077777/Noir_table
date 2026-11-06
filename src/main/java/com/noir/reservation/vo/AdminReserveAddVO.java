package com.noir.reservation.vo;

import java.sql.Timestamp;


public class AdminReserveAddVO {
    private int reserveId;            // 예약 ID (PK)
    private String mealTime;          // 런치/디너
    private String reserveDate;       // 예약 날짜 (yyyy-MM-dd)
    private String timeSlot;          // 시간대 예: 12:00 ~ 13:00
    private Timestamp createdAt;      // 등록 시간
    
    public AdminReserveAddVO() {
	}

	public AdminReserveAddVO(int reserveId, String mealTime, String reserveDate, String timeSlot,
			Timestamp createdAt) {
		this.reserveId = reserveId;
		this.mealTime = mealTime;
		this.reserveDate = reserveDate;
		this.timeSlot = timeSlot;
		this.createdAt = createdAt;
	}

	public int getReserveId() {
		return reserveId;
	}

	public void setReserveId(int reserveId) {
		this.reserveId = reserveId;
	}

	public String getMealTime() {
		return mealTime;
	}

	public void setMealTime(String mealTime) {
		this.mealTime = mealTime;
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

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
