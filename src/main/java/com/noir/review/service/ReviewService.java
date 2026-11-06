package com.noir.review.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.noir.review.vo.ReviewVO;

public interface ReviewService {

	//리뷰게시판 리스트 보기
	List<ReviewVO> getReviewsByPaging(int offset, int limit) throws Exception;
	int getReviewCount() throws Exception;
	//리뷰게시판 상세페이지 보기
	ReviewVO getReviewById(int reviewId) throws Exception;
	//리뷰게시판 글쓰기
	void addReviewWithImages(ReviewVO review) throws Exception;
	//리뷰게시판 수정(업데이트)
	void updateReviewWithImages(ReviewVO review) throws Exception;
	//리뷰게시판 삭제하기
	void deleteReview(int reviewId, String uploadDir) throws Exception;
}
