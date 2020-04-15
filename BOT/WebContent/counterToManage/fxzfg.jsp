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
<title>分选转分光</title>
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
			var product = $("#form-field-icon-1").prop("value");
			var workId = $("#workId").prop("value");
			if (product == '') {
				layer.msg("请输入批次！", {
					icon : 2
				}, function() {
					window.location.reload();
					var e = document.createEvent("MouseEvents");
					e.initEvent("click", true, true);
					document.getElementById("clickMe").dispatchEvent(e);
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=fxzfg", //自己的url
				//提交的数据
				data : {
					"counter.lotId" : product,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.open({
						title : '信息提示',
						content : result
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});

				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					layer.msg("服务器出错！", {
						icon : 2
					});
				//请求出错处理
				}
			});

		});
	});
</script>

<script type="text/javascript">
	function setFocus() {
		document.getElementById('form-field-icon-1').focus();
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
			document.getElementById("clickMe").dispatchEvent(e);
		}
	}, 200);

	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
</head>
<body>
	<div class="page-header">
		<h1>输入批次：</h1>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()" value="Set focus" />
				<td><input id="form-field-icon-1" type="text" name="tapeId" onkeyup="this.value=this.value.toUpperCase()"
					onfocus="this.select()">&nbsp;&nbsp;&nbsp;<select>
						<option>分选转分光</option>
				</select> <input type="hidden" name="workId" id="workId" value="<%=workId%>" />
					<button class="btn btn-primary" id="ajaxA">确认</button></td>
			</tr>
		</table>
	</div>
</body>
</html>