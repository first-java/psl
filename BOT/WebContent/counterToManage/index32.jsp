<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	String rootLotId = (String) request.getParameter("rootLotId");//直接传递
	String materialName = (String) request.getParameter("materialName");//直接传递
	String qty = (String) request.getParameter("qty");//直接传递
	String qty1 = (String) request.getParameter("qty1");//直接传递
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
<title></title>
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
</head>
<script type="text/javascript">

	function check() {

		//$("#test").val()
		var s = $("#qty").val();
		var s1 = $("#qty1").val();
		var value = parseInt(parseInt(s1) / parseInt(s));
		$("#tr1").empty();
		for (var i = 0; i < value; i++) {
			//	var barcodeId = " 'barcodeId' + (i + 1) "
			var p = (i + 1);

			var input = "<td><input type='text' onkeypress='if(event.keyCode==13) t(this, " + p + ");' onkeyup='this.value=this.value.toUpperCase()' id=" + 'barcodeId' + "" + "" + (i + 1) + " name='barcodeId' placeholder=卷轴号" + (i + 1) + "></td>";
			$("#tr1").append(input);
		}
		$("#ajaxA").click();

	}

	/* $("#div1").mouseenter(function() {
		$(this).find("input").click(function() {
			$(this).hide();
		});
		
	禁止粘贴  onpaste="return false" id="test1"
	}); */
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var rootLotId = $("#rootLotId").val();
			var materialName = $("#materialName").val();
			layer.load();

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=filmNoBind2", //12.1 查询预设机台
				//提交的数据
				data : {
					"counter.rootLotId" : rootLotId,
					"counter.materialName" : materialName
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == '没有满足满卷数量的蓝膜') {
						layer.open({
							title : '信息提示',
							content : '没有满足满卷数量的蓝膜'
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
							"<input type='hidden' name='product' id='product' value=" + product + " />" + product + "</td><td>" +
							"<input type='hidden' name='rootLotId' id='rootLotId' value=" + rootLotId + " />" + rootLotId + "</td><td>" +
							"<input type='hidden' name='materialName' id='materialName' value=" + materialName + " />" + materialName + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='shelfName' id='shelfName' value=" + shelfName + " />" + shelfName + "</td><td>" +
							"<input type='hidden' name='caseNo' id='caseNo' value=" + caseNo + " />" + caseNo + "</td><td>" +
							"<input type='hidden' name='intime' id='intime' value=" + intime + " />" + intime +
							"</td></tr>";
						$("#sample5").append(s);
					/* 	$('.page-header input').val(''); */
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
		$("#ajaxE").click(function() {
			var product1 = $('#product2').val();
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
					document.getElementById('product2').select();
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
				}, function() {
					document.getElementById('product2').select();
				});
				return false;
			}

		});
		$("#ajaxB").click(function() {

			//var aInput = $("input[name='barcodeId']").val();
			var aInput = document.getElementsByName("barcodeId");
			for (var i = 0; i < aInput.length; i++) {
				if (aInput[i].value == '') {
					layer.msg("请录入卷轴" + (i + 1) + "！", {
						icon : 2
					});
					return false;
				}
			}
			var aInput1 = document.getElementsByName("product");
			for (var i = 0; i < aInput1.length; i++) {

				if (aInput1[i].parentNode.parentNode.style.backgroundColor != "pink") {
					layer.alert("有片号没校验！" + aInput1[i].value);
					return false;

				}
			}
			var rootLotId = $("#rootLotId").val();
			var workId = $("#workId").val();
			var materialName = $("#materialName").val();

			var barcodeId = "[";
			$("[name='barcodeId']").each(function() {
				barcodeId += '{"barcodeId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			barcodeId = barcodeId.replace(reg, "");
			barcodeId += "]";

			var product = "[";
			$("[name='product']").each(function() {
				product += '{"product":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			product = product.replace(reg, "");
			product += "]";

			var qty = "[";
			$("[name='qty']").each(function() {
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
				url : "ctm.action?methodstr=filmNoBind3", //4.2
				//提交的数据
				data : {
					"counter.barcodeId" : barcodeId,
					"counter.product" : product,
					"counter.rootLotId" : rootLotId,
					"counter.materialName" : materialName,
					"counter.qty" : qty,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作

				success : function(result) {
					if ("绑定成功！" == result) {
						layer.alert(result, {
							icon : 1
						}, function() {
							window.location.go(-1);

						});
					} else
						layer.alert(result, function() {
							window.location.reload();

						});

				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					layer.msg("服务器出错！", {
						icon : 2
					}, function() {
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}
			});

		});
	});
	function check1() {
		$("#ajaxE").click();
	}
	function setFocus() {
		document.getElementById('barcodeId1').select();
	}
	function t(obj, id) {
		var idd = Number(id) + 1;

		$("#barcodeId" + idd + "").select();
	}
	// 两秒后模拟点击
	setTimeout(function() {
		// IE
		if (document.all) {
			document.getElementById("clickMe").click();
		}
		// 其它浏览器
		else {
			var e = document.createEvent("MouseEvents");
			e.initEvent("click", true, true);
			document.getElementById("clickMe").dispatchEvent(e);
		}
	}, 200);
</script>
<style>
body {
	padding: 0;
	margin: 0;
	font: normal 24px/36px "\5FAE\8F6F\96C5\9ED1";
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
	line-height: 20px;
	font-size: 14px;
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
<body onload="check()">
	<input id="clickMe" type="hidden" onclick="setFocus()"
		value="Set focus" />
	<input type="hidden" id="ajaxA" />
	<input type="hidden" id="ajaxE" />
	<input type="hidden" value="<%=qty%>" id="qty" />
	<input type="hidden" value="<%=qty1%>" id="qty1" />
	<input type="hidden" value="<%=rootLotId%>" id="rootLotId" />
	<input type="hidden" value="<%=materialName%>" id="materialName" />
	<input type="hidden" value="<%=workId%>" id="workId" />
	<table>
		<tr>
			<td>卷轴号</td>
		</tr>
		<tr id="tr1">
		</tr>
	</table>

	<table id="sample-table-1">
		<tr>
			<td>在以下列表查询蓝膜： <input type="text" id="product2"
				onkeyup="this.value=this.value.toUpperCase()"
				onkeypress='if(event.keyCode==13) check1();' name="product2"></td>

		</tr>
		<br>
	</table>
	<br>
	<table id="sample5">

		<tr>
			<td>蓝膜号</td>
			<td>5位批次头</td>
			<td>级别</td>
			<td>数量</td>
			<td>货架号</td>
			<td>箱号</td>
			<td>入库时间</td>
		</tr>

	</table>
	<br>
	<table>
		<tr>
			<td><button class='btn btn-primary' id='ajaxB'>提交绑定数据</button></td>
		</tr>
	</table>
</body>
</html>