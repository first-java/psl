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
			alert("请输入要查询数据");
			return false;
		}
	}
	function downLoad(url) {
		//1、获得查询参数
		var query = document.getElementById("quer");
		if (query.value == null || query.value == "") {
			alert("请输入要下载数据");
			return false;
		}
		//2、拼装URL+查询参数
		url = url + "&query=" + query.value;
		//3、使用document.local.href=URL

		location.href = url;
	}
</script>
<html>
<body>
	<br>
	<br>
	<form id="myForm" action="parseExcel.action?methodstr=sele"
		method="post" onsubmit="return sb1()">
		<input type="text" name="query" id="quer"> <input
			id="submitBtn" type="submit" value="查询" />
	</form>

	<div>
		<a href="#" onclick="downLoad('download.action?methodstr=select')">下载查询结果</a>

		<c:if test="${not empty que }">
			<table border="1">
				<tr>
					<td>DOCUMENT_RRN</td>
					<td>DOCUMENT_ID</td>
					<td>DOCUMENT_DESC</td>
					<td>DOCUMENT_COMMENTS</td>
					<td>BARCODE_ID</td>
					<td>CREATE_TIMESTAMP</td>
					<td>STORAGE_ID</td>
					<td>MATERIAL_NAME</td>
				</tr>
				<c:forEach items="${que }" var="bath">
					<tr>
						<td>${bath.document_rrn }</td>
						<td>${bath.document_id }</td>
						<td>${bath.document_desc }</td>
						<td>${bath.document_comments }</td>
						<td>${bath.barcode_id }</td>
						<td>${bath.create_timestamp }</td>
						<td>${bath.storage_id }</td>
						<td>${bath.material_name }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</body>
</html>
