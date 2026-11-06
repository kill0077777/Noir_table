package com.noir.review.dao;

import java.util.List;

import com.noir.review.vo.ReviewVO;

public interface ReviewDAO {

	//리뷰게시판 리스트 보기
	List<ReviewVO> selectReviewsByPaging(int offset, int limit) throws Exception;
	int selectReviewCount() throws Exception;

	//리뷰게시판 상세페이지 보기
	ReviewVO selectReviewById(int reviewId) throws Exception;

	//리뷰게시판 글쓰기
	void insertReview(ReviewVO review) throws Exception;

	//리뷰게시판 업데이트(수정)
	void updateReview(ReviewVO review) throws Exception;

	//리뷰게시판 삭제하기
	void deleteReview(int reviewId) throws Exception;

	// 이미지 관련
	List<String> selectReviewPhotos(Long reviewId) throws Exception;
	//리뷰게시판 포토 삽입
	void insertReviewPhoto(int reviewId, String photoUrl) throws Exception;
	//리뷰게시판 포토 삭제
	void deleteReviewPhotos(int reviewId) throws Exception;
	
}