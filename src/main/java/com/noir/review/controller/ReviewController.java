package com.noir.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.noir.member.vo.MemberVO;
import com.noir.review.service.ReviewServiceImpl;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Controller
@RequestMapping("/review/*")
public class ReviewController {

	@Autowired
	private ReviewServiceImpl reviewService;
		
	//http://localhost:8090/noir/review.do
	//리뷰게시판 리스트 성공
	@RequestMapping(value="/list.do")
	public ModelAndView reviewList(HttpServletRequest request,
			 			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");

		int page = 1;
		int pageSize = 10;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int offset = (page - 1) * pageSize;

		List<ReviewVO> reviewList = reviewService.getReviewsByPaging(offset, pageSize);
		
		List<ReviewCustomerVO> reserveList= reviewService.getCustomerReservation2(request);
				
		int totalCount = reviewService.getReviewCount();
		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		int blockSize = 10;
		int startBlock = ((page - 1) / blockSize) * blockSize + 1;
		int endBlock = Math.min(startBlock + blockSize - 1, totalPage);

		mav.addObject("currentPage", page);
		mav.addObject("totalPage", totalPage);
		mav.addObject("startBlock", startBlock);
		mav.addObject("endBlock", endBlock);
		mav.addObject("currentPage", page);

		mav.addObject("reviewList", reviewList);
		mav.addObject("reserveList", reserveList);
		mav.setViewName(viewName);

		return mav;
	}

	// http://localhost:8090/noir/review/detail.do 
	// 상세페이지 보기 성공
	@RequestMapping(value="/detail.do")
	public ModelAndView reviewDetail(
						@RequestParam("reviewId") int reviewId,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		
		//${contextPath}/review/detail.do?reviewId=${review.reviewId}
		
		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");
		
		ReviewVO review = reviewService.getReviewById(reviewId);
	    
		ReviewCustomerVO reserve = reviewService.getReserveByCustomId(review.getCustomer_id());
		
		mav.addObject("review", review);
		mav.addObject("reserve",reserve);

		mav.setViewName(viewName);

		return mav;
	}

	//  http://localhost:8090/noir/review/wirte.do
	// 글쓰기 폼
	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public ModelAndView writeReviewForm(HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)request.getAttribute("viewName");
		
		//고객 아이디로 고객이 쓸 수 있는 예약 조회
		List<ReviewCustomerVO> reserveList = reviewService.getCustomerReservation(request);
		
		request.setAttribute("reserveList", reserveList);
		
		mav.setViewName(viewName);
		
		return mav;
	}
	
	//  http://localhost:8090/noir/review/wirte.do
	// 글쓰기 처리
	@RequestMapping(value="/write.do", method=RequestMethod.POST)
	public ModelAndView writeReview(
				@RequestParam("photoUrls") MultipartFile photoFile,
            	@RequestParam("customer_id") int customerId,
            	@RequestParam("title") String title,
            	@RequestParam("content") String content,
            	@RequestParam("rating") int rating,
				HttpServletRequest req,
				HttpServletResponse resp) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		ReviewVO review = new ReviewVO();
		
		review.setContent(content);
		review.setCustomer_id(customerId);

		review.setTitle(title);
		review.setRating(rating);
		
		if(photoFile != null && !photoFile.isEmpty()) {
			//업로드 폴더 경로 설정
			String uploadDir = "C:/upload/noir/review/";
			File dir = new File(uploadDir);
			if(!dir.exists()) dir.mkdirs();//경로 없으면 생성
			
			//실제 파일 이름과 저장용 UUID 이름 만들기
			String originalFileName = photoFile.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();
			String saveName = uuid+"_"+originalFileName;
			
			//저장
			File saveFile = new File(uploadDir + saveName);
			photoFile.transferTo(saveFile);
			review.setPhotoUrls(saveName);
		}

		reviewService.addReviewWithImages(review);
		
		mav.setViewName("redirect:/review/list.do");
		
		return mav;
		
	}

 
	// GET  http://localhost:8090/noir/review/edit.do
	// 수정 폼
	@RequestMapping(value="/edit.do", method=RequestMethod.GET)
	public ModelAndView editReviewForm(
						@RequestParam("reviewId") int reviewId,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");
		
		ReviewVO review = reviewService.getReviewById(reviewId);
	    
		ReviewCustomerVO reserve = reviewService.getReserveByCustomId(review.getCustomer_id());
		
		mav.addObject("review", review);
		mav.addObject("reserve",reserve);

		mav.setViewName(viewName);

		return mav;
	}

	// POST  http://localhost:8090/noir/review/edit.do
	// 수정 처리
	@RequestMapping(value="/update.do", method=RequestMethod.POST)
	public ModelAndView editReview( 
									@RequestParam("reviewId") int reviewId,
									@RequestParam("title") String title,
									@RequestParam("content") String content,
									@RequestParam("rating") int rating,
									@RequestParam("photoUrls") String photoUrls,
									@RequestParam("photoFiles") MultipartFile photoFile,
									HttpServletRequest request,
									HttpServletResponse response) throws Exception {
		
		ReviewVO review = new ReviewVO();
	    review.setReviewId(reviewId);
	    review.setTitle(title);
	    review.setRating(rating);
	    review.setContent(content);

	    String uploadDir = "C:/upload/noir/review/";

	    // 📌 새 파일이 있다면 기존 사진 삭제 + 새로 저장
	    if (photoFile != null && !photoFile.isEmpty()) {
	    	
	        // 1. 기존 이미지 삭제
	    	if (photoUrls != null && !photoUrls.trim().isEmpty()) {
	    	    File oldFile = new File(uploadDir, photoUrls.trim());
	    	    if (oldFile.exists()) {
	    	        boolean deleted = oldFile.delete();
	    	    } else {
	    	        System.out.println("⚠️ 파일 없음: " + photoUrls);
	    	    }
	    	}

	        // 2. 새 파일 저장
	        String originalFilename = photoFile.getOriginalFilename();
	        String newFilename = UUID.randomUUID() + "_" + originalFilename;
	        File saveFile = new File(uploadDir, newFilename);
	        try {
	            photoFile.transferTo(saveFile);
	            review.setPhotoUrls(newFilename); // 하나만 저장
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	    } else {
	        // 새 파일 없으면 기존 이미지 유지
	        review.setPhotoUrls(photoUrls);
	    }

	    // 3. DB 반영
	    reviewService.updateReviewWithImages(review);
		

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("redirect:/review/edit.do?reviewId="+reviewId);
		
	
		return mav;
		
	}

	// 리뷰게시판 상세페이지 및 이미지 폴더 같이 삭제 
	@RequestMapping(value="/delete.do", method=RequestMethod.POST)
	public ModelAndView deleteReview(
						@RequestParam("reviewId") int reviewId,
						@RequestParam("photoUrls") String photoUrls,
						HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		
	    String uploadDir = "C:/upload/noir/review/";
		
        // 1. 기존 이미지 삭제
    	if (photoUrls != null && !photoUrls.trim().isEmpty()) {
    	    File oldFile = new File(uploadDir, photoUrls.trim());
    	    if (oldFile.exists()) {
    	        boolean deleted = oldFile.delete();
    	    } else {
    	        System.out.println("⚠️ 파일 없음: " + photoUrls);
    	    }
    	}

		reviewService.deleteReview(reviewId, uploadDir);

		return new ModelAndView("redirect:/review/list.do");
	}
	
	@RequestMapping(value="/myreview.do")
	public ModelAndView myReview(
			HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int page = 1;
		int pageSize = 10;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		int offset = (page - 1) * pageSize;
		
		List<ReviewVO> myReviewList = reviewService.myReviewList(req,offset,pageSize);
		List<ReviewCustomerVO> reserveList= reviewService.getCustomerReservation2(req);
		
		int totalCount = reviewService.getMyReviewCount(req);
		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		int blockSize = 10;
		int startBlock = ((page - 1) / blockSize) * blockSize + 1;
		int endBlock = Math.min(startBlock + blockSize - 1, totalPage);
		
		mav.addObject("currentPage", page);
		mav.addObject("totalPage", totalPage);
		mav.addObject("startBlock", startBlock);
		mav.addObject("endBlock", endBlock);
		mav.addObject("currentPage", page);

		mav.addObject("reviewList", myReviewList);
		mav.addObject("reserveList", reserveList);
		
		String viewName = (String)req.getAttribute("viewName");

		mav.setViewName(viewName);
		
		return mav;
		
	}

}















