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

	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName"class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email"class="form-control" id="email_add_input" placeholder="email@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工性别</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工部门</label>
			    <div class="col-sm-4">
			    <!-- 部门提交部门ID -->
				 <select class="form-control" name="dId"></select>
			    </div>
			  </div>
			</form>
						
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	   	<div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工信息更改</h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工姓名</label>
			    <div class="col-sm-10">
				  <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email"class="form-control" id="email_update_input" placeholder="email@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工性别</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工部门</label>
			    <div class="col-sm-4">
			    <!-- 部门提交部门ID -->
				 <select class="form-control" name="dId"></select>
			    </div>
			  </div>
			</form>
	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
				
	
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
					<button class="btn-success " id="emp_add_modal_btn">新增</button>
					<button class="btn-info" id="emp_deleteall_btn">删除</button>
				</div>
			</div>
			<!-- 表格信息 -->
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped table-hover " id="emps_table">
						<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all" />
							</th>
							<th>^_^</th>
							<th>姓名</th>
							<th>性别</th>
							<th>email</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
						</thead>
						<tbody>	</tbody>
					</table>
				</div>
			</div>
			
			<!-- 显示分页信息-->
			<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"> </div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		
		var totalRecord,currentPage;
		//1.页面加载完成后，直接发送一个ajax请求，要到分页数据
		$(function(){
			//首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示员工
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					build_page_nav(result);					
				}
			});
		}
		
		
		function build_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
				var empIdTD = $("<td></td>").append(item.empId);
				var empNameTD = $("<td></td>").append(item.empName);
				var genderTD = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTD = $("<td></td>").append(item.email);
				var deptName = $("<td></td>").append(item.department.deptName);
				
				var editBtn = $("<button></button>").addClass("btn-success btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil").append(" ").append("编辑"));
				//为编辑按钮添加自定义属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn-info btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash").append(" ").append("删除"));
				//为删除按钮添加自定义属性，来表示当前员工id
				delBtn.attr("del-id",item.empId);
				var btnTD = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append方法执行完成后，还是返回原来的元素（此处还是返回同一个tr）
				$("<tr></tr>").append(checkBoxTd)
							  .append(empIdTD)
							  .append(empNameTD)
							  .append(genderTD)
							  .append(emailTD)
							  .append(deptName)
							  .append(btnTD)
							  .appendTo("#emps_table tbody");
			});
		}
		
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页，共"
					+result.extend.pageInfo.pages+"页,共"
					+result.extend.pageInfo.total+"条记录")
					totalRecord = result.extend.pageInfo.total;
					currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条,点击事件
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage==false){
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}

			
			//添加首页、前一页
			ul.append(firstPageLi).append(prePageLi);
			//添加页码
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页、末页
			ul.append(nextPageLi).append(lastPageLi);
			//把ul添加到nav中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		} 
		
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//表单完整重置(表单数据，表单样式)
			reset_form("#empAddModal form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有的部门信息，并显示在下拉列表中
		function getDepts(ele){
			//清空下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result)
					//显示部门信息在下拉列表中
 					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_form(){
			//1.拿到要校验的数据，使用正则表达式
			//校验用户名信息
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名格式应为2-15位中文或者6-16位子母数字组合！")
				show_validate_msg("#empName_add_input","error","用户名格式必须为2-15位中文或者6-16位字母数字组合!")
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","")
			};
			//校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("请输入正确邮箱格式！")
				show_validate_msg("#email_add_input","error","请输入正确邮箱格式！")
				return false;
			}else{
				show_validate_msg("#email_add_input","success","")
			};
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//先清除当前元素校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			};
		}
		
		$("#empName_add_input").change(function(){
			//发送ajax请求，校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",	
				success:function(result){
					if(result.code==1){
						show_validate_msg("#empName_add_input","success","用户名可用^_^");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//点击保存员工信息
		$("#emp_save_btn").click(function(){
			//1.模态框中填写的表单数据提交给服务器进行保存
			// 先对提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			};
			//1.判断之前的ajax用户名校验是否成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			};
			//2.发送ajax请求保存员工
			//alert($("#empAddModal form").serialize());
   			$.ajax({
			url:"${APP_PATH}/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(result){
				//alert(result.msg);
				//员工保存成功后：
				if(result.code == 1){
					//1.关闭模态框			
					$("#empAddModal").modal('hide');
					//2.来到最后一页，显示保存的数据。
					//发送ajax请求显示最后一页数据即可
					to_page(totalRecord);
				}else{
					//显示失败信息
					//console.log(result);
					//有哪个字段的错误信息，就显示哪个字段
					if(undefined != result.extend.errorFields.email){
						//显示邮箱错误信息
						show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
					}
					if(undefined != result.extend.errorFields.empName){
						//显示员工名字错误信息
						show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
					}
				}	
			}
			});  
		});
		
		//1.可以在创建按钮的时候绑定事件(耦合性高)  2.绑定点击.live()
		//jquery新版没有live，使用on进行替代
		$(document).on("click",".edit_btn",function(){
			//alert("hhh");
			//1.查出部门信息，并显示
			getDepts("#empUpdateModal select");
			//2.查出员工信息，并显示
			getEmp($(this).attr("edit-id"));
			
			//3.把员工的id信息传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//1.验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","请输入正确邮箱格式！")
				return false;
			}else{
				show_validate_msg("#email_update_input","success","")
			};
			
			//2.发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1.关闭对话框
					$("#empUpdateModal").modal('hide');
					//2.回到本页面
					to_page(currentPage);
				}
			})
			
		});
		
		//点击删除，弹出删除模态框
		$(document).on("click",".delete_btn",function(){
			//1.弹出确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				//确认，发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				})
			}	
			//把员工的id信息传给模态框的删除按钮
		});
		
		
		//点击确认删除，删除员工
		$("#emp_delete_btn").click(function(){
			//alert("hello");
			var empId = $(this).attr("delete-id");
			$.ajax({
				url:"${APP_PATH}/emp"+empId,
				type:"DELETE",
				success:function(result){
					alert("删除成功！")
				}
			});
			
		});
		
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked总是undefined
			//这些dom原生的属性使用prop获取值，attr用来获取自定义属性的值
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//每个check_item
		$(document).on("click",".check_item",function(){
			//判断当前页面中元素是否全部被选择
			var flag = $(".check_item:checked").length==$(".check_item").length
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，批量删除选中的元素
		$("#emp_deleteall_btn").click(function(){
			var empNames = "";
			var del_idstr= "";
			$.each($(".check_item:checked"),function(){
				//组装员工名字字符串
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除名字字符串最后多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			//去除id字符串最后多余的-
			del_idstr.substring(0,del_idstr.length-1);
			if(empNames != ""){
				if(confirm("确认删除【"+empNames+"】吗? ")){
					//发送ajax请求确认删除
					$.ajax({
						url:"${APP_PATH}/emp/"+del_idstr,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							//回到当前页面
							to_page(currentPage);
						}
					})
				}
			}

		});
		
	</script>
	
</body>
</html>