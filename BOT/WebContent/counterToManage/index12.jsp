<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递工号
	String lotHead2 = (String) request.getParameter("lotHead2");//直接传递工号
	String rootLotId = (String) request.getParameter("rootLotId");//批次头
	String materialName = (String) request.getParameter("materialName");//级别
	String eqptId = eqptId = (String) request.getParameter("eqptId");
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
		/* $("#ajaxA").click(function() {
			var rootLotId = $('#rootLotId').val();
			if (rootLotId == "无") {
				alert(" 3");
				$('#rootLotId').val("123");
				alert("123");
			}
		}); */
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
					if (result == '没有符合的数据') {
						layer.open({
							title : '信息提示',
							content : '没有符合的数据'
						}, layer.closeAll(), function() {
							window.location.reload();

						});
					}

					var result = eval("(" + result + ")");

					var mat = $('#materialName').val();
					var ro = $('#rootLotId').val();
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var product = result.counter[i].product;
						var rootLotId = result.counter[i].lotHead;
						var barcodeId = result.counter[i].barcodeId;
						var materialName = result.counter[i].materialName;
						var qty = result.counter[i].qty;
						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var createTime = result.counter[i].createTime;
						var str = $.trim($("#ss").val());
						if (ro.length > 2) {
							if (rootLotId != ro) {
								layer.open({
									title : '信息提示',
									content : '信息不符合规则'
								}, layer.closeAll());
								return;
							}
						}
						s = "<tr name='sss'><td>" +
							"<input type='hidden'  name='product'' value=" + product + " />" + product + "</td><td>" +
							"<input type='hidden'  name='rootLotId' value=" + rootLotId + " />" + rootLotId + "</td><td>" +
							"<input type='hidden'  name='materialName' value=" + materialName + " />" + materialName + "</td><td>" +
							"<input type='hidden' name='barcodeId' value=" + barcodeId + " />" + barcodeId + "</td><td>" +
							"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden'  name='createTime' value=" + createTime + " />" + createTime +
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
			var workId = $('#workId').val();
			var eqptId = $('#eqptId').val();

			var product = "[";
			$("[name='product']").each(function() {
				product += '{"product":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			product = product.replace(reg, "");
			product += "]";

			var rootLotId = "[";
			$("[name='rootLotId']").each(function() {
				rootLotId += '{"rootLotId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			rootLotId = rootLotId.replace(reg, "");
			rootLotId += "]";


			var materialName = "[";
			$("[name='materialName']").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";


			var barcodeId = "[";
			$("[name='barcodeId']").each(function() {
				barcodeId += '{"barcodeId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			barcodeId = barcodeId.replace(reg, "");
			barcodeId += "]";

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
				url : "ctm.action?methodstr=saveEqptIng", //12.2
				//提交的数据
				data : {
					"counter.product" : product,
					"counter.rootLotId" : rootLotId,
					"counter.materialName" : materialName,
					"counter.barcodeId" : barcodeId,
					"counter.workId" : workId,
					"counter.eqptId" : eqptId,
					"counter.qty" : qty
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
						window.location.go(-1);
					});
					if (result == "设置成功") {
						layer.msg("设置成功", {
							icon : 1
						}, function() {
							window.location.go(-1);

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
<body onload="check();">


	<input type="hidden" id="ajaxA" />
	<input type="hidden" value="<%=eqptId%>" id="eqptId" />
	<input type="hidden" value="<%=rootLotId%>" id="rootLotId" />
	<input type="hidden" value="<%=materialName%>" id="materialName" />
	<input type="hidden" value="<%=workId%>" id="workId" />
	<h3 color="#FF0000">
		正在向 <input type="hidden" value="<%=eqptId%>" /><%=eqptId%>机台派料，请选择 <input
			type="hidden" value="<%=lotHead2%>" id="lotHead2" /><%=lotHead2%>产品，请扫描
		<input type="hidden" value="<%=rootLotId%>" id="rootLotId" /><%=rootLotId%>批次头，
		<input type="hidden" value="<%=materialName%>" id="materialName" /><%=materialName%>级别的卷轴,
	</h3>
	<table align="left" id="sample-table-1">
		<tr>
			<td>扫描卷轴号: <input type="text" id="barcodeId">
			</td>
			<td colspan="2"><button class="btn btn-primary" id="ajaxS">确定</button></td>
			<td>在以下列表查询蓝膜： <input type="text" id="product2"
				onkeyup="this.value=this.value.toUpperCase()"
				onkeypress='if(event.keyCode==13) check1();' name="product2"></td>
			<td colspan="3"><button class="btn btn-primary" id="ajaxE">查询</button></td>
		</tr>
		<br>
	</table>
	<br>
	<hr>
	<table class="table  table-bordered table-hover" id="sample5"
		width="50%">
		<tr>
			<td>蓝膜号</td>
			<td>5位批次头</td>
			<td>级别</td>
			<td>卷轴号</td>
			<td>数量</td>
			<td>绑定时间</td>
		</tr>
	</table>

	<table>
		<tr>
			<td><input type="hidden" value="<%=workId%>" id="workId" />
				<button class="btn btn-primary" id="ajaxD">确定</button></td>
		</tr>
	</table>

</body>
</html>