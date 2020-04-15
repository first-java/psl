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
<title>查询箱内物料</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('barcode2').focus()
	}
	function loseFocus() {
		document.getElementById('barcode2').blur()
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
			var obj = $("#barcode2").prop("value");

			if (obj === "") {
				layer.msg("还没填写箱號", {
					icon : 2
				}, function() {
					window.location.reload();
					var e = document.createEvent("MouseEvents");
					e.initEvent("click", true, true);
					document.getElementById("clickMe").dispatchEvent(e);
				});

				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "re.action?methodstr=all", //自己的url
				//提交的数据
				data : {
					"caseNo" : obj
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					if (result.scroll.length < 1) {
						layer.msg("没有查到数据", {
							icon : 2
						}, function() {
							$('.text input').val('');
						});

						return false;
					}
					for (var i = 0; i < result.scroll.length; i++) {

						var pcs = result.scroll[i].pcs;
						var creat_time = result.scroll[i].creat_time;
						var remark = result.scroll[i].remark;
						var root_lot_id = result.scroll[i].root_lot_id;
						var caseNo = result.scroll[i].caseNo;
						var filmNo = result.scroll[i].filmNo;
						var workid = result.scroll[i].workid;
						var str = $.trim($("#ss").val());

						s = "<tr><td>" + pcs + "</td><td>" + creat_time + "</td><td>" + remark + "</td><td>" + root_lot_id + "</td><td>" + caseNo + "</td><td>" + filmNo + "</td><td>" + workid + "</td></tr>";
						$("#sample-table-1").append(s);
					}
					$('.text input').val('');
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

		<table class="text">
			<tr>
				<td>查询箱内物料</td>
			</tr>
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td>输入箱号： <input type="text" name="caseNo" id="barcode2" />
				</td>
			</tr>
			<tr>
				<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td>
				<input id="ce" type="hidden" onclick="a()" />
			</tr>
		</table>
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>数量</th>
					<th>创建时间</th>
					<th>级别</th>
					<th>批次头</th>
					<th>箱号</th>
					<th>蓝膜号</th>
					<th>操作人</th>
				</tr>
			</thead>
			</div>
</body>
</html>