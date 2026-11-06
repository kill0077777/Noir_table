package com.noir.review.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.web.servlet.ModelAndView;

import com.noir.member.vo.MemberVO;
import com.noir.review.service.ReviewServiceImpl;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Controller
@RequestMapping("/review/*")
public class ReviewController {

    private static final Path UPLOAD_DIR = Paths.get("C:/upload/noir/review/").toAbsolutePath().normalize();
    private static final long MAX_IMAGE_SIZE = 5L * 1024L * 1024L;

    @Autowired
    private ReviewServiceImpl reviewService;

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
        mav.addObject("reserve", reviewService.getReserveByCustomId(review.getCustomer_id()));
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
            @RequestParam("customer_id") int customerId, @RequestParam("title") String title,
            @RequestParam("content") String content, @RequestParam("rating") int rating,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        MemberVO member = requireMember(request, response);
        if (member == null) return null;
        validateReview(title, content, rating);

        ReviewCustomerVO reservation = reviewService.getReserveByCustomId(customerId);
        if (reservation == null || reservation.getMember_id() != member.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return null;
        }

        ReviewVO review = new ReviewVO();
        review.setContent(content.trim());
        review.setCustomer_id(customerId);
        review.setMember_id(member.getId());
        review.setTitle(title.trim());
        review.setRating(rating);
        String savedName = null;
        try {
            savedName = saveImage(photoFile);
            review.setPhotoUrls(savedName);
            reviewService.addReviewWithImages(review);
        } catch (Exception e) {
            deleteImage(savedName);
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
        mav.addObject("reserve", reviewService.getReserveByCustomId(review.getCustomer_id()));
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
                newName = saveImage(photoFile);
                review.setPhotoUrls(newName);
            } else {
                review.setPhotoUrls(existing.getPhotoUrls());
            }
            reviewService.updateReviewWithImages(review);
            if (newName != null) deleteImage(existing.getPhotoUrls());
        } catch (Exception e) {
            deleteImage(newName);
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
        reviewService.deleteReview(reviewId, member.getId(), UPLOAD_DIR.toString());
        deleteImage(review.getPhotoUrls());
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
        ReviewCustomerVO reservation = reviewService.getReserveByCustomId(review.getCustomer_id());
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

    private String saveImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) return null;
        if (file.getSize() > MAX_IMAGE_SIZE) throw new IOException("이미지 크기 제한 초과");
        String original = file.getOriginalFilename();
        String extension = original == null ? "" : original.substring(original.lastIndexOf('.') + 1).toLowerCase();
        if (!("jpg".equals(extension) || "jpeg".equals(extension) || "png".equals(extension) || "webp".equals(extension)))
            throw new IOException("허용되지 않은 이미지 형식");
        String name = UUID.randomUUID().toString() + "." + extension;
        Files.createDirectories(UPLOAD_DIR);
        Path target = UPLOAD_DIR.resolve(name).normalize();
        if (!target.startsWith(UPLOAD_DIR)) throw new IOException("잘못된 저장 경로");
        file.transferTo(target.toFile());
        return name;
    }

    private void deleteImage(String fileName) throws IOException {
        if (fileName == null || fileName.trim().isEmpty()) return;
        Path target = UPLOAD_DIR.resolve(new File(fileName).getName()).normalize();
        if (!target.startsWith(UPLOAD_DIR)) return;
        Files.deleteIfExists(target);
    }
}
