
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%
	String product = (String) request.getParameter("product");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title></title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
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
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>

<script type="text/javascript">
	function setFocus() {
		document.getElementById('shelfName').focus()
	}
	function loseFocus() {
		document.getElementById('shelfName').blur()
	}
	// 两秒后模拟点击
	setTimeout(function() {
		// IE
		if (document.all) {
			document.getElementById("clickMe").click();
		}
		// 其它浏览器
		else {
			var e = document.createEvent("MouseEvents");
			e.initEvent("click", true, true);

		}
	}, 200);
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var product = $("#sample1").prop("value");
			var qty = $("#qty").prop("value");
			var dept = $("#dept").prop("value");
			var workId = $("#workId").prop("value");
			if (qty.trim() == "") {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				return false;
			}
			if (dept.trim() == "") {
				layer.msg("还没输入借出人！", {
					icon : 2
				});
				return false;
			}
			if (!/^[0-9]*$/.test(qty)) {
				layer.msg("数量只能输入数字！", {
					icon : 2
				});
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectP", //18.1
				//提交的数据
				data : {
					"counter.product" : product,
					"counter.qty" : qty,
					"counter.dept" : dept,
					"counter.workId" :workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					layer.open({
						title : '信息提示',
						content : result
					});
					return false;
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
			var shelfNames = $("#q").prop("value");
			s = shelfNames.split(",");
			var sample1 = s[0];
			$('#sample1').val(sample1);
		});
		var floors = $("#floors").prop("value");
	});
	function check() {
		$("#ajaxB").click();
	}
</script>
</head>
<body onload="check();">

	<input class="btn btn-primary" type="hidden" id="ajaxB" value="赋值" />
	<input type="hidden" id="q" value="<%=product%>" />
	<br>
	<table id="sample-table-1">
		<tr>
			<td><li class="text-primary">借出蓝膜号：</li></td>
			<td><input type="text" id="sample1" name="product"
				readonly="readonly"></td>
			<td><input type="hidden" id="workId" value="6277"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><li class="text-primary">借出数量：</li></td>
			<td><input name="qty" id="qty" type="text" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<input type="hidden" value="<%=workId%>" id="workId" />
		<tr>
			<td><li class="text-primary">借出人：</li></td>
			<td><input name="dept" id="dept" type="text" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><button class="btn btn-primary" id="ajaxA">确定</button></td>
		</tr>
	</table>
</body>
</html>