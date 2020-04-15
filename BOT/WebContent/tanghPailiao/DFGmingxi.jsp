
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
<title>待分光明细</title>

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

	<input type="text" id="lotid" autocomplete="off">
	<button class="btn btn-primary" id="ajaxA">查询</button>
	&nbsp; &nbsp; &nbsp;
	<input class="btn btn-primary"
		onclick="downLoad('cspdaoru.action?methodstr=downloadDFGmingxi')"
		value="导出清单">
	<input type="checkbox" id="flag" onclick='fff()'>包含HOLD状态
	<input type="text" id="ajaxB" class="btn btn-primary" value="下一页" />
	<input type="text" id="ajaxC" class="btn btn-primary" value="上一页" />
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<input type="hidden" id="page" value='20'>
		<thead>
			<tr>
				<th>序号</th>
				<th>种类</th>
				<th>状态</th>
				<th>数量</th>
				<th>袋数</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		function fff() {
			//	var page = $("#page").prop("value");
			var paggdown = Number(20);
			var status1 = "";
	
			if ($("input[type='checkbox']").is(':checked') == true) {
				status1 = "1";
	
			} else {
				status1 = "0";
			}
			layer.load();
	
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selDFGmingxi", //11.2selectShelft
				//提交的数据
				data : {
					"putIn.startTime" : "0",
					"putIn.endTime" : paggdown,
					"putIn.status" : status1
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
						var lotId = result.counter[i].lotType;
						var mesQty = result.counter[i].mesQty;
						var qty = result.counter[i].qty;
						var flag = result.counter[i].flag;
						var id = result.counter[i].id;
						$("#page").val(Number(id));
						if (flag != 1) {
							flag = "NORMAL"
	
						} else {
							flag = "HOLD"
						}
						if (status1 == "1") {
	
							flag = "NORMAL/HOLD"
						}
						s = "<tr name='sss'><td>" + id + "</td>" + "<td><a href=DFGmingxi2.jsp?lotId=" + lotId + "&status=" + status1 + "> " + lotId + "</a></td><td>" + flag + "</td><td>" +
							mesQty + "</td><td>" +
							qty + "</td></tr>";
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
	
		}
	
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var lotType = $("#lotid").prop("value");
				var status1 = "";
				if ($("input[type='checkbox']").is(':checked') == true) {
					status1 = "1";
	
				} else {
					status1 = "0";
				}
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selDFGmingxi", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : "0",
						"putIn.endTime" : paggdown,
						"putIn.status" : status1,
						"putIn.lotType" : lotType
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
							var lotId = result.counter[i].lotType;
							var mesQty = result.counter[i].mesQty;
							var qty = result.counter[i].qty;
							var id = result.counter[i].id;
							$("#page").val(Number(id));
							var flag = result.counter[i].flag;
							if (flag != 1) {
								flag = "NORMAL"
	
							} else {
								flag = "HOLD"
							}if (status1 == "1") {
	
							flag = "NORMAL/HOLD"
						}
							s = "<tr name='sss'><td>" + id + "</td>" + "<td><a href=DFGmingxi2.jsp?lotId=" + lotId + "&status=" + status1 + "> " + lotId + "</a></td><td>" + flag + "</td><td>" +
								mesQty + "</td><td>" +
								qty + "</td></tr>";
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
			$("#ajaxB").click(function() {
				layer.load();
				var status1 = "";
				if ($("input[type='checkbox']").is(':checked') == true) {
					status1 = "1";
	
				} else {
					status1 = "0";
				}
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var paggdown1 = Number(page) + 20;
				var lotType = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selDFGmingxi", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.lotType" : lotType,
						"putIn.startTime" : paggdown,
						"putIn.status" : status1,
						"putIn.endTime" : paggdown1
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
							var lotId = result.counter[i].lotType;
							var mesQty = result.counter[i].mesQty;
							var qty = result.counter[i].qty;
							var id = result.counter[i].id;
							$("#page").val(Number(id));
							var flag = result.counter[i].flag;
							if (flag != 1) {
								flag = "NORMAL"
	
							} else {
								flag = "HOLD"
							}if (status1 == "1") {
	
							flag = "NORMAL/HOLD"
						}
							s = "<tr name='sss'><td>" + id + "</td>" + "<td><a href=DFGmingxi2.jsp?lotId=" + lotId + "&status=" + status1 + "> " + lotId + "</a></td><td>" + flag + "</td><td>" +
								mesQty + "</td><td>" +
								qty + "</td></tr>";
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
			$("#ajaxC").click(function() {
				layer.load();
				var status1 = "";
				if ($("input[type='checkbox']").is(':checked') == true) {
					status1 = "1";
	
				} else {
					status1 = "0";
				}
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
				var lotType = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selDFGmingxi", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.lotType" : lotType,
						"putIn.startTime" : paggdown,
						"putIn.status" : status1,
						"putIn.endTime" : paggdown1
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
							var lotId = result.counter[i].lotType;
							var mesQty = result.counter[i].mesQty;
							var qty = result.counter[i].qty;
							var id = result.counter[i].id;
							$("#page").val(Number(id));
							var flag = result.counter[i].flag;
							if (flag != 1) {
								flag = "NORMAL"
	
							} else {
								flag = "HOLD"
							}if (status1 == "1") {
	
							flag = "NORMAL/HOLD"
						}
							s = "<tr name='sss'><td>" + id + "</td>" + "<td><a href=DFGmingxi2.jsp?lotId=" + lotId + "&status=" + status1 + "> " + lotId + "</a></td><td>" + flag + "</td><td>" +
								mesQty + "</td><td>" +
								qty + "</td></tr>";
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
		//1、获得查询参数
		var status = $('select[name=leixing] option:selected').val();
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");
		if (status == "日期类型...") {
			layer.alert("还没选择要以哪个日期为导出日期类型！", {
				icon : 2
			});
			return;
		}
		if (startTime == '') {
			layer.msg("还没选择开始日期", {
				icon : 2
			});
			return;
		}
		if (endTime == '') {
			layer.msg("还没选择结束日期", {
				icon : 2
			});
			return;
		}

		//2、拼装URL+查询参数
		url = url + "&startTime=" + startTime + "&endTime=" + endTime + "&status=" + status;
		//3、使用document.local.href=URL

		location.href = url;
	}
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//自定义格式
		laydate.render({
			elem : '#test11',
			format : 'yyyy/MM/dd'
		});
		//自定义格式
		laydate.render({
			elem : '#test12',
			format : 'yyyy/MM/dd'
		});

	});
</script>