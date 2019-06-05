<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	//request.getContextPath(),获取当前项目路径，以/开头，不以/结束
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.4.0.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD模板</h1>
			</div>
		</div>
			<!-- 按钮 -->
			<div class="row">
				<div class="col-md-4 col-md-offset-8">
					<button class="btn-success ">新增</button>
					<button class="btn-info">删除</button>
				</div>
			</div>
			<!-- 表格信息 -->
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped table-hover ">
					<tr>
						<th>^_^</th>
						<th>姓名</th>
						<th>性别</th>
						<th>email</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn-success btn-sm ">
									<span class="glyphicon glyphicon-pencil"></span>编辑
								</button>
								<button class="btn-info btn-sm">
									<span class="glyphicon glyphicon-trash"></span>删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
			<!-- 分页信息-->
			<div class="row">
			<div class="col-md-6">
				当前:${pageInfo.pageNum }页，总${pageInfo.pages }页,总${pageInfo.total }条记录
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						<c:if test="${pageInfo.hasPreviousPage}">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum -1}" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>

						<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num == pageInfo.pageNum }">
								<li class="active"><a href="#">${page_Num }</a></li>
							</c:if>
							<c:if test="${page_Num != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num }</a></li>
							</c:if>
						</c:forEach>
 						<c:if test="${pageInfo.hasNextPage}">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum +1}" aria-label="Next"> 
							 		<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if> 
						<li><a href="${APP_PATH }/emps/?pn=${pageInfo.pages}">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>