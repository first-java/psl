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
<title>货架管理查询</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function downLoad(url) {
		location.href = url;
	}
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var shelfMan = $('#shelfMan').val();
			var lotHead = $('#lotHead').val();
			var materialName = $('#materialName').val();
			if (shelfMan == "" && materialName == "" && lotHead == "") {
				layer.msg("还没输入要查询的条件！", {
					icon : 2
				});
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=shelfMan", //12.1 查询预设机台
				//提交的数据
				data : {
					"counter.shelfName" : shelfMan
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == "未找到该货架！") {
						layer.msg("没有货架可以管理！", {
							icon : 2
						});
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {

						var lotHead = result.counter[i].lotHead;
						var materialName = result.counter[i].materialName;
						var product = result.counter[i].product;
						var intime = result.counter[i].intime;
						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var floors = result.counter[i].floors;
						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  name='lotHead' id='lotHead' value=" + lotHead + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + materialName + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + product + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + intime + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='shelfName' id='curDieQty' value=" + shelfName + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='caseNo' id='curDieQty' value=" + caseNo + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='caseNo' id='floors' value=" + floors + " />" +
							"</td></tr>";

						$("#sample5").append(s);

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
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=shelfMan1", //12.1 查询预设机台
				//提交的数据
				data : {

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "未找到该货架！") {
						layer.msg("没有货架可以管理！", {
							icon : 2
						});
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {

						var lotHead = result.counter[i].lotHead;
						var materialName = result.counter[i].materialName;
						var product = result.counter[i].product;
						var intime = result.counter[i].intime;
						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var floors = result.counter[i].floors;


						var adtime = "";
						var time = new Date(intime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  name='lotHead' id='lotHead' value=" + lotHead + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + materialName + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + product + " />" + "</td><td>" +
							 adtime + "</td><td>" +
							"<input type='text' readonly='true' name='shelfName' id='curDieQty' value=" + shelfName + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='caseNo' id='curDieQty' value=" + caseNo + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='floors' id='curDieQty' value=" + floors + " />" +
							"</td></tr>";
						$("#sample5").append(s);
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
	function check() {
		$("#ajaxA").click();
	}
	function check1() {
		$("#ajaxB").click();
	}
</script>
<body onload="check1()">
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="提交" />
	<div class="page-header">

		<table align="left" width="30%" id="sample-table-1">
			<tr>
				<td>查询：<input type="text" id="shelfMan" placeholder='请输入条件模糊查询'>
					<input class="btn btn-primary" type="button" id="ajaxA" value="搜索" /></td>
				<td><input
					onclick="downLoad('<%=request.getContextPath()%>/downloadC.action?methodstr=bin')"
					class="btn btn-primary" type="button" value="导出货架明细" /></td>
			</tr>

		</table>
		<hr>
		<table class="table table-striped table-bordered table-hover"
			id="sample5" width="50%">
			<tr>
				<td>批次</td>
				<td>级别</td>
				<td>蓝膜号</td>
				<td>入库时间</td>
				<td>货架</td>
				<td>箱号</td>
				<td>层数</td>
			</tr>
		</table>
	</div>
</body>
</html>