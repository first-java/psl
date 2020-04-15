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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>已分光入库明细导出</title>
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
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('table').deleteRow(i);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			layer.load();
			var batch = $("#batch").prop("value");
			var endTime = $("#test12").prop("value");
			var startTime = $("#test11").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspkub.action?methodstr=notest", //5.1
				//提交的数据
				data : {
					"batch.lotId" : batch,
					"batch.startTime" : startTime,
					"batch.endTime" : endTime
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.msg("没有查到此批次信息！！", {
							icon : 2
						});
						return;
					}

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var createCategory = result.counter[i].createCategory;
						var categoryDesc = result.counter[i].categoryDesc;
						var instanceId = result.counter[i].instanceId;
						var instanceDesc = result.counter[i].instanceDesc;
						var lotCount = result.counter[i].lotCount;
						var nowQty = result.counter[i].nowQty;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='createCategory' id='createCategory' value=" + createCategory + " />" + createCategory + "</td><td>" +
							"<input type='hidden' name='categoryDesc' id='categoryDesc' value=" + categoryDesc + " />" + categoryDesc + "</td><td>" +
							"<input type='hidden' name='instanceId' id='instanceId' value=" + instanceId + " />" + instanceId + "</td><td>" +
							"<input type='hidden' name='instanceDesc' id='instanceDesc' value=" + instanceDesc + " />" + instanceDesc + "</td><td>" +
							"<input type='hidden' name='nowQty' id='nowQty' value=" + nowQty + " />" + nowQty + "</td><td>" +
							"<input type='hidden' name='lotCount' id='lotCount' value=" + lotCount + " />" + lotCount + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						$("#table").append(s);
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
	<form action="cspDownLoad.action?methodstr=downloadReport"
		method="post">
		<tr></tr>
		<tr>
			<td>下拉选择功能：<select style=""><option>请选择要导出的明细...</option></select></td>
			<td colspan="4">选择日期 从
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="test11"
							name="startTime" placeholder="yyyy/MM/dd">
					</div>
				</div>到
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="test12" name="endTime"
							placeholder="yyyy/MM/dd">
					</div>
				</div>
			</td>
			<input id="submitBtn" class='btn btn-primary' type="submit"
				value="导出" />
		</tr>
	</form>
	<table class="table table-striped table-bordered table-hover"
		id="table" width="50%">
		<thead>
			<tr>
				<th>LOT_ID</th>
				<th>CREATE_CATEGORY</th>
				<th>CATEGORY_DESC</th>
				<th>INSTANCE_ID</th>
				<th>INSTANCE_DESC</th>
				<th>NOW_QTY</th>
				<th>LOT_COUNT</th>
				<th>操作</th>
			</tr>
		</thead>
	</table>
	<br>
</body>
</html>
<script>
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
