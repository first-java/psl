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
<title>贴带机派料历史</title>
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

		$("#ajaxA").click(function() {
			var shelf = $("#shelf").prop("value");
			var status = $("#status").prop("value");
			/* if (shelf == "") {
				layer.open({
					title : '信息提示',
					content : "请先输入报检单号或蓝膜号！！"
				});
				return false;
			} */
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectPailiao", //7.1
				//提交的数据
				data : {
					"counter.shelf" : shelf,
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'n') {
						layer.open({
							title : '存放位置',
							content : "没有查到数据！"
						});
						return false;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var eqptId = result.counter[i].eqptId;
						var rootLotId = result.counter[i].rootLotId;
						var createTime = result.counter[i].createTime;
						var workId = result.counter[i].workId;
						var materialName = result.counter[i].materialName;
						var product = result.counter[i].product;
						var qty = result.counter[i].qty;

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  style='border-style:none'  value=" + eqptId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none'  name='binUnitId' id='s' value=" + rootLotId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='materialName' id='s' value=" + createTime + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='rootLotId' id='s' value=" + workId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='status1' id='s' value=" + materialName + " />" +
							"</td><td>" +
							"<input type='text' readonly='true' style='border-style:none' name='qtys' id='s'  value=" + product + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='sendNum' id='s' value=" + qty + " />" +
							"</td></tr>";
						var luckElements = document.getElementsByName("materialname");

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
<script type="text/javascript">
	function setFocus() {
		document.getElementById('shelf').focus();
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
			document.getElementById('status').focus()
		}
	});
</script>
<script>
	function check1() {
		document.getElementById('myForm1').submit(); //进行表单提交rt(s);	
	}
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交rt(s);	
	}
</script>
</head>
<body>
	<div class="page-header">

		<table align="left">
			<tr>
				</td>
				<td>输入信息查询<input type="text" name="shelf"
					onkeyup="this.value=this.value.toUpperCase()" id="shelf">&nbsp;
					<input id="clickMe" type="hidden" onclick="setFocus()" /> <input
					type="hidden" name="status" value="OK" id="status" />
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">查询</button>
				</td>

			</tr>
		</table>
	</div>

	<br>
	<!-- 7.2 -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>机台号</th>
				<th>批次头</th>
				<th>派料时间</th>
				<th>派料人</th>
				<th>级别</th>
				<th>蓝膜号</th>
				<th>数量（颗）</th>
				<input type="hidden" id="workId" name="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
</body>
</html>
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

	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '1300px', '900px' ],
			content : "<%=request.getContextPath()%>/counterToManage/in5.jsp?workId='" + opt + "'"
		});

	}
</script>