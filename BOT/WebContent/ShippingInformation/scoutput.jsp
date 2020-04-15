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
<title>首尔半导体芯片出库</title>
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
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luck = document.getElementsByName("qty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);

		}
		var luckElements = document.getElementsByName("lotNo");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片</font></td>"
		$("#tt").append(ss);

		$("td[name='count']").remove();
		c = "<td name='count'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxAA").click(function() {
			var workId = $("#workId").prop("value");
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=select",
				//提交的数据
				data : {
					"shippingInformation.workId" : workId
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
					}

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].customerDesc;
						s = "<option onchange='gradeChange()' value=" + eqptId + ">" + eqptId + "</option>"

						$("#se").append(s);
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

		$("#ajaxB").click(function() {

			layer.load();
			var customerDesc = $('#se option:selected').val();
			if (customerDesc.trim() == "请选择...") {
				layer.msg("还没选择出货客户！", {
					icon : 2
				});
				return false;
			}
			var lotNo = "[";
			$("[name=lotNo]").each(function() {
				lotNo += '{"lotNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotNo = lotNo.replace(reg, "");
			lotNo += "]";

			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=scputOut", //11.2
				//提交的数据
				data : {
					"shippingInformation.lotNo2" : lotNo,
					"shippingInformation.workId" : workId,
					"shippingInformation.customerDesc" : customerDesc
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					layer.msg(result, {
						icon : 1
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
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

	function setFocus() {
		document.getElementById('barcode1').select();
	}
	function check() {
		$("#ajaxAA").click();
	}
</script>
<script type="text/javascript">
	function t() {
		var lotN1 = $("#barcode1").prop("value");
		var y = lotN1.split(";");
		var lotNo = y[1];

		if (lotNo.trim() == "") {
			layer.msg("还没输入LOT！", {
				icon : 2
			});
			document.getElementById('barcode1').focus();
			return false;
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ShippingInformationC.action?methodstr=sclotOut", //18.1
			//提交的数据
			data : {
				"shippingInformation.lotNo2" : lotNo
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == '片号不存在！') {
					layer.alert("片号不存在！", function() {

						layer.closeAll();
						check1();
					});

				}
				var result = eval("(" + result + ")");
				var lotNo = result.sf[0];
				var qty = result.sf[1];

				s = "<tr name='sss'><td>" +
					"<input type='hidden' name='lotNo' value=" + lotNo + " />" + lotNo + "</td><td>" +
					"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td><td>" +
					"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";
				var luckElements = document.getElementsByName("lotNo");
				var tapeId = lotNo;
				for (var i = 0; i < luckElements.length; i++) {
					//获取元素的value值
					if (tapeId == luckElements[i].value) {
						layer.msg("数据重复！", {
							icon : 2
						})
						return false;
					}
				}
				var luckElements = document.getElementsByName("lotNo");
				var tapeId = document.getElementById("barcode1").value;
				$("td[name='s']").remove();
				ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "片</font></td>"
				$("#tt").append(ss);

				$("#sample-table-1").append(s);
				var count1 = 0;
				var luck = document.getElementsByName("qty");
				for (var i = 0; i < luck.length; i++) {
					count1 += Number(luck[i].value);
				}
				$("td[name='count']").remove();
				c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
				$("#tt").append(c);
				document.getElementById('barcode1').select();
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
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body onload="check()">
	<div class="page-header">
		<input type="hidden" id="ajaxAA" />
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td id="tt">片号：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t();'
					onkeyup="this.value=this.value.toUpperCase()">
				<td id="nameDiv" style="display:none"><p
						style="color:red;font-size:16px;">该片未入过库或已经出库！</p></td>
				<td id="nameDiv1" style="display:none"><p
						style="color:red;font-size:16px;">该货架处于隔离状态</p></td>
				<td id="nameDiv2" style="display:none"><p
						style="color:red;font-size:16px;">该货架处于停用状态！</p></td> 出货客户：
				<select id='se' name='customerDesc'
					onkeypress='if(event.keyCode==13) t(this,1);'>
					<option id='barcode2' onclick="setFocus()">请选择...</option>

				</select>
				<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				<input type="hidden" id="ajaxQ" onclick="setFocus()" />
				</td>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>片号</th>
				<th>数量</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />
</body>
</html>
