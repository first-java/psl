<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	String lotHead = (String) request.getParameter("lotHead");//直接传递
	String testName = (String) request.getParameter("testName");//直接传递
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
<title>设置颗粒数重量信息</title>
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
			var workId = $("#workId").prop("value");
			var qty = $("#qty").prop("value");
			var lotHead = $("#lotHead").prop("value");
			var weight = $("#weight").prop("value");
			var testName = $("#testName").prop("value");
			if (qty.trim() == "") {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				return false;
			}

			if (weight.trim() == "") {
				layer.msg("还没输入重量！", {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=cel", //11.2
				//提交的数据
				data : {
					"counter.qty" : qty,
					"counter.workId" : workId,
					"counter.weight" : weight,
					"counter.lotHead" : lotHead,
					"counter.testName" : testName
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result,
						function() {
							window.location.back();
						})
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
</head>

<body onload="check()">
	批次头：
	<input type="hidden" value="<%=workId%>">
	<input type="text" id="lotHead" readonly="readonly"
		value="<%=lotHead%>"> 测试档：
	<input type="text" id="testName" readonly="readonly"
		value="<%=testName%>"> 输入取样单重（g）：
	<input type="number" id="weight"> 输入取样颗粒（pcs）:
	<input type="number" id="qty">
	<button class="btn btn-primary" id="ajaxB">确定</button>
</body>
</html>
