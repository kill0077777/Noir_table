<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<div class="wine-container">
<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
	<img src="${contextPath}/resources/image/noir_icon.png"/>
</div>

<!-- 와인 리스트 페이지 -->
<div class="menu-header fade-up">
  <div class="menu-categories fade-up">
    <a class="category-link" href="${contextPath}/menu/list.do?menuType=lunch">lunch</a>
    <a class="category-link" href="${contextPath}/menu/list.do?menuType=dinner">dinner</a>
    <a class="category-link" href="${contextPath}/menu/list.do?menuType=vegan">vegan</a>
    <a class="category-link" href="${contextPath}/menu/wine.do">winelist</a>
  </div>
</div>

<c:if test="${sessionScope.member.role eq 'ADMIN'}">
  <button class="wine-add-btn fade-up">와인 추가</button>
  <button class="wine-delete-btn fade-up">와인 삭제</button>
</c:if>

<div id="wine-add-form" class="fade-up" style="display:none; margin-top:30px; border-top:1px solid #ddd; padding-top:20px;">
	<div style="display:flex; justify-content:center; item-align:center;">
	  	<h3>새로운 와인 추가</h3>
	</div>
  <div class="wine-form-grid">
    <input type="text" placeholder="와인 이름" id="wine_name">
    <input type="text" placeholder="지역" id="region">
    <input type="text" placeholder="빈티지 (연도)" id="vintage">
    <input type="text" placeholder="생산자" id="producer">
    <input type="number" placeholder="가격" id="price">
    <input type="text" placeholder="병 크기 (예: 750ml)" id="bottle_size">
    <select id="wine_category" class="wine-select">
      <option value="">카테고리 선택</option>
      <option value="Full Bottle" ${param.wine_category == 'Full Bottle' ? 'selected' : ''}>𝐅𝐮𝐥𝐥 𝐁𝐨𝐭𝐭𝐥𝐞</option>
      <option value="By the Glass" ${param.wine_category == 'By the Glass' ? 'selected' : ''}>𝐁𝐲 𝐭𝐡𝐞 𝐆𝐥𝐚𝐬𝐬</option>
    </select>
    <select id="wine_type" class="wine-select">
      <option value="">종류 선택</option>
      <option value="Red" ${param.wine_type == 'Red' ? 'selected' : ''}>𝐑𝐞𝐝</option>
      <option value="White" ${param.wine_type == 'White' ? 'selected' : ''}>𝐖𝐡𝐢𝐭𝐞</option>
      <option value="Sparkling" ${param.wine_type == 'Sparkling' ? 'selected' : ''}>𝐒𝐩𝐚𝐫𝐤𝐥𝐢𝐧𝐠</option>
      <option value="Dessert" ${param.wine_type == 'Dessert' ? 'selected' : ''}>𝐃𝐞𝐬𝐬𝐞𝐫𝐭</option>
    </select>
    <textarea placeholder="설명" id="description" rows="4" style="width:100%;"></textarea>
    <button id="saveWineBtn" class="wine-search-btn">저장</button>
  </div>
</div>


<form method="get" action="${contextPath}/menu/winelist.do" class="wine-filter-form fade-up" style="margin-bottom: 30px;">
  <div class="wine-filter-grid fade-up">
    <input type="text" name="wine_name" placeholder="와인 이름" value="${param.wine_name}" class="wine-input"/>

    <input type="text" name="vintage" placeholder="년도" value="${param.vintage}" class="wine-input"/>

    <select name="wine_type" class="wine-select">
      <option value="">종류 선택</option>
      <option value="Red" ${param.wine_type == 'Red' ? 'selected' : ''}>𝐑𝐞𝐝</option>
      <option value="White" ${param.wine_type == 'White' ? 'selected' : ''}>𝐖𝐡𝐢𝐭𝐞</option>
      <option value="Sparkling" ${param.wine_type == 'Sparkling' ? 'selected' : ''}>𝐒𝐩𝐚𝐫𝐤𝐥𝐢𝐧𝐠</option>
      <option value="Dessert" ${param.wine_type == 'Dessert' ? 'selected' : ''}>𝐃𝐞𝐬𝐬𝐞𝐫𝐭</option>
    </select>

    <select name="wine_category" class="wine-select">
      <option value="">카테고리 선택</option>
      <option value="Full Bottle" ${param.wine_category == 'Full Bottle' ? 'selected' : ''}>𝐅𝐮𝐥𝐥 𝐁𝐨𝐭𝐭𝐥𝐞</option>
      <option value="By the Glass" ${param.wine_category == 'By the Glass' ? 'selected' : ''}>𝐁𝐲 𝐭𝐡𝐞 𝐆𝐥𝐚𝐬𝐬</option>
    </select>

    <button type="submit" class="wine-search-btn">검색</button>
  </div>
</form>
  
	  <!-- 1. 처음 진입 시 와인 이미지 -->
	  <c:if test="${wineList == null}">
		<div class="wine-image-placeholder fade-up">
		  <div class="wine-image-overlay">

			    <span class="wine-overlay-text">
				  Noir의 와인리스트를 검색해보세요<br><br>
				  전 세계 다양한 지역에서 엄선한 빈티지 와인부터<br>
				  한 잔으로 즐기는 감각적인 스파클링까지,<br>
				  취향과 순간에 어울리는 와인을 제안합니다.
				</span>

		  </div>
		  <img src="${contextPath}/resources/image/wine_intro.png" alt="와인 소개" />
		</div>
	  </c:if>
	
	  <!-- 2. 검색 결과가 있을 때 -->
	  <c:if test="${not empty wineList}">
	    <c:forEach var="wine" items="${wineList}">
	      <div class="wine-line fade-up" data-id="${wine.wine_id}">
	        <button class="delete-icon" style="display:none;" onclick="confirmDelete(${wine.wine_id})">−</button>
	        <span class="wine-name">${wine.wine_name}</span>
	        <span>${wine.wine_type}</span>,
	        <span>${wine.region}</span>,
	        <c:if test="${not empty wine.vintage}">
	          <span>${wine.vintage}</span>,
	        </c:if>
	        <span>${wine.producer}</span>,
	        <span>${wine.wine_category}</span>
	        <span class="wine-price">KRW <fmt:formatNumber value="${wine.price}" type="number" groupingUsed="true"/></span>
	      </div>
	    </c:forEach>
	  </c:if>
	
	  <!-- 3. 검색했지만 결과가 없는 경우 -->
	  <c:if test="${wineList != null and wineList.size() == 0}">
	    <div class="no-result fade-up" style="text-align: center; margin-top: 50px; font-size: 18px; color: #888;">
	      검색 결과가 없습니다.
	    </div>
	  </c:if>
  	  
  	 <div class="icon_box fade-up" style="margin-top:50px;">
		<img src="${contextPath}/resources/image/noir_icon.png"/>
	</div>
	
</div>
<style>
.wine-form-grid {
  display: flex;
  flex-direction: column;
  gap: 10px;
  max-width: 600px;
  margin-bottom:50px;
  margin-left:auto;
  margin-right:auto;
}

.wine-form-grid input,
.wine-form-grid textarea {
  width: 100%;
  padding: 12px 16px;
  font-size: 15px;
  border: 1px solid #ccc;
  border-radius: 12px;
  transition: all 0.3s ease;
  background-color: #fdfdfd;
  box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
}

.wine-form-grid input:focus,
.wine-form-grid textarea:focus {
  outline: none;
  border-color: #7c2c5c;
  box-shadow: 0 0 5px rgba(124, 44, 92, 0.3);
  background-color: #fff;
}

.wine-form-grid textarea {
  resize: vertical;
}

#saveWineBtn {
  background: linear-gradient(to right, #452160, #4b1d3f);
  color: white;
  border: none;
  padding: 12px;
  font-size: 16px;
  font-weight: bold;
  border-radius: 10px;
  cursor: pointer;
  transition: background 0.3s ease;
}

#saveWineBtn:hover {
  background: linear-gradient(to right, #452160, #301226);
}

.delete-icon {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background-color: red;
  color: white;
  border: none;
  font-weight: bold;
  font-size: 18px;
  margin-right: 10px;
  cursor: pointer;
}

.wine-add-btn{
  font-size: 14px;
  color: #452160;
  border: 1px solid #452160;
  background-color:white;
  padding: 4px 8px;
  border-radius: 4px;
}

.wine-add-btn:hover{
	color:white;
	background-color:#452160;
}

.wine-edit-btn{
  font-size: 14px;
  color: #452160;
  border: 1px solid #452160;
  background-color:white;
  padding: 4px 8px;
  border-radius: 4px;
}

.wine-edit-btn:hover{
	color:white;
	background-color:#452160;
}

.wine-delete-btn {
  font-size: 14px;
  color: red;
  border: 1px solid red;
  background-color:white;
  padding: 4px 8px;
  border-radius: 4px;
}

.wine-delete-btn:hover{
	color:white;
	background-color:red;
}

.wine-image-placeholder {
  position: relative;
  max-width: 80%;
  margin: 60px auto;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
}

.wine-image-placeholder img {
  display: block;
  width: 100%;
  height: auto;
  transition: transform 0.4s ease;
}

.wine-image-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0); /* 기본 투명 */
  display: flex;
  justify-content: center;
  align-items: center;
  transition: background 0.4s ease;
  pointer-events: none;
}

.wine-image-placeholder:hover .wine-image-overlay {
  background: rgba(0, 0, 0, 0.5); /* 마우스 오버 시 반투명 흑색 */
}

.wine-overlay-text {
  color: white;
  font-size: 22px;
  font-weight: bold;
  opacity: 0;
  transition: opacity 0.4s ease;
  text-shadow: 1px 1px 4px rgba(0,0,0,0.6);
  text-align:center;
}

.wine-image-placeholder:hover .wine-overlay-text {
  opacity: 1;
}


.wine-table {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 40px 10px;
}

.wine-line {
  font-size: 15px;
  line-height: 1.8;
  color: #2e2e2e;
  font-family: 'Georgia', 'Serif';
  border-bottom: 1px solid rgba(200, 200, 200, 0.15);
  padding-bottom: 8px;
  transition: background-color 0.3s ease;
  margin-bottom:20px;
}

.wine-line:hover {
  background-color: rgba(240, 240, 240, 0.3);
}

.wine-name {
  display: inline-block;
  width: 320px;
  font-weight: bold;
  color: #3b2142;
  margin-right: 10px;
}

.wine-desc {
  font-style: italic;
  font-size: 13px;
  color: #666;
  margin-top: 5px;
  margin-left: 6px;
}

.wine-price {
  float: right;
  font-weight: bold;
  color: #7c2c5c;
  margin-left: 12px;
}

.wine-filter-form {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 10px;
}

.wine-filter-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  align-items: center;
}

.wine-input, .wine-select {
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-size: 14px;
  width: 150px;
}

.wine-search-btn {
  background-color: #452160;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
}

.wine-search-btn:hover {
  background-color: #2f123e;
}

#wineListTitle {
  font-size: 28px;
  font-weight: bold;
  text-align: center;
  color: #2c1a40;
  margin-bottom: 40px;
}

.wine-container {
  max-width: 75%;
  margin: 0 auto;
  padding: 60px 20px;
}

.menu-header {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-bottom: 10px;
  margin-bottom: 40px;
}

.menu-categories {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.category-link {
  text-decoration: none;
  color: #452160;
  font-weight: bold;
  font-size: 16px;
  transition: color 0.3s;
}

.category-link:hover {
  color: #000;
}

.fade-up {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 1.2s ease-out, transform 1.2s ease-out;
}

.fade-up.show {
  opacity: 1;
  transform: translateY(0);
}

.icon_box {
  display: flex;
  justify-content: center;
  margin-bottom:25px;
}

.icon_box img {
  width: 50px;
  height: 50px;
}
</style>

<script>
const addWineBtn = document.querySelector('.wine-add-btn');
const wineAddForm = document.getElementById('wine-add-form');

if (addWineBtn && wineAddForm) {
	  addWineBtn.addEventListener('click', () => {
	    wineAddForm.style.display = wineAddForm.style.display === 'none' ? 'block' : 'none';
	  });
}

document.getElementById('saveWineBtn').addEventListener('click', () => {
  const data = {
    wine_name: document.getElementById('wine_name').value,
    wine_type: document.getElementById('wine_type').value,
    region: document.getElementById('region').value,
    vintage: document.getElementById('vintage').value,
    producer: document.getElementById('producer').value,
    price: document.getElementById('price').value,
    bottle_size: document.getElementById('bottle_size').value,
    description: document.getElementById('description').value,
    wine_category: document.getElementById('wine_category').value,
  };

  // 유효성 체크는 생략, 필요시 추가 가능
  fetch('${contextPath}/menu/addWine.do', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  })
  .then(res => res.json())
  .then(result => {
    if (result.success) {
      alert('와인 추가 완료!');
      location.href='${contextPath}/menu/winelist.do';
    } else {
      alert('추가 실패: ' + result.message);
    }
  });
});

const deleteToggleBtn = document.querySelector('.wine-delete-btn');
let deleteMode = false;

if(deleteToggleBtn){
deleteToggleBtn.addEventListener('click', () => {
  deleteMode = !deleteMode;
  document.querySelectorAll('.delete-icon').forEach(btn => {
    btn.style.display = deleteMode ? 'inline-block' : 'none';
  });
  deleteToggleBtn.textContent = deleteMode ? '삭제 완료' : '와인 삭제';
});
}
function confirmDelete(wineId) {
  if (confirm('정말 이 와인을 삭제하시겠습니까?')) {
    fetch('${contextPath}/menu/deleteWine.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: 'wine_id=' + wineId
    })
    .then(res => res.json())
    .then(result => {
      if (result.success) {
        alert('삭제 완료');
        location.reload(); // 삭제 후 새로고침
      } else {
        alert('삭제 실패');
      }
    });
  }
}


//메인 페이지 페이드아웃 -> 페이드 인 적용 익명 함수
const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('show');
        observer.unobserve(entry.target); // 한 번만 실행
      }
    });
  }, { threshold: 0.2 });

  document.querySelectorAll('.fade-up').forEach(section => {
    observer.observe(section);
  });
</script>
