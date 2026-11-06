package com.noir.member.vo;

import java.sql.Date;

public class MemberProfileVO {
	
	private int profile_id;
	private int member_id;
	private String grade;
	private int total_spent;
	private int visit_count;
	private Date last_visit;
	public int getProfile_id() {
		return profile_id;
	}
	public void setProfile_id(int profile_id) {
		this.profile_id = profile_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getTotal_spent() {
		return total_spent;
	}
	public void setTotal_spent(int total_spent) {
		this.total_spent = total_spent;
	}
	public int getVisit_count() {
		return visit_count;
	}
	public void setVisit_count(int visit_count) {
		this.visit_count = visit_count;
	}
	public Date getLast_visit() {
		return last_visit;
	}
	public void setLast_visit(Date last_visit) {
		this.last_visit = last_visit;
	}
	
}
