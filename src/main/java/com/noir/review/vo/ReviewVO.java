package com.noir.review.vo;

import java.sql.Date;
import java.util.List;

public class ReviewVO {

	private int reviewId;
	private String title;
	private String content;
	private int rating;
	private int customer_id; //고객 예약 ID
	private String photoUrls; // 멀티 이미지 지원
	
	private String userName;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getPhotoUrls()
	{ 
		return photoUrls;
	}
    public void setPhotoUrls(String photoUrls)
    {
    	this.photoUrls = photoUrls;
    }

}
