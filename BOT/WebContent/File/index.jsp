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
<title>上传文件</title>
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
		$("#submitBtn").click(function() {
			//获取上传框内容
			var batch = $("#excel1").val();
			var bin = $("#excel2").val();
			var code = $("#excel3").val();
			var mainRule = $("#excel4").val();
			var paraJump = $("#excel5").val();
			var paraRule = $("#excel6").val();

			if ((batch == "" || batch == "null") && (bin == "" || bin == "null")
				&& (code == "" || code == "null") && (mainRule == "" || mainRule == "null")
				&& (paraJump == "" || paraJump == "null") && (paraRule == "" || paraRule == "null")) {
				alert("还没选择任何文件！");
				return false;
			}
			//截取文件名
			var strbatch = batch.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileBatch = strbatch.substring(0, 9);
			//截取文件名后缀
			var suffixBatch = (batch.substr(batch.lastIndexOf("."))).toUpperCase();
			if (!(batch == "" || batch == null) && suffixBatch != ".CSV") {
				alert("文件格式只能是.CSV");
				return false;
			}
			if (!(batch == "" || batch == null) && (fileBatch != "批次前缀对应规则表")) {
				alert("请选择批次前缀对应规则表");
				return false;
			}
			//截取文件名
			var strbin = bin.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileBin = strbin.substring(0, 7);
			//截取文件名后缀
			var suffixBin = (bin.substr(bin.lastIndexOf("."))).toUpperCase();

			if (!(bin == "" || bin == null) && (suffixBin != ".CSV")) {
				alert("文件格式只能是.CSV");
				return false;
			}

			if (!(bin == "" || bin == null) && (fileBin != "BIN表跳转表")) {
				alert("请上传BIN表跳转表");
				return false;
			}
			//截取文件名
			var strcode = code.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileCode = strcode.substring(0, 3);
			//截取文件名后缀
			var suffixCode = (code.substr(code.lastIndexOf("."))).toUpperCase();
			if (!(code == "" || code == null) && (suffixCode != ".CSV")) {
				alert("文件格式只能是.CSV");
				return false;
			}
			if (!(code == "" || code == null) && (fileCode != "编码表")) {
				alert("请上传编码表")
				return false;
			}
			//截取文件名
			var strmainRule = mainRule.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileMainRule = strmainRule.substring(0, 5);
			//截取文件名后缀
			var suffixMainRule = (mainRule.substr(mainRule.lastIndexOf("."))).toUpperCase();
			if (!(mainRule == "" || mainRule == null) && (suffixMainRule != ".CSV")) {
				alert("文件格式只能是.CSV");
				return false;
			}
			if (!(mainRule == "" || mainRule == null) && fileMainRule != "主规细规表") {
				alert("请选择主规细规表");
				return false;
			}

			//截取文件名
			var strparaJump = paraJump.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			var fileParaJump = strparaJump.substring(0, 5);
			var suffixParaJump = (paraJump.substr(paraJump.lastIndexOf("."))).toUpperCase();
			if (!(paraJump == "" || paraJump == null) && (suffixParaJump != ".CSV")) {
				alert("文件格式只能是.CSV");
				return false;
			}
			if (!(paraJump == "" || paraJump == null) && (fileParaJump != "参数跳转表")) {
				alert("请选择参数跳转表");
				return false;
			}
			//截取文件名
			var strparaRule = paraRule.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			var fileParaRule = strparaRule.substring(0, 5);
			var suffixParaRule = (paraRule.substr(paraRule.lastIndexOf("."))).toUpperCase();
			if (!(paraRule == "" || !paraRule == null) && (suffixParaRule != ".CSV")) {
				alert("文件格式只能是.CSV");
				return false;
			}
			if (!(paraRule == "" || !paraRule == null) && (fileParaRule != "参数规则表")) {
				alert("请选择参数规则表");
				return false;
			}
			$("#myForm").submit();
		});
	});
</script>

</head>
<body>
	<div class="div2">
		<form id="myForm" action="parseExcel.action?methodstr=execute2" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>编码表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" name="excel" id="excel3" size="30" />
						</div>
					</td>
				</tr>
				<tr>
					<td>bin表跳转表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" name="excel" id="excel2" size="30" />
						</div>
					</td>
				</tr>
				<tr>
					<td>主规细规表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" name="excel" id="excel4" size="30" />
						</div>
					</td>
				</tr>

				<tr>
					<td>参数跳转表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" name="excel" id="excel5" size="30" />
						</div>
					</td>
					<td>
						<input type="checkbox" name="changeJump" id="changeJump" value="2">删除冲突参数跳转表</td>
					<td>
				</tr>
				<tr>
					<td>参数规则表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" name="excel" id="excel6" size="30" />
						</div>
					</td>
				</tr>
				<tr>
					<td>批次前缀对应表：</td>
					<td>
						<div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> 
							<input type="button" name="file" class="button" value="浏览..." /> 
							<input type="file" size="30" name="excel" id="excel1" />
						</div>
					</td>
					<td>
						<input type="checkbox" name="changeBatch" id="changeBatch" value="1">允许更改批次头</td>
					<td>
				</tr>
				<tr>
					<td></td>
					<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td></tr>
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
		$("#excel2").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});
		$("#excel3").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});
		$("#excel4").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});
		$("#excel5").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});
		$("#excel6").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#excel1").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《批次前缀对应规则表》");
			}
		});
		$("#excel2").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《BIN表跳转表》");
			}
		});
		$("#excel3").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《编码表》");
			}
		});
		$("#excel4").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《主规细规表》");
			}
		});
		$("#excel5").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《参数跳转表》");
			}
		});
		$("#excel6").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《参数规则表》");
			}
		});
	});
	$(".first").click(function() {
		$(this).next().toggle();
		$(this).parent().siblings().children(".second").css("display", "none");
	});
</script>