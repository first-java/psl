<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {

			$("#myForm").submit();
		});
	});
</script>
<body>
	<form id="myForm"
		action="<%=request.getContextPath()%>/bloa.action?methodstr=ConvertBLOBtoString"
		method="post">
		<button class="btn btn-primary" id="submitBtn" value="ss">提交ss</button>
	</form>
	<div>
		<c:if test="${not empty que }">

			<table border="1">
				<tr>
					<td>${newStr }</td>
				</tr>
			</table>

		</c:if>
	</div>
</body>
</html>
