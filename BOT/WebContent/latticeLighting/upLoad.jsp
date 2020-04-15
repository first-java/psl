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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	$(function() {
		$("#submitBtn").click(function() {
			//获取上传框内容

			var code = $("#excel3").val();

			//截取文件名
			var strcode = code.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileCode = strcode.substring(0, 3);
			//截取文件名后缀

			var suffixCode = (code.substr(code.lastIndexOf("."))).toUpperCase();
			if (!(code == "" || code == null) && (suffixCode != ".XLS")) {
				alert("文件格式只能是.XLS");
				return false;
			}

			$("#myForm").submit();
		});
	});
</script>
<script>
	function downLoad(url) {
		/* 	//1、获得查询参数
			var obj = $("#test1").prop("value");
			var obj2 = $("#test2").prop("value");
			var obj3 = $("#productModel").prop("value");


			if (((obj === "") || (obj2 === "")) && (obj3 === "")) {
				layer.msg("请先输入下载条件！", {
					icon : 2
				});
				return false;
			}

			var d1 = new Date(obj.replace(/\-/g, "\/"));
			var d2 = new Date(obj2.replace(/\-/g, "\/"));

			if (obj != "" && obj2 != "" && d1 >= d2) {
				layer.msg("开始时间不能大于结束时间！", {
					icon : 2
				});
				return false;
			} */
		//2、拼装URL+查询参数
		//url = url + "&startTime=" + obj + "&endTime=" + obj2 + "&productModel=" + obj3;
		//3、使用document.local.href=URL

		location.href = url;
	}
</script>
<script>

	function check() {
		document.getElementById('myForm').submit(); //进行表单提交
	}
</script>
<style type="text/css">
span {
	font-family: 华文新魏;
	font-size: 24px;
	margin: 0;
}

.div1 {
	margin-bottom: 0;
	width: 15%;
	background: #CCE8CF;
	float: left;
}

.div {
	height: 40px;
	width: 100%;
	background: yellow;
	/* float: left; */
}

.div2 {
	width: 80%;
	/* background:blue; */
	float: right;
}

ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	list-style-type: none;
}
</style>
</head>
<body>
	<div class="div2">
		<form id="myForm" action="lig.action?methodstr=execute2" method="post"
			enctype="multipart/form-data">
			<legend>上传文件</legend>
			<table>
				<tr>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> <input
								type="button" name="file" class="button" value="浏览..." /> <input
								type="file" name="excel" id="excel3" size="30" />&nbsp;&nbsp;&nbsp;
							<button class="btn btn-primary" id="submitBtn">上传</button>
						</div>
					</td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>
<style>
#nav {
	position: absolute;
	top: 80px;
	left: 26px;
}

#nav ul {
	list-style: none;
}

#nav ul li {
	display: block;
	width: 196px;
	line-height: 60px;
	border-bottom: 1px solid #999;
}

#nav ul li div.first {
	text-indent: 20px;
	border-bottom: 1px solid #999;
}

#nav ul.second {
	display: none;
}

#nav ul.second li {
	display: block;
	width: 166px;
	padding-left: 30px;
	height: 30px;
	line-height: 30px;
	border: none;
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
<script>$(function() {

		$("#excel3").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#excel3").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择文件...");
			}
		});

	});
	$(".first").click(function() {
		$(this).next().toggle();
		$(this).parent().siblings().children(".second").css("display", "none");
	});
</script>