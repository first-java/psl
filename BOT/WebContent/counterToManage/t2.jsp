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
<title>条码打印</title>
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
		$("#ajaxS").click(function() {
			var barcodeId = "[";
			$("[name='barcodeId']").each(function() {
				barcodeId += '{"barcodeId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			barcodeId = barcodeId.replace(reg, "");
			barcodeId += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=pti", //12.3
				//提交的数据
				data : {
					"counter.barcodeId" : barcodeId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
				success : function(result) {
					if (result == '没有满足满卷数量的蓝膜') {
						layer.msg('没有满足满卷数量的蓝膜！', {
							icon : 2
						}, function() {
							layer.closeAll();
						});

					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var product = result.counter[i].product;
						var rootLotId = result.counter[i].lotHead;
						var floors = result.counter[i].floors;
						var materialName = result.counter[i].materialName;
						var qty1 = result.counter[i].qty;
						var shelfName = result.counter[i].shelfName;
						var caseNo = result.counter[i].caseNo;
						var intime = result.counter[i].intime;
						var str = $.trim($("#ss").val());
						var qty = $('#lotHead2').val();
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='rootLotId' id='rootLotId' value=" + rootLotId + " />" + rootLotId + "</td><td>" +
							"<input type='hidden' name='materialName' id='materialName' value=" + materialName + " />" + materialName + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty1 + " />" + qty1 + "</td><td>" +
							"<a href='counterToManage/index32.jsp?rootLotId=" + rootLotId + "&&materialName=" + materialName + "&&qty1=" + qty1 + "&&qty=" + qty + " '>蓝膜卷轴绑定</a>" +
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
	});
</script>
<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#lotHead" + idd + "").select();
	}
	function setFocus() {
		document.getElementById('lotHead1').select();
	}
	$(function() {
		$("#test1").change(function() {
			var value = $(this).val();
			$("#tr1").empty();
			for (var i = 0; i < value; i++) {
				var input = "<td><input type='text' value=inp" + i + " /></td>";
				$("#tr1").append(input);
			}
		/* $("#div1").mouseenter(function() {
			$(this).find("input").click(function() {
				$(this).hide();
			});
			
		禁止粘贴  onpaste="return false" id="test1"
		}); */
		});

	});
</script>
<body>


	<table align="left" id="sample-table-1">
		<tr>
			<td>输入两位或五位批次头：<input type="text" id="lotHead1" name="barcodeId" /></td>
			<td>输入满卷数量: <input type="text" name="barcodeId"></td>
			<td colspan="2">
				<button class="btn btn-primary" id="ajaxS" onclick="setFocus()">查询满足条件的蓝膜</button>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>

		<tr id="tr1">
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<!-- <tr>
			<td>在以下列表查询蓝膜： <input type="text" id="product2"
				onkeyup="this.value=this.value.toUpperCase()"
				onkeypress='if(event.keyCode==13) check1();' name="product2"></td>
			<td colspan="3"><button class="btn btn-primary">查询</button></td>
		</tr> -->
		<br>
	</table>
	<br>

	<hr>
	<table class="table  table-bordered table-hover" id="sample5"
		width="50%">
		<tr>
			<td>批次头</td>
			<td>级别</td>
			<td>总颗粒数</td>
			<td>操作</td>
		</tr>
	</table>

	<table>
		<tr>
			<%-- <td>出库校验（蓝膜是否在以上列表中存在）<input type="text" name="product1"
				onkeyup="this.value=this.value.toUpperCase()" id="product1" /> <input
				type="hidden" value="<%=workId%>" id="workId" /> --%>
			<button class="btn btn-primary" id="ajaxD"
				onkeypress='if(event.keyCode==13) check1();'>确定</button>
			</td>
		</tr>
	</table>

</body>
</html>
<script>
	$("#lotHead2").blur(function() {

		$("#ajaxS").click();
	});
</script>
<script>
	function shuru(txt) {
		var reg = /\d/g;
		if (isNaN(txt.value)) {
			layer.msg("只能输入数字！", {
				icon : 2
			});
			txt.value = '';
			return false;
		}
	}
</script>