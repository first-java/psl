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
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>检卷轴接收</title>
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var obj = $("#form-field-icon-1").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tion.action?methodstr=notest", //自己的url
				//提交的数据
				data : {
					"tapeId" : obj
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					var s = document.getElementById("form-field-icon-1").value;
					if (s === "") {
						layer.msg("请先输入卷轴！", {
							icon : 2
						});
						return false;
					}
					if (result.scroll.length < 1) {
						//alert("卷轴号有误！");setTimeout()
						//layer.confirm("dfdfdf","qw");
						layer.msg("卷轴号不存在！", {
							icon : 2
						});
						$('.page-header input').val('');

					}
					;

					for (var i = 0; i < result.scroll.length; i++) {

						var tape_id = result.scroll[i].tape_id;
						var create_time = result.scroll[i].create_time;
						var material_name = result.scroll[i].material_name;
						var root_lot_id = result.scroll[i].root_lot_id;
						var str = $.trim($("#ss").val());

						s = "<tr><td>" + "<input type='text' readonly='true'  style='border-style:none' name='tapeIdq' id='s' value=" + tape_id + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='createtime' id='s' value=" + create_time + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='materialname' id='s' value=" + material_name + " />" + "</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='rootlotid' id='s' value=" + root_lot_id + " />" + "</td></tr>";
						var luckElements = document.getElementsByName("tapeIdq");
						var tapeId = document.getElementById("form-field-icon-1").value;
						for (var i = 0; i < luckElements.length; i++) {
							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("卷轴号重复", {
									icon : 2
								}
								);$('.page-header input').val('');
								return false;
							}
						}
						$("#sample-table-1").append(s);
						$('.page-header input').val('');
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
	function check() {
		var s = document.getElementById("s");

		if (s != null) {

			document.getElementById('myForm').submit(); //进行表单提交rt(s);

		} else {
			layer.msg("还没录入卷轴号", {
				icon : 2
			})

		}
	}
</script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('form-field-icon-1').focus();
	}
	function loseFocus() {
		document.getElementById('form-field-icon-1').blur()
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
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		}
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
		<h1>录入卷轴：</h1>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td><input id="form-field-icon-1" type="text" name="tapeId"
					style="text-transform:uppercase;" onfocus="this.select()">

					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">录入</button>
				</td>
			</tr>
		</table>
	</div>

	<br>
	<form id="myForm" action="<%=path%>/re.action?methodstr=save"
		method="post" enctype="multipart/form-data">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>卷轴号</th>
					<th>创建时间</th>
					<th>级别</th>
					<th>批次头</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
		</table>
		<input class="btn btn-primary" type="button" value="提交"
			onclick="check()" />
	</form>
</body>
</html>