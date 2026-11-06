package com.noir.gallery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noir.gallery.dao.GalleryDAO;
import com.noir.gallery.vo.PhotoVO;

@Service
public class GalleryService {
	
	@Autowired
	GalleryDAO galleryDAO;
	
	//1.사진 등록
	public void insertPhoto(PhotoVO photoVO) {
		
		galleryDAO.insertPhoto(photoVO);
		
	}
	
	//2.사진 불러오기
	public List<PhotoVO> getAllPhotos() {
		
		return galleryDAO.getAllPhotos();
	}
	
	//3.사진 삭제
	public int deleteByPhotoId(int photoId) {
		
		return galleryDAO.deleteByPhotoId(photoId);
	}

}
