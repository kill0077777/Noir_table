package com.noir.menu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noir.menu.dao.MenuDAO;
import com.noir.menu.vo.MenuAddVO;
import com.noir.menu.vo.MenuVO;
import com.noir.menu.vo.SupplementVO;
import com.noir.menu.vo.WineVO;

@Service
public class MenuService {
	
	@Autowired
	MenuDAO menuDAO;
		
	//1. 코스 메뉴 가져오기
	public List<MenuVO> getMenusByType(String menuType) {
		
		return menuDAO.selectByType(menuType);
	}
	
	//2. 보충 메뉴 가져오기
	public List<SupplementVO> getSupplementMenu() {
		
		return menuDAO.selectSupplementMenu();
	}
	
	//3. 와인리스트 가져오기
	public List<WineVO> getWineList(Map<String, Object> paramMap) {
		
		return menuDAO.selectWineList(paramMap);
	}
	
	//4. 보충메뉴 수정
	public void updateSupplementMenu(SupplementVO supplement) {
		menuDAO.updateSupplementMenu(supplement);
		
	}
	
	//5. 메뉴 수정
	public void updateMenu(MenuVO menu) {
		menuDAO.updateMenu(menu);
		
	}
	
	//6. 순서 변경
	public boolean swapOrder(int currentId, int currentOrder, int targetId, int targetOrder) {
		
		menuDAO.swapOrder(currentId,targetOrder);
		menuDAO.swapOrder(targetId,currentOrder);
		
		return true;
	}
	
	//7. 메뉴 추가
	public boolean insertMenu(MenuAddVO vo) {
		
		if(vo.getMenuType().equals("supplement")) {
			
			SupplementVO supplement = new SupplementVO();
			
			supplement.setMenu_name(vo.getName());
			supplement.setMenu_english_name(vo.getEnglishName());
			supplement.setMenu_description(vo.getDescription());
			supplement.setMenu_price(vo.getPrice());
			supplement.setMenu_type(vo.getType());
			
			menuDAO.insertSupplementMenu(supplement);
		}
		
		else {
			
			//메뉴순서 제일 마지막 순서보다 +1
			int orderNum = menuDAO.selectMaxOrderByType(vo.getMenuType())+1;
			
			MenuVO menu = new MenuVO();
			
			menu.setMenu_description(vo.getDescription());
			menu.setMenu_english_name(vo.getEnglishName());
			menu.setMenu_name(vo.getName());
			menu.setMenu_type(vo.getMenuType());
			menu.setMenu_order(orderNum);
			
			menuDAO.insertMenu(menu);
		}
			
		return true;
	}
	
	//8. 메뉴 삭제
	@Transactional
	public boolean deleteMenu(Map<String, Object> param) {
		
		int menu_id = (Integer)param.get("menuId");
		String menuType = (String)param.get("menuType");
		
		//보충 메뉴일 경우
		if(menuType.equals("supplement")) {
			menuDAO.deleteSupplementMenu(menu_id);
		}
		//코스 메뉴일 경우
		else {
 
			menuDAO.deleteMenu(menu_id);
		}
		
		return true;
	}
	
	//9. 와인 추가
	public void insertWine(WineVO wineVO) {
		
		menuDAO.insertWine(wineVO);
		
	}
	
	//10. 와인 삭제
	public void deleteWineById(int wineId) {
		
		menuDAO.deleteWine(wineId);
		
	}

}
