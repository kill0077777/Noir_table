package com.noir.reservation.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class CustomerGetReserveInfoVO {
    // 좌석 정보
    private int seatId;
    private String location;
    private int headCount;
    private int seatFloor;

    // 예약 정보
    private int reserveId;
    private String mealTime;
    private Date reserveDate;
    private String timeSlot;
    private Timestamp createdAt;
	
    public CustomerGetReserveInfoVO() {
	}

	public CustomerGetReserveInfoVO(int seatId, String location, int headCount, int seatFloor, int reserveId,
			String mealTime, Date reserveDate, String timeSlot, Timestamp createdAt) {
		super();
		this.seatId = seatId;
		this.location = location;
		this.headCount = headCount;
		this.seatFloor = seatFloor;
		this.reserveId = reserveId;
		this.mealTime = mealTime;
		this.reserveDate = reserveDate;
		this.timeSlot = timeSlot;
		this.createdAt = createdAt;
	}

	public int getSeatId() {
		return seatId;
	}

	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getHeadCount() {
		return headCount;
	}

	public void setHeadCount(int headCount) {
		this.headCount = headCount;
	}

	public int getSeatFloor() {
		return seatFloor;
	}

	public void setSeatFloor(int seatFloor) {
		this.seatFloor = seatFloor;
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

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
	    return "CustomerGetReserveInfoVO{" +
	            "reserveDate='" + reserveDate + '\'' +
	            ", timeSlot='" + timeSlot + '\'' +
	            ", mealTime='" + mealTime + '\'' +
	            ", floor='" + seatFloor + '\'' +
	            ", location='" + location + '\'' +
	            ", headCount=" + headCount +
	            '}';
	}
    
    
    
}
