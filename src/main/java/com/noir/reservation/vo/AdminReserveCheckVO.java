package com.noir.reservation.vo;

import java.util.List;

public class AdminReserveCheckVO {
    private String date;
    private String time;
    private List<AdminCheckSeatVO> reservedList;
    
    
	public AdminReserveCheckVO() {
	}
	
	public AdminReserveCheckVO(String date, String time, List<AdminCheckSeatVO> reservedList) {
		this.date = date;
		this.time = time;
		this.reservedList = reservedList;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public List<AdminCheckSeatVO> getReservedList() {
		return reservedList;
	}
	public void setReservedList(List<AdminCheckSeatVO> reservedList) {
		this.reservedList = reservedList;
	}
    
    
}
