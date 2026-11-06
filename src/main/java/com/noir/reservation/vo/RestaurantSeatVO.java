package com.noir.reservation.vo;

// 좌석 테이블
public class RestaurantSeatVO {
    private int seat_Id;       // 좌석 고유 ID (PK)
    private String location;  // 위치 (ex: '창가', '중앙')
    private int head_Count;    // 수용 인원수
    private int floor;        // 층수 (1층 or 2층)
	
    public RestaurantSeatVO() {
	}

	public RestaurantSeatVO(int seat_Id, String location, int head_Count, int floor) {
		this.seat_Id = seat_Id;
		this.location = location;
		this.head_Count = head_Count;
		this.floor = floor;
	}

	public int getSeat_Id() {
		return seat_Id;
	}

	public void setSeat_Id(int seat_Id) {
		this.seat_Id = seat_Id;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getHead_Count() {
		return head_Count;
	}

	public void setHead_Count(int head_Count) {
		this.head_Count = head_Count;
	}

	public int getFloor() {
		return floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}
    
}
