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
<title>银胶查批次</title>
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
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luckElements = document.getElementsByName("fullName");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "支</font></td>"
		$("#tt").append(ss);
	}
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var batchs1 = $("#barcode1").prop("value");
			var batchs = batchs1.replace(/\s+/g, "");
			if (batchs.trim() == "") {
				layer.msg("还没录入信息！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ela.action?methodstr=selectBatch", //5.1
				//提交的数据
				data : {
					"ebs.fullName" : batchs,
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
				success : function(result) {
					if (result == 'no') {
						layer.msg("没有找到此二维码信息", {
							icon : 2
						});
						document.getElementById('barcode1').focus();
						return false;
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.sf.length; i++) {
						var fullName = result.sf[i].fullName;
						var inTime = result.sf[i].inTime;
						var time = new Date(inTime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
						var inUser = result.sf[i].inUser;
						var lotId = result.sf[i].lotId;
						s = "<tr name='sss'><td>" +
							"<input type='hidden' value=" + fullName + " />" + fullName +
							"</td><td>" +
							"<input type='hidden' value=" + adtime + " />" + adtime +
							"</td><td>" +
							"<input type='hidden' value=" + inUser + " />" + inUser +
							"</td><td>" +
							"<input type='hidden' value=" + lotId + " />" + lotId +
							"</td></tr>";
						$("#sample-table-1").append(s);
						$('#shelf').val('');
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
<script>
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}
	function setFocus() {
		document.getElementById('barcode1').select();
	}
	function check() {
		$("#ajaxAA").click();
	}
</script>
<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}
	function setFocus() {
		document.getElementById('barcode1').select();
	}
	function check2() {
		$("#ajaxA").click();
	}
</script>
</head>
<body onload="check()">
	<div class="page-header">

		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td id="tt">扫描二维码：<input id="barcode1" type="text" size="28"
					onkeyup="this.value=this.value.toUpperCase()"
					onkeypress='if(event.keyCode==13) check2();'> <input
					type="hidden" id='barcode2' onclick="setFocus()"> <input
					type="hidden" id="ajaxA" onclick="setFocus()" />
				</td>
			</tr>
		</table>
	</div>
	<br>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>二维码信息</th>
				<th>采集时间</th>
				<th>添加人</th>
				<th>批号</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<!-- <input class="btn btn-primary" type="button" id="ajaxB" value="提交" onclick="check()" /> -->
</body>
</html>
