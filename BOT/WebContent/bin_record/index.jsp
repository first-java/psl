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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>圆片清线抓主BIN记录</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
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
<script src="Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		if (event.keyCode == 13) {
			$("#submitBtn").click(function() {

				$("#myForm").submit();

			});
		}
	});
</script>
<script type="text/javascript">
	function handleEnter(field, event) {
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13) {
			var i;
			for (i = 0; i < field.form.elements.length; i++)
				if (field == field.form.elements[i])
					break;
			i = (i + 1) % field.form.elements.length;
			field.form.elements[i].focus();
			return false;
		}
		else
			return true;
	}
</script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('password1').focus()
	}
	function loseFocus() {
		document.getElementById('password1').blur()
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
</script>

</head>
<body>
	<div class="div2">
		<table>
			<tr>
				 <td>圆片清线抓主BIN记录表</td>
			</tr>
			<tr>
				<form id="myForm" action="<%=path%>/res.action?methodstr=save"
					method="post" enctype="multipart/form-data">

					<tr>
						<td>片号： <input type="text" id="password1" name="volume"  /> <input
							id="clickMe" type="hidden" onclick="setFocus()" value="Set focus" />
						</td>
					</tr>

					<tr>
					   <td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td></tr>
				</form>
			</tr>
		</table>
	</div>


</body>
</html>
<style>
.uploader {
	position: relative;
	display: inline-block;
	overflow: hidden;
	cursor: default;
	padding: 0;
	margin: 10px 0px;
	-moz-box-shadow: 0px 0px 5px #ddd;
	-webkit-box-shadow: 0px 0px 5px #ddd;
	box-shadow: 0px 0px 5px #ddd;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
}

.filename {
	float: left;
	display: inline-block;
	outline: 0 none;
	height: 32px;
	width: 200px;
	margin: 0;
	padding: 8px 10px;
	overflow: hidden;
	cursor: default;
	border: 1px solid;
	border-right: 0;
	font: 9pt/80% Arial, Helvetica, sans-serif;
	color: #777;
	text-shadow: 1px 1px 0px #fff;
	text-overflow: ellipsis;
	white-space: nowrap;
	-moz-border-radius: 5px 0px 0px 5px;
	-webkit-border-radius: 5px 0px 0px 5px;
	border-radius: 5px 0px 0px 5px;
	background: #f5f5f5;
	background: -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fafafa),
		color-stop(100%, #f5f5f5));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fafafa',
		endColorstr='#f5f5f5', GradientType=0);
	border-color: #ccc;
	-moz-box-shadow: 0px 0px 1px #fff inset;
	-webkit-box-shadow: 0px 0px 1px #fff inset;
	box-shadow: 0px 0px 1px #fff inset;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.button {
	float: left;
	height: 32px;
	display: inline-block;
	outline: 0 none;
	padding: 8px 12px;
	margin: 0;
	cursor: pointer;
	border: 1px solid;
	font: bold 9pt/100% Arial, Helvetica, sans-serif;
	-moz-border-radius: 0px 5px 5px 0px;
	-webkit-border-radius: 0px 5px 5px 0px;
	border-radius: 0px 5px 5px 0px;
	-moz-box-shadow: 0px 0px 1px #fff inset;
	-webkit-box-shadow: 0px 0px 1px #fff inset;
	box-shadow: 0px 0px 1px #fff inset;
}

.uploader input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	border: 0;
	padding: 0;
	margin: 0;
	height: 30px;
	cursor: pointer;
	filter: alpha(opacity = 0);
	-moz-opacity: 0;
	-khtml-opacity: 0;
	opacity: 0;
}

input[type=button]::-moz-focus-inner {
	padding: 0;
	border: 0 none;
	-moz-box-sizing: content-box;
}

input[type=button]::-webkit-focus-inner {
	padding: 0;
	border: 0 none;
	-webkit-box-sizing: content-box;
}

input[type=text]::-moz-focus-inner {
	padding: 0;
	border: 0 none;
	-moz-box-sizing: content-box;
}

input[type=text]::-webkit-focus-inner {
	padding: 0;
	border: 0 none;
	-webkit-box-sizing: content-box;
}
/* Blue Color Scheme ------------------------ */
.blue .button {
	color: #fff;
	text-shadow: 1px 1px 0px #09365f;
	background: #064884;
	background: -moz-linear-gradient(top, #3b75b4 0%, #064884 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #3b75b4),
		color-stop(100%, #064884));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3b75b4',
		endColorstr='#064884', GradientType=0);
	border-color: #09365f;
}

.blue:hover .button {
	background: #3b75b4;
	background: -moz-linear-gradient(top, #064884 0%, #3b75b4 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #064884),
		color-stop(100%, #3b75b4));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#064884',
		endColorstr='#3b75b4', GradientType=0);
}
</style>
<script>$(function() {

		$("#excel3").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#excel3").each(function() {

			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择文件");
			}
		});

	});
	$(".first").click(function() {
		$(this).next().toggle();
		$(this).parent().siblings().children(".second").css("display", "none");
	});
</script>