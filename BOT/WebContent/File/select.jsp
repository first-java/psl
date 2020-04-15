<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	function sb1() {
		var query = document.getElementById("quer");
		if (query.value == null || query.value == "") {
			alert("请输入要查询的批次头");
			return false;
		}
	}
	function downLoad(url) {
		//1、获得查询参数
		var query = document.getElementById("quer");
		if (query.value == null || query.value == "") {
			alert("请输入要下载的批次头");
			return false;
		}
		//2、拼装URL+查询参数
		url = url + "&query=" + query.value;
		//3、使用document.local.href=URL

		location.href = url;
	}
</script>
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
<html>
<body>
	<br>
	<br>
	<form id="myForm" action="parseExcel.action?methodstr=batch"
		method="post" onsubmit="return sb1()">
		<input type="text" name="query" id="quer"> <input
			id="submitBtn" type="submit" class="btn btn-primary" value="查询" />
	</form>

	<div>
		<a href="#"
			onclick="downLoad('<%=request.getContextPath()%>/downloadF.action?methodstr=batch')">下载批次头</a>

		<a href="#"
			onclick="downLoad('<%=request.getContextPath()%>/downloadF.action?methodstr=bin')">下载bin</a>

		<a href="#"
			onclick="downLoad(<%=request.getContextPath()%>/downloadF.action?methodstr=paraJump')">下载参数跳转</a>

		<a href="#"
			onclick="downLoad('<%=request.getContextPath()%>/downloadF.action?methodstr=paraRule')">下载参数规则</a>

		<a href="#"
			onclick="downLoad('<%=request.getContextPath()%>/downloadF.action?methodstr=mainRule')">下载主规细规</a>

		<a href="#"
			onclick="downLoad('<%=request.getContextPath()%>/downloadF.action?methodstr=code')">下载编码</a>
		<c:if test="${not empty que }">
			<table border="1">
				<tr>
					<td>RelationID</td>
					<td>ProductType</td>
					<td>UnitType</td>
					<td>UnitSize</td>
					<td>UnitElec</td>
					<td>RelationVol</td>
					<td>ProductID</td>
					<td>K_Flag</td>
					<td>DelQty</td>
					<td>ModFlag</td>
				</tr>
				<c:forEach items="${que }" var="bath">
					<tr>
						<td>${bath.relationID }</td>
						<td>${bath.productType }</td>
						<td>${bath.unitType }</td>
						<td>${bath.unitSize }</td>
						<td>${bath.unitElec }</td>
						<td>${bath.relationVol }</td>
						<td>${bath.productID }</td>
						<td>${bath.k_Flag }</td>
						<td>${bath.delQty }</td>
						<td>${bath.modFlag }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</body>
</html>
