package com.noir.review.vo;

public class ReviewCustomerVO {
	
	private int customer_id;
	private int member_id;
	private int seat_id;
	private int reserve_id;
	private String status;
	
	private ReviewAdminVO reviewAdminVO;
	
	public ReviewAdminVO getReviewAdminVO() {
		return reviewAdminVO;
	}
	public void setReviewAdminVO(ReviewAdminVO reviewAdminVO) {
		this.reviewAdminVO = reviewAdminVO;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public int getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}
	public int getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
