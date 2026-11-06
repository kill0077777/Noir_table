package com.noir.member.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class NaverProfile {
    private String resultcode;
    private String message;
    private Response response;

    // 내부 클래스
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Response {
        private String id;
        private String nickname;
        private String profile_image;
        private String email;
        private String mobile;
        private String mobile_e164;
        private String name;

        // Getter/Setter
        public String getId() { return id; }
        public void setId(String id) { this.id = id; }

        public String getNickname() { return nickname; }
        public void setNickname(String nickname) { this.nickname = nickname; }

        public String getProfile_image() { return profile_image; }
        public void setProfile_image(String profile_image) { this.profile_image = profile_image; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getMobile() { return mobile; }
        public void setMobile(String mobile) { this.mobile = mobile; }

        public String getMobile_e164() { return mobile_e164; }
        public void setMobile_e164(String mobile_e164) { this.mobile_e164 = mobile_e164; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
    }

    // Getter/Setter
    public String getResultcode() { return resultcode; }
    public void setResultcode(String resultcode) { this.resultcode = resultcode; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Response getResponse() { return response; }
    public void setResponse(Response response) { this.response = response; }
}

