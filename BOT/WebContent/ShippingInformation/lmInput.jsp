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
<title>Lumileds芯片入库</title>
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


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luck = document.getElementsByName("lmQty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);

		}
		var luckElements = document.getElementsByName("mesLot");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片</font></td>"
		$("#tt").append(ss);

		$("td[name='count']").remove();
		c = "<td name='count' style='color:red'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var binTapeId = $("#barcode1").prop("value");


			if (binTapeId.trim() == "") {
				layer.msg("还没录入binTapeId", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=lumiledsLotNo", //5.1
				//提交的数据
				data : {
					"shippingInformation.binTapeId" : binTapeId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'error') {
						layer.msg("该片已经入库！", {
							icon : 2
						});
						$('.page-header input').val('');
						return false;
					}
					var result = eval("(" + result + ")");

					for (var i = 0; i < result.sf.length; i++) {
						var smartLot = result.sf[i].smartLot;
						var mesLot = result.sf[i].mesLot;
						var Bin = result.sf[i].bin;
						var lmQty = result.sf[i].lmQty;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='smartLot' value=" + smartLot + " />" + smartLot + "</td><td>" +
							"<input type='hidden' name='mesLot' value=" + mesLot + " />" + mesLot + "</td><td>" +
							"<input type='hidden' name='Bin' value=" + Bin + " />" + Bin + "</td><td>" +
							"<input type='hidden' name='lmQty' value=" + lmQty + " />" + lmQty + "</td><td>" +

							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";
						var luckElements = document.getElementsByName("smartLot");
						var tapeId = smartLot;


						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}

						}
						$("td[name='s']").remove();
						ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "片<font size='8' color='red'></td>"
						$("#tt").append(ss);
						$("#sample-table-1").append(s);
						var count1 = 0;
						var luck = document.getElementsByName("lmQty");
						for (var i = 0; i < luck.length; i++) {
							count1 += Number(luck[i].value);
						}
						$("td[name='count']").remove();
						c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
						$("#tt").append(c);
					}
					$("#barcode1").select();
					
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

		$("#ajaxB").click(function() {

			var smartLot = "[";
			$("[name=smartLot]").each(function() {
				smartLot += '{"smartLot":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			smartLot = smartLot.replace(reg, "");
			smartLot += "]";

			var mesLot = "[";
			$("[name=mesLot]").each(function() {
				mesLot += '{"mesLot":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			mesLot = mesLot.replace(reg, "");
			mesLot += "]";


			var Bin = "[";
			$("[name=Bin]").each(function() {
				Bin += '{"Bin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			Bin = Bin.replace(reg, "");
			Bin += "]";

			var lmQty = "[";
			$("[name=lmQty]").each(function() {
				lmQty += '{"lmQty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lmQty = lmQty.replace(reg, "");
			lmQty += "]";
			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=lumiledsPutIn", //11.2
				//提交的数据
				data : {
					"shippingInformation.workId" : "F489",
					"shippingInformation.smartLot" : smartLot,
					"shippingInformation.mesLot" : mesLot,
					"shippingInformation.Bin" : Bin,
					"shippingInformation.lmQty" : lmQty
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
					});
					return false;
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
		var workId = $("#workId").prop("value");
		layer.load();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ShippingInformationC.action?methodstr=select1",
			//提交的数据
			data : {
				"shippingInformation.workId" : "F489"
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 'noUser') {

					layer.open({
						area : [ '500px', '300px' ],
						closeBtn : 0,
						type : 1,
						content : '很抱歉，您無此權限' //这里content是一个普通的String
					});
					return false;

				} else {
					layer.closeAll();
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
</script>
<script type="text/javascript">
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
		$("#barcode" + (idd + 1) + "").select();

	}
	function t2() {
		$("#ajaxA").click();
	}
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">Bin Tape ID：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t2();'
					onkeyup="this.value=this.value.toUpperCase()">
				</td>

				<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>Bin Tape ID</th>
				<th>Smart Lot</th>
				<th>Bin</th>
				<th>Qty</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />

</body>
</html>

