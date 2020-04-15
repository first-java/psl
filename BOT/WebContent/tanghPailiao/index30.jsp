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
	String eqptId = (String) request.getParameter("eqptId");//直接传递
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
<title>设置货架存放产品</title>
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
	function check1() {
		var shelfName = $("#shelfName").val();
		var floors = $("#floors").val();
		if ((floors == "") || (shelfName == "")) {
			layer.msg('请输入要清空的对象！', {
				icon : 2
			});
			return false;
		}
		layer.confirm("确定重置该货架层数的产品吗？", {
			btn : [ '确定', '取消' ],
			title : "提示"
		}, function() {
			document.getElementById('myForm1').submit();
		});
	}

	function check() {
		var shelfName = $("#shelfName1").val();
		if ((shelfName == "") || (shelfName == "")) {
			layer.msg('还没输入货架！', {
				icon : 2
			});
			return false;
		}

		document.getElementById('myForm').submit();

	}
	$(function() { //用jQuery获取table中td值     
		$("#mytable tr").click(function() {
			var ss = $(this).text(); //jQuery获取table中点击位置所在行的id  
			layer.open({
				type : 2,
				area : [ '500px', '300px' ],
				content : "<%=request.getContextPath()%>/tanghPailiao/in2.jsp?floors=" + ss + ""
			});
		});
	});
	$(document).ready(function() {});
</script>
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			//获取上传框内容
			var code = $("#excel3").val();

			if ( (code == "" || code == "null") ) {
				layer.alert("还没选择任何文件！");
				return false;
			}

			//截取文件名
			var strcode = code.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileCode = strcode.substring(0, 3);
			//截取文件名后缀
			var suffixCode = (code.substr(code.lastIndexOf("."))).toUpperCase();
			if (!(code == "" || code == null) && (suffixCode != ".CSV")) {
				layer.alert("文件格式只能是.CSV");
				return false;
			}

			if (!(code == "" || code == null) && (fileCode != "货架表")) {
				alert("请选择待货架表");
				return false;
			}
			$("#myForm1").submit();
		});
	});
</script>
<body>
	<div class="page-header">
		<form id="myForm"
			action="<%=path%>/ctm.action?methodstr=shelfProduct2" method="post"
			enctype="multipart/form-data">
			<table id="sample-table-1" width="50%">
				<thead>
					<tr>
						<td>查找货架： <input type="text" placeholder='请输入货架'
							name="counter.shelfName" value="" id="shelfName1" />&nbsp;&nbsp;<input
							class="btn btn-primary" type="button" onclick="check();"
							value="搜索" /></td>
					</tr>
				</thead>
			</table>
		</form>
	</div>


	<div class="form-group col-sm-10">
		<form id="myForm1" action="cspdaoru.action?methodstr=execute2"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="biaoji" value="货架表">
			<table>
				<tr>
					<td>货架表：</td>
					<td><div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> <input
								type="button" name="file" class="button" value="浏览..." /> <input
								type="file" name="excel" id="excel3" size="30" />

						</div></td>

					<td><button id="submitBtn"
							class="btn btn-primary btn-lg btn-block btn-postek"
							data-loading-text="打印模板中...">导入</button></td>
				</tr>
			</table>
		</form>
		<c:if test="${not empty que }">
			<table class="table table-striped table-bordered table-hover"
				id="mytable" width="50%">
				<thead>
					<tr>
						<th>货架名</th>
						<th>箱号</th>
						<th>已设置的产品类型</th>
						<th>已设置的存放类型</th>
						<th>bin号</th>
						<input type="hidden" name="workId" value="<%=workId%>" />
					</tr>
				</thead>
				<c:forEach items="${que }" var="bath">
					<tr>
						<td>${bath.shelfName}<p style="display: none">,</p></td>
						<td><a>
								<p style="display: none">,</p>${bath.caseNo}<p
									style="display: none">,</p>
								<p style="display: none">,</p>
						</a></td>
						<td>${bath.product }</td>
						<td>${bath.deposit }</td>
						<td>${bath.bin }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
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
				$(this).parents(".uploader").find(".filename").val("请选择《货架表》");
			}
		});
	});
	$(".first").click(function() {
		$(this).next().toggle();
		$(this).parent().siblings().children(".second").css("display", "none");
	});
</script>