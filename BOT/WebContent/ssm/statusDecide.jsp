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
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>卷轴判定</title>
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var obj = $("#form-field-icon-1").prop("value");
			var obj1 = $("#status").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tion.action?methodstr=status", //自己的url
				//提交的数据
				data : {
					"tapeId" : obj,
					"status" : obj1
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
				
					if (result === "message") {
						layer.msg("保存成功！", {
							icon : 1
						}, function() {
							window.location.reload();
						});
						return false;
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
<script>
	function check() {
		var s = document.getElementById("s");

		if (s != null) {

			document.getElementById('myForm').submit(); //进行表单提交rt(s);

		} else {
			layer.msg("还没录入卷轴号", {
				icon : 2
			})

		}
	}
</script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('form-field-icon-1').focus();
	}
	function loseFocus() {
		document.getElementById('form-field-icon-1').blur()
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
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>
	<div class="page-header">
		<h1>卷轴判定：</h1>
		<hr>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()" value="Set focus" />
				<td>输入卷轴：<input id="form-field-icon-1" type="text" size="10" name="tapeId" style="text-transform:uppercase;"
					onfocus="this.select()"> <br/><hr>
					选择卷轴状态：<select name="status" id="status">
						<option value="1">1，异常待定</option>
						<option value="2">2，待手动换/补灯</option>
						<option value="3">3，待返回振动盘重做</option>
				</select>
					<hr>
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确定</button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>