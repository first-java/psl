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
<title>登录成功</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		if (event.keyCode == 13) {
			$("#submitBtn").click(function() {

				$("#myForm").submit();

			});
		}
	});
	function downLoad(url) {
		//1、获得查询参数
		var query = document.getElementById("beginTime");
		var querys = document.getElementById("endTime");
		if (query.value == null || query.value == "") {
			alert("请选择开始日期");
			return false;
		}
		if (querys.value == null || querys.value == "") {
			alert("请选择结束日期");
			return false;
		}
		//2、拼装URL+查询参数
		url = url + "&query=" + query.value;

		//3、使用document.local.href=URL
		location.href = url;
	}
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
</head>
<body>
	<div class="div2">
		<table>
			<tr>
				  <td>入库</td>
			</tr>
			<tr>
				<form id="myForm" action="<%=path%>/re.action?methodstr=save"
					method="post" enctype="multipart/form-data">

					<tr>
						<td>箱 &nbsp;&nbsp;号： <input type="text" name="caseNo"
							onkeypress="return handleEnter(this, event)" />
						</td>
					</tr>
					<tr>
						<td>蓝膜号： <input type="text" name="filmNo"
							onkeypress="return handleEnter(this, event)" /></td>
					</tr>
					<tr>
						<td>数 &nbsp;&nbsp;量： <input type="text" name="pcs" size="6" /></td>
					</tr>
					<input type="hidden" name="workId" value="<%=workId%>"
						<tr>
						<td><input id="submitBtn" type="image"
							<IMG src="<%=request.getContextPath()%>/image/submit.png" width="85" height="35" border="0"/></td>
					</tr>
				</form>
			</tr>
		</table>

		<table>
			<tr>
				<form id="myForm" action="<%=path%>/re.action?methodstr=select"
					method="post" enctype="multipart/form-data">
					<tr>
						<td>查询</td>
					</tr>
					<tr>
						<td>蓝膜号： <input type="text" name="filmNo" />
						</td>
					</tr>
					<tr>
						<td><input id="submitBtn" type="image"
							<IMG src="<%=request.getContextPath()%>/image/submit.png" width="85" height="35" border="0"/></td>
					</tr>
				</form>
			</tr>
		</table>
		<table>
			<tr>
				<form id="myForm" action="<%=path%>/re.action?methodstr=all"
					method="post" enctype="multipart/form-data">
					<tr>
						<td>查询箱内物料</td>
					</tr>
					<tr>
						<td>输入箱号： <input type="text" name="caseNo" />
						</td>
					</tr>
					<tr>
						<td><input id="submitBtn" type="image"
							<IMG src="<%=request.getContextPath()%>/image/submit.png" width="85" height="35" border="0"/></td>
					</tr>
				</form>
			</tr>
		</table>
		<table>
			<tr>
				<form id="myForm" action="<%=path%>/re.action?methodstr=del"
					method="post" enctype="multipart/form-data">
					<tr>
						<td>出库</td>
					</tr>
					<tr>
						<td>蓝膜号： <input type="text" name="film" />
						</td>
					</tr>
					<tr>
						<td><input id="submitBtn" type="image"
							<IMG src="<%=request.getContextPath()%>/image/submit.png" width="85" height="35" border="0"/></td>
					</tr>
				</form>
			</tr>
		</table>
		<form id="myForm"
			action="<%=path%>/download.action?methodstr=downloadReport"
			method="post" enctype="multipart/form-data">
			<p align="left">
				下载<input value="下载" id="submitBtn" type="image"
					<IMG src="<%=request.getContextPath()%>/image/down.png" width="85" height="35" border="0"/>
			</p>
		</form>
	</div>
</body>
</html>