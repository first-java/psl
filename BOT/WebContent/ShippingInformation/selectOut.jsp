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
<title>出库查询</title>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

	$(document).ready(function() {
		$("#ajaxC").click(function() {
			var obj = $("#test1").prop("value");
			var obj2 = $("#test2").prop("value");
			var barcodeType = $('#con option:selected').val();

			var d1 = new Date(obj.replace(/\-/g, "\/"));
			var d2 = new Date(obj2.replace(/\-/g, "\/"));

			if (obj != "" && obj2 != "" && d1 >= d2) {
				layer.msg("开始时间不能大于结束时间！", {
					icon : 2
				});
				return false;
			}
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=queryOutTime", //自己的url
				//提交的数据
				data : {
					"startTime" : obj,
					"endTime" : obj2,
					"barcodeType" : barcodeType
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();

					var result = eval("(" + result + ")");
					$("tr[name='re']").remove();
					for (var i = 0; i < result.sf.length; i++) {
						var barcodeString = result.sf[i].barcodeId;
						var cQty = result.sf[i].cQty;
						var cType = result.sf[i].cType;
						if (cQty == '') {
							var cQty = result.sf[i].jyQty;
						}
						var cType = result.sf[i].cType;
						if (cType == '') {
							var cType = result.sf[i].jyType;
						}
						var createTimeStamp = result.sf[i].createTimeStamp;
						if (createTimeStamp == '') {
							var createTimeStamp = result.sf[i].cacheDate;
						}
						s = "<tr name='re'><td>" +
							"<input type='hidden' name='lotNo' value=" + barcodeString + " />" + barcodeString + "</td><td>" +
							"<input type='hidden' value=" + createTimeStamp + " />" + createTimeStamp +
							"<input type='hidden' name='qty' value=" + cQty + " />" + "</td></tr>";
						$("#sample-table-1").append(s);
					}
					var luck = document.getElementsByName("qty");
					var count1 = 0;
					for (var i = 0; i < luck.length; i++) {
						count1 += Number(luck[i].value);
					}
					var luckElements = document.getElementsByName("lotNo");
					$("td[name='s']").remove();
					ss = "<td name='s'><font size='5' color='red'>查詢到" + (luckElements.length) + "片，</font></td>"
					$("#tt").append(ss);

					$("td[name='count']").remove();
					c = "<td name='count' style='color:red'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
					$("#tt").append(c);

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

<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>

	<div class="page-header">
		<div class="layui-inline">
			<h1>按出库时间查询：</h1>
			選擇公司：<select id="con"><option value="4">晶元</option>
				<option value="5">光宏</option>
			</select> <input type="hidden" id="barcodeType" value="5" /> 开始：<input
				type="text" id="test1" name="startTime" placeholder="yyyy-MM-dd">结束：<input
				type="text" name="endTime" id="test2" placeholder="yyyy-MM-dd">

			<button class="btn btn-primary" id="ajaxC">查询</button>

		</div>
		<table>
			<tr>
				<td id="tt"></td>
			</tr>
		</table>
	</div>

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>片号</th>
				<th>出库时间</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId %>" />
			</tr>
		</thead>
	</table>
</body>
</html>
<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//常规用法
		laydate.render({
			elem : '#test1'
		});

		//常规用法
		laydate.render({
			elem : '#test2'
		});


	});
</script>