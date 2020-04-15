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
<title>入库达成</title>
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
<script>
	function check() {
		$("#ajaxA").click();
	}

	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var lotHead5 = $("#lotHead5").prop("value");
			var createTime = $("#createTime").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=notest3", //5.1
				//提交的数据
				data : {
					"agreed1.lotId" : lotHead5,
					"agreed1.createTimes" : createTime
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
						var LOT_ID = result.counter[i].LOT_ID; //批次号
						//var CREATETIME = result.counter[i].CREATETIME; //创批时间
						var TRANCETIME = result.counter[i].TRANCETIME; //固晶时间
						//var UNIT_ID = result.counter[i].UNIT_ID; //底板号
						var QTY = result.counter[i].QTY; //底板数量
						var OPERATION_DESC = result.counter[i].OPERATION_DESC; //所在工步
						var LOT_STATUS = result.counter[i].LOT_STATUS; //批次状态


						/* var time = new Date(CREATETIME.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var CREATETIME1 = y + "-" + m + "-" + da; //投入时间 */

						var time1 = new Date(TRANCETIME.time);
						var y1 = time1.getFullYear();
						var m1 = time1.getMonth() + 1;
						var da1 = time1.getDate();
						var h1 = time1.getHours();
						var mm1 = time1.getMinutes();
						var s1 = time1.getSeconds();
						s1 = s1 < 10 ? '0' + s1 : s1;
						var TRANCETIME1 = y1 + "-" + m1 + "-" + da1; //投入时间

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id=lotId" + i + " value=" + LOT_ID + " />" + LOT_ID + "</td><td>" +
							"<input type='hidden'  name='adtime1' id='adtime1' value=" + TRANCETIME1 + " />" + TRANCETIME1 + "</td><td>" +
						//	"<input type='hidden'  name='cycle' id='cycle' value=" + UNIT_ID + " />" + UNIT_ID + "</td><td>" +
							"<input type='hidden'  name='yiled' id='yiled' value=" + QTY + " />" + QTY + "</td><td>" +
							"<input type='hidden'  name='qty' id='qty' value=" + OPERATION_DESC + " />" + OPERATION_DESC + "</td><td>" +
							"<input type='hidden'  name='JIAO_QTY' id='JIAO_QTY' value=" + LOT_STATUS + " />" + LOT_STATUS + "</td></tr>";
						$("#InputsWrapper").append(s);

					}

					var aInput = document.getElementsByName("zheng");

					for (var i = 0; i < aInput.length; i++) {
						if (aInput[i].value == "未达成") {
							aInput[i].parentNode.parentNode.style.background = 'pink';
						}
						if (aInput[i].value == "已达成") {
							aInput[i].parentNode.parentNode.style.background = 'yellow';
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
<body onload="check()">
	<input type="hidden" id="lotHead5" value="<%=lotHead5%>" />
	<input type="hidden" id="createTime" value="<%=createTime%>" />

	<input type="hidden" id="ajaxA">
	<table id="InputsWrapper">
		<tr>
			<td>批次号</td>
			<td>固晶时间</td>
		
			<td>底板数量</td>
			<td>所在工步</td>
			<td>批次状态</td>
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