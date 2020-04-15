
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
<title>在制汇总L6</title>

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
				onclick="downLoad('cspdaoru.action?methodstr=downloadL6')"
				value="导出清单"></td>
			<input type="text" id="ajaxB" class="btn btn-primary" value="下一页" />
			<input type="text" id="ajaxC" class="btn btn-primary" value="上一页" />
		</tr>
	</table>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>序号</th>
				<th>种类</th>
				<th>待分光散芯</th>
				<th>在分光散芯</th>
				<th>已分光（良品）</th>
				<th>已分光（不良品）</th>
				<th>已分光（废料）</th>
				<th>在编带散芯</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
		<input type="hidden" id="page" value='20'>

	</table>
	<script type="text/javascript">
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selL6", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : "0",
						"putIn.endTime" : paggdown,
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
							var qty = result.counter[i].qty;
							var now_die_qty = result.counter[i].now_die_qty;
							var goodbin_qty = result.counter[i].goodbin_qty;
							var ng_qty = result.counter[i].ng_qty;
							var odd = result.counter[i].odd;
							$("#page").val(Number(odd));
							var fl_qty = result.counter[i].fl_qty;
							var sc_qty = result.counter[i].sc_qty;
							s = "<tr name='sss'><td>" +
								odd + "</td><td>" + lotType + "</a></td><td>" +
								qty + "</td><td>" +
								now_die_qty + "</td><td>" +
								goodbin_qty + "</td><td>" +
								ng_qty + "</td><td>" +
								fl_qty + "</td><td>" +
								sc_qty + "</td></tr>";
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
	
			});$("#ajaxB").click(function() {
				layer.load();
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var paggdown1 = Number(page) + 20;
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selL6", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : paggdown,
						"putIn.endTime" : paggdown1,
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
							var qty = result.counter[i].qty;
							var now_die_qty = result.counter[i].now_die_qty;
							var goodbin_qty = result.counter[i].goodbin_qty;
							var ng_qty = result.counter[i].ng_qty;
							var odd = result.counter[i].odd;
							$("#page").val(Number(odd));
							var fl_qty = result.counter[i].fl_qty;
							var sc_qty = result.counter[i].sc_qty;
							s = "<tr name='sss'><td>" +
								odd + "</td><td>" + lotType + "</a></td><td>" +
								qty + "</td><td>" +
								now_die_qty + "</td><td>" +
								goodbin_qty + "</td><td>" +
								ng_qty + "</td><td>" +
								fl_qty + "</td><td>" +
								sc_qty + "</td></tr>";
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
	
			});$("#ajaxC").click(function() {
				layer.load();
				var page = $("#page").prop("value");
				var paggdown = Number(page) - 40;
				if (paggdown < 0) {
					layer.alert("不能再上一页", {
						icon : 2
					}, function() {
						layer.closeAll();
					});
					return;
				}
				var paggdown1 = Number(page) - 20;
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selL6", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : paggdown,
						"putIn.endTime" : paggdown1,
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
							var qty = result.counter[i].qty;
							var now_die_qty = result.counter[i].now_die_qty;
							var goodbin_qty = result.counter[i].goodbin_qty;
							var ng_qty = result.counter[i].ng_qty;
							var odd = result.counter[i].odd;
							$("#page").val(Number(odd));
							var fl_qty = result.counter[i].fl_qty;
							var sc_qty = result.counter[i].sc_qty;
							s = "<tr name='sss'><td>" +
								odd + "</td><td>" + lotType + "</a></td><td>" +
								qty + "</td><td>" +
								now_die_qty + "</td><td>" +
								goodbin_qty + "</td><td>" +
								ng_qty + "</td><td>" +
								fl_qty + "</td><td>" +
								sc_qty + "</td></tr>";
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