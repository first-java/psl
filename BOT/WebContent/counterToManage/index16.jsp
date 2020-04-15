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
<title>货架转移功能</title>
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
		$("#ajaxA").click(function() {
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=transfer1", //自己的url
				//提交的数据
				data : {

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 's') {
						layer.open({
							title : '信息提示',
							content : "没有未启用货架可以转移，要使用此功能，请先把货架设置成未启用！"
						});
						return false;
					}
					var result = eval("(" + result + ")");
					layer.closeAll();
					for (var i = 0; i < result.counter.length; i++) {
						var shelfName = result.counter[i].shelfName;
						var str = $.trim($("#ss").val());
						s = "<option value=" + shelfName + ">" + shelfName + "</option>"
						$("#shelfName").append(s);
					}
				/* $('.page-header input').val(''); */
				},

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});

		});$("#ajaxC").click(function() {
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=transfer4", //自己的url
				//提交的数据
				data : {

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 's') {
						layer.open({
							title : '信息提示',
							content : "没有未启用货架可以转移，要使用此功能，请先把货架设置成未启用！"
						});
						return false;
					}
					var result = eval("(" + result + ")");
					layer.closeAll();
					for (var i = 0; i < result.counter.length; i++) {
						var shelfName = result.counter[i].shelfName;

						s = "<option value=" + shelfName + ">" + shelfName + "</option>"

						$("#shelfName1").append(s);
					}

				},

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});

		});
		$("#ajaxB").click(function() {
			var shelfName = $('#shelfName option:selected').val();
			var caseNo = $('#caseNo option:selected').val();
			var shelfName1 = $('#shelfName1 option:selected').val();
			var caseNo1 = $('#caseNo1 option:selected').val();
			var workId = $("#workId").prop("value");
			if (shelfName == "请选择..." || caseNo == "请选择..." || shelfName1 == "请选择..." || caseNo1 == "请选择...") {
				layer.msg("请选择转移货架", {
					icon : 2
				});
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=transfer3", //自己的url
				//提交的数据
				data : {
					"counter.shelfName" : shelfName, //旧货架
					"counter.caseNo" : caseNo, //旧箱子
					"counter.shelfName1" : shelfName1, //新货架
					"counter.caseNo1" : caseNo1, //新箱子
					"counter.workId" : workId //新箱子
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "s") {
						layer.msg("设置成功", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
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
		$("#ajaxC").click();
	}
</script>
<script type="text/javascript">

	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxC").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
<body onload="check()">

	<div class="page-header">
		<input type="hidden" id="ajaxA" /> <input type="hidden" id="ajaxC" />
		<span class="badge badge-pink">旧货架</span> <br>
		<table id="sample-table-1">
			<tr>
				<td>选择货架： <select id="shelfName1"><option>请选择...</option></select>选择箱子：
					<select id="caseNo1"><option>请选择...</option></select>
					<h1>转移到</h1>
					<span class="badge badge-pink">新货架</span> <br>选择货架： <select
					id="shelfName"><option>请选择...</option></select>选择箱子： <select
					id="caseNo"><option>请选择...</option></select></td>
				</td>
			</tr>
			<tr>
				<td><button class="btn btn-primary" id="ajaxB">提交修改数据</button></td>
			</tr>
		</table>

		<input type="hidden" id="workId" value="<%=workId%>" /> <span
	</div>
</body>
</html>
<script>
	$("#shelfName1").change(function() {
		var shelfName = $('#shelfName1 option:selected').val();

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=transfer5", //12.3
			//提交的数据
			data : {
				"counter.shelfName" : shelfName
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				if (result == "设置成功") {
					layer.msg("设置成功", {
						icon : 1
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}

				var result = eval("(" + result + ")");
				$("option[name='ss']").remove();
				for (var i = 0; i < result.counter.length; i++) {

					var caseNo = result.counter[i].caseNo;

					s = "<option name='ss' value=" + caseNo + ">" + caseNo + "</option>"
					var luckElements = document.getElementsByName("materialname");

					$("#caseNo1").append(s);

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
	$("#shelfName").change(function() {
		var shelfName = $('#shelfName option:selected').val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=transfer2", //
			//提交的数据
			data : {
				"counter.shelfName" : shelfName
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 'ss') {
					layer.open({
						title : '存放位置',
						content : result
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}

				var result = eval("(" + result + ")");
				$("option[name='s1']").remove();
				for (var i = 0; i < result.counter.length; i++) {

					var caseNo = result.counter[i].caseNo;

					var str = $.trim($("#ss").val());

					s = "<option name='s1' value=" + caseNo + ">" + caseNo + "</option>"
					var luckElements = document.getElementsByName("materialname");

					$("#caseNo").append(s);

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