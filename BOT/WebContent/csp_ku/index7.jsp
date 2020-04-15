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
<title>出货指令</title>
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
<script>
	$(document).ready(function() {
		$("#ajaxC").click(function() {
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
						$("#client").append(s);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					alert("出错");
				}
			});
		});
		$("#ajaxA").click(function() {
			var client = $('select[name=client] option:selected').val();
			var cuase = $("#cuase").prop("value");
			var stockid = $("#stockid").prop("value");
			var itemId = $("#item").prop("value");
			var workId = $("#workId").prop("value");
			var qty = $("#qty").prop("value");

			var product = $("#product").prop("value");
			var sewen = $("#sewen").prop("value");
			var light = $("#light").prop("value");
			var xianzhi = $("#xianzhi").prop("value");
			var dianya = $("#dianya").prop("value");
			var bochang = $("#bochang").prop("value");

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
				url : "cspku.action?methodstr=saveZhiling1", //5.1
				//提交的数据
				data : {
					"counter.client" : client,
					"counter.cuase" : cuase,
					"counter.stockId" : stockid,
					"counter.itemId" : itemId,
					"counter.qty" : qty,
					"counter.workId" : workId,
					"counter.product" : product,
					"counter.sewen" : sewen,
					"counter.light" : light,
					"counter.xianzhi" : xianzhi,
					"counter.dianya" : dianya,
					"counter.bochang" : bochang
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'success') {
						layer.msg("指令下达成功！", {
							icon : 1
						}, function() {
							window.location.reload();

						});
					} else {
						layer.msg("指令下达失败！", {
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
		$("#table").hide();
		$("#ajaxC").click();
	}
</script>
</head>
<body onload="check();">
	<input type="hidden" id="ajaxC" /> 存货编码：
	<input type="text" id='stockid1' />
	<button class="btn btn-primary" id="ajaxB">查看已下达的出货指令</button>
	<button class="btn btn-primary" onclick="t();">新增出货客户</button>

	<br>
	<br>

	<form id="myForm"
		action="<%=path%>/downKu.action?methodstr=downloadReport"
		method="post" enctype="multipart/form-data">
		<td><button class="btn btn-primary">导出出货指令</button></td>
	</form>
	<div class="page-header">

		<table align="left">

			<tr>
				<td id="tt">出货客户：<select name='client' id='client'><option>请选择出货客户...</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>出货备注： <input type="text" id="cuase" />
				</td>
			</tr>
			<tr>
				<td>存货编码：<input type="text" id='stockid' maxlength="8"
					oninput='if(value.length>"8")layer.alert("存货编码不能大于8位");' /> <a
					style="color:red ">不能为空*</a>
				</td>
			</tr>
			<!-- <tr>
				<td>参数级别：<input type="text" id='item' />
				</td>
			</tr> -->
			<tr>
				<td>产&nbsp;品：<input type="text" id='product' />
				</td>
			</tr>
			<tr>
				<td>色&nbsp;温：<input type="text" id='sewen' />
				</td>
			</tr>
			<tr>
				<td>亮&nbsp;度：<input type="text" id='light' />
				</td>
			</tr>
			<tr>
				<td>显&nbsp;指：<input type="text" id='xianzhi' />
				</td>
			</tr>
			<tr>
				<td>电&nbsp;压：<input type="text" id='dianya' />
				</td>
			</tr>
			<tr>
				<td>波&nbsp;长：<input type="text" id='bochang' />
				</td>
			</tr>
			<tr>
				<td>白光芯片前缀：<input type="text" id='qian' />
				</td>
			</tr>
			<tr>
				<td>出货数量（颗）： <input type="text" id=qty
					onkeyup="this.value=this.value.replace(/\D/g,'')"
					onafterpaste="this.value=this.value.replace(/\D/g,'')"
					onblur="value=value.replace(/[^\d]/g,'')" />
				</td>
			</tr>
			<tr>
				<input type="hidden" name="workId" id="workId" value="<%=workId%> " />
				<td><button class="btn btn-primary" id="ajaxA">确认</button></td>
			</tr>
		</table>
	</div>
	<table class="table table-striped table-bordered table-hover"
		id="table" width="50%">
		<thead>
			<tr>
				<th>指令ID</th>
				<th>出货客户</th>
				<th>出货原因</th>
				<th>出货编码</th>
				<th>出货参数</th>
				<th>产品</th>
				<th>色温</th>
				<th>亮度</th>
				<th>显指</th>
				<th>电压</th>
				<th>波长</th>
				<th>出货数量</th>
				<th>指令下达时间</th>
				<th>指令下达人</th>
				<th>操作</th>
			</tr>
		</thead>
	</table>
	<br>
</body>
</html>
<script>
	$(document).ready(function() {
		$("#ajaxB").click(function() {
			layer.load();
			$("#table").show();

			var stockId = $("#stockid1").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=selZhiL", //5.1
				data : {
					"counter.stockId" : stockId
				},
				success : function(result) {
					layer.closeAll();
					if (result == 'ss') {
						layer.msg("未找到查询信息！", {
							icon : 2
						}, function() {
							window.location.reload();

						});
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var id = result.counter[i].id;
						var client = result.counter[i].client;
						var cuase = result.counter[i].cuase;
						var stockId = result.counter[i].stockId;
						var itemId = result.counter[i].itemId;
						var qty = result.counter[i].qty;
						var workId = result.counter[i].workId;
						var product = result.counter[i].product;
						var sewen = result.counter[i].sewen;
						var light = result.counter[i].light;
						var xianzhi = result.counter[i].xianzhi;
						var dianya = result.counter[i].dianya;
						var bochang = result.counter[i].bochang;
						var createTime = result.counter[i].createTime;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='id' id='id' value=" + id + " />" + id + "</td><td>" +
							"<input type='hidden' name='client' id='client' value=" + client + " />" + client + "</td><td>" +
							"<input type='hidden' name='cuase' id='cuase' value=" + cuase + " />" + cuase + "</td><td>" +
							"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
							"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
							"<input type='hidden' name='product' id='product' value=" + product + " />" + product + "</td><td>" +
							"<input type='hidden' name='sewen' id='sewen' value=" + sewen + " />" + sewen + "</td><td>" +
							"<input type='hidden' name='light' id='light' value=" + light + " />" + light + "</td><td>" +
							"<input type='hidden' name='xianzhi' id='xianzhi' value=" + xianzhi + " />" + xianzhi + "</td><td>" +
							"<input type='hidden' name='dianya' id='dianya' value=" + dianya + " />" + dianya + "</td><td>" +
							"<input type='hidden' name='bochang' id='bochang' value=" + bochang + " />" + bochang + "</td><td>" +
							"<input type='hidden' name='qty1' id='qty1' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='createTime' id='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
							"<input type='hidden' name='workId' id='workId' value=" + workId + " />" + workId + "</td><td>" +
							"<input type='button'class='btn btn-primary'  value='编辑' /></td></tr>";

						$("#table").append(s);
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
	$(function() {
		$("#table").on("click", ":button", function(event) {
			var id = $(this).closest("tr").find("td").eq(0).text();
			var client = $(this).closest("tr").find("td").eq(1).text();
			var casede = $(this).closest("tr").find("td").eq(2).text();
			var stockId = $(this).closest("tr").find("td").eq(3).text();
			var itemId = $(this).closest("tr").find("td").eq(4).text();
			var qty = $(this).closest("tr").find("td").eq(5).text();
			var time = $(this).closest("tr").find("td").eq(6).text();
			var workId = $("#workId").prop("value");
			layer.open({
				type : 2,
				area : [ '800px', '500px' ],
				content : "<%=request.getContextPath()%>/csp_ku/test.jsp?workId=" + workId
					+ "&casede=" + casede + "&stockId=" + stockId + "&itemId=" + itemId + "&qty=" +
					qty + "&client=" + client + "&id=" + id + " "
			});
		});
	});

	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '800px', '500px' ],
			content : "<%=request.getContextPath()%>/csp_ku/index9.jsp?workId='" + opt + "'"
		});

	}
</script>
