<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String lotHead5 = (String) request.getParameter("lotHead5");//直接传递
	String createTime = (String) request.getParameter("createTime");//直接传递
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
<title>月度达成</title>
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/DatePicker.js"></script>
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
<script>

	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var month = $("#month").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=notest4", //5.1
				//提交的数据
				data : {
					"agreed1.month" : month
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.msg("没有查到信息！！", {
							icon : 2
						});
						return;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var LOT_ID = result.counter[i].LOT_ID; //产品
						var TRANCETIME = result.counter[i].C_MONTH; //年月
						var QTY = result.counter[i].JIAO_QTY; //交货需求量
						var OPERATION_DESC = result.counter[i].KU_QTY; //对应入库量
						var LOT_STATUS = result.counter[i].C_QTY; //达成差异
						if (LOT_STATUS < 0) {
							LOT_STATUS = 0;
						}

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id=lotId" + i + " value=" + LOT_ID + " />" + LOT_ID + "</td><td>" +
							"<input type='hidden'  name='adtime1' id='adtime1' value=" + TRANCETIME + " />" + TRANCETIME + "</td><td>" +
							"<input type='hidden'  name='yiled' id='yiled' value=" + QTY + " />" + QTY + "</td><td>" +
							"<input type='hidden'  name='qty' id='qty' value=" + OPERATION_DESC + " />" + OPERATION_DESC + "</td><td>" +
							"<input type='hidden'  name='JIAO_QTY' id='JIAO_QTY' value=" + LOT_STATUS + " />" + LOT_STATUS + "</td></tr>";
						$("#InputsWrapper").append(s);

					}

					var aInput = document.getElementsByName("JIAO_QTY");

					for (var i = 0; i < aInput.length; i++) {
						if (aInput[i].value == "0") {
							aInput[i].parentNode.parentNode.style.background = 'pink';
						}
					}

				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					layer.closeAll();
					alert("出错");
				//请求出错处理
				}
			});
		});
	});
</script>
</head>
<body>
	<input onclick="setmonth(this)" readonly="readonly" size="8" id="month" />

	<button class="btn btn-primary" id="ajaxA">查询数据</button>
	<table id="InputsWrapper">
		<tr>
			<td>产品</td>
			<td>年月</td>
			<td>交货需求量</td>
			<td>对应入库量</td>
			<td>达成差异</td>
		</tr>
	</table>
	<br>
</body>
</html>

<style>
table {
	width: 100%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	align: left;
}

body {
	padding-bottom: 0px;
	min-height: 100%;
	font-family: "Open Sans";
	font-size: 20px;
	line-height: 1.5;
	font-family: "Open Sans";
	font-size: 20px;
	font-size: 20px;
}

table tr:nth-child(1) {
	background: #73B1E0;
	color: #FFF;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}
</style>