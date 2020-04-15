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
<title>固晶录入</title>
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
			var fullName1 = $("#barcode1").prop("value");
			var fullName = fullName1.replace(/\s+/g, "");
			//onkeyup="this.value=this.value.replace(' ','')
			if (fullName1.trim() == "") {
				layer.msg("还没录入信息！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			s = "<tr name='sss'><td>" +
				"<input type='hidden' name='fullName' value=" + fullName + " />" + fullName + "</td><td>" +
				"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";
			var luckElements = document.getElementsByName("fullName");
			var tapeId = document.getElementById("barcode1").value.replace(/\s+/g, "");
			for (var i = 0; i < luckElements.length; i++) {
				//获取元素的value值
				if (tapeId == luckElements[i].value) {
					layer.msg("数据重复！", {
						icon : 2
					})
					return false;
				}
			}
			var luckElements = document.getElementsByName("fullName");
			var tapeId = document.getElementById("barcode1").value.replace(/\s+/g, "");
			;
			$("td[name='s']").remove();
			ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "支</font></td>"
			$("#tt").append(ss);

			$("#sample-table-1").append(s);
		});
		$("#ajaxB").click(function() {
			//.replace(/\s+/g,"")

			var fullName = "[";
			$("[name=fullName]").each(function() {
				fullName += '{"fullName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			fullName = fullName.replace(reg, "");
			fullName += "]";
			if (fullName.length == 2) {
				layer.msg("没有任何数据可以提交！", {
					icon : 2
				}, function() {
					var e = document.createEvent("MouseEvents");
					e.initEvent("click", true, true);
					document.getElementById("clickMe").dispatchEvent(e);
				});
				return false;
			}
			var workId = $("#workId").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "diebond.action?methodstr=execute2", //11.2
				//提交的数据
				data : {
					"dieBond.lotNo" : fullName,
					"dieBond.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					alert(result)
					if (result == 'success') {
						layer.msg("录入成功！", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
						return false;
					} else {
						layer.msg("录入失败！", {
							icon : 2
						});
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
				<td id="tt">扫描信息：<input id="barcode1" type="text" size="28"
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
				<th>片号</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />
</body>
</html>
