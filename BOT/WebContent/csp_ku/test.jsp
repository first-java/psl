<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String id = (String) request.getParameter("id");//直接传递
	String client = (String) request.getParameter("client");//直接传递
	String workId = (String) request.getParameter("workId");//直接传递
	String casede = (String) request.getParameter("casede");//直接传递
	String stockId = (String) request.getParameter("stockId");//直接传递
	String itemId = (String) request.getParameter("itemId");//直接传递
	String qty = (String) request.getParameter("qty");//直接传递
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
<title>入库</title>
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

</head>
<script>
	$(document).ready(function() {

		$("#ajaxC").click(function() {
			var client1 = $("#client1").prop("value");
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=selClient", //5.1
				success : function(result) {
					layer.closeAll();

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var client = result.counter[i].client;
						s = '<option>' + client + '</option>'
						if (client == client1) {
							$("#client").val(client1);

						}
						$("#client").append(s);
					}
					for (var i = 0; i < result.counter.length; i++) {
						var client = result.counter[i].client;
						if (client == client1) {
							$("#client").val(client1);

						}
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					alert("出错");
				}
			});
		});
		$("#ajaxA").click(function() {
			var id = $("#id").prop("value");
			var client = $('select[name=client] option:selected').val();
			var cuase = $("#cuase").prop("value");
			var stockid = $("#stockid").prop("value");
			var itemId = $("#item").prop("value");
			var qty = $("#qty").prop("value");
			if (client == '请选择出货客户...') {
				layer.msg("还没选择出货客户！", {
					icon : 2
				});
				return;
			}
			if (stockid == '') {
				layer.msg("还没输入存货编码！", {
					icon : 2
				});
				return;
			}
			if (qty == '') {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				return;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=updatesaveZhiling1", //5.1
				//提交的数据
				data : {
					"counter.id" : id,
					"counter.client" : client,
					"counter.cuase" : cuase,
					"counter.stockId" : stockid,
					"counter.itemId" : itemId,
					"counter.qty" : qty
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'success') {
						layer.msg("指令修改成功！", {
							icon : 1
						});
					} else {
						layer.msg("指令修改失败！", {
							icon : 2
						}, function() {
							window.location.reload();

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
		$("#ajaxB").click(function() {
			var id = $("#id").prop("value");
			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=updatesaveZhiling2", //5.1
				//提交的数据
				data : {
					"counter.id" : id,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'success') {
						layer.msg("撤销成功！", {
							icon : 1
						});
					} else if (result == 'nowork') {
						layer.msg("撤销失败！工号不一致！", {
							icon : 2
						}, function() {
							window.location.reload();

						});
					} else {
						layer.msg("撤销失败！", {
							icon : 2
						}, function() {
							window.location.reload();

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
	function check() {
		$("#ajaxC").click();
	}
</script>
<body onload="check();">
	<input type="hidden" name="workId" id="workId" value="<%=workId%>" />

	<table class="table table-striped table-bordered table-hover"
		id="table" width="50%">
		<thead>
			<tr>
				<th>指令ID</th>
				<th><input type="text" id="id" id="id" value="<%=id%>" /></th>
			</tr>
			<tr>
				<th>出货客户</th>
				<input type="hidden" name="client1" id="client1" value="<%=client%>" />
				<td id="tt"><select name='client' id='client'><option>请选择出货客户...</option>
				</select></td>

			</tr>
			<tr>
				<th>出货备注</th>
				<th><input type="text" id="cuase" id="cuase"
					value="<%=casede%>" /></th>
			</tr>
			<tr>
				<th>存货编码</th>
				<th><input type="text" readonly="readonly" id='stockid'
					value="<%=stockId%>" /></th>
			</tr>
			<tr>
				<th>出货参数</th>
				<th><input type="text" id='item' value="<%=itemId%>" /></th>
			</tr>
			<tr>
				<th>出货数量</th>
				<th><input type="text" id="qty" value="<%=qty%>" /></th>
			</tr>
			<tr>
				<input type="hidden" id="ajaxC" />
				<td><button class="btn btn-primary" id="ajaxA">修改指令</button></td>
				<td><button class="btn btn-primary" id="ajaxB">撤销该条指令</button></td>
			</tr>
		</thead>
	</table>

</body>
</html>

