
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
<title>各类在制明细</title>

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
<body onload="check();">

	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>

	输入种类查询：
	<input type="text" id="lotid" autocomplete="off">
	<button class="btn btn-primary" id="ajaxA">查询</button>
	<table>
		<tr>
			<td colspan="4"><input class="btn btn-primary"
				onclick="downLoad('cspdaoru.action?methodstr=downloadSelZaizong')"
				value="导出清单"></td>
		</tr>
	</table>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>类型</th>
				<th>静电袋号</th>
				<th>批次头</th>
				<th>BIN</th>
				<th>数量</th>
				<th>入库日期</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>


	</table>
	<script type="text/javascript">
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selZong", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.leiXing" : lotid
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
							var lotType = result.counter[i].lotType;
							var leiXing = result.counter[i].leiXing;
							var qty = result.counter[i].qty;
							var bin = result.counter[i].bin;
							var bagName = result.counter[i].bagName;
							var createtime = result.counter[i].createTime;
							var time = new Date(createtime.time);
							var y = time.getFullYear();
							var m = time.getMonth() + 1;
							var da = time.getDate();
							var h = time.getHours();
							var mm = time.getMinutes();
							var s = time.getSeconds();
							s = s < 10 ? '0' + s : s;
							var adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
	
							s = "<tr name='sss'><td>" + leiXing + "</a></td><td>" +
								bagName + "</td><td>" +
								lotType + "</td><td>" +
								bin + "</td><td>" +
								qty + "</td><td>" +
								adtime + "</td></tr>";
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
<script>
	function downLoad(url) {
		location.href = url;
	}
</script>