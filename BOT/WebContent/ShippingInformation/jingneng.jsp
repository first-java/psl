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
<title>晶能</title>
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
		c = "<td name='count'><font size='5' color='red'>总" + count1 + "K颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var lotNo = $("#barcode1").prop("value");
			if (lotNo.trim() == "") {
				layer.msg("还没输入片号！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			var luckElements = document.getElementsByName("unitId");
			var tapeId = document.getElementById("barcode1").value;
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "jna.action?methodstr=jingNeng", //5.1
				//提交的数据
				data : {
					"jn.binUnitId" : lotNo
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");

					for (var i = 0; i < result.sf.length; i++) {
						var j = i + 1;
						var list = new Array();
						var unitId = result.sf[i].unitId;
						var OutReason = result.sf[i].outReason;
						var qty = result.sf[i].qty;
						var luck = document.getElementsByName("unitId");

						for (var i = 0; i < luck.length; i++) {
							if (luck[i].value != unitId) {
								s = "<tr name='sss' ><td>" +
									"<input type='hidden' name='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
									"<input type='hidden' name='qty' value=" + (qty * 1000) + " />" + (qty * 1000) + "</td><td>" +
									"<input type='hidden' name='OutReason' value=" + OutReason + " />" + OutReason + "</td></tr>";

								/*  <td>" +
									"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td>*/
								$("#sample-table-1").append(s);
							}

						}

					}

					$("td[name='s']").remove();
					var luck = document.getElementsByName("unitId");
					ss = "<td name='s'><font size='5' color='red'>当前一共" + luck.length + "片<font size='8' color='red'></td>"
					$("#tt").append(ss);
					var count1 = 0;
					var luck = document.getElementsByName("qty");
					for (var i = 0; i < luck.length; i++) {
						count1 += Number(luck[i].value);
					}
					$("td[name='count']").remove();
					c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
					$("#tt").append(c);

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

			var unitId = "[";
			$("[name=unitId]").each(function() {
				unitId += '{"unitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			unitId = unitId.replace(reg, "");
			unitId += "]";

			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=putIn3", //11.2
				//提交的数据
				data : {
					"shippingInformation.lotNo2" : unitId,
					"shippingInformation.workId" : workId
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
		var luck = document.getElementsByName("unitId");
		if (luck.length > 0) {
			$("#ajaxA").click();
		} else {
			var lotNo = $("#barcode1").prop("value");
			if (lotNo.trim() == "") {
				layer.msg("还没输入片号！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			var luckElements = document.getElementsByName("unitId");
			var tapeId = document.getElementById("barcode1").value;
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "jna.action?methodstr=jingNeng", //5.1
				//提交的数据
				data : {
					"jn.binUnitId" : lotNo
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.sf.length; i++) {
						var j = i + 1;
						var list = new Array();
						var unitId = result.sf[i].unitId;
						var OutReason = result.sf[i].outReason;
						var qty = result.sf[i].qty;
						s = "<tr name='sss' ><td>" +
							"<input type='hidden' name='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='hidden' name='qty' value=" + (qty * 1000) + " />" + (qty * 1000) + "</td><td>" +
							"<input type='hidden' name='OutReason' value=" + OutReason + " />" + OutReason + "</td></tr>";

						$("#sample-table-1").append(s);

					}

					$("td[name='s']").remove();
					var luck = document.getElementsByName("unitId");
					ss = "<td name='s'><font size='5' color='red'>当前一共" + luck.length + "片<font size='8' color='red'></td>"
					$("#tt").append(ss);
					var count1 = 0;
					var luck = document.getElementsByName("qty");
					for (var i = 0; i < luck.length; i++) {
						count1 += Number(luck[i].value);
					}
					$("td[name='count']").remove();
					c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
					$("#tt").append(c);

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
	}
</script>


<%-- <script>
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
</script> --%>
<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}
	function setFocus() {
		document.getElementById('barcode1').select();
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

	$(document).keypress(function(e) {
		// 回车键事件  
		/* if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		} */
	});
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
				<td id="tt">片号：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<input type="button" id="button" onclick="check()" value="查重" />
	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>片号</th>
				<th>数量</th>
				<th>出货信息</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />

</body>
</html>