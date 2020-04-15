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
<!doctype html>
<html lang="en">
<head>
<meta charset="U
TF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>页面名称</title>
<script type="text/javascript"
	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
</head>
<body>
	<table id="tab" border="1">
		<tr>
			<td>aaa</td>
			<td>aa1</td>
			<td>aa2</td>
		</tr>
		<tr>
			<td>bbb</td>
			<td>aa3</td>
			<td>aa4</td>
		</tr>
	</table>
	<input type="text" id="text" value="" />
	
	<input type="button" value="add" onclick="addtab();" />
	<script type="text/javascript">
		function addtab() {
			var tab = $("#tab");
			var str = $.trim($("#text").val());
			if (tab.find("td").filter(function() {
					return $.trim($(this).text()) == str;
				}).length > 0) {
				alert("有重复");
				return;
			}
			tab.append("<tr><td>" + str + "</td><td>" + str + "</td></tr>");
		}
	</script>
</body>
</html>
