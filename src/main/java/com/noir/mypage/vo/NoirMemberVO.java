package com.noir.mypage.vo;

public class NoirMemberVO {
    private int memberId;             // 회원 고유 ID
    private String loginId;           // 로그인 아이디
    private String password;          // 비밀번호
    private String name;              // 고객 이름
    private String phone;             // 전화번호
    private String role;              // 역할: ADMIN / USER
    private String socialType;        // 소셜 로그인 종류 (예: KAKAO)
    private String snsId;             // 소셜 서비스 고유 ID
    private String profileImage;      // 프로필 이미지 URL
	
    public NoirMemberVO() {
	}

	public NoirMemberVO(int memberId, String loginId, String password, String name, String phone, String role,
			String socialType, String snsId, String profileImage) {
		this.memberId = memberId;
		this.loginId = loginId;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.role = role;
		this.socialType = socialType;
		this.snsId = snsId;
		this.profileImage = profileImage;
	}

	public int getMemberId() {
		return memberId;
	}


	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}


	public String getLoginId() {
		return loginId;
	}


	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public String getSocialType() {
		return socialType;
	}


	public void setSocialType(String socialType) {
		this.socialType = socialType;
	}


	public String getSnsId() {
		return snsId;
	}


	public void setSnsId(String snsId) {
		this.snsId = snsId;
	}


	public String getProfileImage() {
		return profileImage;
	}


	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

    
}
