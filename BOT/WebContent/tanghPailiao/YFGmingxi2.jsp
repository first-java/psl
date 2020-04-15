
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<%
    String workId = (String) request.getParameter("workId");//直接传递
			String lotType = (String) request.getParameter("lotType");//直接传递
			String status = (String) request.getParameter("status");//直接传递
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
<title>待编带明细</title>

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
	<input type="hidden" id="ajaxA" /> &nbsp; &nbsp; &nbsp;
	<input class="btn btn-primary"
		onclick="downLoad('cspdaoru.action?methodstr=downloadYFGmingxi2')"
		value="导出清单">
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>袋号</th>
				<th>种类-ID-BIN</th>
				<th>数量</th>
				<th>入库日期</th>
				<th>分光批次号</th>
				<th>状态</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
			<input type="hidden" id="lotType" value="<%=lotType%>">
			<input type="hidden" id="status" value="<%=status%>">
		</thead>
	</table>
	<script type="text/javascript">
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var lotType = $("#lotType").prop("value");
				var t = lotType.split("-");
				var status = $("#status").prop("value");
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selYFGmingxi2", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.lotType" : t[0],
						"putIn.id" : t[1],
						"putIn.bin" : t[2],
						"putIn.status" : status,
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
	
	
							var bagname = result.counter[i].bagName;
							var lotType = result.counter[i].lotType;
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var mesQty = result.counter[i].mesQty;
							var qty = result.counter[i].qty;
							var createTime = result.counter[i].createTime;
							var lotId = result.counter[i].lotId;
							var status = result.counter[i].status;
							var r = lotType + "-" + id + "-" + bin;
							var flag = result.counter[i].flag;
	
							var adtimeq = "";
							if (createTime == null) {
								createTime = "";
							} else {
								var timeq = new Date(createTime.time);
								var yq = timeq.getFullYear();
								var mq = timeq.getMonth() + 1;
								var daq = timeq.getDate();
								var hq = timeq.getHours();
								var mmq = timeq.getMinutes();
								var sq = timeq.getSeconds();
								sq = sq < 10 ? '0' + sq : sq;
								adtimeq = yq + "-" + mq + "-" + daq + " " + hq + ":" + mmq + ":" + sq;
							}
	
	
							//袋号	种类-ID-BIN	数量	入库日期	分光批次号	状态
							if (flag != "1") {
								status = "NORMAL"
	
							} else {
								status = "HOLD"
							}
							s = "<tr name='sss'><td>" +
								bagname + "</td><td>" +
								lotType + "-" + id + "-" + bin + "</td><td>" +
								qty + "</td><td>" +
								adtimeq + "</td><td>" +
								lotId + "</td><td>" +
								status + "</td></tr>";
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
		var lotType = $("#lotType").prop("value");

		var status = $("#status").prop("value");
		//2、拼装URL+查询参数
		url = url + "&startTime=" + lotType + "&endTime=" + status;
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