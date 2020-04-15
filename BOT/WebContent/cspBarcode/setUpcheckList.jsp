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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/jBox/i118n/jquery.jBox-zh-CN.js"></script>
<head>
<meta charset="utf-18">
<title>生产创建检查单</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	$(function() {

		$("#submitBtn").click(function() {
			var options = $("#urg option:selected").val();

			var wheth = $('input[name="wheth"]:checked').val();

			var workIdC = "[";
			$("[name=workIdC]").each(function() {
				workIdC += '{"workIdC":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			workIdC = workIdC.replace(reg, "");
			workIdC += "]";

			var seri = "[";
			$("[name=seri]").each(function() {
				seri += '{"seri":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			seri = seri.replace(reg, "");
			seri += "]";


			var barcode = "[";
			$("[name=barcode]").each(function() {
				barcode += '{"barcode":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			barcode = barcode.replace(reg, "");
			barcode += "]";


			var lotHead = "[";
			$("[name=lotHead]").each(function() {
				lotHead += '{"lotHead":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotHead = lotHead.replace(reg, "");
			lotHead += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			var whethd = "[";
			$("select[name=whethd] option:selected").each(function() {
				whethd += '{"whethd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			whethd = whethd.replace(reg, "");
			whethd += "]";

			var remark = "[";
			$("[name=remark]").each(function() {
				remark += '{"remark":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			remark = remark.replace(reg, "");
			remark += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspBarcode.action?methodstr=saveBarcodeCl1", //5.1
				//提交的数据
				data : {
					"barcodeCl.urg" : options,
					"barcodeCl.workIdC" : workIdC,
					"barcodeCl.wheth" : wheth,
					"barcodeCl.seri" : seri,
					"barcodeCl.barcode" : barcode,
					"barcodeCl.lotHeader" : lotHead,
					"barcodeCl.qty" : qty,
					"barcodeCl.whethd" : whethd,
					"barcodeCl.remark" : remark
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result.startsWith('error:')) {
						layer.alert(result);
						$("#barcode1").select();
						return false;
					}
					if (result == 'success') {
						layer.alert("创建成功");
						window.location.reload();
						return false;
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
	function t(obj, id) {
		var idd = Number(id);
		var barcode = $("#barcode" + idd + "").val();
		if (barcode == '') {
			layer.alert('还没输入卷轴！', {
				icon : 2
			}, function() {
				$("#barcode" + idd + "").val('');
				$("#barcode" + idd + "").select();
				layer.closeAll();
			});
			return false;
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "cspBarcode.action?methodstr=setCheckList", //自己的url
			//提交的数据
			data : {
				"barcodeCl.barcode" : barcode
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 'error') {
					layer.alert('此卷轴已经创建过检查单，不允许再次创建，请使用判退批次送检！！', {
						icon : 2
					}, function() {
						$("#barcode" + idd + "").val('');
						$("#barcode" + idd + "").select();
						layer.closeAll();
					})

					return false;
				}
				if (result == 'error1') {
					layer.alert('卷轴不存在！', {
						icon : 2
					}, function() {
						$("#barcode" + idd + "").val('');
						$("#barcode" + idd + "").select();
						layer.closeAll();
					})
					return false;
				}
				var result = eval("(" + result + ")");
				var qty = result.counter[0].qty
				var lothead = result.counter[0].lotHeader
				$("#qty" + idd + "").val(qty);
				$("#lotHeada" + idd + "").val(lothead);
				$("#barcode" + (idd + 1) + "").select();

				layer.closeAll();
			},
			//调用执行后调用的函数

			error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
				//layer.closeAll();
				//layer.msg("--" + errorThrown)
				alert("出错");
			//请求出错处理
			}
		});

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
		<input type="hidden" name="workId" value="<%=workId%>" />
		<table id="InputsWrapper">
			<tr>
				<td colspan="4" align="center" style='font-size:24px' size="18">入库报检单</td>
			</tr>
			<tr>
				<input type="hidden" name="workId" value="<%=workId%>" />

				<td>紧急程度：</td>
				<td><select name="urg" id="urg" class="s" />
					<option value="一般">一般 </option>
					<option value="急">急</option>
					<option value="紧急">紧急</option> </select></td>

				<td>是否重工：</td>
				<td>是&nbsp;<input type="radio" name="wheth" value="是" />
					&nbsp; 否&nbsp;<input type="radio" name="wheth" value="否" />
				</td>
				<td><a href="index6.jsp">查看判退批次</a></td>
				<td><a href="index11.jsp">解除送检卷轴</a></td>
			</tr>
			<tr>
				<td>序号</td>
				<td>卷轴号</td>
				<td>批次头</td>
				<td>数量</td>
				<td>重工确认</td>
				<td>报检员</td>
				<td>备注</td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="1"
					readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode1"
					onkeyup="this.value=this.value.toUpperCase()"
					onkeypress='if(event.keyCode==13) t(this,1);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada1" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty1"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>

			<tr>
				<td><input type="text" size="18" name="seri" value="2"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode2"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,2);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada2" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty2"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>


			<tr>
				<td><input type="text" size="18" name="seri" value="3"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode3"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,3);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada3" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty3"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>


			<tr>
				<td><input type="text" size="18" name="seri" value="4"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode4"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,4);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada4" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty4"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="5"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode5"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,5);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada5" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty5"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="6"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode6"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,6);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada6" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty6"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="7"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode7"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,7);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada7" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty7"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="8"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode8"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,8);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada8" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty8"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="9"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode9"
					onkeyup="this.value=this.value.toUpperCase();"
					onkeypress='if(event.keyCode==13) t(this,9);' /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada9" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty9"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="10"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode10"
					onkeypress='if(event.keyCode==13) t(this,10);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada10" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty10"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="11"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode11"
					onkeypress='if(event.keyCode==13) t(this,11);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada11" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty11"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="12"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode12"
					onkeypress='if(event.keyCode==13) t(this,12);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada12" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty12"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="13"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode13"
					onkeypress='if(event.keyCode==13) t(this,13);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada13" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty13"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="14"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode14"
					onkeypress='if(event.keyCode==13) t(this,14);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada14" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty14"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="15"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode15"
					onkeypress='if(event.keyCode==13) t(this,15);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada15" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty15"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="16"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode16"
					onkeypress='if(event.keyCode==13) t(this,16);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada16" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty16"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="17"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode17"
					onkeypress='if(event.keyCode==13) t(this,17);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada17" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty17"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="18"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode18"
					onkeypress='if(event.keyCode==13) t(this,18);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada18" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty18"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="19"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode19"
					onkeypress='if(event.keyCode==13) t(this,19);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada19" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty19"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
			<tr>
				<td><input type="text" size="18" name="seri" value="20"
					id="seri" readonly="readonly" /></td>
				<td><input type="text" size="18" name="barcode" id="barcode20"
					onkeypress='if(event.keyCode==13) t(this,20);'
					onkeyup="this.value=this.value.toUpperCase();" /></td>
				<td><input type="text" size="18" name="lotHead" value=""
					id="lotHeada20" readonly="readonly" /></td>
				<td><input type="text" size="18" name="qty" value="" id="qty20"
					readonly="readonly" /></td>
				<td><select name="whethd" class="s">
						<option value="是">是</option>
						<option value="否" selected="selected">否</option>
				</select></td>
				<td><input type="text" size="18" name="workIdC" /></td>
				<td><input type="text" size="18" name="remark" value="无" /></td>
			</tr>
		</table>
		<table>
			<tr>
				<td><input type="button" class="btn btn-primary" id="submitBtn"
					value="创建检查单" /></td>
			</tr>
		</table>
	</div>
</body>
</html>
