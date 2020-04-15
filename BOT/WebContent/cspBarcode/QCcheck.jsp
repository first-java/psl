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
<title>品质审核检查单</title>
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
			var barcode = $("#barcode1").prop("value");
			var bar = barcode.split("^");
		var y = bar.length;

		if (y != 3) {
			layer.alert('请扫描正确的大标签二维码！！', {
				icon : 2
			}, function() {
				$("#barcode1").val('');
				$("#barcode1").select();
				layer.closeAll();
			});
			return false;
		}
			if (barcode.trim() == "") {
				layer.msg("还没录入TYPE", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspBarcode.action?methodstr=selOdd", //5.1
				//提交的数据
				data : {
					"barcodeCl.barcode" : bar[2]
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					var workId = $("#workId").prop("value");
					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#barcode1").select();
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var odd = result.counter[i].odd;
						var productModel = result.counter[i].productModel;
						var seri = result.counter[i].seri;
						var createTime1 = result.counter[i].createtime;
						var time = new Date(createTime1.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var createTime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s; //投入时间

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='odd' value=" + odd + " />" + odd + "</td><td>" +
							"<input type='hidden' name='productModel'  value=" + productModel + " />" + productModel + "</td><td>" +
							"<input type='hidden' name='seri' value=" + seri + " />" + seri + "</td><td>" +
							"<input type='hidden' name='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
							"<a  href='cspBarcode/index7.jsp?odd=" + odd + "&workId=" + workId + "' class='btn btn-primary'>审核</a></td></tr>";

						var luckElements = document.getElementsByName("reelId");
						var tapeId = document.getElementById("barcode1").value;

						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}

						}

					}

					$("#sample-table-1").append(s);

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
		$("#ajaxA").click();
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
<a href="<%=request.getContextPath()%>/cspBarcode/index72.jsp">导出已检验明细</a>
	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td id="tt">卷轴号：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
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
				<th>检查单名称</th>
				<th>产品型号</th>
				<th>送检数量（卷）</th>
				<th>创建时间</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
</body>
</html>
