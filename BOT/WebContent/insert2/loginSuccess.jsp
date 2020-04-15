<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	/* if (workId == " " || workId == null) {

		out.print("<script>alert('工号有误！')</script>");
		out.print("<a href='#' onClick='javascript :history.back(-1);'>返回上一页</a>");
		return;
	} */
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>首件确认</title>
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

	function sb1() {
		var query = document.getElementById("UnitID1");

		if (query.value == null || query.value == "") {
			alert("请输入要查询的数据");
			return false;
		}
	}
	$(function() {
		$("#submitBtn").click(function() {
			var query = document.getElementById("UnitID");
			var batch1 = $("#Confirm_UID").val();
			if (query.value == null || query.value == "") {
				alert("请输入UnitID");
				return false;
			}
			if (batch1.length > 11) {
				alert("输入Confirm_UID长度过长");
				return false;
			}
			//获取上传框内容
			var batch = $("#image").val();

			//获取文件名
			//var strbatch = batch.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			//var fileBatch = strbatch.substring(0, 9);
			//截取文件名后缀
			var suffixBatch = (batch.substr(batch.lastIndexOf("."))).toUpperCase();
			if (suffixBatch != null && suffixBatch != "") {
				if (suffixBatch != ".PNG" && suffixBatch != ".JPG" && suffixBatch != ".JPEG") {
					alert("图片类型必须是.gif,jpeg,jpg,png中的一种");
					return false;
				}
			}
			$("#myForm").submit();
		});
	});
	$(function() {
		$("#image").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#image").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择上传图片");
			}
		});
	});
</script>
<style>
body {
	padding: 0;
	margin: 0;
	font: normal 24px/48px "\5FAE\8F6F\96C5\9ED1";
	color: #444;
}

table {
	width: 30%;
	border: 0;
	margin: 0px auto 0;
	border-collapse: collapse;
	border-spacing: 0;
}

table th {
	/* background: #0090D7; */
	font-weight: normal;
	line-height: 30px;
	font-size: 24px;
	color: #444444;
}

table tr:nth-child(odd) {
	background: #F4F4F4;
}

table td:nth-child(even) {
	color: #C00;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}

table td, table th {
	border: 1px solid #EEE;
}

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

</head>
<body>
	<form id="myForm" action="myup.action?methodstr=insert2" method="post"
		enctype="multipart/form-data" onsubmit=" return sb2()">
		<table border="1" width="80%"
			style="font-family:'宋体'; font-size:16px;">
			<tr>
				<td>上传</td>
			</tr>
			<tr>
				<td><input type="hidden" name="Confirm_UID" value="<%=workId%>"
					id="Confirm_UID" /></td>
			</tr>
			<tr>
				<td>输入方片号：<input type="text" name="UnitID" id="UnitID" />
				</td>
				<td><input type="hidden" value="1" name="chack2" /></td>
			</tr>

			<tr>
				<td>
					<div class="uploader blue">
						<input type="text" class="filename" readonly="readonly" /> <input
							type="button" name="file" class="button" value="浏览..." /> <input
							type="file" size="30" name="image" id="image" />
					</div>
				</td>
			</tr>
			<tr>
				<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td>
			</tr>
		</table>
	</form>

	<form id="myForm"
		action="<%=request.getContextPath()%>/myup.action?methodstr=getOne"
		method="post" enctype="multipart/form-data" onsubmit=" return sb1()">
		<table border="1" width="1000%"
			style="font-family:'宋体'; font-size:16px;">
			<tr>
				<td>查询</td>
			</tr>
			<tr>
				<td><input type="hidden" value="1" name="chack" />输入方片号或批次头前4位：<input
					type="text" name="UnitID" id="UnitID1" /></td>
			</tr>

			<tr>
				<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td>
			</tr>
		</table>
	</form>
</body>
</html>
