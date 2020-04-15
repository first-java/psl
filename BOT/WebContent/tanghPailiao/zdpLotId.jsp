
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
<!DOCTYPE html>
<html class="signin no-js" lang="zh">
<head>
<link type="favicon" rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="description" content="postek browser printer">
<meta name="keywords" content="postek">
<title>震动盘编带批次号查询</title>

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
</head>
<body onload="check();">
	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>
	<table>
		<tr>
			<td colspan="4">选择<select name="leixing"><option>日期类型...</option>
					<option>创建日期</option>
					<option>结束日期</option>
			</select> 从
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" autocomplete="off" class="layui-input"
							id="test11" placeholder="yyyy/MM/dd">
					</div>
				</div>到
				<div class="layui-inline">
					<div class="layui-input-inline">
						<input type="text" autocomplete="off" class="layui-input"
							id="test12" placeholder="yyyy/MM/dd">
					</div>
				</div> <input class="btn btn-primary"
				onclick="downLoad('cspdaoru.action?methodstr=downloadVibrate')"
				value="导出清单">
			</td>
		</tr>
	</table>
	<input type="hidden" id="page" value='20'> 输入机台号查询：
	<input type="text" id="lotid" autocomplete="off">
	<button class="btn btn-primary" id="ajaxA">查询</button>
	<input type="text" id="ajaxB" class="btn btn-primary" value="下一页" />
	<input type="text" id="ajaxC" class="btn btn-primary" value="上一页" />
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>序号</th>
				<th>编带批次号</th>
				<th>创建时间</th>
				<th>结束时间</th>
				<th>种类</th>
				<th>ID</th>
				<th>BIN</th>
				<th>总派出</th>
				<th>总投入</th>
				<th>卷轴产出</th>
				<th>编带尾料</th>
				<th>电极面不良</th>
				<th>膜面不良</th>
				<th>编带落地料</th>
				<th>总产出</th>
				<th>在制</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			var workId = $("#workId").prop("value");
			var page = $("#page").prop("value");
			var paggdown = Number(20);
	
			$("#ajaxA").click(function() {
				layer.load();
				/* var shelfName = $("#shelfName").prop("value"); */
				var lotid = $("#lotid").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selzdpbdLotId", //11.2selectShelft
					//提交的数据
					data : {
						"eqpt.bdLotId" : lotid,
						"eqpt.startTime" : "0",
						"eqpt.endTime" : paggdown,
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						if (result.counter.length == 0) {
							layer.alert("没有查到数据！", {
								icon : 2
							}, function() {
								layer.closeAll();
							});
						}
						for (var i = 0; i < result.counter.length; i++) {
	
							var bdLotId = result.counter[i].bdLotId;
							var createtime = result.counter[i].createTime;
							var qcTime = result.counter[i].qcTime;
							var lotType = result.counter[i].lotType;
							var odd = result.counter[i].odd;
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var inQty = result.counter[i].inQty;
							var tapeOutQty = result.counter[i].tapeOutQty;
							var weiliao = result.counter[i].weiliao;
							var momian = result.counter[i].momian;
							var dianji = result.counter[i].dianji;
							var diliao = result.counter[i].diliao;
							var zongPai = result.counter[i].zongPai;
							var zongQty = result.counter[i].zongQty;
							var nowDieQty = result.counter[i].nowDieQty;
							var adtime = "";
							var time = new Date(createtime.time);
							var y = time.getFullYear();
							var m = time.getMonth() + 1;
							var da = time.getDate();
							var h = time.getHours();
							var mm = time.getMinutes();
							var s = time.getSeconds();
							s = s < 10 ? '0' + s : s;
							adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							var adtime1 = "";
							if (qcTime != null) {
								var time1 = new Date(qcTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								adtime1 = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
								diliao = nowDieQty;
								nowDieQty = 0;
							}
							s = "<tr name='sss'><td>" + odd + "</td><td>" +
								bdLotId + "</td><td>" +
								adtime + "</td><td>" +
								adtime1 + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								zongPai + "</td><td>" +
								inQty + "</td><td>" +
								tapeOutQty + "</td><td>" +
								weiliao + "</td><td>" +
								momian + "</td><td>" +
								dianji + "</td><td>" +
								diliao + "</td><td>" +
								zongQty + "</td><td>" +
								nowDieQty + "</td></tr>";
							$("#sample-table-1").append(s);
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
				layer.load();
				var lotid = $("#lotid").prop("value");
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var paggdown1 = Number(page) + 20;
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selzdpbdLotId", //11.2selectShelft
					//提交的数据
					data : {
						"eqpt.bdLotId" : lotid,
						"eqpt.startTime" : paggdown,
						"eqpt.endTime" : paggdown1,
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						if (result.counter.length == 0) {
							layer.alert("没有查到数据！", {
								icon : 2
							}, function() {
								layer.closeAll();
							});
						}
						for (var i = 0; i < result.counter.length; i++) {
	
							var bdLotId = result.counter[i].bdLotId;
							var createtime = result.counter[i].createTime;
							var qcTime = result.counter[i].qcTime;
							var lotType = result.counter[i].lotType;
							var odd = result.counter[i].odd;
							$("#page").val(Number(odd));
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var inQty = result.counter[i].inQty;
							var tapeOutQty = result.counter[i].tapeOutQty;
							var weiliao = result.counter[i].weiliao;
							var momian = result.counter[i].momian;
							var dianji = result.counter[i].dianji;
							var diliao = result.counter[i].diliao;
							var zongPai = result.counter[i].zongPai;
							var zongQty = result.counter[i].zongQty;
							var nowDieQty = result.counter[i].nowDieQty;
							var adtime = "";
							var time = new Date(createtime.time);
							var y = time.getFullYear();
							var m = time.getMonth() + 1;
							var da = time.getDate();
							var h = time.getHours();
							var mm = time.getMinutes();
							var s = time.getSeconds();
							s = s < 10 ? '0' + s : s;
							adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							var adtime1 = "";
							if (qcTime != null) {
								var time1 = new Date(qcTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								adtime1 = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
								diliao = nowDieQty;
								nowDieQty = 0;
							}
							s = "<tr name='sss'><td>" + odd + "</td><td>" +
								bdLotId + "</td><td>" +
								adtime + "</td><td>" +
								adtime1 + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								zongPai + "</td><td>" +
								inQty + "</td><td>" +
								tapeOutQty + "</td><td>" +
								weiliao + "</td><td>" +
								momian + "</td><td>" +
								dianji + "</td><td>" +
								diliao + "</td><td>" +
								zongQty + "</td><td>" +
								nowDieQty + "</td></tr>";
							$("#sample-table-1").append(s);
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
	
			});$("#ajaxC").click(function() {
				layer.load();
				var lotid = $("#lotid").prop("value");
				var page = $("#page").prop("value");
				var paggdown = Number(page) - 40;
				if (paggdown < 0) {
					layer.alert("不能再上一页", {
						icon : 2
					}, function() {
						layer.closeAll();
					});
					return;
				}
				var paggdown1 = Number(page) - 20;
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selzdpbdLotId", //11.2selectShelft
					//提交的数据
					data : {
						"eqpt.bdLotId" : lotid,
						"eqpt.startTime" : paggdown,
						"eqpt.endTime" : paggdown1,
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						if (result.counter.length == 0) {
							layer.alert("没有查到数据！", {
								icon : 2
							}, function() {
								layer.closeAll();
							});
						}
						for (var i = 0; i < result.counter.length; i++) {
	
							var bdLotId = result.counter[i].bdLotId;
							var createtime = result.counter[i].createTime;
							var qcTime = result.counter[i].qcTime;
							var lotType = result.counter[i].lotType;
							var odd = result.counter[i].odd;
							$("#page").val(Number(odd));
							var id = result.counter[i].id;
							var bin = result.counter[i].bin;
							var inQty = result.counter[i].inQty;
							var tapeOutQty = result.counter[i].tapeOutQty;
							var weiliao = result.counter[i].weiliao;
							var momian = result.counter[i].momian;
							var dianji = result.counter[i].dianji;
							var diliao = result.counter[i].diliao;
							var zongPai = result.counter[i].zongPai;
							var zongQty = result.counter[i].zongQty;
							var nowDieQty = result.counter[i].nowDieQty;
							var adtime = "";
							var time = new Date(createtime.time);
							var y = time.getFullYear();
							var m = time.getMonth() + 1;
							var da = time.getDate();
							var h = time.getHours();
							var mm = time.getMinutes();
							var s = time.getSeconds();
							s = s < 10 ? '0' + s : s;
							adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							var adtime1 = "";
							if (qcTime != null) {
								var time1 = new Date(qcTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								adtime1 = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
								diliao = nowDieQty;
								nowDieQty = 0;
							}
							s = "<tr name='sss'><td>" + odd + "</td><td>" +
								bdLotId + "</td><td>" +
								adtime + "</td><td>" +
								adtime1 + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								zongPai + "</td><td>" +
								inQty + "</td><td>" +
								tapeOutQty + "</td><td>" +
								weiliao + "</td><td>" +
								momian + "</td><td>" +
								dianji + "</td><td>" +
								diliao + "</td><td>" +
								zongQty + "</td><td>" +
								nowDieQty + "</td></tr>";
							$("#sample-table-1").append(s);
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
</body>
</html>
<script>
	function downLoad(url) {
		//1、获得查询参数
		var status = $('select[name=leixing] option:selected').val();
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");
		if (status == "日期类型...") {
			layer.alert("还没选择要以哪个日期为导出日期类型！", {
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
		url = url + "&startTime=" + startTime + "&endTime=" + endTime + "&status=" + status;
		//3、使用document.local.href=URL

		location.href = url;
	}
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