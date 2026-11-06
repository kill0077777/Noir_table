package com.noir.reservation.vo;

public class AdminCheckSeatVO {
    private int customerId;
    private int memberId;
    private int seatId;
    
	public AdminCheckSeatVO() {
	}

	
	public AdminCheckSeatVO(int customerId, int memberId, int seatId) {
		this.customerId = customerId;
		this.memberId = memberId;
		this.seatId = seatId;
	}


	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public int getSeatId() {
		return seatId;
	}
	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	@Override
	public String toString() {
		return "AdminCheckSeatVO [customerId=" + customerId + ", seatId=" + seatId + "]";
	}
    
    
}
