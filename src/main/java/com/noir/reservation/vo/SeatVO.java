package com.noir.reservation.vo;

public class SeatVO {
    private int seatId;         // 좌석 고유 ID
    private String location;    // 위치 (예: 창가자리, 중앙, 구석자리 등)
    private int headCount;      // 수용 인원수
    private int floor;          // 층 (1층 또는 2층)

    public SeatVO() {
	}

	public SeatVO(int seatId, String location, int headCount, int floor) {
		this.seatId = seatId;
		this.location = location;
		this.headCount = headCount;
		this.floor = floor;
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

	public int getFloor() {
		return floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}

	
}
