package com.noir.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.noir.menu.service.MenuService;
import com.noir.menu.vo.MenuAddVO;
import com.noir.menu.vo.MenuVO;
import com.noir.menu.vo.SupplementVO;
import com.noir.menu.vo.WineVO;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;
	//메뉴 페이지
	@RequestMapping(value= "/list.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView menu(@RequestParam String menuType,
							 HttpServletRequest request,
							 HttpServletResponse response) throws Exception{
		
		HttpSession session;
		session=request.getSession();
		
		if(menuType==null || menuType.equals("")) menuType="lunch";
		
		ModelAndView mav=new ModelAndView();
		
		//메뉴타입으로 메뉴리스트 불러오기
		List<MenuVO> menuList = menuService.getMenusByType(menuType);
		
		//보충메뉴 메뉴리스트 불러오기
		List<SupplementVO> supplementList = menuService.getSupplementMenu();
		
		mav.addObject("menuList",menuList);
		mav.addObject("supplementList",supplementList);
		
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@RequestMapping("/wine.do")
	public ModelAndView wine(HttpServletRequest req, HttpServletResponse resp) {

		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("/menu/winelist");
		
		return mav;
	}
	
	//와인 리스트 페이지
	@RequestMapping("/winelist.do")
	public ModelAndView wineList(
			@RequestParam(required = false) String wine_name,
		    @RequestParam(required = false) String wine_type,
		    @RequestParam(required = false) String region,
		    @RequestParam(required = false) String vintage,
		    @RequestParam(required = false) String wine_category,
			HttpServletRequest req,HttpServletResponse resp)throws Exception{
		
		HttpSession session;
		session=req.getSession();

		ModelAndView mav=new ModelAndView();
		
		
		//와인 검색 조건
		Map<String, Object> paramMap = new HashMap<>();
	    if (wine_name != null && !wine_name.isEmpty()) paramMap.put("wine_name", wine_name);
	    if (wine_type != null && !wine_type.isEmpty()) paramMap.put("wine_type", wine_type);
	    if (region != null && !region.isEmpty()) paramMap.put("region", region);
	    if (vintage != null && !vintage.isEmpty()) paramMap.put("vintage", vintage);
	    if (wine_category != null && !wine_category.isEmpty()) paramMap.put("wine_category", wine_category);
		
		//와인리스트 불러오기
		List<WineVO> wineList = menuService.getWineList(paramMap);
		
		mav.addObject("wineList",wineList);

		String viewName=(String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
	}
	
    @RequestMapping(value = "/addWine.do", method=RequestMethod.POST,consumes = "application/json")
    @ResponseBody
    public Map<String, Object> addWine(@RequestBody WineVO wineVO) {
    	
        Map<String, Object> result = new HashMap<>();

        try {
        	menuService.insertWine(wineVO);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }
    
    @RequestMapping(value = "/deleteWine.do", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteWine(@RequestParam("wine_id") int wineId) {
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	try {
    		menuService.deleteWineById(wineId);
    		result.put("success", true);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put("success", false);
    		result.put("error", e.getMessage());
    	}
    	
    	return result;
    }
    
    
	
	//메뉴 수정 화면
	@RequestMapping("/edit.do")
	public ModelAndView menuEdit(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName=(String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//메뉴타입으로 메뉴 수정 페이지 불러오기
	@RequestMapping("/editMenu.do")
	public ModelAndView menuEdit(@RequestParam String menuType,
								 HttpServletRequest req,
								 HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		if(menuType.equals("supplement")) {
			//보충메뉴 메뉴리스트 불러오기
			List<SupplementVO> supplementList = menuService.getSupplementMenu();
			mav.addObject("supplementList",supplementList);
			//메뉴타입 전달 => 메뉴 추가시에 메뉴타입 이용
			mav.addObject("menuType",menuType);
		}
		else {
			//메뉴타입으로 메뉴리스트 불러오기
			List<MenuVO> menuList = menuService.getMenusByType(menuType);
			mav.addObject("menuList",menuList);
			//메뉴타입 전달 => 메뉴 추가시에 메뉴타입 이용
			mav.addObject("menuType",menuType);
		}
		
		String viewName=(String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//비동기 요청으로 메뉴 수정
	@RequestMapping(value = "/updateMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateMenu(@RequestBody Map<String,Object> data) throws Exception{
		
		Map<String, Object> result = new HashMap<>();
		
	    try {
	        // 필드 추출
	        int id = Integer.parseInt(data.get("id").toString());
	        String name = data.get("name").toString();
	        String englishName = data.get("englishName").toString();
	        String description = data.get("description").toString();

	        // 보충 메뉴인지 일반 메뉴인지 판단
	        if (data.containsKey("type") && data.containsKey("price")) {
	            // 보충메뉴 업데이트
	            String type = data.get("type").toString();
	            int price = Integer.parseInt(data.get("price").toString());

	            SupplementVO supplement = new SupplementVO();
	            supplement.setMenu_id(id);
	            supplement.setMenu_name(name);
	            supplement.setMenu_english_name(englishName);
	            supplement.setMenu_description(description);
	            supplement.setMenu_type(type);
	            supplement.setMenu_price(price);

	            menuService.updateSupplementMenu(supplement);

	        } else {
	            // 일반 메뉴 업데이트
	            MenuVO menu = new MenuVO();
	            menu.setMenu_id(id);
	            menu.setMenu_name(name);
	            menu.setMenu_english_name(englishName);
	            menu.setMenu_description(description);

	            menuService.updateMenu(menu);
	        }

	        result.put("success", true);

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("error", e.getMessage());
	    }

	    return result;
        
	}
	
	//비동기 요청으로 메뉴 순서 수정
	@RequestMapping(value = "/swapOrder",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> swapOrder(@RequestBody Map<String,Object> data) throws Exception{
		
			// 필드 추출
			int currentOrder = Integer.parseInt(data.get("currentOrder").toString());
			int currentId = Integer.parseInt(data.get("currentId").toString());
			int targetId = Integer.parseInt(data.get("targetId").toString());
			int targetOrder = Integer.parseInt(data.get("targetOrder").toString());
			
			boolean success = menuService.swapOrder(currentId,currentOrder,targetId,targetOrder);
			
		    Map<String, Object> response = new HashMap<>();
		    response.put("success", success);
		    return response;
		
	}
	
	//메뉴 추가
	@RequestMapping(value="/addMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addMenu(@RequestBody MenuAddVO vo) {
	    // dto 안에 menuType, name, englishName, description, type(optional), price(optional)
		
	    boolean success = menuService.insertMenu(vo);
	    
	    return Map.of("success", success);
	}
	
	//메뉴 삭제
	@RequestMapping(value="/deleteMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteMenu(@RequestBody Map<String, Object> param) {
		
	    boolean success = menuService.deleteMenu(param);
	    return Map.of("success", success);
	}

}
