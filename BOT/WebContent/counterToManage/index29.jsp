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
<title>设置颗粒数重量信息</title>
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

	$(document).ready(function() {
		$("#ajaxB").click(function() {
			var workId = $("#workId").prop("value");
			var qty = $("#qty").prop("value");
			var lotHead = $("#lotHead").prop("value");
			var weight = $("#weight").prop("value");
			var testName = $("#testFile").prop("value");
			if (qty.trim() == "") {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				return false;
			}

			if (weight.trim() == "") {
				layer.msg("还没输入重量！", {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=cel", //11.2
				//提交的数据
				data : {
					"counter.qty" : qty,
					"counter.workId" : workId,
					"counter.weight" : weight,
					"counter.lotHead" : lotHead,
					"counter.testName" : testName
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result,
						function() {
							window.location.reload();
						})
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

<script type="text/javascript">
	function check() {
		$("#ajaxA").click();
	}
	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('status').focus()
		}
	});

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=queryQty", //12.1 查询预设机台
				//提交的数据
				data : {

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].lotHead;
						s = "<option value=" + eqptId + ">" + eqptId + "</option>"
						var luckElements = document.getElementsByName("materialname");
						$("#sample").append(s);
					/* $('.page-header input').val(''); */
					}
					layer.closeAll();
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
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
</script>

</head>

<body onload="check()">
	<div class="page-header">
		<h4>
			<hr>
			<span class="badge badge-pink">&nbsp;&nbsp;&nbsp;&nbsp;查询已经设置过的产品&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<hr>

			<!-- <button class="btn btn-primary" id="ajaxC" onclick="setFocus()">选中机台</button> -->
		</h4>
		<table align="left" width="30%" id="table"
			class="table table-striped table-bordered table-hover">
			<tr>
				<td>选择产品： <select id="sample"><option>请选择...</option></select></td>
			</tr>
			<tr>
				<td>取样重量(g)</td>
				<td>测试档</td>
				<td>取样颗粒(pcs)</td>
			</tr>
		</table>
		<h4>
			<hr>
			<span class="badge badge-pink">&nbsp;&nbsp;&nbsp;&nbsp;设置产品重量数量&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<hr>
			<input type="hidden" id="ajaxA" />
			<!-- <button class="btn btn-primary" id="ajaxC" onclick="setFocus()">选中机台</button> -->
		</h4>
		<table class="table table-striped table-bordered table-hover"
			width="50%">
			<tr>
				<td>输入批次头：<input type="text" id="lotHead"></td>
				<td>输入测试档：<input type="text" id="testFile"></td>
				<td>输入重量：<input type="text" id="weight" name="weight"
					onkeyup="javascript:CheckInputIntFloat(this);"></td>
				<td>输入数量：<input type="text" id="qty" name="qty"
					onkeyup="javascript:CheckInputIntFloat(this);"></td>
			</tr>
			<tr>
				<td><button class="btn btn-primary" id="ajaxB">确定</button></td>
			</tr>
		</table>
</body>
</html>
<script type="text/javascript">
	$("#sample").change(function() {
		var lotHead = $('#sample option:selected').val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=queryQty1", //11.3
			//提交的数据
			data : {
				"counter.lotHead" : lotHead,
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				$("tr[name='sss']").remove();
				var result = eval("(" + result + ")");
				for (var i = 0; i < result.counter.length; i++) {
					var weight = result.counter[i].weight;
					var qty = result.counter[i].qty;
					var testName = result.counter[i].testName;

					s = "<tr name='sss'><td>" +
						"<input type='text' readonly='true'  name='materialName' id='materialName' value=" + weight + " />" + "</td><td>" +
						"<input type='text' readonly='true'  name='testName' id='testName' value=" + testName + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='intime' id='intime' value=" + qty + " />" + "</td><td>" +
						"<a href=<%=request.getContextPath()%>/counterToManage/index29xiu.jsp?lotHead=" + lotHead + "&testName=" + testName + ">修改</a>" +
						"</td></tr>";

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
</script>