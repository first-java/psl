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
<title>对比</title>
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


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
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
			var type = $("#barcode1").prop("value");
			if (type.trim() == "") {
				layer.msg("还没录入卷轴1", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			var lotNo = $("#barcode2").prop("value");
			var workId = $("#workId").prop("value");
			if (lotNo.trim() == "") {
				layer.msg("还没输入卷轴2！", {
					icon : 2
				});
				document.getElementById('barcode2').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "duibi.action?methodstr=execute2", //5.1
				//提交的数据
				data : {
					"bd.barcode1" : lotNo,
					"bd.barcode2" : type,
					"bd.workId" : workId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					var barcode1 = result.sf[0];
					var barcode2 = result.sf[1];
					var result = result.sf[2];
					if (result == '不相同') {
						s = "<tr name='sss' bgcolor='FF0000'><td>" +
							"<input type='hidden' name='barcode1' value=" + barcode1 + " />" + barcode1 + "</td><td>" +
							"<input type='hidden' name='barcode2' value=" + barcode2 + " />" + barcode2 + "</td><td>" +
							"<input type='hidden' name='result' value=" + result + " />" + result +
							"</td></tr>";
						$("#sample-table-1").prepend(s);
					} else {
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='barcode1' value=" + barcode1 + " />" + barcode1 + "</td><td>" +
							"<input type='hidden' name='barcode2' value=" + barcode2 + " />" + barcode2 + "</td><td>" +
							"<input type='hidden' name='result' value=" + result + " />" + result +
							"</td></tr>";
						$("#sample-table-1").prepend(s);
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

</head>
<body>

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
				<td id="tt">卷轴1<input id="barcode1" type="text" maxlength="12"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()"> 卷轴2<input
					id="barcode2" type="text" maxlength="13"
					onkeypress='if(event.keyCode==13) setFocus();'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table  table-hover" id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>卷轴1</th>
				<th>卷轴2</th>
				<th>比对结果</th>

			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="提交"
		onclick="check()" />

</body>
</html>
<script>
	$("#barcode2").blur(function() {

		$("#ajaxA").click();
	});
</script>
