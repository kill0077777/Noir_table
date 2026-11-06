package com.noir.member.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class KakaoProfile {

    private Long id;
    private String connected_at;
    private Properties properties;
    private KakaoAccount kakao_account;

    // ----- 내부 클래스: properties -----
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Properties {
        private String nickname;
        private String profile_image;
        private String thumbnail_image;

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getProfile_image() {
            return profile_image;
        }

        public void setProfile_image(String profile_image) {
            this.profile_image = profile_image;
        }

        public String getThumbnail_image() {
            return thumbnail_image;
        }

        public void setThumbnail_image(String thumbnail_image) {
            this.thumbnail_image = thumbnail_image;
        }
    }

    // ----- 내부 클래스: kakao_account -----
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class KakaoAccount {
        private Boolean has_email;
        private Boolean has_phone_number;
        private String email;
        private String phone_number;
        private Profile profile;

        public Boolean getHas_email() {
            return has_email;
        }

        public void setHas_email(Boolean has_email) {
            this.has_email = has_email;
        }

        public Boolean getHas_phone_number() {
            return has_phone_number;
        }

        public void setHas_phone_number(Boolean has_phone_number) {
            this.has_phone_number = has_phone_number;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone_number() {
            return phone_number;
        }

        public void setPhone_number(String phone_number) {
            this.phone_number = phone_number;
        }

        public Profile getProfile() {
            return profile;
        }

        public void setProfile(Profile profile) {
            this.profile = profile;
        }
    }

    // ----- 내부 클래스: profile (kakao_account 내부) -----
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Profile {
        private String nickname;
        private String thumbnail_image_url;
        private String profile_image_url;
        private Boolean is_default_image;
        private Boolean is_default_nickname;

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getThumbnail_image_url() {
            return thumbnail_image_url;
        }

        public void setThumbnail_image_url(String thumbnail_image_url) {
            this.thumbnail_image_url = thumbnail_image_url;
        }

        public String getProfile_image_url() {
            return profile_image_url;
        }

        public void setProfile_image_url(String profile_image_url) {
            this.profile_image_url = profile_image_url;
        }

        public Boolean getIs_default_image() {
            return is_default_image;
        }

        public void setIs_default_image(Boolean is_default_image) {
            this.is_default_image = is_default_image;
        }

        public Boolean getIs_default_nickname() {
            return is_default_nickname;
        }

        public void setIs_default_nickname(Boolean is_default_nickname) {
            this.is_default_nickname = is_default_nickname;
        }
    }

    // ----- KakaoProfile getter/setter -----
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getConnected_at() {
        return connected_at;
    }

    public void setConnected_at(String connected_at) {
        this.connected_at = connected_at;
    }

    public Properties getProperties() {
        return properties;
    }

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public KakaoAccount getKakao_account() {
        return kakao_account;
    }

    public void setKakao_account(KakaoAccount kakao_account) {
        this.kakao_account = kakao_account;
    }
}


