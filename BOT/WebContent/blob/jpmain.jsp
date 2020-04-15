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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>LBMAIN</title>
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var obj = $("#test1").prop("value");
			var obj2 = $("#test2").prop("value");
			if (obj == '') {
				layer.msg("请选择开始导出日期！", {
					icon : 2
				});
				return false;
			}
			if (obj2 == '') {
				layer.msg("请选择导出结束日期！", {
					icon : 2
				});
				return false;
			}
			var d1 = new Date(obj.replace(/\-/g, "\/"));
			var d2 = new Date(obj2.replace(/\-/g, "\/"));
			var datadiff = d2 - d1;
			var time = 30 * 24 * 60 * 60 * 1000;

			if (datadiff < 0 || datadiff > time) {
				layer.msg("日期间隔不能超过30天！", {
					icon : 2
				});
				return false;
			}
			if (obj != "" && obj2 != "" && d1 >= d2) {
				layer.msg("开始时间不能大于结束时间！", {
					icon : 2
				});
				return false;
			}
		})
	});
</script>

</head>
<body>
	<div class="div2">
		<form id="myForm" action="test1.action?methodstr=execute2"
			method="post" enctype="multipart/form-data">
			<table>
				<input type="hidden" name="targ" value="jpmain" /> 选择开始日期：
				<input type="Date" id="test1" name="startTime"
					placeholder="yyyy-MM-dd">选择结束日期：
				<input type="Date" name="endTime" id="test2"
					placeholder="yyyy-MM-dd">
				<tr>
					<td><button class="btn btn-primary" id="ajaxA" value="ss">导出备注</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//常规用法
		laydate.render({
			elem : '#test1'
		});

		//常规用法
		laydate.render({
			elem : '#test2'
		});


	});
</script>