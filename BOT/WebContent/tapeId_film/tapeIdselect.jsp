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
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查詢</title>
<script>
	function check() {

		//1、获得查询参数
		var query = document.getElementById("filmNoq");
		var querys = document.getElementById("tapeId");
		var d12 = document.getElementById("d12");
		var d13 = document.getElementById("d13");
		if ((query.value == null || query.value == "") && (querys.value == null || querys.value == "")
			&& (d12.value == null || d12.value == "") && (d13.value == null || d13.value == "")) {
			layer.msg("还没输入查询参数", {
				icon : 2
			}, function() {
				window.location.reload();
			});
			return false;
		}



		document.getElementById('myForm').submit(); //进行表单提交rt(s);
	}
</script>
</head>
<body>
	<form id="myForm" action="<%=path%>/ret.action?methodstr=select"
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
								placeholder="请输入卷轴" name="tapeId" id="tapeId" /></td>
							<div>
								<label for="form-field-11"><h4>用创建时间查询</h4></label>
								<div class="center_top_date">
									<span>开始:</span>
									<div class="center_top_date_left">
										<input id="d12" name="startTime"
											onclick="WdatePicker({el:'d12',dateFmt:'yyyy/MM/dd'})"
											type="text" name="create_time_begin" readonly="true" /> <img
											onclick="WdatePicker({el:'d12',dateFmt:'yyyy/MM/dd'})"
											src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/skin/datePicker.gif"
											width="26" height="36" align="absmiddle">
									</div>
									<span>结束:</span>
									<div class="center_top_date_right">
										<input id="d13" name="endTime"
											onclick="WdatePicker({el:'d13',dateFmt:'yyyy/MM/dd'})"
											type="text" name="create_time_end" readonly="true" /> <img
											onclick="WdatePicker({el:'d13',dateFmt:'yyyy/MM/dd'})"
											src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/skin/datePicker.gif"
											width="26" height="36" align="absmiddle">
									</div>
									<hr>
						</tr>
						<tr>
							<td><label for="form-field-9"><h4>用蓝膜查询：</h4></label> <input
								placeholder="请输入蓝膜" name="filmNoq" id="filmNoq" /></td>

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
