package com.noir.menu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.menu.vo.MenuVO;
import com.noir.menu.vo.SupplementVO;
import com.noir.menu.vo.WineVO;

@Repository
public class MenuDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//1. 코스 메뉴 가져오기
	public List<MenuVO> selectByType(String menuType) {
		
		return sqlSession.selectList("mapper.menu.selectMenuByType",menuType);
	}
	
	//2. 보충 메뉴 가져오기
	public List<SupplementVO> selectSupplementMenu() {
		
		return sqlSession.selectList("mapper.menu.selectSupplementMenu");
	}
	
	//3. 와인 리스트 가져오기
	public List<WineVO> selectWineList(Map<String, Object> paramMap) {
		
		return sqlSession.selectList("mapper.menu.selectWineList",paramMap);
	}
	
	//4. 보충 메뉴 수정
	public void updateSupplementMenu(SupplementVO supplement) {
		
		sqlSession.update("mapper.menu.updateSupplementMenu",supplement);
	}
	
	//5. 코스 메뉴 수정
	public void updateMenu(MenuVO menu) {
		
		sqlSession.update("mapper.menu.updateMenu",menu);
	}
	
	//6. 메뉴 순서 변경 요청
	public void swapOrder(int currentId, int targetOrder) {
		Map<String,Integer> paramMap= new HashMap<>();
		paramMap.put("id",currentId);
		paramMap.put("order", targetOrder);
		
		sqlSession.update("mapper.menu.swapOrder",paramMap);
		
	}
	
	//7. 보충 메뉴 추가
	public void insertSupplementMenu(SupplementVO supplement) {
		
		sqlSession.insert("mapper.menu.insertSupplementMenu",supplement);
		
	}
	
	//8. 메뉴타입으로 가장 높은 메뉴 순서 값 가져오기
	public int selectMaxOrderByType(String menuType) {
		
		return sqlSession.selectOne("mapper.menu.selectMaxOrderByType",menuType);
	}
	
	//9. 코스 메뉴 추가
	public void insertMenu(MenuVO menu) {
		
		sqlSession.insert("mapper.menu.insertMenu",menu);
		
	}
	
	//10. 보충 메뉴 삭제
	public void deleteSupplementMenu(int menu_id) {
		sqlSession.delete("mapper.menu.deleteSupplementMenu",menu_id);
		
	}
	
	//11. 코스 메뉴 삭제
	public void deleteMenu(int menu_id) {
		
		//메뉴 삭제
		sqlSession.delete("mapper.menu.deleteMenu",menu_id);
	
	}


	public void deletePhoto(int photoId) {
		
		sqlSession.delete("mapper.gallery.deletePhoto",photoId);
		
	}

	public void insertWine(WineVO wineVO) {
		
		sqlSession.insert("mapper.menu.insertWine",wineVO);
		
	}

	public void deleteWine(int wineId) {
		sqlSession.delete("mapper.menu.wineDelete",wineId);
		
	}

}
