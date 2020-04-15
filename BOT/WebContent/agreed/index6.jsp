<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	String lotHead5 = (String) request.getParameter("lotHead5");
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
<title></title>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(function() {

		$("#ajaxC").click(function() {
			var lotHead5 = $("#lotHead5").prop("value");
			var cycle = $("#cycle").prop("value");
			var yield = $("#yield1").prop("value");
			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=updBasics", //5.1
				//提交的数据
				data : {
					"agreed.lotHead5" : lotHead5,
					"agreed.cycle" : cycle,
					"agreed.yield" : yield,
					"agreed.workId" : workId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'success') {
						layer.alert("设置成功！");

						return false;
					} else {
						layer.alert("设置失败！");
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
	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '800px', '500px' ],
			content : "<%=request.getContextPath()%>/csp_ku/index9.jsp?workId='" + opt + "'"
		});

	}
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
</script>
</head>
<body>
	<div class="page-header">
		<table align="left">
			<tr>
				<td id="tt">5位批次头：</td>
				<td><input readonly="readonly" id="lotHead5" type="text"
					value="<%=lotHead5%>"></td>
			</tr>
			<tr>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
				<td>周期：</td>
				<td><input id="cycle"
					onkeyup="javascript:CheckInputIntFloat(this);" type="text"></td>
			</tr>
			<tr>
				<td>良率：</td>
				<td><input id="yield1"
					onkeyup="javascript:CheckInputIntFloat(this);" type="number"
					step="0.01"></td>
			</tr>
			<tr>
				<td>
					<button class="btn btn-primary" id="ajaxC">确认</button>
				</td>
			</tr>
		</table>
	</div>
	<br>
</body>
</html>