<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
/* 페이드 인 */
.fade-up {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 1.2s ease-out, transform 1.2s ease-out;
}
.fade-up.show {
  opacity: 1;
  transform: translateY(0);
}

/* 상단 아이콘 */
.icon_box {
  display: flex;
  justify-content: center;
}
.icon_box img {
  width: 50px;
  height: 50px;
}

/* 테이블 헤더 스타일 */
table thead tr {
  background-color: black;
  color: white;
}

/* 테이블 테두리 */
table, th, td {
  border: 1px solid #e0e0e0;
  border-collapse: collapse;
}

/* tr 호버 시 볼록하게 */
.member-row {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
}
.member-row:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* 모달 스타일 */
#profileDetail {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  border: 1px solid #aaa;
  border-radius: 10px;
  padding: 25px 30px;
  width: 400px;
  max-width: 90%;
  z-index: 999;
  display: none;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

/* 모달 뒷배경 흐림 효과 (선택) */
#modalOverlay {
  display: none;
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 998;
}

  /* VIP 전용 스타일 */
  #profileDetail.vip {
    border: 5px solid black;
  }

  #profileDetail.vip #profileImagePreview {
    border: 2px solid black;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.6);
  }

  #profileDetail.vip #profileGrade {
    color: goldenrod;
    font-weight: bold;
  }

  @keyframes shine {
    from {
      box-shadow: 0 0 10px gold;
    }
    to {
      box-shadow: 0 0 20px orange;
    }
  }
	
  .update-btn{
  	width:128px;
  	height:31px;
  	background-color:white;
  	border:1px solid black;
  	color:black;
  	border-radius:5px;
  }
  
  .update-btn:hover{
  	background-color:black;
  	color:white;	
  }
  
  .search-btn{
    width:128px;
  	height:31px;
  	background-color:black;
  	border:1px solid black;
  	color:white;
  	border-radius:5px;
  }
  
  .search-btn:hover{
  	background-color:white;
  	color:black;	
  }
  .search-bar{
  	width: 300px;
  	height:31px;
  	border:1px solid black;
  	border-radius:5px;
  }
  
  .pagination-container {
  text-align: center;
  margin-top: 40px;
}

.pagination-container a,
.pagination-container span {
  display: inline-block;
  margin: 0 6px;
  padding: 8px 14px;
  font-size: 15px;
  border-radius: 8px;
  text-decoration: none;
  color: #fff;
  background-color: black;
  transition: background-color 0.3s, transform 0.2s;
}

.pagination-container a:hover {
  background-color: #444;
  transform: translateY(-2px);
}

.pagination-container .active-page {
  background-color: white;
  color: black;
  border: 3px solid black;
  font-weight: bold;
}
</style>

<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<div class="icon_box fade-up">
 	<h2>고객 관리</h2>
</div>
<div id="modalOverlay"></div>

<div class="fade-up" style="margin: 30px auto; max-width: 75%;">
  <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
  	<div style="display:flex; gap:10px;">
		<button type="button" class="update-btn" id="updateCustomer">고객 업데이트</button>
		<button type="button" class="update-btn" id="viplist">VIP 고객목록</button>
	</div>
	<div>
		<form action="${contextPath}/member/memberlist.do" method="get" style="text-align:center; margin-top: 20px;">
			<input class="search-bar" name="searchId" placeholder="아이디를 입력해 주세요.">
			<button type="submit" class="search-btn" id="searchBtn">검색</button>
		</form>
	</div>
  </div>
  <table style="width: 100%; border-collapse: collapse; text-align: center;">
    <thead>
      <tr>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">ID</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">로그인아이디</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">비밀번호</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">전화번호</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">이름</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">소셜</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="member" items="${memberList}">
       <c:if test="${member.login_id != 'admin'}">
        <tr class="member-row" data-member-id="${member.id}">
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.id}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">
		  	<c:forEach var="profile" items="${memberProfileList}">
		    	<c:if test="${profile.member_id == member.id && profile.grade == 'VIP'}">
		      		<img src="${contextPath}/resources/image/noir_icon.png" style="width:17px; height:17px; margin-left:5px; vertical-align:middle;" alt="VIP"/>
		    	</c:if>
		  	</c:forEach>
		  	${member.login_id}
		  </td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.password}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.phone}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.name}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">
            <c:choose>
              <c:when test="${not empty member.social_type}">
                ${member.social_type}
              </c:when>
              <c:otherwise>
                일반
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        </c:if>
      </c:forEach>
    </tbody>
  </table>
  
<c:set var="searchQuery" value="${not empty param.searchId ? '&searchId=' += param.searchId : ''}" />

<div class="pagination-container">
  <!-- Prev -->
  <c:if test="${currentPage > 1}">
    <a href="${contextPath}/member/memberlist.do?page=${currentPage - 1}${searchQuery}">&laquo; Prev</a>
  </c:if>

  <!-- Page numbers -->
  <c:forEach var="i" begin="1" end="${totalPages}">
    <c:choose>
      <c:when test="${i == currentPage}">
        <span class="active-page">${i}</span>
      </c:when>
      <c:otherwise>
        <a href="${contextPath}/member/memberlist.do?page=${i}${searchQuery}">${i}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <!-- Next -->
  <c:if test="${currentPage < totalPages}">
    <a href="${contextPath}/member/memberlist.do?page=${currentPage + 1}${searchQuery}">Next &raquo;</a>
  </c:if>
</div>
</div>

<!-- 🔹 회원 상세 프로필 모달 -->
<div id="profileDetail">
  <h3><span id="profileGrade" class=""></span></h3>
  <h4 style="text-align:center;">회원 상세 프로필</h4>

  <!-- 프로필 사진 -->
  <div style="text-align:center; margin-bottom:50px;">
    <img id="profileImagePreview" src="" alt="프로필 이미지"
         style="width:100px; height:100px; border-radius:50%; object-fit:cover; border:1px solid #ddd;">
  </div>
  <p><strong>총 소비 금액:</strong> <span id="profileSpent"></span>원</p>
  <p><strong>방문 횟수:</strong> <span id="profileVisits"></span>회</p>
  <p><strong>마지막 방문일:</strong> <span id="profileLastVisit"></span></p>
</div>

<script>

document.getElementById('updateCustomer').addEventListener('click', function () {
  // 전체 고객 등급/정보 갱신
  location.href = '${contextPath}/member/updateCustomerInfo.do';  // 컨트롤러에서 처리
});

document.getElementById('viplist').addEventListener('click', function () {
  // VIP 목록 보기
  location.href = '${contextPath}/member/vipList.do';  // VIP 고객 필터링된 리스트 보여주기
});

document.getElementById('searchBtn').addEventListener('click', function () {
  const keyword = document.querySelector('.search-bar').value.trim();
  if (!keyword) {
    alert("아이디를 입력해 주세요.");
    return;
  }
});

const memberMap = {};
<c:forEach var="member" items="${memberList}">
  memberMap["${member.id}"] = {
    profileImage: "${member.profileImage}"
  };
</c:forEach>

const memberProfileMap = {};
<c:forEach var="profile" items="${memberProfileList}">
  memberProfileMap["${profile.member_id}"] = {
    grade: "${profile.grade}",
    total_spent: ${profile.total_spent},
    visit_count: ${profile.visit_count},
    last_visit: "${profile.last_visit}"
  };
</c:forEach>

document.querySelectorAll('.member-row').forEach(row => {
  row.addEventListener('click', () => {
    const memberId = row.getAttribute('data-member-id');
    const profile = memberProfileMap[memberId];
    const memberData = memberMap[memberId];
    const imageTag = document.getElementById('profileImagePreview');
	
    const modal = document.getElementById('profileDetail');
    const gradeSpan = document.getElementById('profileGrade');

    if (profile.grade === 'VIP') {
      modal.classList.add('vip');
      gradeSpan.innerHTML = '<span class="vip-grade">👑 VIP</span>';
    } else {
      modal.classList.remove('vip');
      gradeSpan.innerText = profile.grade || '없음';
    }
    
    if (profile) {
      document.getElementById('profileGrade').innerText = profile.grade || '없음';
      document.getElementById('profileSpent').innerText = (profile.total_spent || 0).toLocaleString('ko-KR');
      document.getElementById('profileVisits').innerText = profile.visit_count || 0;
      document.getElementById('profileLastVisit').innerText = profile.last_visit || 'N/A';
	  
      //여기에서 memberMap에서 프로필 이미지 경로 꺼냄
      const memberData = memberMap[memberId];
      const imageTag = document.getElementById('profileImagePreview');
      const profileImg = memberData?.profileImage;

      if (profileImg && profileImg.startsWith('http')) {
        // 외부 URL
        imageTag.src = profileImg;
      } else if (!profileImg || profileImg === 'null') {
        // 기본 이미지
        imageTag.src = '${contextPath}/resources/image/noir_icon.png';
      } else {
        // 서버 내부 업로드 이미지
        imageTag.src = '${contextPath}/upload/profile/' + profileImg;
      }
      
      document.getElementById('profileDetail').style.display = 'block';
      document.getElementById('modalOverlay').style.display = 'block';
    } else {
      alert('해당 회원의 상세정보가 없습니다.');
    }
  });
});

// 모달 외부 클릭 시 닫기
document.getElementById('modalOverlay').addEventListener('click', () => {
  document.getElementById('profileDetail').style.display = 'none';
  document.getElementById('modalOverlay').style.display = 'none';
});
// 페이드 인 효과
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
