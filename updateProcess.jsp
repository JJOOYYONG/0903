<%@page import="com.exam.vo.BoardVO"%>
<%@page import="com.exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--post 파라미터값 한글처리--%>
<% request.setCharacterEncoding("utf-8"); %>

<%--boardVO자바빈 객체 생성 --%>
<jsp:useBean id="boardVO" class="com.exam.vo.BoardVO"/>

<%--자바빈 객체어 파라미터값 찾아서 저장--%>
<jsp:setProperty property="*" name="boardVO"/>

<%--pageNum 파라미터값 가져오기 --%>
<% String pageNum = request.getParameter("pageNum"); %>


<%

//DAO객체 준비
BoardDao boardDao = BoardDao.getInstance();

//BoardVO dbBoardVO=boardDao.getBoard(boardVO.getNum());

//*
//로그인 안한 사용자(글 패스워드 값이 있는 사용자)는
//패스워드 일치 여부를 확인 후 일치하면 글수정 하고,
//일치하지 않으면 "글 패스워드가 다름" 뒤로가기

if(boardVO.getPasswd()!=null){
	
	boolean isPasswdEqual = boardDao.isPasswdEqual(boardVO.getNum(),boardVO.getPasswd());
	
	if(!isPasswdEqual){//!boardVO.getPasswd().equls(dboardVO.getPasswd())
	%>
	<script>
	
	alert('글 패스워드가 다릅니다.');
	history.back();
	
	</script>
	
	<%	
	return; // 리턴을 안걸면 수정할 코드까지 같인 수행하게 됨
		}
	}//if

	//게시글 수정하기 메소드 호출
	boardDao.updateBoard(boardVO);
	
	//글목록 notice.jsp로 이동
	//response.sendRedirect("notice.jsp?pageNum="+pageNum);
	%>
	<script>
	alert('글 수정 성공!');
	location.href='notice.jsp?pageNum=<%=pageNum%>';
	</script>
	


