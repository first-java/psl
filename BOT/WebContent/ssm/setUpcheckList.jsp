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
<script src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="Theme/Scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script src="Theme/Scripts/jBox/i118n/jquery.jBox-zh-CN.js"></script>
<head>
<meta charset="utf-18">
<title>生产创建检查单</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			//获取上传框内容

			var quantity = $("#quantity").val();
			if (quantity == "" || quantity == "null") {
				alert("请输入数量！");
				return false;
			}

			var customsInspector = $("#customsInspector").val();
			if (customsInspector == "" || customsInspector == "null") {
				alert("请输入报检员！");
				return false;
			}

			$("#myForm").submit();
		});



	});
	/* $(function() {
		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
				//           有时需要阻止一下回车键的默认事件.如果不组织的话。就会直接刷新页面。而不进行点击下一步了。
				event.preventDefault();
				$("#AddMoreFileBox").click();
				//document.getElementById("sbdm").focus()
			}
		});

	}); */
	function getsubId(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}
</script>

<style>
table {
	width: 70%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	align: left;
}

body {
	padding-bottom: 0px;
	min-height: 100%;
	font-family: "Open Sans";
	font-size: 13px;
	line-height: 1.5;
	font-family: "Open Sans";
	font-size: 13px;
	font-size: 13px;
}

table th {
	background: #0090D7;
	font-weight: normal;
	line-height: 30px;
	font-size: 118px;
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

.s {
	width: 150px;
	height: 30px;
}
</style>

</head>
<body>
	<div>
		<form id="myForm" action="<%=path%>/re.action?methodstr=saveBar"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="workId" value="<%=workId%>" />
			<table id="InputsWrapper">
				<tr>
					<td colspan="4" align="center" style='font-size:24px' size="18">入库报检单</td>
				</tr>
				<tr>
					<input type="hidden" name="workId" value="<%=workId%>" />

					<td>紧急程度：</td>
					<td><select name="urgencyDegree" id="urgencyDegree" class="s" />
						<option value="一般">一般 </option>
						<option value="急">急</option>
						<option value="紧急">紧急</option> </select</td>
				</tr>
				<tr>
					<td>报检员：</td>
					<td><input type="text" size="18" name="customsInspector"
						id="customsInspector" /></td>
					<td>是否重工：</td>
					<td>是&nbsp;<input type="radio" name="whetheredor" value="是" />
						&nbsp; 否&nbsp;<input type="radio" name="whetheredor" value="否" />
					</td>
				</tr>
				<tr>
					<td>序号</td>
					<td>卷轴号</td>
					<td>重工确认</td>
					<td>备注</td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="1"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode1"
						onkeypress='if(event.keyCode==13) getsubId(this,1);' /></td>
					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="2"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode2"
						onkeypress='if(event.keyCode==13) getsubId(this,2);' /></td>
					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="3"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode3"
						onkeypress='if(event.keyCode==13) getsubId(this,3);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="4"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode4"
						onkeypress='if(event.keyCode==13) getsubId(this,4);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="5"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode5"
						onkeypress='if(event.keyCode==13) getsubId(this,5);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="6"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode6"
						onkeypress='if(event.keyCode==13) getsubId(this,6);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="7"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode7"
						onkeypress='if(event.keyCode==13) getsubId(this,7);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="8"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode8"
						onkeypress='if(event.keyCode==13) getsubId(this,8);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber" value="9"
						id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode9"
						onkeypress='if(event.keyCode==13) getsubId(this,9);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="10" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode10"
						onkeypress='if(event.keyCode==13) getsubId(this,10);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="11" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode11"
						onkeypress='if(event.keyCode==13) getsubId(this,11);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="12" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode12"
						onkeypress='if(event.keyCode==13) getsubId(this,12);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="13" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode13"
						onkeypress='if(event.keyCode==13) getsubId(this,13);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="14" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode14"
						onkeypress='if(event.keyCode==13) getsubId(this,14);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="15" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode15"
						onkeypress='if(event.keyCode==13) getsubId(this,15);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="16" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode16"
						onkeypress='if(event.keyCode==13) getsubId(this,16);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="17" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode17"
						onkeypress='if(event.keyCode==13) getsubId(this,17);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="18" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode18"
						onkeypress='if(event.keyCode==13) getsubId(this,18);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="19" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode19"
						onkeypress='if(event.keyCode==13) getsubId(this,19);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
				<tr>
					<td><input type="text" size="18" name="serialNumber"
						value="20" id="serialNumber" readonly="readonly" /></td>
					<td><input type="text" size="18" name="barcode" id="barcode20"
						onkeypress='if(event.keyCode==13) getsubId(this,20);' /></td>

					<td><select name="redo" class="s">
							<option value="是">是</option>
							<option value="否" selected="selected">否</option>
					</select></td>
					<td><input type="text" size="18" name="remark" /></td>
				</tr>
			</table>
			<table>
				<tr>
					<td><input type="button" class="btn btn-primary"
						id="submitBtn" value="创建检查单" onclick="check()" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>