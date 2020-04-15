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
<title></title>
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

		$("#ajaxA").click(function() {
			var lotHead5 = $("#lotHead5").val();
			var cycle = $("#cycle1").val();
			cycle = parseFloat(cycle).toFixed(2);
			var yield1 = $("#yield1").val();
			yield1 = parseFloat(yield1).toFixed(2);

			var opt = $("#workId").val();
			var len = lotHead5.length;
			if (len !== 5) {
				layer.alert("批次头长度不对！");
				return false;
			}
			if (cycle == "NaN") {
				layer.alert("没填周期！");
				return false;
			}
			if (yield1 == "NaN") {
				layer.alert("没填良率！");
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=notest", //5.1
				//提交的数据
				data : {
					"agreed.lotHead5" : lotHead5,
					"agreed.cycle" : cycle,
					"agreed.yield" : yield1,
					"agreed.workId" : opt
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'success') {
						layer.alert("设置成功！");

						return false;
					} else {
						layer.alert("设置失败！");
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
			var lotHead5 = $("#lotHead5").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=selectBasics", //5.1
				//提交的数据
				data : {
					"agreed.lotHead5" : lotHead5
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'error') {
						layer.alert("未查询到基础信息！");

						return false;
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {

						/*  "agreed.cycle" : ,
						"agreed.yield" : ,
						"agreed." : opt*/
						var lotHead5 = result.counter[i].LOTHEAD5;
						var cycle = result.counter[i].CYCLE;
						var yield = result.counter[i].YIELD;
						var workId = result.counter[i].WORKID;

						var inTime = result.counter[i].CREATETIME;
						var time = new Date(inTime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotHead5' id='lotHead5' value=" + lotHead5 + " />" + lotHead5 + "</td><td>" +
							"<input type='hidden' name='cycle' id='cycle' value=" + cycle + " />" + cycle + "</td><td>" +
							"<input type='hidden' name='yield' id='yield' value=" + yield + " />" + yield + "</td><td>" +
							"<input type='hidden' name='workId' id='workId' value=" + workId + " />" + workId + "</td><td>" +
							"<input type='hidden' name='adtime' id='adtime' value=" + adtime + " />" + adtime + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='t(this)' value='修改信息' /></td></tr>";

						$("#table").append(s);
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
	function t(obj) {
		var opt = $("#workId").val();
		var lotHead5 = $(obj).parent().parent().find("td").eq(0).text();

		layer.open({
			type : 2,
			area : [ '800px', '500px' ],
			content : "<%=request.getContextPath()%>/agreed/index6.jsp?workId=" + opt + "&lotHead5=" + lotHead5 + "&workId=" + opt + ""
		});

	}
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
</script>
</head>
<body>
	<div class="page-header">
		<table align="left">
			<tr>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
				<td id="tt">5位批次头：<input id="lotHead5" type="text"> 周期：<input
					onkeyup="javascript:CheckInputIntFloat(this);" id="cycle1"
					type="text"> 良率：<input
					onkeyup="javascript:CheckInputIntFloat(this);" id="yield1"
					type="text">
					<button class="btn btn-primary" id="ajaxA">录入基础信息</button>
					<button class="btn btn-primary" id="ajaxB">查询数据</button>
				</td>
			</tr>
		</table>
	</div>
	<table class="table table-striped table-bordered table-hover"
		id="table" width="50%">
		<thead>
			<tr>
				<th>5位批次头</th>
				<th>周期</th>
				<th>良率</th>
				<th>工号</th>
				<th>时间</th>
				<th>操作</th>
			</tr>
		</thead>
	</table>
	<br>
</body>
</html>