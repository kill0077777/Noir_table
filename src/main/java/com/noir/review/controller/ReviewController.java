package com.noir.review.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.noir.member.vo.MemberVO;
import com.noir.review.service.ReviewServiceImpl;
import com.noir.review.service.ReviewFileStorageService;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Controller
@RequestMapping("/review/*")
public class ReviewController {

    @Autowired
    private ReviewServiceImpl reviewService;

    @Autowired
    private ReviewFileStorageService fileStorage;

    @RequestMapping(value="/list.do")
    public ModelAndView reviewList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int page = parsePage(request.getParameter("page"));
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        List<ReviewVO> reviewList = reviewService.getReviewsByPaging(offset, pageSize);
        int totalCount = reviewService.getReviewCount();
        int totalPage = (int)Math.ceil((double)totalCount / pageSize);
        ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
        mav.addObject("currentPage", page);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startBlock", ((page - 1) / 10) * 10 + 1);
        mav.addObject("endBlock", Math.min(((page - 1) / 10 + 1) * 10, totalPage));
        mav.addObject("reviewList", reviewList);
        return mav;
    }

    @RequestMapping(value="/detail.do")
    public ModelAndView reviewDetail(@RequestParam("reviewId") int reviewId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReviewVO review = reviewService.getReviewById(reviewId);
        if (review == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }
        ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
        mav.addObject("review", review);
        mav.addObject("reserve", reviewService.getReserveByReserveId(review.getReserve_id()));
        return mav;
    }

    @RequestMapping(value="/write.do", method=RequestMethod.GET)
    public ModelAndView writeReviewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (requireMember(request, response) == null) return null;
        ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
        mav.addObject("reserveList", reviewService.getCustomerReservation(request));
        return mav;
    }

    @RequestMapping(value="/write.do", method=RequestMethod.POST)
    public ModelAndView writeReview(@RequestParam("photoUrls") MultipartFile photoFile,
            @RequestParam("reserve_id") int reserveId, @RequestParam("title") String title,
            @RequestParam("content") String content, @RequestParam("rating") int rating,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        MemberVO member = requireMember(request, response);
        if (member == null) return null;
        validateReview(title, content, rating);

        ReviewCustomerVO reservation = reviewService.getReserveByReserveId(reserveId);
        if (reservation == null || reservation.getMember_id() != member.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return null;
        }

        ReviewVO review = new ReviewVO();
        review.setContent(content.trim());
        review.setReserve_id(reserveId);
        review.setCustomer_id(reservation.getCustomer_id());
        review.setMember_id(member.getId());
        review.setTitle(title.trim());
        review.setRating(rating);
        String savedName = null;
        try {
            savedName = fileStorage.store(photoFile);
            review.setPhotoUrls(savedName);
            reviewService.addReviewWithImages(review);
        } catch (Exception e) {
            fileStorage.delete(savedName);
            throw e;
        }
        return new ModelAndView("redirect:/review/list.do");
    }

    @RequestMapping(value="/edit.do", method=RequestMethod.GET)
    public ModelAndView editReviewForm(@RequestParam("reviewId") int reviewId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        MemberVO member = requireMember(request, response);
        if (member == null) return null;
        ReviewVO review = reviewService.getReviewById(reviewId);
        if (review == null) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return null; }
        if (!ownsReview(review, member)) { response.sendError(HttpServletResponse.SC_FORBIDDEN); return null; }
        ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
        mav.addObject("review", review);
        mav.addObject("reserve", reviewService.getReserveByReserveId(review.getReserve_id()));
        return mav;
    }

    @RequestMapping(value="/update.do", method=RequestMethod.POST)
    public ModelAndView editReview(@RequestParam("reviewId") int reviewId,
            @RequestParam("title") String title, @RequestParam("content") String content,
            @RequestParam("rating") int rating, @RequestParam("photoFiles") MultipartFile photoFile,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        MemberVO member = requireMember(request, response);
        if (member == null) return null;
        validateReview(title, content, rating);
        ReviewVO existing = reviewService.getReviewById(reviewId);
        if (existing == null) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return null; }
        if (!ownsReview(existing, member)) { response.sendError(HttpServletResponse.SC_FORBIDDEN); return null; }

        ReviewVO review = new ReviewVO();
        review.setReviewId(reviewId);
        review.setMember_id(member.getId());
        review.setTitle(title.trim());
        review.setContent(content.trim());
        review.setRating(rating);
        String newName = null;
        try {
            if (photoFile != null && !photoFile.isEmpty()) {
                newName = fileStorage.store(photoFile);
                review.setPhotoUrls(newName);
            } else {
                review.setPhotoUrls(existing.getPhotoUrls());
            }
            reviewService.updateReviewWithImages(review);
            if (newName != null) fileStorage.delete(existing.getPhotoUrls());
        } catch (Exception e) {
            fileStorage.delete(newName);
            throw e;
        }
        return new ModelAndView("redirect:/review/detail.do?reviewId=" + reviewId);
    }

    @RequestMapping(value="/delete.do", method=RequestMethod.POST)
    public ModelAndView deleteReview(@RequestParam("reviewId") int reviewId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        MemberVO member = requireMember(request, response);
        if (member == null) return null;
        ReviewVO review = reviewService.getReviewById(reviewId);
        if (review == null) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return null; }
        if (!ownsReview(review, member)) { response.sendError(HttpServletResponse.SC_FORBIDDEN); return null; }
        reviewService.deleteReview(reviewId, member.getId(), "external");
        fileStorage.delete(review.getPhotoUrls());
        return new ModelAndView("redirect:/review/list.do");
    }

    @RequestMapping(value="/myreview.do")
    public ModelAndView myReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (requireMember(request, response) == null) return null;
        int page = parsePage(request.getParameter("page"));
        int pageSize = 10;
        int totalCount = reviewService.getMyReviewCount(request);
        ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
        mav.addObject("currentPage", page);
        mav.addObject("totalPage", (int)Math.ceil((double)totalCount / pageSize));
        mav.addObject("reviewList", reviewService.myReviewList(request, (page - 1) * pageSize, pageSize));
        return mav;
    }

    private MemberVO requireMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        MemberVO member = session == null ? null : (MemberVO)session.getAttribute("member");
        if (member == null) response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        return member;
    }

    private boolean ownsReview(ReviewVO review, MemberVO member) {
        ReviewCustomerVO reservation = reviewService.getReserveByReserveId(review.getReserve_id());
        return reservation != null && reservation.getMember_id() == member.getId();
    }

    private int parsePage(String raw) {
        try {
            int page = raw == null ? 1 : Integer.parseInt(raw);
            if (page < 1 || page > 10000) throw new IllegalArgumentException("page 범위 오류");
            return page;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("page 형식 오류", e);
        }
    }

    private void validateReview(String title, String content, int rating) {
        if (title == null || title.trim().isEmpty() || title.trim().length() > 200)
            throw new IllegalArgumentException("제목이 비어 있거나 너무 깁니다.");
        if (content == null || content.trim().isEmpty() || content.length() > 5000)
            throw new IllegalArgumentException("내용이 비어 있거나 너무 깁니다.");
        if (rating < 1 || rating > 5) throw new IllegalArgumentException("별점은 1~5 사이여야 합니다.");
    }

}
