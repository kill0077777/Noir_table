package com.noir.gallery.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.gallery.vo.PhotoVO;
import com.noir.member.vo.MemberVO;

@Repository
public class GalleryDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//1.사진 등록
	public void insertPhoto(PhotoVO photoVO) {
		sqlSession.insert("mapper.gallery.insertPhoto",photoVO);
	}
	
	//2.사진 불러오기
	public List<PhotoVO> getAllPhotos() {
		
		return sqlSession.selectList("mapper.gallery.selectAllPhotos");
	}

	public int deleteByPhotoId(int photoId) {
		
		return sqlSession.delete("mapper.gallery.deletePhoto",photoId);
	}
	
}
