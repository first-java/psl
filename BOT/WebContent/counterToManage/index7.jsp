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
<title>机台管理</title>
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

			var shelf = $("#shelf").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=updateCaseNo", //自己的url
				//提交的数据
				data : {
					"counter.shelf" : shelf
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");

					for (var i = 0; i < result.counter.length; i++) {

						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var createtime = result.counter[i].createTime;
						var cntargs = result.counter[i].cntargs;
						var workId = result.counter[i].workId;
						var str = $.trim($("#ss").val());

						s = "<tr><td>" + "<input type='text' readonly='true'  style='border-style:none' name='shelfName' id='s' value=" + shelfName + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='caseNo' id='s' value=" + caseNo + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='materialname' id='s' value=" + createtime + " />" + "</td><td>" + "<input type='text'  style='border-style:none' name='cntargs' id='s' value=" + cntargs + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='rootlotid' id='s' value=" + workId + " />" + "</td></tr>";
						var luckElements = document.getElementsByName("materialname");

						$("#sample-table-1").append(s);
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
		document.getElementById('status').focus();
	}
	function loseFocus() {
		document.getElementById('status').blur()
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
			document.getElementById('status').focus()
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

		<table align="left" width="30%">
			<tr>
				</td>
				<td>货架名称：<input type="text" name="shelf" id="shelf">&nbsp;
					<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">搜索箱子</button>
				</td>
			</tr>
		</table>
	</div>

	<br>
	<form id="myForm" action="<%=path%>/ctm.action?methodstr=update2"
		method="post" enctype="multipart/form-data">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>货架名称</th>
					<th>箱号</th>
					<th>箱号序号</th>
					<th>创建时间</th>
					<th>货架状态</th>
					<th>货架创建人</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
		</table>
		<table align="left">
			<tr>
				<td><button class="btn btn-primary" id="ajaxB">提交修改后的数据</button></td>
			</tr>
		</table>
	</form>
</body>
</html>