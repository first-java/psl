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
<title>入库达成</title>
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
	function getData2(element) {
		var ss = element.children[0].innerHTML;
		var dd = element.children[1].innerHTML;

		layer.open({
			type : 2,
			area : [ '1300px', '600px' ],
			content : "<%=request.getContextPath()%>/agreed/index12.jsp?lotHead5=" + ss + "&&createTime=" + dd + ""
		});

	}
	$(document).ready(function() {
		$("#ajaxB").click(function() {

			layer.open({
				type : 2,
				area : [ '1000px', '600px' ],
				content : "<%=request.getContextPath()%>/agreed/index7.jsp"
			});


		})
		$("#ajaxA").click(function() {
			var lotHead5 = $("#lotHead5").prop("value");
			var startTime = $("#test11").prop("value");
			var endTime = $("#test22").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "agreedDelivery.action?methodstr=notest22", //5.1
				//提交的数据
				data : {
					"agreed1.lotId" : lotHead5,
					"agreed1.startTime" : startTime,
					"agreed1.endTime" : endTime
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.msg("没有查到信息！！", {
							icon : 2
						});
						return;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var lotId = result.counter[i].LOT_ID; //批次头
						var cycle = result.counter[i].CYCLE; //周期
						var inTime = result.counter[i].CREATETIME; //mes投入时间
						var qty = result.counter[i].QTY; //投入量
						var yiled = result.counter[i].YIELD; //良率
						var inTime1 = result.counter[i].CY_TIME; //交期
						var JIAO_QTY = result.counter[i].JIAO_QTY; //交货量
						var KU_QTY = result.counter[i].KU_QTY; //达成量
						var C_QTY = result.counter[i].C_QTY; //差异
						var COMPLETED_FLAG = result.counter[i].COMPLETED_FLAG; //差异

						var zheng = '';
						if (Math.ceil(COMPLETED_FLAG) == 1 && C_QTY <= 0) {
							zheng = '已达成'
						}
						if (Math.ceil(COMPLETED_FLAG) == 1 && C_QTY > 0) {
							zheng = '未达成'

						}
						if (Math.ceil(COMPLETED_FLAG) == 0) {
							zheng = '进行中'

						}

						var time = new Date(inTime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var adtime = y + "-" + m + "-" + da; //投入时间


						var time1 = new Date(inTime1.time);
						var y1 = time1.getFullYear();
						var m1 = time1.getMonth() + 1;
						var da1 = time1.getDate();
						var h1 = time1.getHours();
						var mm1 = time1.getMinutes();
						var s1 = time1.getSeconds();
						s1 = s1 < 10 ? '0' + s1 : s1;
						var adtime1 = y1 + "-" + m1 + "-" + da1; //投入时间

						JIAO_QTY = Math.ceil(JIAO_QTY);
						C_QTY = Math.ceil(C_QTY);
						var c_qty2 = "";

						if (C_QTY >= 0) {
							c_qty2 = C_QTY;
							C_QTY = 0;
						} else {
							c_qty2 = 0;
							C_QTY = C_QTY * -1;
						}

						s = "<tr name='sss' onclick='getData2(this);'><td>" + lotId + "</td><td>" + adtime + "</td><td>" +
							adtime1 + "</td><td>" +
							cycle + "</td><td>" +
							yiled + "</td><td>" +
							qty + "</td><td>" +
							JIAO_QTY + "</td><td>"
							+ KU_QTY + "</td><td>" +
							"<input type='hidden' name='c_qty2' id='c_qty2' value=" + c_qty2 + " />" + c_qty2 + "</td><td>" +
							"<input type='hidden' name='zheng' id='zheng' value=" + zheng + " />" + zheng + "</td><td>" +
							"<input type='hidden' name='C_QTY' id='C_QTY' value=" + C_QTY + " />" + C_QTY + "</td></tr>";
						$("#InputsWrapper").append(s);

					}

					var aInput = document.getElementsByName("zheng");

					for (var i = 0; i < aInput.length; i++) {
						if (aInput[i].value == "未达成") {
							aInput[i].parentNode.parentNode.style.background = 'pink';
						}
						if (aInput[i].value == "已达成") {
							aInput[i].parentNode.parentNode.style.background = 'yellow';
						}
					}

				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					layer.closeAll();
					alert("出错");
				//请求出错处理
				}
			});
		});
	});
</script>
</head>
<body>
	选择固晶日期 从
	<div class="layui-inline">
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="test11" autocomplete="off"
				placeholder="yyyy/MM/dd">
		</div>
	</div>
	到
	<div class="layui-inline">
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="test12" autocomplete="off"
				placeholder="yyyy/MM/dd">
		</div>
	</div>

	<td>输入批次头<input type="text" id="lotHead5"></td>
	<button class="btn btn-primary" id="ajaxA">查询数据</button>
	<button class="btn btn-primary" id="ajaxB">查看月度计划达成情况</button>
	<table id="InputsWrapper">

		<tr>
			<td>五位批次头</td>
			<td>前段固晶时间</td>
			<td>最后交货时间</td>
			<td>交货周期（天）</td>
			<td>预设良率</td>
			<td>投入量（pcs）</td>
			<td>交货需求量（pcs）</td>
			<td>入库达成量（pcs）</td>
			<td>交货缺额（pcs）</td>
			<td>达成情况</td>
			<td>达成后结余量（pcs）</td>
		</tr>
	</table>
	<br>

</body>
</html>
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

<style>
table {
	width: 100%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	align: left;
}

body {
	padding-bottom: 0px;
	min-height: 100%;
	font-family: "Open Sans";
	font-size: 20px;
	line-height: 1.5;
	font-family: "Open Sans";
	font-size: 20px;
	font-size: 20px;
}

table tr:nth-child(1) {
	background: #73B1E0;
	color: #FFF;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}
</style>