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
<title>机台派料</title>
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
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectEqpt2", //12.1 查询预设机台
				//提交的数据
				data : {

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == '没有找到可以派料的机台！') {
						layer.open({
							title : '信息提示',
							content : '没有找到可以派料的机台,请先设置'
						}, layer.closeAll());
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].eqptId;
						var lotHead2 = result.counter[i].lotHead2;
						var rootLotId = result.counter[i].rootLotId;
						var materialName = result.counter[i].materialName;
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='rootLotId' id='eqptId' value=" + eqptId + " />" + eqptId + "</td><td>" +
							"<input type='hidden' name='lotHead2' id='lotHead2' value=" + lotHead2 + " />" + lotHead2 + "</td><td>" +
							"<input type='hidden' name='rootLotId' id='rootLotId' value=" + rootLotId + " />" + rootLotId + "</td><td>" +
							"<input type='hidden' name='materialName' id='materialName' value=" + materialName + " />" + materialName + "</td><td>" +
							"<a href='counterToManage/index12.jsp?rootLotId=" + rootLotId + "&&eqptId=" + eqptId + "&&materialName=" + materialName + "&&lotHead2=" + lotHead2 + " '>派料</a>" +
							"</td></tr>";
						$("#sample-table-1").append(s);
					/* $('.page-header input').val(''); */
					}
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
		});
		$("#ajaxS").click(function() {
			layer.load();

			var barcodeId = $('#barcodeId').val();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectBind", //12.3
				//提交的数据
				data : {
					"counter.barcodeId" : barcodeId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == '没有满足满卷数量的蓝膜可派') {
						layer.open({
							title : '信息提示',
							content : '没有满足满卷数量的蓝膜可派'
						}, layer.closeAll());
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var product = result.counter[i].product;
						var rootLotId = result.counter[i].lotHead;
						var floors = result.counter[i].floors;
						var materialName = result.counter[i].materialName;
						var qty = result.counter[i].qty;
						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var intime = result.counter[i].intime;
						var str = $.trim($("#ss").val());

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true' name='product' id='product' value=" + product + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='rootLotId' id='rootLotId' value=" + rootLotId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='materialName' id='materialName' value=" + materialName + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='qty' id='qty' value=" + qty + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='shelfName' id='shelfName' value=" + shelfName + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='caseNo' id='caseNo' value=" + caseNo + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='intime' id='intime' value=" + intime + " />" +
							"</td></tr>";
						$("#sample5").append(s);
					/* 	$('.page-header input').val(''); */
					}
					layer.closeAll();
				},
				//调用执行后调用的函数
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框

					layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});
		});
		$("#ajaxD").click(function() {
			var eqpt = $('#sample option:selected').val();
			var lotHead2 = $('#sample1 option:selected').val();
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
					aInput[i].parentNode.parentNode.style.background = 'red';
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
						"counter.lotHead2" : lotHead2,
						"counter.eqptId" : eqpt,
						"counter.workId" : workId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
					success : function(result) {
						layer.open({
							title : '信息提示',
							content : result
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
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

		$("#ajaxE").click(function() {
			var product1 = $('#product2').val();
			alert(product1);
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
					aInput[i].parentNode.parentNode.style.background = 'pink';
					myBoolean = true;
					break;
				} else {
					myBoolean = false;
				}
			}

			if (myBoolean) {

				return false;

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
	function check1() {
		$("#ajaxE").click();
	}
</script>
<body onload="check()">

	<input type="hidden" id="ajaxA" />
	<table
		<table  class="table table-bordered table-hover" align="left" id="sample-table-1">
		<tr>
			<td>选择机台</td>
			<td>预设两位产品</td>
			<td>正在做的产品的批次头</td>
			<td>正在做的产品的级别</td>
			<td>操作</td>
		</tr>
	</table>
</body>
</html>