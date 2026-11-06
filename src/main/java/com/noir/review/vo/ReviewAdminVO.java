package com.noir.review.vo;

import java.sql.Date;

public class ReviewAdminVO {
	
	private int reserve_id;
	private String meal_time;
	private Date reserve_date;
	private String time_slot;
	private Date created_at;
	
	public int getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}
	public String getMeal_time() {
		return meal_time;
	}
	public void setMeal_time(String meal_time) {
		this.meal_time = meal_time;
	}
	public Date getReserve_date() {
		return reserve_date;
	}
	public void setReserve_date(Date reserve_date) {
		this.reserve_date = reserve_date;
	}
	public String getTime_slot() {
		return time_slot;
	}
	public void setTime_slot(String time_slot) {
		this.time_slot = time_slot;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	
	
}
