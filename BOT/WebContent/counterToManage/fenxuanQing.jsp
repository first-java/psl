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
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>分选机清机</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

	$(document).ready(function() {

		$("#ajaxB").click(function() {
			layer.load();
			var workId = $("#workId").prop("value");
			var eqpt = $('select[name=eqpt] option:selected').val();

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "boliao.action?methodstr=fenxuanQing", //11.2
				//提交的数据
				data : {
					"boliao.workId" : workId,
					"boliao.eqpt" : eqpt
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					layer.open({
						title : '提示信息',
						content : result
					}, function() {
						window.location.reload();

					});

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

<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>
	<input type="hidden" id="workId" value="<%=workId%>">
	<div class="page-header">
		选择机台：<select id="eqpt" name="eqpt">
			<option>SORT001</option>
			<option>SORT002</option>
			<option>SORT003</option>
			<option>SORT004</option>
			<option>SORT005</option>
			<option>SORT006</option>
			<option>SORT007</option>
			<option>SORT008</option>
			<option>SORT009</option>
			<option>SORT010</option>
			<option>SORT011</option>
		</select> <input class="btn btn-primary" type="button" id="ajaxB" value="清机" />
	</div>
	<br>
</body>
</html>