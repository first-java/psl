
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>蓝膜入库</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
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
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('barcode1').focus()
	}
	function loseFocus() {
		document.getElementById('barcode1').blur()
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

<script>
	$(document).ready(function() {
		$("#ajaxA").click(function() {

			var obj = $("#barcode1").prop("value");
			var obj1 = $("#barcode2").prop("value");
			var obj2 = $("#barcode3").prop("value");
			var obj3 = $("#workId").prop("value");
			if (obj === "") {
				layer.msg("还没输入箱号", {
					icon : 2
				}, function() {});
				return false;
			}
			if (obj1 === "") {
				layer.msg("还没输入蓝膜", {
					icon : 2
				})

				return false;
			}
			if (obj2 === "") {
				layer.msg("还没输入数量", {
					icon : 2
				})

				return false;
			}
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "re.action?methodstr=save", //自己的url
				//提交的数据
				data : {
					"caseNo" : obj,
					"filmNo" : obj1,
					"pcs" : obj2,
					"workId" : obj3
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "message") {
						layer.msg("沒有查到數據", {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "ss") {
						layer.msg("保存成功", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "cf") {
						layer.msg("蓝膜号已存在", {
							icon : 2
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
	});
	function getsubId(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}

	function a() {
		$("#ajaxA").click();
	}
	function _b() {
		if (event.keyCode == 13)
			a();
	}
</script>

</head>
<body onKeyDown="_b()">

	<div class="div2">
		<from>
		<table>
			<tr>
				<td>入库</td>
			</tr>
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td>箱 &nbsp;&nbsp;号： <input type="text" name="caseNo"
					id="barcode1" onkeypress='if(event.keyCode==13) getsubId(this,1);' />
				</td>
			</tr>
			<tr>
				<td>蓝膜号： <input type="text" name="filmNo" id="barcode2"
					onkeypress='if(event.keyCode==13) getsubId(this,2);' /></td>
			</tr>
			<tr>
				<td>数 &nbsp;&nbsp;量： <input type="text" name="pcs" size="6"
					id="barcode3" onkeypress='if(event.keyCode==13) getsubId(this,3);' /></td>
			</tr>
			<input type="hidden" name="workId" value="<%=workId%>" id="workId" />
			<tr>
				<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td>
				<input id="ce" type="hidden" onclick="a()" />
			</tr>
			</tr>
		</table>
		<hr>

		<hr>
		<form id="myForm"
			action="<%=path%>/downloads.action?methodstr=downloadReport"
			method="post" enctype="multipart/form-data">
			<td><button class="btn btn-primary" id="ajaxA" value="ss">下载清单</button></td>
		</form>
	</div>
</body>
</html>