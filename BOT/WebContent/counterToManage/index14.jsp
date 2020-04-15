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
<title>设置机台预做产品</title>
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
			var s = document.getElementById("materialName");
			var workId = $('#workId').val();
			if (s == null) {
				layer.msg("没有任何数据可以提交！", {
					icon : 2
				});
				return false;
			}
			var eqpt = $('#sample option:selected').val();
			var lotHead2 = $('#lxl option:selected').val();

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=savePresetEqpt", //11.2
				//提交的数据
				data : {
					"counter.eqptId" : eqpt,
					"counter.lotHead2" : lotHead2,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == "保存失败!") {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "保存失败，数据库异常！") {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
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

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectTwo", //11.2

				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					var result = eval("(" + result + ")");

					for (var i = 0; i < result.counter.length; i++) {
						var twoProduct = result.counter[i].twoProduct;
						var str = $.trim($("#ss").val());

						ss = "<option value=" + twoProduct + ">" + twoProduct + "</option>"
						var luckElements = document.getElementsByName("materialname");

						$("#lxl").append(ss);
						$('.page-header input').val('');
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

		$("#ajaxV").click(function() {

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=twoProduct1",

				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					$("[name='sss']").remove();
					var result = eval("(" + result + ")");
					$("#chaxunPro").show();
					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].eqptId;
						var twoProduct = result.counter[i].lotHead2;
						s = "<tr name='sss'  onclick='click(this)''><td>" + eqptId +
							"</td><td>" + twoProduct +
							"</td><td><a href='<%=request.getContextPath()%>/counterToManage/xiugaiTwoPro.jsp?eqptId=" + eqptId + "&twoProduct=" + twoProduct + "'>修改</a>" +
							"</td></tr>";
						$("#chaxunPro").append(s);

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
		$("#chaxunPro").hide();
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
		<h4>
			<input type="hidden" id="ajaxA" /> <input type="hidden" id="ajaxC" />
		</h4>
		<button class="btn btn-primary" id="ajaxV">查询机台查询</button>

		<table class="table table-striped table-bordered table-hover"
			id="chaxunPro" width="50%">
			<thead>
				<tr>
					<th>机台</th>
					<th>设置产品</th>
					<th>操作</th>
				</tr>
			</thead>
		</table>
</body>
</html>
<script type="text/javascript">
	$("#lxl").change(function() {
		var eqpt = $('#lxl option:selected').val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=selectPro", //11.3
			//提交的数据
			data : {
				"counter.lotHead2" : eqpt,
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				if (result == 's') {
					layer.msg("未找到改两位批次", {
						icon : 2
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}

				if (result == "d") {
					layer.msg("货架上未找到此产品", {
						icon : 2
					});
				}
				$("tr[name='sss']").remove();
				var result = eval("(" + result + ")");
				for (var i = 0; i < result.counter.length; i++) {
					var materialName1 = result.counter[i].materialName;
					var materialName2 = result.counter[i].materialName;
					var materialName = result.counter[i].materialName;
					var lotHead = result.counter[i].lotHead;
					var product = result.counter[i].product;
					var qty = result.counter[i].qty;
					var intime = result.counter[i].intime;
					/* var str = $.trim($("#ss").val()); */

					s = "<tr name='sss' ><td>" +
						"<input type='text' readonly='true'  name='materialName' id='materialName' value=" + materialName + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='lotHead' id='lotHead' value=" + lotHead + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='product' id='product' value=" + product + " />" + "</td><td>" +
						"<input type='text' readonly='true'  name='qty' id='qty' value=" + qty + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='intime' id='intime' value=" + intime + " />" +
						"</td></tr>";
						/* var luckElements = document.getElementsByName("materialname"); */

					$("#sample-table-1").append(s);
				/* $('.page-header input').val(''); */
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