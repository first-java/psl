
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
<title>已分光入库明细</title>

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
	<input type="hidden" id="ajaxA" />
	<table>
		<tr>
			<td colspan="4">选择<select name="leixing"><option>日期类型...</option>
					<option>入库日期</option>
					<option>出库日期</option>
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
				onclick="downLoad('cspdaoru.action?methodstr=downloadYFgTouru')"
				value="导出清单"><input type="text" id="ajaxB"
				class="btn btn-primary" value="下一页" /><input type="text" id="ajaxC"
				class="btn btn-primary" value="上一页" />
			</td>
			<input type="hidden" id="page" value='20'>
		</tr>
	</table>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>序号</th>
				<th>标签生成日期</th>
				<th>入库日期</th>
				<th>入库操作人</th>
				<th>袋号</th>
				<th>状态</th>
				<th>品质判定</th>
				<th>分光批次号</th>
				<th>种类</th>
				<th>ID</th>
				<th>BIN</th>
				<th>类型</th>
				<th>重量g（含袋子）</th>
				<th>袋子重量g</th>
				<th>标签重量g</th>
				<th>裸重（g）</th>
				<th>单颗重量g</th>
				<th>重量转换颗粒数</th>
				<th>清档数量</th>
				<th>误差数量</th>
				<th>误差百分比</th>
				<th>计算数量</th>
				<th>出库日期</th>
				<th>出库操作人</th>
				<th>出库类型</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		function check() {
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var page = $("#page").prop("value");
				/* var shelfName = $("#shelfName").prop("value");
				var caseNo = $("#caseNo").prop("value"); */
				var paggdown = Number(page);
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=select11", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : "0",
						"putIn.endTime" : paggdown
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
	
							var scTime = result.counter[i].scTime;
							var createTime = result.counter[i].createTime;
							var workId = result.counter[i].workId;
							var bagname = result.counter[i].bagName;
							var status = result.counter[i].flag;
							var qcstatus = result.counter[i].qcstatus;
							var fgLotId = result.counter[i].fgLotId;
							var lotType = result.counter[i].lotType;
							var id = result.counter[i].id;
							var flag = result.counter[i].flag;
							var bin = result.counter[i].bin;
							var leiXing = result.counter[i].leiXing;
							var weight = result.counter[i].weight;
							var bagWeight = result.counter[i].bagWeight;
							var labelWeight = result.counter[i].labelWeight;
							var jingWeight = result.counter[i].jingWeight;
							var eachWeight = result.counter[i].eachWeight;
							var zhQty = result.counter[i].zhQty;
							var qty = result.counter[i].qty;
							var chayi = result.counter[i].chayi;
							var percentage = result.counter[i].percentage;
							var mesQty = result.counter[i].mesQty;
							var outTime = result.counter[i].outTime;
							var outWorkId = result.counter[i].outWorkId;
							var chuLei = result.counter[i].chuLei;
							var remark = result.counter[i].remark;
							remark=remark.substring(0, 5);
							var baofei_bin1_start1 = result.counter[i].baofei_bin1_start1
							//alert(baofei_bin1_start1)
							$("#page").val(Number(baofei_bin1_start1));
							if (bagname.startsWith("H")) {
	
								mesQty = qty;
								qty = 0;
								chayi = 0;
								percentage = 0;
								fgLotId = "";
							}
							var str = Number(percentage * 100).toFixed(2);
							str += "%";
							if (flag == "1") {
								status = "HOLD";
							} else {
								status = "NORMAL"
							}
							var adtime = "";
							if (createTime != null) {
								var time = new Date(createTime.time);
								var y = time.getFullYear();
								var m = time.getMonth() + 1;
								var da = time.getDate();
								var h = time.getHours();
								var mm = time.getMinutes();
								var s = time.getSeconds();
								s = s < 10 ? '0' + s : s;
								adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							}
	
							var stime = "";
	
							if (scTime != null) {
								var time2 = new Date(scTime.time);
								var y2 = time2.getFullYear();
								var m2 = time2.getMonth() + 1;
								var da2 = time2.getDate();
								var h2 = time2.getHours();
								var mm2 = time2.getMinutes();
								var s2 = time2.getSeconds();
								s2 = s2 < 10 ? '0' + s2 : s2;
								stime = y2 + "-" + m2 + "-" + da2 + " " + h2 + ":" + mm2 + ":" + s2;
	
							}
							var odtime = "";
							if (outTime != null) {
	
								var time1 = new Date(outTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								odtime = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
							}
							if (outTime == "null") {
								odtime = "";
							}
	
							s = "<tr name='sss'><td>" + baofei_bin1_start1 + "</td><td>" +
								stime + "</td><td>" +
								adtime + "</td><td>" +
								workId + "</td><td>" +
								bagname + "</td><td>" +
								status + "</td><td>" +
								qcstatus + "</td><td>" +
								fgLotId + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								leiXing + "</td><td>" +
								weight + "</td><td>" +
								bagWeight + "</td><td>" +
								labelWeight + "</td><td>" +
								jingWeight + "</td><td>" +
								eachWeight + "</td><td>" +
								zhQty + "</td><td>" +
								qty + "</td><td>" +
								chayi + "</td><td>" +
								str + "</td><td>" +
								mesQty + "</td><td>" +
								odtime + "</td><td>" +
								outWorkId + "</td><td>" +
								chuLei + "</td><td>" +
								remark + "</td></tr>";
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
				var page = $("#page").prop("value");
				var paggdown = Number(page);
				var paggdown1 = Number(page) + 20;
				/* var caseNo = $("#caseNo").prop("value"); */
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=select11", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : paggdown,
						"putIn.endTime" : paggdown1
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
	
							var scTime = result.counter[i].scTime;
							var createTime = result.counter[i].createTime;
							var workId = result.counter[i].workId;
							var bagname = result.counter[i].bagName;
							var status = result.counter[i].flag;
							var qcstatus = result.counter[i].qcstatus;
							var fgLotId = result.counter[i].fgLotId;
							var lotType = result.counter[i].lotType;
							var id = result.counter[i].id;
							var flag = result.counter[i].flag;
							var bin = result.counter[i].bin;
							var leiXing = result.counter[i].leiXing;
							var weight = result.counter[i].weight;
							var bagWeight = result.counter[i].bagWeight;
							var labelWeight = result.counter[i].labelWeight;
							var jingWeight = result.counter[i].jingWeight;
							var eachWeight = result.counter[i].eachWeight;
							var zhQty = result.counter[i].zhQty;
							var qty = result.counter[i].qty;
							var chayi = result.counter[i].chayi;
							var percentage = result.counter[i].percentage;
							var mesQty = result.counter[i].mesQty;
							var outTime = result.counter[i].outTime;
							var outWorkId = result.counter[i].outWorkId;
							var chuLei = result.counter[i].chuLei;
							var baofei_bin1_start1 = result.counter[i].baofei_bin1_start1
							$("#page").val(baofei_bin1_start1);
							if (bagname.startsWith("H")) {
	
								mesQty = qty;
								qty = 0;
								chayi = 0;
								percentage = 0;
								fgLotId = "";
							}
							var str = Number(percentage * 100).toFixed(2);
							str += "%";
							if (flag == "1") {
								status = "HOLD";
							} else {
								status = "NORMAL"
							}
							var adtime = "";
							if (createTime != null) {
								var time = new Date(createTime.time);
								var y = time.getFullYear();
								var m = time.getMonth() + 1;
								var da = time.getDate();
								var h = time.getHours();
								var mm = time.getMinutes();
								var s = time.getSeconds();
								s = s < 10 ? '0' + s : s;
								adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							}
	
							var stime = "";
	
							if (scTime != null) {
								var time2 = new Date(scTime.time);
								var y2 = time2.getFullYear();
								var m2 = time2.getMonth() + 1;
								var da2 = time2.getDate();
								var h2 = time2.getHours();
								var mm2 = time2.getMinutes();
								var s2 = time2.getSeconds();
								s2 = s2 < 10 ? '0' + s2 : s2;
								stime = y2 + "-" + m2 + "-" + da2 + " " + h2 + ":" + mm2 + ":" + s2;
	
							}
							var odtime = "";
							if (outTime != null) {
	
								var time1 = new Date(outTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								odtime = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
							}
							if (outTime == "null") {
								odtime = "";
							}
	
							s = "<tr name='sss'><td>" + baofei_bin1_start1 + "</td><td>" +
								stime + "</td><td>" +
								adtime + "</td><td>" +
								workId + "</td><td>" +
								bagname + "</td><td>" +
								status + "</td><td>" +
								qcstatus + "</td><td>" +
								fgLotId + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								leiXing + "</td><td>" +
								weight + "</td><td>" +
								bagWeight + "</td><td>" +
								labelWeight + "</td><td>" +
								jingWeight + "</td><td>" +
								eachWeight + "</td><td>" +
								zhQty + "</td><td>" +
								qty + "</td><td>" +
								chayi + "</td><td>" +
								str + "</td><td>" +
								mesQty + "</td><td>" +
								odtime + "</td><td>" +
								outWorkId + "</td><td>" +
								chuLei + "</td></tr>";
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
	
				//alert(paggdown + "******" + paggdown1)
				/* var caseNo = $("#caseNo").prop("value"); */
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=select11", //11.2selectShelft
					//提交的数据
					data : {
						"putIn.startTime" : paggdown,
						"putIn.endTime" : paggdown1
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
	
							var scTime = result.counter[i].scTime;
							var createTime = result.counter[i].createTime;
							var workId = result.counter[i].workId;
							var bagname = result.counter[i].bagName;
							var status = result.counter[i].flag;
							var qcstatus = result.counter[i].qcstatus;
							var fgLotId = result.counter[i].fgLotId;
							var lotType = result.counter[i].lotType;
							var id = result.counter[i].id;
							var flag = result.counter[i].flag;
							var bin = result.counter[i].bin;
							var leiXing = result.counter[i].leiXing;
							var weight = result.counter[i].weight;
							var bagWeight = result.counter[i].bagWeight;
							var labelWeight = result.counter[i].labelWeight;
							var jingWeight = result.counter[i].jingWeight;
							var eachWeight = result.counter[i].eachWeight;
							var zhQty = result.counter[i].zhQty;
							var qty = result.counter[i].qty;
							var chayi = result.counter[i].chayi;
							var percentage = result.counter[i].percentage;
							var mesQty = result.counter[i].mesQty;
							var outTime = result.counter[i].outTime;
							var outWorkId = result.counter[i].outWorkId;
							var chuLei = result.counter[i].chuLei;
							var baofei_bin1_start1 = result.counter[i].baofei_bin1_start1
							$("#page").val(baofei_bin1_start1);
							if (bagname.startsWith("H")) {
	
								mesQty = qty;
								qty = 0;
								chayi = 0;
								percentage = 0;
								fgLotId = "";
							}
							var str = Number(percentage * 100).toFixed(2);
							str += "%";
							if (flag == "1") {
								status = "HOLD";
							} else {
								status = "NORMAL"
							}
							var adtime = "";
							if (createTime != null) {
								var time = new Date(createTime.time);
								var y = time.getFullYear();
								var m = time.getMonth() + 1;
								var da = time.getDate();
								var h = time.getHours();
								var mm = time.getMinutes();
								var s = time.getSeconds();
								s = s < 10 ? '0' + s : s;
								adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							}
	
							var stime = "";
	
							if (scTime != null) {
								var time2 = new Date(scTime.time);
								var y2 = time2.getFullYear();
								var m2 = time2.getMonth() + 1;
								var da2 = time2.getDate();
								var h2 = time2.getHours();
								var mm2 = time2.getMinutes();
								var s2 = time2.getSeconds();
								s2 = s2 < 10 ? '0' + s2 : s2;
								stime = y2 + "-" + m2 + "-" + da2 + " " + h2 + ":" + mm2 + ":" + s2;
	
							}
							var odtime = "";
							if (outTime != null) {
	
								var time1 = new Date(outTime.time);
								var y1 = time1.getFullYear();
								var m1 = time1.getMonth() + 1;
								var da1 = time1.getDate();
								var h1 = time1.getHours();
								var mm1 = time1.getMinutes();
								var s1 = time1.getSeconds();
								s1 = s1 < 10 ? '0' + s1 : s1;
								odtime = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1;
							}
							if (outTime == "null") {
								odtime = "";
							}
	
							s = "<tr name='sss'><td>" + baofei_bin1_start1 + "</td><td>" +
								stime + "</td><td>" +
								adtime + "</td><td>" +
								workId + "</td><td>" +
								bagname + "</td><td>" +
								status + "</td><td>" +
								qcstatus + "</td><td>" +
								fgLotId + "</td><td>" +
								lotType + "</td><td>" +
								id + "</td><td>" +
								bin + "</td><td>" +
								leiXing + "</td><td>" +
								weight + "</td><td>" +
								bagWeight + "</td><td>" +
								labelWeight + "</td><td>" +
								jingWeight + "</td><td>" +
								eachWeight + "</td><td>" +
								zhQty + "</td><td>" +
								qty + "</td><td>" +
								chayi + "</td><td>" +
								str + "</td><td>" +
								mesQty + "</td><td>" +
								odtime + "</td><td>" +
								outWorkId + "</td><td>" +
								chuLei + "</td></tr>";
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