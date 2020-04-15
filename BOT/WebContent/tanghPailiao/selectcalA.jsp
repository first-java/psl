
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
<!DOCTYPE html>
<html class="signin no-js" lang="zh">
<head>
<link type="favicon" rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="description" content="postek browser printer">
<meta name="keywords" content="postek">
<title>修改颗粒数重量信息</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
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
</head>
<body>
	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>

	<div class="page-header">
		<h1>输入信息查询</h1>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td><input autocomplete="off" type="text" id="lotHead"
					onkeyup="this.value=this.value.toUpperCase()"
					onfocus="this.select()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">查询</button>
				</td>
			</tr>
		</table>
	</div>

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>批次头</th>
				<th>单颗重量</th>
				<th>ID</th>
				<th>良品BIN</th>
				<th>NG品BIN</th>
				<th>报废BIN</th>
				<th>色温显指</th>
				<th>卷轴号前4位</th>
				<th>卷轴数量</th>
				<th>程序名</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				var lotHead = $("#lotHead").prop("value");
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selectcel", //11.2
					//提交的数据
					data : {
						"eqpt.lotHead" : lotHead
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
	
							var lotHead = result.counter[i].lotHead;
							var eachWeight = result.counter[i].eachWeight;
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var sexian = result.counter[i].sexian;
							var barcode = result.counter[i].barcode;
							var qty = result.counter[i].qty;
							var ngBin = result.counter[i].ngBin;
							var baofeiBin = result.counter[i].baofeiBin;
							var project1 = result.counter[i].project1;
	
							s = "<tr name='sss'><td>" + lotHead + "</td><td>" +
								eachWeight + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								ngBin + "</td><td>" +
								baofeiBin + "</td><td>" +
								sexian + "</td><td>" +
								barcode + "</td><td>" +
								qty + "</td><td>" +
								project1 + "</td><td>" +
								"<a href='index6.jsp?lotHead=" + lotHead + " '>修改</a></td></tr>";
							$("#sample-table-1").append(s);
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
</body>
</html>