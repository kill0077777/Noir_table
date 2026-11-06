package com.noir.reservation.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class CustomerReserveFirstVO {
	private int reserve_Id;                // 예약 ID (PK, 자동 증가)
	private String meal_Time;              // 식사 시간 ('lunch' 또는 'dinner')
	private java.sql.Date reserve_Date;    // 예약 날짜 (yyyy-MM-dd)
	private String time_Slot;              // 예약 시간대 (예: "12:00 ~ 13:00")
	private int floor;                     // 예약 층수 (1 또는 2)
	private java.sql.Timestamp created_At; // 생성 시각 (자동 기록)

    public CustomerReserveFirstVO() {	}

	public CustomerReserveFirstVO(int reserve_Id, String meal_Time, Date reserve_Date, String time_Slot, int floor,
			Timestamp created_At) {
		super();
		this.reserve_Id = reserve_Id;
		this.meal_Time = meal_Time;
		this.reserve_Date = reserve_Date;
		this.time_Slot = time_Slot;
		this.floor = floor;
		this.created_At = created_At;
	}

	public int getReserve_Id() {
		return reserve_Id;
	}

	public void setReserve_Id(int reserve_Id) {
		this.reserve_Id = reserve_Id;
	}

	public String getMeal_Time() {
		return meal_Time;
	}

	public void setMeal_Time(String meal_Time) {
		this.meal_Time = meal_Time;
	}

	public java.sql.Date getReserve_Date() {
		return reserve_Date;
	}

	public void setReserve_Date(java.sql.Date reserve_Date) {
		this.reserve_Date = reserve_Date;
	}

	public String getTime_Slot() {
		return time_Slot;
	}

	public void setTime_Slot(String time_Slot) {
		this.time_Slot = time_Slot;
	}

	public int getFloor() {
		return floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}

	public java.sql.Timestamp getCreated_At() {
		return created_At;
	}

	public void setCreated_At(java.sql.Timestamp created_At) {
		this.created_At = created_At;
	}

}
