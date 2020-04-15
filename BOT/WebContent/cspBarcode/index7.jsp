<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<%
    String workId = (String) request.getParameter("workId");//直接传递
			String odd = (String) request.getParameter("odd");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function t1() {
		var barcode = $("#tapei2").val();
		var bar = barcode.split("^");
		var y = bar.length;

		if (y != 3) {
			layer.alert('请扫描正确的小标签二维码！！', {
				icon : 2
			}, function() {
				$("#tapei2").val('');
				$("#tapei2").select();
				layer.closeAll();
			});
			return false;
		}
		if (barcode == '') {
			layer.alert('还没输入卷轴！', {
				icon : 2
			}, function() {
				$("#tapei2").val('');
				$("#tapei2").select();
				layer.closeAll();
			});
			return false;
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "cspBarcode.action?methodstr=barcodeVerify", //5.1
			//提交的数据

			data : {
				"picking.tapeId" : bar[2],
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result.startsWith("error:")) {
					layer.alert("卷轴有误！卷轴未打标", function() {
						window.location.reload();
					});
					return false;
				}
				var result = eval("(" + result + ")");
				var qrSplit = result.counter[0].qrSplit;
				var qrIdSec = result.counter[0].qrIdSec;
				var rpdString = result.counter[0].rpdString;
				$("#qrSplit").val(qrSplit);
				$("#qrIdSec").val(qrIdSec);
				$("#rpdString").val(rpdString);
				$("#tapei").select();
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
	function t2() {
		var barcode1 = $('#tapei2').val().trim();
		var barcode2 = $('#tapei').val().trim();
		if (barcode1 == barcode2) {
			layer.alert('两个输入框内容不能一样！！！', {
				icon : 2
			}, function() {
				$("#tapei2").val('');
				$("#tapei2").select();
				layer.closeAll();
			});
			return false;
		}
		var qrSplit = $("#qrSplit").val();
		var qrIdSec = $("#qrIdSec").val();
		var rpdString = $("#rpdString").val();
		var bar2 = barcode2.split(qrSplit);
		var bar1 = barcode1.split("^");

		var qrIdSec1 = "";
		if (rpdString == "") {
			qrIdSec1 = qrIdSec - 1;
		} else {
			qrIdSec1 = qrIdSec;
		}

		if (bar1[qrIdSec1] != bar2[qrIdSec - 1].replace(rpdString.toUpperCase(), "")) {
			layer.alert('两张二维码标签卷轴号不匹配！！', {
				icon : 2
			}, function() {
				$("#barcode2").val('');
				$("#barcode2").select();
				layer.closeAll();
			});
			return false;
		}
		$("#ajaxC").click();
		$("#tapei2").select();

	}
	function t3() {
		$("#ajaxD").click();

	}
	function t() {
		var odd = $("#odd").val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "cspBarcode.action?methodstr=selOddqc", //5.1
			//提交的数据
			data : {
				"barcodeCl.odd" : odd
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				if (result == 'error') {
					layer.alert("未找到此片信息");
					$("#barcode1").select();
					return false;
				}
				var result = eval("(" + result + ")");
				var productModel = result.counter[result.counter.length - 1].lotHeader;
				var seri1 = result.counter[result.counter.length - 1].seri;
				var odd = result.counter[result.counter.length - 1].odd;
				var urg = result.counter[result.counter.length - 1].urg;
				var workIdC = result.counter[result.counter.length - 1].workIdC;
				var createTime1 = result.counter[result.counter.length - 1].createtime;


				var time = new Date(createTime1.time);
				var y = time.getFullYear();
				var m = time.getMonth() + 1;
				var da = time.getDate();
				var h = time.getHours();
				var mm = time.getMinutes();
				var s = time.getSeconds();
				s = s < 10 ? '0' + s : s;
				var createTime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s; //投入时间


				$("#productModle").val(productModel);
				$("#seri1").val(seri1);
				$("#odd1").val(odd);
				$("#urg").val(urg);
				$("#workIdC").val(workIdC);
				$("#createtime").val(createTime);


				for (var i = 0; i < result.counter.length; i++) {

					var seri = result.counter[i].seri;
					var barcode = result.counter[i].barcode;
					var lotHeader = result.counter[i].lotHeader;
					var qty = result.counter[i].qty;
					var remark = result.counter[i].remark;

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='seri' value=" + seri + " />" + seri + "</td><td>" +
						"<input type='hidden' name='barcode'  value=" + barcode + " />" + barcode + "</td><td>" +
						"<input type='hidden' name='lotHead' value=" + lotHeader + " />" + lotHeader + "</td><td>" +
						"<select name='checkBarcode' id=" + seri + "> <option value='是'>是</option> <option value='否' selected='selected'>否</option></select></td><td>" +
						"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<select name='scrollpd' id=''> <option value='OK'>OK</option> <option value='NG' '>NG</option></select></td><td>" +
						"<input type='text' name='buCause'  size='8' value='无'/></td><td>" +
						"<input type='text' name='defQty'  size='8' value=''/></td><td>" +
						"<input type='text' name='whethd' size='8' value=''/></td><td>" +
						"<input type='hidden' name='workIdC' value=" + workIdC + " />" + workIdC + "</td><td>" +
						"<input type='text' name='workIdC2' size='8' value=''/></td><td>" +
						"<input type='hidden' name='remark' value=" + remark + " />" + remark + "</td></tr>";

					$("#InputsWrapper").append(s);
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

	}

	$(document).ready(function() {
		$("#ajaxC").click(function() {
			var tapei = $('#tapei2').val().trim();
			var bar = tapei.split("^");
			var aInput = document.getElementsByName("barcode");
			var myBoolean = false;

			for (var i = 0; i < aInput.length; i++) {
				var ins = aInput[i].value.trim();

				if (ins == bar[2]) {
					/* 	$("#" + (i + 1) + "").find("option[value = '是']").attr("selected", "selected"); */
					aInput[i].parentNode.parentNode.style.background = 'red';
					myBoolean = true;
					break;
				} else {
					myBoolean = false;
				}
			}
			if (myBoolean) {
				layer.msg("卷轴存在！", {
					icon : 1,
				});
				$('.page-header input').val('');
				$("#tapei2").select();
				return false;
			} else {
				layer.msg("卷轴不存在以下列表！", {
					icon : 2
				});
				$('.page-header input').val('');
				$("#tapei2").select();
				return false;
			}

		});
		$("#ajaxD").click(function() {
			var tapei = $('#tapei1').val().trim();

			var bar = tapei.split("^");
			var y = bar.length;
			var aInput = document.getElementsByName("barcode");
			var myBoolean = false;
			for (var i = 0; i < aInput.length; i++) {

				if (aInput[i].parentNode.parentNode.style.background != 'red') {
					if (aInput[i].parentNode.parentNode.style.background != 'yellow') {

						layer.msg("有卷轴没校验，要抽检卷轴请先校验卷轴！", {
							icon : 2
						});
						return;
					}

				}
				var ins = aInput[i].value.trim();

				if (ins == bar[2]) {
					$("#" + (i + 1) + "").find("option[value = '是']").attr("selected", "selected");
					aInput[i].parentNode.parentNode.style.background = 'yellow';
					myBoolean = true;
					break;
				} else {
					myBoolean = false;
				}
			}
			if (myBoolean) {
				layer.msg("卷轴存在！", {
					icon : 1,
				});
				$('.page-header input').val('');
				return false;
			} else {
				layer.msg("卷轴不存在以下列表！", {
					icon : 2
				});
				$('.page-header input').val('');
				return false;
			}
		});

		$("#ajaxA").click(function() {
			var productModel = $('#productModle').val().trim();
			var seri1 = $('#seri1').val().trim();
			var odd1 = $('#odd1').val().trim();
			var urg = $('#urg').val().trim();
			var workIdC = $('#workIdC').val().trim();
			var workId = $('#workId').val().trim();
			var createtime = $('#createtime').val().trim();
			var batchpd = $('input[name="batchpd"]:checked').val();
			var badSign = $('#badsign').val().trim();


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

			var scrollpd = "[";
			$("select[name=scrollpd] option:selected").each(function() {
				scrollpd += '{"scrollpd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scrollpd = scrollpd.replace(reg, "");
			scrollpd += "]";


			var buCause = "[";
			$("[name=buCause]").each(function() {
				buCause += '{"buCause":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			buCause = buCause.replace(reg, "");
			buCause += "]";


			var defQty = "[";
			$("[name=defQty]").each(function() {
				defQty += '{"defQty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			defQty = defQty.replace(reg, "");
			defQty += "]";


			var whethd = "[";
			$("[name=whethd]").each(function() {
				whethd += '{"whethd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			whethd = whethd.replace(reg, "");
			whethd += "]";

			var checkBarcode = "[";
			$("[name=checkBarcode]").each(function() {
				checkBarcode += '{"checkBarcode":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			checkBarcode = checkBarcode.replace(reg, "");
			checkBarcode += "]";


			var workIdC2 = "[";
			$("[name=workIdC2]").each(function() {
				workIdC2 += '{"workIdC2":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			workIdC2 = workIdC2.replace(reg, "");
			workIdC2 += "]";

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
				url : "cspBarcode.action?methodstr=saveQcCheck1", //5.1
				//提交的数据
				data : {
					"barcodeQC.productModel" : productModel, //产品型号
					"barcodeQC.seri1" : seri1, //送检数量
					"barcodeQC.odd" : odd1, //报检单号
					"barcodeQC.urg" : urg, //紧急程度
					"barcodeQC.workIdC" : workIdC, //报检员
					"barcodeQC.createtime" : createtime, //送检时间
					"barcodeQC.seri" : seri, //序号
					"barcodeQC.barcode" : barcode, //卷轴号
					"barcodeQC.lotHeader" : lotHead, //批次头
					"barcodeQC.qty" : qty, //卷轴数量
					"barcodeQC.scrollpd" : scrollpd, //卷轴判定
					"barcodeQC.buCause" : buCause, //不良原因
					"barcodeQC.defQty" : defQty, //不良数量
					"barcodeQC.whethd" : whethd, //重工确认
					"barcodeQC.remark" : remark, //备注
					"barcodeQC.batchdet" : batchpd, //批次判定
					"barcodeQC.badSign" : badSign, //不良签收员
					"barcodeQC.workId" : workId, //
					"barcodeQC.workIdC2" : workIdC2, //
					"barcodeQC.checkBarcode" : checkBarcode //
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#barcode1").select();
						return false;
					}
					if (result == 'success') {
						layer.alert("审核成功");
						window.location.href = "<%=request.getContextPath()%>/cspBarcode/QCcheck.jsp";
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
<base href="<%=basePath%>">
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="t()">
	<input type="hidden" id="odd" value="<%=odd%>" />
	<input type="hidden" id="workId" value="<%=workId%>" />
	<center>
		<div class="page-header">
			<table>
				<tr>
					<td>校验卷轴对校 <br>扫小标签卷轴号：<input type="text" id="tapei2"
						onkeyup="this.value=this.value.toUpperCase()"
						onkeypress='if(event.keyCode==13) t1();'>&nbsp;<!-- 校验卷轴号是否在以下列表中存在 -->
						<br>扫大标签卷轴号：<input type="text" id="tapei"
						onkeypress='if(event.keyCode==13) t2();'
						onkeyup="this.value=this.value.toUpperCase()">&nbsp;
						<button class="btn btn-primary" id="ajaxC" onclick="setFocus()">确定</button></td>
					<td>抽检卷轴号<br>扫小标签卷轴号：<input type="text" id="tapei1"
						onkeypress='if(event.keyCode==13) t3();'
						onkeyup="this.value=this.value.toUpperCase()">&nbsp;
						<button class="btn btn-primary" id="ajaxD" onclick="setFocus()">确定</button></td>
				</tr>
			</table>
			<br>

		</div>

		<div>
			<table id="InputsWrapper" border="1">
				<tr>
					<td colspan="9" align="center" style='font-size:22px'>入库报检单</td>
				</tr>
				<tr>

					<!-- $("#seri1").val(seri1); -->
					<td>产品型号：</td>
					<td><input type="text" size="8" id="productModle" value=""
						readonly="true " /></td>
					<td>送检数量：</td>
					<td><input type="text" size="8" id="seri1" value=""
						readonly="true " /></td>
					<td>报检单号：</td>
					<td><input type="text" size="16" id="odd1" value=""
						readonly="true " /></td>
				</tr>
				<tr>
					<td>紧急程度：</td>
					<td><input type="text" size="8" id="urg" value=""
						readonly="true " /></td>
					<td>报检员：</td>
					<td><input type="text" size="8" id="workIdC" value=""
						readonly="true " /></td>
					<td>送检时间：</td>
					<td><input type="text" size="12" value="" readonly="true"
						id="createtime" /></td>
				</tr>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />

				<tr>
					<td>序号</td>
					<td>卷轴号</td>
					<td>批次头</td>
					<td>抽检卷轴号</td>
					<td>数量</td>
					<td>卷轴判定</td>
					<td>不良原因</td>
					<td>不良数量</td>
					<td>重工确认</td>
					<td>报检人</td>
					<td>检验员</td>
					<td>备注</td>
				</tr>
				<input type="hidden" id="qrIdSec" />
				<input type="hidden" id="qrSplit" />
				<input type="hidden" id="rpdString" />
				<table border="1">
					<tr>
						<td>批次判定</td>
						<td colspan="3"><input type="radio" name="batchpd"
							id="batchpd" value="允收" />允收 <input type="radio" name="batchpd"
							id="batchpd" value="判退" />判退</td>
						<td colspan="2">不良签收员：</td>
						<td><input type="text" size="8" name="badsign" id="badsign" /></td>
					</tr>
				</table>
				<tr>
					<input type="button" class="btn btn-primary" id="ajaxA" value="提交" />
				</tr>
				</div>

				</center>
</body>
</html>