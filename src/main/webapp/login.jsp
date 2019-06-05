<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<%
	//request.getContextPath(),获取当前项目路径，以/开头，不以/结束
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.4.0.min.js"></script>
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<!-- 管理员注册模态框 -->
	<div id="adminAddModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">用户注册</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" name="username" class="form-control"
									id="userName_add_input" placeholder="请输入用户名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" name="password" class="form-control"
									id="pwd_add_input" placeholder="请输入密码"> <span
									class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="reg_btn">确认注册</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<!-- 登录界面 -->
	<div id="div1" class="col-sm-offset-4 col-sm-3"
		style="background-color: #E0EEEE; border-radius: 20px; margin-top: 10%;">
		<h1>Welocme!</h1>
		<form class="form-horizontal">
			<div class="col-sm-offset-3">
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"> <span
					class="glyphicon glyphicon-screenshot" aria-hidden="true"></span>
				</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" name="userId" id="inputID"
						placeholder="ID" style="border-radius: 10px">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"> <span
					class="glyphicon glyphicon-user" aria-hidden="true"></span>
				</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" name="userName" id="inputName"
						placeholder="Username" style="border-radius: 10px">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"> <span
					class="glyphicon glyphicon-lock" aria-hidden="true"></span>
				</label>
				<div class="col-sm-8">
					<input type="password" class="form-control" name="userPwd" id="inputPassword"
						placeholder="Password" style="border-radius: 10px" height="100px">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label> <input type="checkbox">remeber me
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-success" id="signin_btn">Sign in</button>
					<button id="register_btn" type="button"
						class="btn btn-info col-sm-offset-2">register</button>
				</div>
			</div>
		</form>
	</div>

	<!-- 点击注册弹出注册模态框 -->
	<script type="text/javascript">
		$("#register_btn").click(function() {
			$("#adminAddModal").modal({
				backdrop : "static"
			});
		});
		
		
		//表单验证
		function validate_adduser_form(){
			var userName = $("#userName_add_input").val();
			//用户名格式应为2-5位中文或者4-10位子母数字组合
			var regUserName = /(^[a-zA-Z0-9_-]{3,10}$)|(^[\u2E80-\u9FFF]{2,5})/;
			var password = $("#pwd_add_input").val();
			//密码格式应为6-10位数字
			var regPwd = /^\d{6,10}$/;
			
			if(!regUserName.test(userName)){
				alert("用户名格式错误");
				return false;
			}else if(!regPwd.test(password)){
				alert("密码格式错误！");
				return false;
			}
			return true;
		}
		
		
		//点击确认注册，进行用户注册
		$("#reg_btn").click(function(){
			//校验用户名和密码信息
			if(!validate_adduser_form()){
				return false;
			};
			//发ajax请求保存用户信息
			//alert($("#adminAddModal form").serialize());
  			$.ajax({
				url:"${APP_PATH}/user",
				type:"POST",
				data:$("#adminAddModal form").serialize(),
				success:function(result){
					//1.关闭模态框		
					if(result.code == 1){
						$("#adminAddModal").modal('hide');
						alert("注册成功！");
					}
					
				}
				
			})
		
		});
		
/* 		function get_beforecheck(){
			var uId = $("#inputID").val();
			$.ajax({
				url:"${APP_PATH}/user/"+uId+"/info",
				type:"GET",
				success:function(result){
					if(result.code==1){
						//alert("YES");
						return true;
					}else{
						return false;
					}
				}
			})
			return true;
		} */
		
		
		//点击登录，进入主页面
		$("#signin_btn").click(function(){
			
			var InputId = $("#inputID").val();
			var	InputUserName = $("#inputName").val();
			var InputUserPwd = $("#inputPassword").val();
			
/* 			if(!get_beforecheck()){
				return false;
			}; */
			//alert($("#inputID").val());
			//alert($("#div1 form").serialize());
			
			//发送ajax请求查询数据库，验证登录
			//alert($("#div1 form").serialize());
  /*  			$.ajax({
				url:"${APP_PATH}/user2",
				type:"POST",
				data:$("#div1 form").serialize(),
				success:function(result){
					//alert($("#inputID").val()+$("#inputName").val()+$("#inputPassword").val());
					alert($("#div1 form").serialize());
				}
			})  */
			
			
 			$.ajax({
				url:"${APP_PATH}/user2/"+InputId+"/"+encodeURI(encodeURI(InputUserName))+"/"+InputUserPwd,
				type:"GET",
				success:function(result){
					if(result.code==1){
						//alert(InputUserName+" "+InputUserPwd);
						window.location="index.jsp";
						//alert(window.location.href);
					}else{
						//alert("fail"+" "+InputId+" "+InputUserName+" "+InputUserPwd);
						alert("用户名或密码错误！");
					}
				}
			}) 
			
			
		});
		
		
	</script>


</body>
</html>