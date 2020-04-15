
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
<title>震动盘编带机看板</title>

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
	输入机台号查询：
	<input type="text" id="lotid" autocomplete="off">
	<button class="btn btn-primary" id="ajaxA">查询</button>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>编带批次号</th>
				<th>创建时间</th>
				<th>种类</th>
				<th>ID</th>
				<th>BIN</th>
				<th>总派出</th>
				<th>总投入</th>
				<th>卷轴产出</th>
				<th>编带尾料</th>
				<th>膜面不良</th>
				<th>电极面不良</th>
				<th>编带落地料</th>
				<th>总产出</th>
				<th>在制</th>
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
				/* var shelfName = $("#shelfName").prop("value");
				 */
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selzdpbd", //11.2selectShelft
					//提交的数据
					data : {
						"eqpt.bdLotId" : lotid
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
	
						if (result.counter.length == 0) {
							layer.alert("没有查到数据！", {
								icon : 2
							}, function() {
								layer.closeAll();
							});
						}
	
						for (var i = 0; i < result.counter.length; i++) {
	
							var bdLotId = result.counter[i].bdLotId;
							var createtime = result.counter[i].createTime;
							var lotType = result.counter[i].lotType;
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var zongPai = result.counter[i].zongPai;
							var inQty = result.counter[i].inQty;
							var tapeOutQty = result.counter[i].tapeOutQty;
							var weiliao = result.counter[i].weiliao;
							var momian = result.counter[i].momian;
							var dianji = result.counter[i].dianji;
							var diliao = result.counter[i].diliao;
							var zongQty = result.counter[i].zongQty;
							var nowDieQty = result.counter[i].nowDieQty;
							var adtime = "";
							var time = new Date(createtime.time);
							var y = time.getFullYear();
							var m = time.getMonth() + 1;
							var da = time.getDate();
							var h = time.getHours();
							var mm = time.getMinutes();
							var s = time.getSeconds();
							s = s < 10 ? '0' + s : s;
							adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
	
							s = "<tr name='sss'><td>" + bdLotId + "</td><td>" +
								adtime + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								zongPai + "</td><td>" +
								inQty + "</td><td>" +
								tapeOutQty + "</td><td>" +
								weiliao + "</td><td>" +
								momian + "</td><td>" +
								dianji + "</td><td>" +
								diliao + "</td><td>" +
								zongQty + "</td><td>" +
								nowDieQty + "</td></tr>";
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