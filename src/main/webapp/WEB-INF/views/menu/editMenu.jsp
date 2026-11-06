<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 메뉴 수정 -->
<div class="menu-container fade-up">

  <div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
	  <img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>  
  
  <div class="menu-header fade-up">
  	<h1>${menuType} 메뉴 관리</h1>
  </div>
  
  <div class="menu-type-buttons fade-up">
    <button onclick="goEditMenu('lunch')"><strong>LUNCH</strong></button>
    <button onclick="goEditMenu('dinner')"><strong>DINNER</strong></button>
    <button onclick="goEditMenu('vegan')"><strong>VEGAN</strong></button>
    <button onclick="goEditMenu('supplement')"><strong>SUPPLEMENT</strong></button>
  </div>


  

  <!-- 수정: 모달 열기 -->
  <button class="btn-add fade-up" onclick="toggleAddRow()">메뉴 추가</button>
  
  <div class="menu-table fade-up">
  	<table>
  		<thead>
  			<tr>
  			<c:if test="${not empty menuList}">
  				<th>순서</th>
  				<th>이름</th>
  				<th>영문명</th>
  				<th>설명</th>
  				<th>기능</th>
  			</c:if>
  			<c:if test="${not empty supplementList}">
  				<th>이름</th>
  				<th>영문명</th>
  				<th>설명</th>
  				<th>타입</th>
  				<th>가격</th>
  				<th>기능</th>
  			</c:if>
  			</tr>
  		</thead>
  		<tbody>
			<tr id="addMenuRow-basic" style="display:none; background-color: #f9f9f9;">
			  <td colspan="6">
			    <div style="display:flex; gap:10px; align-items:center; padding:10px;">
			      <input type="text" id="newMenuName" placeholder="이름" style="flex:1;">
			      <input type="text" id="newMenuEnglishName" placeholder="영문명" style="flex:1;">
			      <input type="text" id="newMenuDescription" placeholder="설명" style="flex:2;">
			      <button type="button" onclick="addMenu('basic')" class="btn-edit">추가</button>
			      <button onclick="toggleAddRow()" class="btn-cancel">취소</button>
			    </div>
			  </td>
			</tr>
			<tr id="addMenuRow-supplement" style="display:none; background-color: #f9f9f9;">
			  <td colspan="6">
			    <div style="display:flex; gap:10px; align-items:center; padding:10px;">
			      <input type="text" id="newMenuName_s" placeholder="이름" style="flex:1;">
			      <input type="text" id="newMenuEnglishName_s" placeholder="영문명" style="flex:1;">
			      <input type="text" id="newMenuDescription_s" placeholder="설명" style="flex:2;">
			      <select id="newMenuType_s" style="flex:1;">
			        <option value="">선택</option>
			        <option value="DESSERT">Dessert</option>
			        <option value="PREMIUM">Premium</option>
			      </select>
			      <input type="number" id="newMenuPrice_s" placeholder="가격" style="width:100px;">
			      <button type="button" onclick="addMenu('supplement')" class="btn-edit">추가</button>
			      <button onclick="toggleAddRow()" class="btn-cancel">취소</button>
			    </div>
			  </td>
			</tr>
  			<c:if test="${not empty menuList}">
  			<c:forEach var="menu" items="${menuList}" varStatus="status">
  			<tr data-id="${menu.menu_id}" data-order="${menu.menu_order}">
  				<td style="width:150px;">
  					<div style="display:flex; gap:10px; justify-content:center; align-items:center;">
	  					<div>
	  						<span class="text-mode">${menu.menu_order}</span>
	  					</div>
				        <div style="display:flex; flex-direction:column; gap:4px;">
					        <button class="btn-order-up" onclick="moveOrder(this, 'up')">▲</button>
					        <button class="btn-order-down" onclick="moveOrder(this, 'down')">▼</button>
					    </div>
				    </div>
  				</td>
  				<td><span class="text-mode">${menu.menu_name}</span><input class="edit-mode" name="menu_name" type="text" value="${menu.menu_name}" style="display:none;"></td>
  				<td><span class="text-mode">${menu.menu_english_name}</span><input class="edit-mode" name="menu_english_name" type="text" value="${menu.menu_english_name}" style="display:none;"></td>
  				<td><span class="text-mode">${menu.menu_description}</span><input class="edit-mode" type="text" name="menu_description" value="${menu.menu_description}" style="display:none;"></td>
				<td>
					<button class="btn-edit" onclick="toggleEdit(this)">메뉴 수정</button>
					<button class="btn-delete" onclick="deleteMenu(${menu.menu_id}, '${menuType}')">메뉴 삭제</button>	
				</td>
			</tr>
  			</c:forEach>
  			</c:if>
  			
  			<c:if test="${not empty supplementList}">
  			<c:forEach var="menu" items="${supplementList}" varStatus="status">
  			<tr data-id="${menu.menu_id}">
  				<td><span class="text-mode">${menu.menu_name}</span><input class="edit-mode" name="menu_name" type="text" value="${menu.menu_name}" style="display:none;"></td>
  				<td><span class="text-mode">${menu.menu_english_name}</span><input class="edit-mode" name="menu_english_name" type="text" value="${menu.menu_english_name}" style="display:none;"></td>
  				<td><span class="text-mode">${menu.menu_description}</span><input class="edit-mode" name="menu_description" type="text" value="${menu.menu_description}" style="display:none;"></td>
				<td>
				  <span class="text-mode">${menu.menu_type}</span>
				  <select class="edit-mode" name="menu_type" style="display:none;">
				    <option value="">선택</option>
				    <option value="DESSERT" ${menu.menu_type eq 'DESSERT' ? 'selected' : ''}>Dessert</option>
				    <option value="PREMIUM" ${menu.menu_type eq 'PREMIUM' ? 'selected' : ''}>Premium</option>
				  </select>
				</td>
  				<td><span class="text-mode">${menu.menu_price}</span><input class="edit-mode" name="menu_price" type="number" value="${menu.menu_price}" style="display:none;"></td>
				<td style="width:300px;">
					<button class="btn-edit" onclick="toggleEdit(this)">메뉴 수정</button>
					<button class="btn-delete" onclick="deleteMenu(${menu.menu_id}, '${menuType}')">메뉴 삭제</button>			
				</td>
			</tr>
  			</c:forEach>
  			</c:if>
  		</tbody>
  	</table>
  </div>
</div>

<script>
	//메뉴 삭제
	function deleteMenu(menuId, menuType) {
	  if (!confirm('정말 이 메뉴를 삭제하시겠습니까?')) return;
	
	  fetch('${contextPath}/menu/deleteMenu', {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/json'
	    },
	    body: JSON.stringify({
	      menuId: menuId,
	      menuType: menuType
	    })
	  })
	  .then(res => res.json())
	  .then(result => {
	    if (result.success) {
	      alert('메뉴가 삭제되었습니다.');
	      location.reload();
	    } else {
	      alert('삭제 실패!');
	    }
	  });
	}

	//메뉴 추가 토글
	function toggleAddRow() {
	  const menuType = '${menuType}';
	  const basicRow = document.getElementById('addMenuRow-basic');
	  const supplementRow = document.getElementById('addMenuRow-supplement');
	  const addBtn = document.querySelector('.btn-add');

	  if (menuType === 'supplement') {
	    if (!supplementRow) return alert('supplement 행이 없습니다');
	    const isVisible = supplementRow.style.display === 'table-row';
	    supplementRow.style.display = isVisible ? 'none' : 'table-row';
	    addBtn.textContent = isVisible ? '메뉴 추가' : '닫기';
	  } else {
	    if (!basicRow) return alert('기본 메뉴 행이 없습니다');
	    const isVisible = basicRow.style.display === 'table-row';
	    basicRow.style.display = isVisible ? 'none' : 'table-row';
	    addBtn.textContent = isVisible ? '메뉴 추가' : '닫기';
	  }
	}
	
	//비동기 메뉴 추가
	function addMenu(type) {
		
		  let data = { menuType: '${menuType}' };

		  if (type === 'basic') {
		    data.name = document.getElementById('newMenuName').value.trim();
		    data.englishName = document.getElementById('newMenuEnglishName').value.trim();
		    data.description = document.getElementById('newMenuDescription').value.trim();
		  } else if (type === 'supplement') {
		    data.name = document.getElementById('newMenuName_s').value.trim();
		    data.englishName = document.getElementById('newMenuEnglishName_s').value.trim();
		    data.description = document.getElementById('newMenuDescription_s').value.trim();
		    data.type = document.getElementById('newMenuType_s').value;
		    data.price = document.getElementById('newMenuPrice_s').value;
		  }
		
		  console.log(data.name);
		  console.log(data.englishName);
		  console.log(data.description);
		  
		  // 필수 체크 (간단하게 예제로)
		  if (!data.name || !data.englishName || !data.description) {
		    alert('모든 값을 입력해주세요.');
		    return;
		  }
		  
		  if((type === 'supplement' && (!data.type || !data.price))) {
			  alert('모든 값을 입력해주세요.');
			  return;
		  }

		  fetch('${contextPath}/menu/addMenu', {
		    method: 'POST',
		    headers: { 'Content-Type': 'application/json' },
		    body: JSON.stringify(data)
		  })
		  .then(res => res.json())
		  .then(result => {
		    if (result.success) {
		      alert('메뉴가 추가되었습니다!');
		      location.reload();
		    } else {
		      alert('추가 실패!');
		    }
		  });
	}

	function goEditMenu(menuType) {
	  location.href = '${contextPath}/menu/editMenu.do?menuType=' + menuType;
	}

	function toggleEdit(button) {
	  const row = button.closest('tr');
	  const spans = row.querySelectorAll('.text-mode');
	  const inputs = row.querySelectorAll('.edit-mode');
	  const deleteBtn = row.querySelector('.btn-delete'); // 사진 등록 버튼
	  const cancelBtn = row.querySelector('.btn-cancel'); // 사진 등록 버튼
	  const isEditing = button.textContent === '수정완료';
	  const menuId = row.dataset.id;
	  const menuType = row.dataset.type;
	  const nameInput = row.querySelector('input[name="menu_name"]');
	  const engInput = row.querySelector('input[name="menu_english_name"]');
	  const descInput = row.querySelector('input[name="menu_description"]');
	  const typeInput = row.querySelector('select[name="menu_type"]');
	  const priceInput = row.querySelector('input[name="menu_price"]');
	  
	  if (isEditing) {
	    // 수정 완료 처리 (AJAX)
	    const data = {
	      id: row.dataset.id,
	      name: nameInput.value.trim(),
	      englishName: engInput.value.trim(),
	      description: descInput.value.trim(),
	    };

	    if (typeInput && priceInput) {
	      data.type = typeInput.value.trim();
	      data.price = priceInput.value.trim();
	    }

	    fetch('${contextPath}/menu/updateMenu', {
	      method: 'POST',
	      headers: {
	        'Content-Type': 'application/json'
	      },
	      body: JSON.stringify(data)
	    })
	    .then(res => res.json())
	    .then(result => {
	      if (result.success) {
	        alert('수정 완료!');
	        location.reload();
	      } else {
	        alert('수정 실패');
	      }
	    });
	  } else {
	    // 편집 모드 진입
	    inputs.forEach(input => input.style.display = 'inline');
	    spans.forEach(span => span.style.display = 'none');
	    button.textContent = '수정완료';

	    // 📌 사진등록 버튼을 '취소' 버튼으로 바꾸기
	    deleteBtn.textContent = '수정 취소';
	    deleteBtn.classList.remove('btn-delete');
	    deleteBtn.classList.add('btn-cancel');

	    // 기존 onclick 제거하고 새로운 기능 설정
	    deleteBtn.onclick = () => {
	      // 원상복구
	      inputs.forEach(input => input.style.display = 'none');
	      spans.forEach(span => span.style.display = 'inline');
	      button.textContent = '메뉴 수정';

	      deleteBtn.textContent = '메뉴 삭제';
	      deleteBtn.classList.remove('btn-cancel');
	      deleteBtn.classList.add('btn-delete');
	      //=======================================================================================================
	      deleteBtn.onclick = () => {
			  deleteMenu(Number(menuId), '${menuType}');
			};
	      //=======================================================================================================
	    };
	  }
	}
	
	//이동
	function moveOrder(button, direction) {
		  const currentRow = button.closest('tr');
		  const currentId = currentRow.dataset.id;
		  const currentOrder = parseInt(currentRow.dataset.order);
				
		  let targetRow = null;

		  if (direction === 'up') {
		    targetRow = currentRow.previousElementSibling;
		  } else if (direction === 'down') {
		    targetRow = currentRow.nextElementSibling;
		  }

		  if (!targetRow || !targetRow.dataset.order) {
		    alert('이동할 수 없습니다.');
		    return;
		  }

		  const targetId = targetRow.dataset.id;
		  const targetOrder = parseInt(targetRow.dataset.order);

		  // 서버에 순서 교환 요청
		  fetch('${contextPath}/menu/swapOrder', {
		    method: 'POST',
		    headers: { 'Content-Type': 'application/json' },
		    body: JSON.stringify({
		      currentId: currentId,
		      currentOrder: currentOrder,
		      targetId: targetId,
		      targetOrder: targetOrder
		    })
		  })
		  .then(res => res.json())
		  .then(result => {
		    if (result.success) {
		      location.reload(); // 새로고침으로 정렬 다시 불러오기
		    } else {
		      alert('순서 변경 실패');
		    }
		  });
	}


	const observer = new IntersectionObserver(entries => {
	  entries.forEach(entry => {
	    if (entry.isIntersecting) {
	      entry.target.classList.add('show');
	      observer.unobserve(entry.target);
	    }
	  });
	}, { threshold: 0.2 });

	document.querySelectorAll('.fade-up').forEach(section => {
	  observer.observe(section);
	});
	
	
	
</script>

<style>

#addMenuForm {
  display: none;
  background-color: #fefefe;
  margin-bottom: 40px;
  padding: 30px;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid #ddd;
  max-width: 600px;
  margin: 40px auto;
  font-family: 'Noto Sans KR', sans-serif;
}

#addMenuForm h3 {
  font-size: 24px;
  color: #452160;
  margin-bottom: 20px;
  text-align: center;
  font-weight: 600;
}

#addMenuForm label {
  display: block;
  margin-bottom: 6px;
  font-weight: 500;
  color: #333;
}

#addMenuForm input,
#addMenuForm textarea {
  width: 100%;
  padding: 12px 14px;
  font-size: 15px;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-sizing: border-box;
  margin-bottom: 20px;
  font-family: inherit;
  transition: border 0.3s ease;
}

#addMenuForm input:focus,
#addMenuForm textarea:focus {
  outline: none;
  border: 1px solid #452160;
}

#addMenuForm button {
  padding: 10px 24px;
  font-size: 15px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  margin-right: 10px;
  transition: background-color 0.3s ease, color 0.3s ease;
  font-weight: 500;
}

#addMenuForm button:first-of-type {
  background-color: #452160;
  color: #fff;
}

#addMenuForm button:first-of-type:hover {
  background-color: #5e2a80;
}

#addMenuForm button:last-of-type {
  background-color: #eee;
  color: #333;
}

#addMenuForm button:last-of-type:hover {
  background-color: #ddd;
}

.menu-container {
  max-width: 80%;
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

.menu-table table {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}

.menu-table th, .menu-table td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
}

.menu-table th {
  background-color: #452160;
  color:#fff;
  font-weight: bold;
}

.menu-table input[type="text"],
.menu-table input[type="number"],
.menu-table select {
  width: 90%;
  padding: 5px;
  font-size: 13px;
}

.menu-type-buttons {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 40px;
}

.menu-type-buttons button {
  padding: 10px 24px;
  font-size: 16px;
  border: 1px solid #452160;
  background-color: white;
  color: #452160;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}

.menu-type-buttons button:hover {
  background-color: #452160;
  color: white;
}

.btn-edit{
  padding: 5px 15px;
  font-size: 16px;
  border: 1px solid #452160;
  background-color: white;
  color: #452160;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}

.btn-delete{
  padding: 5px 15px;
  font-size: 16px;
  border: 1px solid red;
  background-color: white;
  color: red;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}
.btn-cancel{
  padding: 5px 15px;
  font-size: 16px;
  border: 1px solid red;
  background-color: white;
  color: red;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}

.btn-add{
  padding: 5px 15px;
  font-size: 16px;
  border: 1px solid #452160;
  background-color: white;
  color: #452160;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
  margin-bottom:20px;
  text-decoration:none;
}

.btn-order-up{
  	cursor: pointer;
	border:0px;
	background-color: white;
	color: #452160;
}

.btn-order-down{
  	cursor: pointer;
	border:0px;
	background-color: white;
	color: #452160;
}

.btn-add:hover{
  background-color: #452160;
  color: white;
}

.btn-edit:hover{
  background-color: #452160;
  color: white;
}
.btn-delete:hover{
  background-color: red;
  color: white;
}
.btn-cancel:hover{
  background-color: red;
  color: white;
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

.icon_box{
  display:flex;
  justify-content:center;
}

.icon_box img{
	width:50px;
	height:50px;
}
</style>

