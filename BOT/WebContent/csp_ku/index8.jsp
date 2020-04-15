<%@ page language="java" import="java.util.*,java.net.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	InetAddress hostAndIP = null;
	try {
		hostAndIP = InetAddress.getLocalHost();
	} catch (UnknownHostException e) {
		e.printStackTrace();
	}
	String ip = hostAndIP.toString();

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
<body onload="check();">
	<input type="hidden" id="ajaxC" />

	<table>
		<tr>
			<td>选择库存状态<select name="status" id="status" onchange="func();"><option>请选择...</option>
					<option>不限</option>
					<option>已出库</option>
					<option>未出库</option>
			</select>
			</td>
			<td>选择出货编码：<select id="select" name="stockId1"
				onchange="func1();"><option>请选择存货编码</option>
			</select></td>
			<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</select>
			</td>
		</tr>
		<tr>
			<td colspan="4">选择日期 从
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" autocomplete="off" class="layui-input"
							id="test11" placeholder="yyyy/MM/dd">
					</div>
				</div>到
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" class="layui-input" autocomplete="off"
							id="test12" placeholder="yyyy/MM/dd">
					</div>
				</div> 输入存货编码前两位：<input type="text" id="twoCode"> <input
				class="btn btn-primary" onclick="ServerDetail(this)" id="ajaxB"
				value='查询入库' /> <input class="btn btn-primary"
				onclick="ServerDetail(this)" value='查询出库' />
			</td>
		</tr>
		<tr>
			<td>要导出的库存状态<select name="st" id="st" onchange=""><option>请选择...</option>
					<option value="">不限</option>
					<option value="1">已出库</option>
					<option value="0">未出库</option>
			</select>
			</td>
			<td><input class="btn btn-primary"
				onclick="downLoad('downKu.action?methodstr=downloadKu')"
				value="导出库存"></td>
			</form>
			</td>
			<td><button class="btn btn-primary" onclick="t();">下出库指令</button></td>
		</tr>
		<!-- <tr>
			<td>尺寸： <input type="text"></td>
			<td>色温： <input type="text"></td>
			<td>亮度：<input type="text"></td>
			<td>显指：<input type="text"></td>
			<td>电压：<input type="text"></td>
			<td>波长：<input type="text"></td>
			<td><button class="btn btn-primary">查询</button></td>
		</tr> -->
		<td id="tt"></td>
	</table>

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>底板号</th>
				<th>编码</th>
				<th>参数</th>
				<th>数量</th>
				<th>产品</th>
				<th>色温</th>
				<th>亮度</th>
				<th>显指</th>
				<th>电压</th>
				<th>波长</th>
				<th>入库时间</th>
				<th>出库时间</th>
				<th>状态</th>
			</tr>
		</thead>
	</table>
</body>
</html>
<script>
	function downLoad(url) {
		//1、获得查询参数
		var status = $('select[name=st] option:selected').val();
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");
		var pro = $("#twoCode").prop("value");
		if (status == "请选择...") {
			layer.msg("还没选择要导出的库存状态", {
				icon : 2
			});
			return;
		}
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

		//2、拼装URL+查询参数
		url = url + "&startTime=" + startTime + "&endTime=" + endTime + "&status=" + status + "&stockId=" + pro;
		//3、使用document.local.href=URL

		location.href = url;
	}

	function check() {
		$("#ajaxC").click();
	}
	function ServerDetail(_this) {
		var status = null;
		if (_this.value == '查询入库') {
			status = '0';
		}
		if (_this.value == '查询出库') {
			status = '1';
		}
		var endTime = $("#test12").prop("value");
		var twoCode = $("#twoCode").prop("value");
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
			url : "cspku.action?methodstr=selTime", //5.1
			//提交的数据
			data : {
				"counter.endTime" : endTime,
				"counter.product" : twoCode,
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

					var strs = new Array(); //定义一数组 
					strs = itemId.split("-"); //字符分割 
					var chanpin = strs[0];
					var sewen = strs[1];
					var liangdu = strs[2];
					var xianzhi = strs[3];
					var dianya = strs[4];
					var bochang = strs[5];

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
						"<input type='hidden'colspan='4' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden'  value=" + chanpin + " />" + chanpin + "</td><td>" +
						"<input type='hidden'  value=" + sewen + " />" + sewen + "</td><td>" +
						"<input type='hidden' value=" + liangdu + " />" + liangdu + "</td><td>" +
						"<input type='hidden'  value=" + xianzhi + " />" + xianzhi + "</td><td>" +
						"<input type='hidden'  value=" + dianya + " />" + dianya + "</td><td>" +
						"<input type='hidden'  value=" + bochang + " />" + bochang + "</td><td>" +
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

				alert("服务器出错");
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
			url : "cspku.action?methodstr=notest2", //5.1
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
					var createTime = result.counter[i].createTime;
					var outDate = result.counter[i].outDate;
					var status = result.counter[i].status;
					var strs = new Array(); //定义一数组 
					strs = itemId.split("-"); //字符分割 
					var chanpin = strs[0];
					var sewen = strs[1];
					var liangdu = strs[2];
					var xianzhi = strs[3];
					var dianya = strs[4];
					var bochang = strs[5];
					if (status == '0') {
						status = '未出库';
					}
					if (status == '1') {
						status = '已出库';
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' colspan='4' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden'  value=" + chanpin + " />" + chanpin + "</td><td>" +
						"<input type='hidden'  value=" + sewen + " />" + sewen + "</td><td>" +
						"<input type='hidden' value=" + liangdu + " />" + liangdu + "</td><td>" +
						"<input type='hidden'  value=" + xianzhi + " />" + xianzhi + "</td><td>" +
						"<input type='hidden'  value=" + dianya + " />" + dianya + "</td><td>" +
						"<input type='hidden'  value=" + bochang + " />" + bochang + "</td><td>" +
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
	;
	function func1() {
		layer.load();
		var status = $('select[name=status] option:selected').val();
		var stockId = $('select[name=stockId1] option:selected').val();
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
			url : "cspku.action?methodstr=notest2", //5.1
			data : {
				"counter.status" : status,
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
					var reelId = result.counter[i].reelId;
					var stockId = result.counter[i].stockId;
					var itemId = result.counter[i].itemId;
					var qty = result.counter[i].qty;
					var createTime = result.counter[i].createTime;
					var outDate = result.counter[i].outDate;
					var status = result.counter[i].status;
					var strs = new Array(); //定义一数组 
					strs = itemId.split("-"); //字符分割 
					var chanpin = strs[0];
					var sewen = strs[1];
					var liangdu = strs[2];
					var xianzhi = strs[3];
					var dianya = strs[4];
					var bochang = strs[5];
					if (status == '0') {
						status = '未出库';
					}
					if (status == '1') {
						status = '已出库';
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' colspan='4' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden'  value=" + chanpin + " />" + chanpin + "</td><td>" +
						"<input type='hidden'  value=" + sewen + " />" + sewen + "</td><td>" +
						"<input type='hidden' value=" + liangdu + " />" + liangdu + "</td><td>" +
						"<input type='hidden'  value=" + xianzhi + " />" + xianzhi + "</td><td>" +
						"<input type='hidden'  value=" + dianya + " />" + dianya + "</td><td>" +
						"<input type='hidden'  value=" + bochang + " />" + bochang + "</td><td>" +
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
	$(document).ready(function() {
		$("#ajaxC").click(function() {
			layer.load();
			$.ajax({
				type : "POST",
				url : "cspku.action?methodstr=selstockId", //5.1

				success : function(result) {
					layer.closeAll();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var stockId = result.counter[i].stockId;
						s = '<option>' + stockId + '</option>'

						$("#select").append(s);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					alert("出错");

				}
			});

		})
	})
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
	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '800px', '600px' ],
			content : "<%=request.getContextPath()%>/csp_ku/index7.jsp?workId='" + opt + "'"
		});

	}
</script>