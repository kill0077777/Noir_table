package com.noir.reservation.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class AdminReservationVO {
    private int reserveId;        // 예약 ID
    private String mealTime;      // 식사 시간 (예: lunch, dinner)
    private Date reserveDate;     // 예약 날짜
    private String timeSlot;      // 시간대 (예: 12:00 ~ 13:00)
    private int floor;            // 층수 (1 or 2)
    private Timestamp createdAt;  // 생성일시
	
    public AdminReservationVO() {
	}
	
    public AdminReservationVO(int reserveId, String mealTime, Date reserveDate, String timeSlot, int floor,
			Timestamp createdAt) {
		this.reserveId = reserveId;
		this.mealTime = mealTime;
		this.reserveDate = reserveDate;
		this.timeSlot = timeSlot;
		this.floor = floor;
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
	public Date getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
