package com.noir.review.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noir.member.vo.MemberVO;
import com.noir.review.dao.ReviewDAOImpl;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAOImpl reviewDAO;
	
	@Override
	public List<ReviewVO> getReviewsByPaging(int offset, int limit) throws Exception {
		return reviewDAO.selectReviewsByPaging(offset, limit);
	}

	@Override
	public int getReviewCount() throws Exception {
		return reviewDAO.selectReviewCount();
	}

	//리뷰게시판 상세페이지 보기
	@Override
	public ReviewVO getReviewById(int reviewId) throws Exception {
		
		ReviewVO review = reviewDAO.selectReviewById(reviewId);
		
		return review;
	}

	@Override
	public void addReviewWithImages(ReviewVO review) throws Exception {
		
		reviewDAO.insertReview(review);
	}
	
	//
	@Override
	public void updateReviewWithImages(ReviewVO review) throws Exception {
		reviewDAO.updateReview(review);
	}

	//리뷰게시판 삭제하기
	@Override
	public void deleteReview(int reviewId, String uploadDir) throws Exception {
		
		reviewDAO.deleteReview(reviewId);
	}

	
	//고객 리뷰 남길수 있는 목록 불러오기
	public List<ReviewCustomerVO> getCustomerReservation(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		int member_id = member.getId();
		
		List<ReviewCustomerVO> list = reviewDAO.findReserveByMemberId(member_id);
		
		return list;
				
	}
	
	//고객 리뷰 남길수 있는 목록 불러오기
	public List<ReviewCustomerVO> getCustomerReservation2(HttpServletRequest request) {
		

		List<ReviewCustomerVO> list = reviewDAO.findReserve();
		
		return list;
		
	}
	
	
	public ReviewCustomerVO getReserveByCustomId(int customer_id) {
		
		return reviewDAO.getReserveByCustomId(customer_id);
	}

	public List<ReviewVO> myReviewList(HttpServletRequest req,int offset,int pageSize) {
		
		HttpSession session = req.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		int member_id = member.getId();
		
		List<ReviewVO> myReviewList = reviewDAO.myReviewList(member_id,offset,pageSize);
		
		
		
		return myReviewList;
	}

	public int getMyReviewCount(HttpServletRequest req) {
		
		return reviewDAO.getMyReviewCount(req);
	}

}