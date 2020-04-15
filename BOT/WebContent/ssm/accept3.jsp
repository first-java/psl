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
			var inspection = $("#inspection").val();
			if (inspection == "" || inspection == "null") {
				alert("请输入检查单名称！");
				return false;
			}
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
			

					<table id="InputsWrapper" border="1">
						<tr>
							<td colspan="9" align="center" style='font-size:22px'>入库报检单</td>
						</tr>
					
							<tr>
								<td>报检单名称：</td>
								<td><input type="text" name="inspection"
									value="${bath.inspection }" size="8" readonly="true " /></td>
							</tr>
							<tr>
								<td>产品型号：</td>
								<td><input type="text" size="8" name="productModel"
									value="${bath.productModel }" readonly="true " /></td>
								<td>送检数量：</td>
								<td><input type="text" size="8" name="quantity"
									value="${bath.quantity }" readonly="true " /></td>
								<td>报检单号：</td>
								<td><input type="text" size="8" name="odd"
									value="${bath.odd }" readonly="true " /></td>
								<td>是否重工：</td>
								<td colspan="2">是<input type="radio" name="raa" value="1" />
									&nbsp; 否<input type="radio" name="raa" value="2" />
								</td>
							</tr>
							<tr>
								<td>紧急程度：</td>
								<td><input type="text" size="8" name="urgencyDegree"
									value="${bath.urgencyDegree }" readonly="true " /></td>
								<td>报检员：</td>
								<td><input type="text" size="8" name="customsInspector"
									value="${bath.customsInspector }" readonly="true " /></td>
								<td>报检时间：</td>
								<td colspan="4"><input type="text" size="8"
									value="${bath.customsTime }" readonly="true "
									name="customsTime" /></td>
							</tr>
					
						<tr>
							<td>序号</td>
							<td>卷轴号</td>
							<td>检验时间</td>
							<td>抽检卷轴号</td>
							<td>卷轴判定</td>
							<td>不良原因</td>
							<td>不良数量</td>
							<td>重工确认</td>
							<td>备注</td>
						</tr>
								<tr>
									<td><input type="text" size="8" name="serialNumber"
										value="${b.serialNumber }" readonly="true " /></td>
									<td><input type="text" size="8" name="barcode"
										value="${b.barcode} " readonly="true " /></td>
									<td><input type="text" size="8" name="provingTime" /></td>
									<td><select name="checkBarcode">
											<option value="1">是</option>
											<option value="2" selected="selected">否</option>
									</select></td>
									<td><input type="text" size="8" name="scrollToDetermine" /></td>
									<td><input type="text" size="8" name="causeDefect" /></td>
									<td><input type="text" size="8" name="defectQuantity" /></td>
									<td><select name="firm">
											<option value="1">是</option>
											<option value="2" selected="selected">否</option>
									</select></td>
									<td><input type="text" size="8" name="remark" /></td>
								</tr>
					</table>
				
				<table border="1">
					<tr>
						<td>批次判定</td>
						<td colspan="3"><input type="radio" name="batchDetermine"
							id="ra" value="1" />允收 <input type="radio" name="batchDetermine"
							id="ra" value="2" />判退</td>
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
	<script>
		$(document).ready(function() {
			var MaxInputs = 8; //maximum input boxes allowed
			var InputsWrapper = $("#InputsWrapper"); //Input boxes wrapper ID
			var AddButton = $("#AddMoreFileBox"); //Add button ID
			var x = InputsWrapper.length; //initlal text box count
			var FieldCount = 1; //to keep track of text box added
			$(AddButton).click(function(e) //on add input button click
			{
				if (x <= MaxInputs) //max input box allowed
				{
					FieldCount++; //text box added increment
					//add input box
					$(InputsWrapper).append('<tr><td><input type="text" size="8" name="serialNumber"  value=" ' + FieldCount + '" /></td><td><input type="text" size="8" name="barcode" /></td><td><input type="text" size="8" name="provingTime" /></td><td><select name="checkBarcode"><option>请选择...</option><option value="1">是</option><option value="2">否</option></select></td><td><input type="text" size="8" name="scrollToDetermine" /></td><td><input type="text" size="8" name="causeDefect" /></td><td><input type="text" size="8" name="defectQuantity" /></td><td><select name="cConfirm"><option>请选择...</option><option value="1">是</option><option value="2">否</option></select></td><td><input type="text" size="8" name="remark" /></td></tr>');
					x++; //text box increment
				}
				return false;
			});
			$("body").on("click", ".removeclass", function(e) { //user click on remove text
				if (x > 1) {
					$(this).parent('tr').remove(); //remove text box
					x--; //decrement textbox
				}
				return false;
			})
		});
	</script>
</body>
</html>