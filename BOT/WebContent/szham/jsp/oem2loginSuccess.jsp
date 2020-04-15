<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>登录成功</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			//获取上传框内容
			var oemList = $("#excel1").val();
			if ( (oemList == "" || oemList == "null") ) {
				alert("还没选择任何文件！");
				return false;
			}
			//截取文件名
			var stroemList = oemList.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileoemList = stroemList.substring(0, 9);
			//截取文件名后缀
			var suffixoemList = (oemList.substr(oemList.lastIndexOf("."))).toUpperCase();
			if (!(oemList == "" || oemList == null) && suffixoemList != ".CSV") {
				alert("文件格式只能是.CSV");
				return false;
			}
			$("#myForm").submit();
		});
	});
</script>
<style type="text/css">
span {
	font-family: 华文新魏;
	font-size: 24px;
	margin: 0;
}

.div {
	height: 45px;
	width: 100%;
	background: yellow;
	float: right;
}
</style>
</head>
<body>
	<%-- <p>${user.id}</p>
	<p>${name}</p>  --%>
	<div align="left" class="div">
		<IMG alt="公司logo" src="<%=request.getContextPath()%>/image/logo.png"
			width="65" height="40" border="0"> <span>欢迎使用本系统${sessionScope.name}</span>
	</div>
	<div id="time"></div>
	<div class="div2">
		<form id="myForm"
			action="oemList.action?methodstr=execute2"
			method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>上传文件</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> <input
								type="button" name="file" class="button" value="浏览..." /> <input
								type="file" name="excel" id="excel1" size="30" />
						</div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input id="submitBtn" type="image"
						<IMG src="<%=request.getContextPath()%>/image/submit.png" width="85" height="35" border="0"/>
				</tr>
			</table>
		</form>
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

		$("#excel1").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#excel1").each(function() {

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
<script type="text/javascript">
	var id;
	var weekday = "";
	function ti() {
		var d = new Date();
		var year = d.getFullYear();
		var MM = d.getMonth() + 1;
		var dd = d.getDate();
		var hh = d.getHours();
		var mm = d.getMinutes();
		var ss = d.getSeconds();
		var wd = d.getDay();

		if (hh == 0) {
			hours = "12";
			xfile = "PM ";
		} else if (hh < 12) {
			hours = hh;
			xfile = "AM ";
		} else if (hh == 12) {
			hours = "12";
			xfile = "AM";
		} else {
			hh = hh - 12
			hours = hh;
			xfile = "PM";
		}

		if (wd == 0)
			weekday = " 星期日";
		else if (wd == 1)
			weekday = " 星期一";
		else if (wd == 2)
			weekday = " 星期二";
		else if (wd == 3)
			weekday = " 星期三";
		else if (wd == 4)
			weekday = " 星期四";
		else if (wd == 5)
			weekday = " 星期五";
		else if (wd == 6)
			weekday = " 星期六";

		var time = "<h3>" + year + "年" + MM + "月" + dd + "日&nbsp;" + hh + ":" + mm + ":" + ss + " &nbsp;" + xfile + " &nbsp;" + weekday + "</h3>";
		document.getElementById("time").innerHTML = time;
	}
	var id = setInterval("ti()", 100);
</script>