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
<meta charset="utf-8">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			//获取上传框内容

			var productModel = $("#productModel").val();
			if (productModel == "" || productModel == "null") {
				alert("请输入型号！");
				return false;
			}
			var quantity = $("#quantity").val();
			if (quantity == "" || quantity == "null") {
				alert("请输入数量！");
				return false;
			}
			var odd = $("#odd").val();
			if (odd == "" || odd == "null") {
				alert("请输入报检单号！");
				return false;
			}
			var urgencyDegree = $("#urgencyDegree").val();
			if (urgencyDegree == "" || urgencyDegree == "null") {
				alert("请输入紧急程度！");
				return false;
			}
			var customsInspector = $("#customsInspector").val();
			if (customsInspector == "" || customsInspector == "null") {
				alert("请输入报检员！");
				return false;
			}
			var customsTime = $("#customsTime").val();
			if (customsTime == "" || customsTime == "null") {
				alert("请输入报检时间！");
				return false;
			}
			var barcode = $("#barcode").val();
			if (barcode == "" || barcode == "null") {
				alert("请输入卷轴号！");
				return false;
			}
			var serialNumber = $("#serialNumber").val();
			if (serialNumber == "" || serialNumber == "null") {
				alert("请输入序号！");
				return false;
			}
			var provingTime = $("#provingTime").val();
			if (provingTime == "" || provingTime == "null") {
				alert("请输入检验时间！");
				return false;
			}

			var scrollToDetermine = $("#scrollToDetermine").val();
			if (scrollToDetermine == "" || scrollToDetermine == "null") {
				alert("卷轴还未做判定！");
				return false;
			}
			var causeDefect = $("#causeDefect").val();
			if (causeDefect == "" || causeDefect == "null") {
				alert("请输入不良原因！");
				return false;
			}
			var defectQuantity = $("#defectQuantity").val();
			if (defectQuantity == "" || defectQuantity == "null") {
				alert("请输入不良数量！");
				return false;
			}
			var remark = $("#remark").val();
			if (remark == "" || remark == "null") {
				alert("请输入备注！");
				return false;
			}
			var verifyPerson = $("#verifyPerson").val();
			if (verifyPerson == "" || verifyPerson == "null") {
				alert("请输入检验员！");
				return false;
			}
			var badsign = $("#badsign").val();
			if (badsign == "" || badsign == "null") {
				alert("请输入不良签收员！");
				return false;
			}
			var raa = $("#raa").val();
			if (raa == "" || raa == "null") {
				alert("还未选择是否重工！");
				return false;
			}
			var ra = $("#ra").val();
			if (ra == "" || ra == "null") {
				alert("还未判定卷轴！");
				return false;
			}

			$("#myForm").submit();
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
	width: 70%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
}

table th {
	background: #0090D7;
	font-weight: normal;
	line-height: 30px;
	font-size: 18px;
	color: #FFF;
}

table tr:nth-child(odd) {
	background: #F4F4F4;
}

table td:nth-child(even) {
	color: #C00;
}

table tr:nth-child(1) {
	background: #73B1E0;
	color: #FFF;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}

table td, table th {
	border: 1px solid #EEE;
}
</style>
<title>送出检查单</title>
<script src='http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js'></script>
</head>
<body>
	<center>

		<form id="myForm" action="<%=path%>/re.action?methodstr=saveBar1"
			method="post" enctype="multipart/form-data">
			<div>
				<c:if test="${not empty queryAll }">

					<table id="InputsWrapper" border="1">
						<tr>
							<td colspan="9" align="center" style='font-size:22px'>入库报检单</td>
						</tr>
						<c:forEach items="${queryAll }" var="bath">
							<tr>
								<td>产品型号：</td>
								<td><input type="text" size="8" name="productModel"
									value="${bath.productModel }" readonly="true " /></td>
								<td>送检数量：</td>
								<td><input type="text" size="8" name="quantity"
									value="${bath.quantity }" readonly="true " /></td>
								<td>报检单号：</td>
								<td><input type="text" size="16" name="odd"
									value="${bath.odd }" readonly="true " /></td>
							</tr>
							<tr>
								<td>紧急程度：</td>
								<td><input type="text" size="8" name="urgencyDegree"
									value="${bath.urgencyDegree }" readonly="true " /></td>
								<td>报检员：</td>
								<td><input type="text" size="8" name="customsInspector"
									value="${bath.customsInspector }" readonly="true " /></td>
								<td>送检时间：</td>
								<td ><input type="text" size="12"
									value="${bath.createTime }" readonly="true "
									name="customsTime" /></td>
							</tr>
							<input type="hidden" name="workId" value="<%=workId%>" />
						</c:forEach>
						<tr>
							<td>序号</td>
							<td>卷轴号</td>		
							<td>抽检卷轴号</td>
							<td>卷轴判定</td>
							<td>不良原因</td>
							<td>不良数量</td>
							<td>重工确认</td>
							<td>备注</td>
						</tr>

						<c:if test="${not empty query }">
							<c:forEach items="${query }" var="b">
								<tr>
									<td><input type="text" size="8" name="serialNumber"
										value="${b.serialNumber }" readonly="true " /></td>
									<td><input type="text" size="10" name="barcode"
										value="${b.barcode} " readonly="true " /></td>
									
									<td><select name="checkBarcode">
											<option value="是">是</option>
											<option value="否" selected="selected">否</option>
									</select></td>
									<td><select name="scrollToDetermine">
											<option value="OK">OK</option>
											<option value="NG">NG</option>
									</select></td>
									<td><input type="text" size="8" name="causeDefect" /></td>
									<td><input type="text" size="8" name="defectQuantity" /></td>

									<td><input type="text" name="redo"size="6"
										value="${b.redo }" readonly="true " /></td>
									<td><input type="text" size="8" name="remark" value="${b.remake }"/></td>
								</tr>

							</c:forEach>
						</c:if>

					</table>
				</c:if>
				<table border="1">
					<tr>
						<td>批次判定</td>
						<td colspan="3"><input type="radio" name="batchDetermine"
							id="ra" value="允收" />允收 <input type="radio" name="batchDetermine"
							id="ra" value="判退" />判退</td>
						<td>检验员：</td>
						<td><input type="text" size="8" name="verifyPerson" /></td>
						<td colspan="2">不良签收员：</td>
						<td><input type="text" size="8" name="badsign" /></td>
					</tr>
				</table>
				<tr>
					<input type="button" class="btn" id="submitBtn" value="提交" />
				</tr>
			</div>
		</form>
	</center>
</body>
</html>