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
<title>补料</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var status = $("#status").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectEqpt3", //13.1
				//提交的数据
				data : {
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == "没有找到数据！") {
						layer.msg(result, {
							icon : 2
						});
						return false;
					}
					var result = eval("(" + result + ")");

					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].eqptId;
						var str = $.trim($("#ss").val());

						s = "<option value=" + eqptId + ">" + eqptId + "</option>"
						var luckElements = document.getElementsByName("materialname");

						$("#sample").append(s);
					/* 	$('.page-header input').val(''); */
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
		$("#ajaxB").click(function() {
			var eqpt = $('#sample option:selected').val();
			var materialName = $("#materialName").prop("value");
			var qty = $("#qty").prop("value");
			var intime = $("#intime").prop("value");
			var product = $("#product").prop("value");
			var lotHead2 = $("#lotHead2").prop("value");
			if (materialName == "") {
				layer.msg("请先设置产品", {
					icon : 2
				});
				return false;
			}

			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";


			var lotHead = "[";
			$("[name=lotHead]").each(function() {
				lotHead += '{"lotHead":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotHead = lotHead.replace(reg, "");
			lotHead += "]";

			var product = "[";
			$("[name=product]").each(function() {
				product += '{"product":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			product = product.replace(reg, "");
			product += "]";


			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=savePresetEqpt", //11.2
				//提交的数据
				data : {
					"counter.materialName" : materialName,
					"counter.eqptId" : eqpt,
					"counter.lotHead" : lotHead,
					"counter.product" : product,
					"counter.lotHead2" : lotHead2,
					"counter.qty" : qty
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "设置成功") {
						layer.msg("设置成功", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
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
		$("#ajaxD").click(function() {
			var eqpt = $('#sample option:selected').val();
			var product1 = $('#product1').val();
			var workId = $('#workId').val();
			if (product1 == "") {
				layer.msg("请输入蓝膜！", {
					icon : 2
				});
				return false;
			}

			var aInput = document.getElementsByName("product");

			var myBoolean = false;
			if (aInput.length < 0) {
			
				return;
			}
			for (var i = 0; i < aInput.length; i++) {
				var ins = aInput[i].value;

				if (ins == product1) {
					myBoolean = true;
					break;
				} else {
					myBoolean = false;
				}
			}

			if (myBoolean) {
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "ctm.action?methodstr=saveEqptIng", //12.2
					//提交的数据
					data : {
						"counter.product1" : product1,
						"counter.eqptId" : eqpt,
						"counter.workId" : workId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数

					success : function(result) {

						if (result == "设置成功") {
							layer.msg("设置成功", {
								icon : 1
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
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
			} else {
				layer.msg("蓝膜不存在以上列表！", {
					icon : 2
				});
				return false;
			}

		});
	});
	function check() {
		$("#ajaxA").click();
	}
</script>
<script type="text/javascript">

	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxC").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
<body onload="check()">
	<div class="page-header">
		<h4>
			<hr>
			<span class="badge badge-pink">&nbsp;&nbsp;&nbsp;&nbsp;补料&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<hr>
			<input type="hidden" id="ajaxA" />
			<!-- <button class="btn btn-primary" id="ajaxC" onclick="setFocus()">选中机台</button> -->
		</h4>
		<table>

		</table>
		<table align="left" width="30%" id="sample-table-1">
			<tr>
				<td>选择机台： <select id="sample"><option>请选择...</option></select>
				</td>
			</tr>
		</table>
	</div>
	<table class="table table-striped table-bordered table-hover"
		id="sample2" width="50%">

		<tr>
			<td>货架号</td>
			<td>箱号</td>
			<td>数量</td>
			<td>蓝膜号</td>
			<td>5位批次头</td>
			<td>级别</td>
			<td>入库时间</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>出库校验（蓝膜是否在以上列表中存在）<input
				onkeyup="this.value=this.value.toUpperCase()" type="text"
				name="product1" id="product1" /> <input type="hidden" name="workId"
				id="workId" value="<%=workId%>" />
				<button class="btn btn-primary" id="ajaxD" onclick="setFocus()">确定</button>
			</td>
		</tr>
	</table>
</body>
</html>
<script>
	$("#sample").change(function() {
		var eqpt = $('#sample option:selected').val();

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=selectDoing", //13.2
			//提交的数据
			data : {
				"counter.eqptId" : eqpt,
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				if (result == 's') {
					layer.msg("未找到改两位批次", {
						icon : 2
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}

				if (result == "d") {
					layer.msg("货架上未找到此产品", {
						icon : 2
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}

				var result = eval("(" + result + ")");
				for (var i = 0; i < result.counter.length; i++) {
					var product = result.counter[i].product;
					var rootLotId = result.counter[i].lotHead;
					var materialName = result.counter[i].materialName;
					var qty = result.counter[i].qty;
					var shelfName = result.counter[i].shelfName;
					var caseNo = result.counter[i].caseNo;
					var intime = result.counter[i].intime;

					s = "<tr><td>" + shelfName +
						"<input type='hidden' readonly='true' name='shelfName' id='shelfName' value=" + shelfName + " />" + "</td><td>" +
						caseNo + "<input type='hidden' readonly='true' name='caseNo' id='caseNo' value=" + caseNo + " />" + "</td><td>" +
						qty + "<input type='hidden' readonly='true'  name='qty' id='qty' value=" + qty + " />" + "</td><td>" +
						product + "<input type='hidden' readonly='true'  name='product' id='product' value=" + product + " />" + "</td><td>" +
						rootLotId + "<input type='hidden' readonly='true' name='rootLotId' id='rootLotId' value=" + rootLotId + " />" + "</td><td>" +
						materialName + "<input type='hidden' readonly='true' name='materialName' id='materialName' value=" + materialName + " />" + "</td><td>" +
						intime + "<input type='hidden' readonly='true' name='intime' id='intime' value=" + intime + " />" +
						"</td></tr>";

					$("#sample2").append(s);
				/* 	$('.page-header input').val(''); */
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
</script>