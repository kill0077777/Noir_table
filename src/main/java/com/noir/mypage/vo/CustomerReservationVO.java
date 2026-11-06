package com.noir.mypage.vo;

import java.sql.Date;

public class CustomerReservationVO {
    private int customerId;       // cr.CUSTOMER_ID
    private String memberName;    // m.name
    private int seatId;           // s.SEAT_ID
    private String location;      // s.LOCATION
    private int headCount;        // s.HEAD_COUNT
    private Date reserveDate;     // ar.RESERVE_DATE
    private String timeSlot;      // ar.TIME_SLOT
    private String status;        // cr.STATUS
    
	public CustomerReservationVO() {
	}

	public CustomerReservationVO(int customerId, String memberName, int seatId, String location, int headCount,
			Date reserveDate, String timeSlot, String status) {
		this.customerId = customerId;
		this.memberName = memberName;
		this.seatId = seatId;
		this.location = location;
		this.headCount = headCount;
		this.reserveDate = reserveDate;
		this.timeSlot = timeSlot;
		this.status = status;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
    
    
    
}
