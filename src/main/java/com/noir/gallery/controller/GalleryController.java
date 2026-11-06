package com.noir.gallery.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.noir.gallery.service.GalleryService;
import com.noir.gallery.vo.PhotoVO;
import com.noir.member.vo.MemberVO;

@Controller
@RequestMapping("/gallery")
public class GalleryController {
	
	@Autowired
	GalleryService galleryService;
	
	//갤러리 사진 등록폼 요청
	@RequestMapping("/registerForm.do")
	public ModelAndView photoRegisterForm(HttpServletRequest req, HttpServletResponse resp) {
		
		HttpSession session;
		session=req.getSession();
				
		ModelAndView mav=new ModelAndView();
		
		String viewName=(String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@RequestMapping(value="/upload.do",method=RequestMethod.POST)
	public ModelAndView uploadPhoto(@RequestParam("photoFile") MultipartFile photoFile,
									@RequestParam("photoType") String photoType,
									HttpServletRequest req) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//업로드 폴더 경로 설정
		String uploadDir = "C:/upload/noir/gallery/";
		File dir = new File(uploadDir);
		if(!dir.exists()) dir.mkdirs();//경로 없으면 생성
		
		//실제 파일 이름과 저장용 UUID 이름 만들기
		String originalFileName = photoFile.getOriginalFilename();
		String uuid = UUID.randomUUID().toString();
		String saveName = uuid+"_"+originalFileName;
		
		//저장
		File saveFile = new File(uploadDir + saveName);
		photoFile.transferTo(saveFile);
		
		PhotoVO photoVO = new PhotoVO();
		photoVO.setPhoto_url(saveName);
		photoVO.setPhoto_type(photoType);
		
		galleryService.insertPhoto(photoVO);
		
		mav.setViewName("redirect:/gallery.do");
		
		return mav;
	}
	
	@RequestMapping(value = "/deletePhoto",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletePhoto(@RequestBody Map<String, String> body, HttpSession session) {
		
	    Map<String, Object> result = new HashMap<>();

	    int photoId = Integer.parseInt(body.get("photoId"));
	    
	    
	    // 여기서 DB + 파일 삭제 처리하면 됨
	    int deleted = galleryService.deleteByPhotoId(photoId); // 예시
	    
	    if (deleted == 1) {
	        result.put("success", true);
	    } else {
	        result.put("success", false);
	        result.put("message", "삭제 실패");
	    }

	    return result;
	}
}
