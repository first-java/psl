<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var obj = $("#tapeId").prop("value");
			//将多个同name的值组成一个json数组字符串 
			var jsondata = "[";
			$("[name=filmNo]").each(function() {
				jsondata += '{"filmNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			jsondata = jsondata.replace(reg, "");
			jsondata += "]";

			var jsondata1 = "[";
			$("[name=qty]").each(function() {
				jsondata1 += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg1 = /,$/gi;
			jsondata1 = jsondata1.replace(reg1, "");
			jsondata1 += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tion.action?methodstr=notest", //自己的url
				//提交的数据
				data : {
					"filmNo" : jsondata,
					"qty" : jsondata1,
					"tapeId" : obj
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "沒有查到數據") {
						layer.msg("沒有查到數據", {
							icon : 2
						});
					}
					if (result == "补料数量大于总数量") {
						layer.msg("补料数量大于总数量", {
							icon : 2
						});
					}
					var result = eval("(" + result + ")");

					if (result.scroll.length < 1) {
						//alert("卷轴号有误！");setTimeout()
						//layer.confirm("dfdfdf","qw");
						layer.msg("卷轴号有误", {
							icon : 2
						});
					}

				},
				//调用执行后调用的函数
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});

		});
	});
</script>
<script>
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交rt(s);
	}
</script>
</head>
<body>
	<form id="myForm" action="<%=path%>/re.action?methodstr=select"
		method="post" enctype="multipart/form-data">
		<div class="widget-box">
			<div class="widget-header">
				<h4>查询</h4>
			</div>
			<div class="widget-body">
				<div class="widget-main">
					<table>
						<tr>
							<td><label for="form-field-8"><h4>用卷轴查询：</h4></label> <input
								placeholder="请输入卷轴" name="tapeId" /></td>
							<div>
								<label for="form-field-11"><h4>用创建时间查询</h4></label>
								<div class="center_top_date">
									<span>开始:</span>
									<div class="center_top_date_left">
										<input id="d12" name="startTime"
											onclick="WdatePicker({el:'d12',dateFmt:'yyyy/MM/dd'})"
											type="text" name="create_time_begin" readonly="true" /> <img
											onclick="WdatePicker({el:'d12',dateFmt:'yyyy/MM/dd'})"
											src="Theme/Scripts/My97DatePicker/skin/datePicker.gif"
											width="26" height="36" align="absmiddle">
									</div>
									<span>结束:</span>
									<div class="center_top_date_right">
										<input id="d13" name="endTime"
											onclick="WdatePicker({el:'d13',dateFmt:'yyyy/MM/dd'})"
											type="text" name="create_time_end" readonly="true" /> <img
											onclick="WdatePicker({el:'d13',dateFmt:'yyyy/MM/dd'})"
											src="Theme/Scripts/My97DatePicker/skin/datePicker.gif"
											width="26" height="36" align="absmiddle">
									</div>
									<hr>
							</tr>
						<tr>
							<td><label for="form-field-9"><h4>用蓝膜查询：</h4></label> <input
								placeholder="请输入蓝膜" name="filmNoq" /></td>

						</tr>
						<tr>
							<td><div>
									<input class="btn btn-primary" type="button" value="提交"
										onclick="check()" />

								</div></td>
						</tr>
					</table>

				</div>
			</div>
	</form>
</body>
</html>
