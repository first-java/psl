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
<title>设置机台预做产品</title>
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
</head>
<body>
	<script type="text/javascript">
	
	
		function fun() {
			var s = document.getElementsByName("color");
			for (var i = 0; i < s.length; i++) {
				var color = s[i]
				var com = window.getComputedStyle ? window.getComputedStyle(color, null) : color.currentStyle;
				alert(com.backgroundColor);
				console.log(com.backgroundColor); //结果：rgb(0, 153, 153)
	
			}
	
		}
	</script>

	<input type="text" style="background: pink" id="color" name="color"
		value='点击按钮获取页面背景色' onclick="fun()" />
	<input type="text" style="background: red" name="color"
		value='点击按钮获取页面背景色' onclick="fun()" />
	<input type="text" style="background: yellow" name="color"
		value='点击按钮获取页面背景色' onclick="fun()" />
	<input type="text" style="background: blue" name="color"
		value='点击按钮获取页面背景色' onclick="fun()" />
	<input type="text" style="background: pink" " name="color"
		value='点击按钮获取页面背景色' onclick="fun()" />

</body>
</html>