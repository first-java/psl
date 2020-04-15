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
<title>查看库存</title>
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


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
</head>
<body>

	<table>
		<tr>
			<td>选择库存状态<select name="status" id="status" onchange="func();"><option>请选择...</option>
					<option>不限</option>
					<option>已出库</option>
					<option>未出库</option>
			</select>
			</td>
			<td>
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="hidden" class="layui-input" id="test11"
							placeholder="yyyy/MM/dd">
					</div>
				</div>
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="hidden" class="layui-input" id="test12"
							placeholder="yyyy/MM/dd">
					</div>
				</div> <input type="hidden" class="btn btn-primary" onclick="ServerDetail(this)"
				id="ajaxB" value='查询入库' /> <input class="btn btn-primary" type="hidden"
				onclick="ServerDetail(this)" id="ajaxC" value='查询出库' />
			</td>
			<td id="tt"></td>
		</tr>
	</table>

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>底板号</th>
				<th>编码</th>
				<th>参数</th>
				<th>数量</th>
				<th>入库时间</th>
				<th>出库时间</th>
				<th>状态</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" class="btn btn-primary" id="ajaxA">
</body>
</html>
<script>
	function ServerDetail(_this) {
		var status = null;
		if (_this.value == '查询入库') {
			status = '0';
		}
		if (_this.value == '查询出库') {
			status = '1';
		}
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");

		if (startTime == '') {
			layer.msg("还没选择开始日期", {
				icon : 2
			});
			return;
		}
		if (endTime == '') {
			layer.msg("还没选择结束日期", {
				icon : 2
			});
			return;
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "xlku.action?methodstr=selTime", //5.1
			//提交的数据
			data : {
				"counter.endTime" : endTime,
				"counter.startTime" : startTime,
				"counter.status" : status
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

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
					var reelId = result.counter[i].reelId;
					var stockId = result.counter[i].stockId;
					var itemId = result.counter[i].itemId;
					var qty = result.counter[i].qty;
					var createTime = result.counter[i].createTime;
					var outDate = result.counter[i].outDate;
					var status = result.counter[i].status;
					if (status == '0') {
						status = '未出库';
					}
					if (status == '1') {
						status = '已出库';
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden' name='createTime' id='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
						"<input type='hidden' name='outDate' id='outDate' value=" + outDate + " />" + outDate + "</td><td>" +
						"<input type='hidden' name='status' id='status' value=" + status + " />" + status + "</td></tr>";

					$("#sample-table-1").append(s);

				}
				var luckElements = document.getElementsByName("reelId");
				$("td[name='s']").remove();
				ss = "<td name='s'><font size='5' color='red'>当前查询到" + (luckElements.length) + "片<font size='8' color='red'></td>"
				$("#tt").append(ss);

				var count1 = 0;
				var luck = document.getElementsByName("qty");
				for (var i = 0; i < luck.length; i++) {
					count1 += Number(luck[i].value);
				}
				$("td[name='count']").remove();
				c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
				$("#tt").append(c);


			},
			//调用执行后调用的函数

			error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
				//layer.closeAll();
				//layer.msg("--" + errorThrown)
				alert("出错");
			//请求出错处理
			}
		});
	}
	function func() {
		layer.load();
		var status = $('select[name=status] option:selected').val();
		if (status == '不限') {
			status = '';
		}
		if (status == '未出库') {
			status = '0';
		}
		if (status == '已出库') {
			status = '1';
		}
		if (status == '请选择...') {
			layer.msg("还没库存状态！", {
				icon : 2
			}, function() {
				window.location.reload();

			});
			return false;
		}

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "xlku.action?methodstr=notest2", //5.1
			data : {
				"counter.status" : status
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
					var reelId = result.counter[i].reelId;
					var stockId = result.counter[i].stockId;
					var itemId = result.counter[i].itemId;
					var qty = result.counter[i].qty;

					var outDate = result.counter[i].outDate;
					var status = result.counter[i].status;

					var inTime = result.counter[i].createTime;
					var time = new Date(inTime.time);
					var y = time.getFullYear();
					var m = time.getMonth() + 1;
					var da = time.getDate();
					var h = time.getHours();
					var mm = time.getMinutes();
					var s = time.getSeconds();
					s = s < 10 ? '0' + s : s;
					var adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;


					if (status == '0') {
						status = '未出库';
					}
					if (status == '1') {
						status = '已出库';
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden' name='adtime' id='adtime' value=" + adtime + " />" + adtime + "</td><td>" +
						"<input type='hidden' name='outDate' id='outDate' value=" + outDate + " />" + outDate + "</td><td>" +
						"<input type='hidden' name='status' id='status' value=" + status + " />" + status + "</td></tr>";

					$("#sample-table-1").append(s);
				}
				var luckElements = document.getElementsByName("reelId");
				$("td[name='s']").remove();
				ss = "<td name='s'><font size='5' color='red'>当前查询到" + (luckElements.length) + "片<font size='8' color='red'></td>"
				$("#tt").append(ss);

				var count1 = 0;
				var luck = document.getElementsByName("qty");
				for (var i = 0; i < luck.length; i++) {
					count1 += Number(luck[i].value);
				}
				$("td[name='count']").remove();
				c = "<td name='count' ><font size='5' color='red'>,总" + count1 + "颗粒</font></td>"
				$("#tt").append(c);

			},
			//调用执行后调用的函数

			error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
				//layer.closeAll();
				//layer.msg("--" + errorThrown)
				alert("出错");
			//请求出错处理
			}
		});

	}
	;
</script>

<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//自定义格式
		laydate.render({
			elem : '#test11',
			format : 'yyyy/MM/dd'
		});
		//自定义格式
		laydate.render({
			elem : '#test12',
			format : 'yyyy/MM/dd'
		});

	});
</script>