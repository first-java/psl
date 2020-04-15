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
<title>tangh</title>
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
<script type="text/javascript">

	function sb1() {
		document.getElementById("tgh").submit();
	}
	function sb2() {
		document.getElementById("tgh1").submit();
	}
</script>

<body>
	<td colspan="4">选择日期 从
		<div class="layui-inline">
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="test11" name="startTime"
					placeholder="yyyy/MM/dd">
			</div>
		</div>到
		<div class="layui-inline">
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="test12" name="endTime"
					placeholder="yyyy/MM/dd">
			</div>
		</div>
	</td>
	<button class="btn btn-primary" id="ajaxF">查询</button>
	请选择功能：
	<select id="sample" onchange="gradeChange(this);">
		<option>请选择...</option>
		<option>查看明细信息</option>
		<option>查看汇总信息</option>
	</select>请扫描：
	<input type="text" id="barcode1"
		onkeypress='if(event.keyCode==13) t(this,1);'
		onkeyup="this.value=this.value.toUpperCase();">
	<form action="DownTgh.action?methodstr=notest4" id="tgh1" method="post"
		onsubmit="return sb2()">
		<table class="table table-striped table-bordered table-hover"
			id="sample5">
			<tr>
				<td>批号</td>
				<td>片号</td>
				<td>是否最终计数</td>
				<td>数量</td>
				<td>BIN</td>
				<td>是否计数</td>
				<td>批次状态</td>
			</tr>
		</table>
		<input id="submitBtn" class='btn btn-primary' type="submit"
			value="导出明细数据" />
	</form>
	<table class="table table-striped table-bordered table-hover"
		id="sample7">
		<tr>
			<td>批号</td>
			<td>片号</td>
			<td>是否最终计数</td>
			<td>数量</td>
			<td>BIN</td>
			<td>是否最终计数</td>
			<td>批次状态</td>
		</tr>
	</table>
	<form action="DownTgh.action?methodstr=notest3" id="tgh" method="post"
		onsubmit="return sb1()">
		<table class="table table-striped table-bordered table-hover"
			id="sample6">
			<tr>
				<td>批号</td>
				<td>总片数</td>
				<td>计数片数</td>
				<td>最终計數颗粒数</td>
				<td>非計數颗粒数</td>
				<td>总颗粒数</td>
				<td>批次状态</td>
				<td>操作</td>
			</tr>
		</table>

		<input id="submitBtn1" class='btn btn-primary' type="submit"
			value="导出汇总数据" />
	</form>
	<input type="hidden" id="ajaxA">
	<input type="hidden" id="ajaxB">
</body>
</html>
<script type="text/javascript">
	function gradeChange(obj) {
		$("#sample").attr("disabled", "disabled");
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#ajaxF").click(function() {
			$("#sample7").show();
			layer.load();

			var startTime = $("#test11").prop("value");
			var endTime = $("#test12").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tangh.action?methodstr=notest4", //5.1
				//提交的数据
				data : {
					"tg.startTime" : startTime,
					"tg.endTime" : endTime
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.msg("没有查到此批次信息！！", {
							icon : 2
						});
						return;
					}

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var unitId = result.counter[i].unitId;
						var qty = result.counter[i].qty;
						var bin = result.counter[i].bin;
						var lotStatus = result.counter[i].lotStatus;
						var finishflag = result.counter[i].finishflag;

						if (finishflag == "0") {
							finishflag = '非最终计数'
						} else {
							finishflag = '最终计数'
						}
						var lotId1 = document.getElementsByName("lotId");
						var unitId1 = document.getElementsByName("unitId");
						var qty1 = document.getElementsByName("qty");
						var bin1 = document.getElementsByName("bin");
						var lotStatus1 = document.getElementsByName("lotStatus");
						if (lotStatus == 'RUNNING') {
							lotStatus = '运行中';
						}
						if (lotStatus == 'HOLD') {
							lotStatus = '暂停中';
						}
						if (lotStatus == 'WAITING') {
							lotStatus = '等待中';
						}
						if (lotStatus == 'DISPATCH') {
							lotStatus = '准备加工';
						}
						if (lotStatus == 'COMPLETED') {
							lotStatus = '已完结';
						}

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='unitId' id='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='hidden' name='finishflag' id='finishflag' value=" + finishflag + " />" + finishflag + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='bin' id='bin' value=" + bin + " />" + bin + "</td><td> 未计数</td><td>" +
							"<input type='hidden' name='lotStatus' id='lotStatus' value=" + lotStatus + " />" + lotStatus +
							"</td></tr>";
						$("#sample7").append(s);
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
	$("#ajaxB").click(function() {
		layer.load();
		var barcode = $("#barcode1").val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "tangh.action?methodstr=notest3", //自己的url
			//提交的数据
			data : {
				"tg.lotId" : barcode
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if ('error' == result) {
					layer.msg("没有未计数的数据！", {
						icon : 2
					});
					return false;
				}
				layer.closeAll();
				var result = eval("(" + result + ")");
				for (var i = 0; i < result.counter.length; i++) {
					var lotId = result.counter[i].lotId;
					var unitId = result.counter[i].unitId;
					var qty = result.counter[i].qty;
					var bin = result.counter[i].bin;
					var lotStatus = result.counter[i].lotStatus;
					var finishflag = result.counter[i].finishflag;

					if (finishflag == "0") {
						finishflag = '非最终计数'
					} else {
						finishflag = '最终计数'
					}
					var lotId1 = document.getElementsByName("lotId");
					var unitId1 = document.getElementsByName("unitId");
					var qty1 = document.getElementsByName("qty");
					var bin1 = document.getElementsByName("bin");
					var lotStatus1 = document.getElementsByName("lotStatus");
					if (lotStatus == 'RUNNING') {
						lotStatus = '运行中';
					}
					if (lotStatus == 'HOLD') {
						lotStatus = '暂停中';
					}
					if (lotStatus == 'WAITING') {
						lotStatus = '等待中';
					}
					if (lotStatus == 'DISPATCH') {
						lotStatus = '准备加工';
					}
					if (lotStatus == 'COMPLETED') {
						lotStatus = '已完结';
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
						"<input type='hidden' name='unitId' id='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
						"<input type='hidden' name='finishflag' id='finishflag' value=" + finishflag + " />" + finishflag + "</td><td>" +
						"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden' name='bin' id='bin' value=" + bin + " />" + bin + "</td><td> 未计数</td><td>" +
						"<input type='hidden' name='lotStatus' id='lotStatus' value=" + lotStatus + " />" + lotStatus +
						"</td></tr>";
					var luckElements = document.getElementsByName("lotId");
					if (luckElements.length > 0) {
						//获取元素的value值
						if ((barcode.startsWith("BIN") && luckElements[0].value.startsWith("BIN"))
							|| (!barcode.startsWith("BIN") && !luckElements[0].value.startsWith("BIN"))) {
							$("#sample5").append(s);

						} else {
							layer.msg("批次工段不一致！", {
								icon : 2
							});
							return false;
						}
					} else {
						$("#sample5").append(s);
					}
				}
				$("#barcode" + idd + "").val('');
				layer.closeAll();
			},
			//调用执行后调用的函数

			error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
				//layer.closeAll();
				//layer.msg("--" + errorThrown)
				alert("出错");
			//请求出错处理
			}
		});
	})
	$("#sample6").hide();
	$("#submitBtn").hide();
	$("#submitBtn1").hide();
	$("#sample5").hide();
	$("#sample7").hide();

	function t(obj, id) {
		layer.load();

		var idd = Number(id);
		var barcode = $("#barcode" + idd + "").val();
		var ecount = $('#sample option:selected').val();
		if (ecount == "请选择...") {
			layer.alert('还没选择功能！', {
				icon : 2
			});
			return false;
		}
		if (ecount == "查看明细信息") {
			$("#sample5").show();
			$("#submitBtn").show();
			if (barcode == '') {
				layer.alert('未获取到扫描数据！', {
					icon : 2
				});

				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tangh.action?methodstr=notest1", //自己的url
				//提交的数据
				data : {
					"tg.lotId" : barcode
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if ('error' == result) {
						$("#ajaxB").click();
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var unitId = result.counter[i].unitId;
						var qty = result.counter[i].qty;
						var bin = result.counter[i].bin;
						var lotStatus = result.counter[i].lotStatus;
						var finishflag = result.counter[i].finishflag;

						if (finishflag == "0") {
							finishflag = '非最终计数'
						} else {
							finishflag = '最终计数'
						}
						var lotId1 = document.getElementsByName("lotId");
						var unitId1 = document.getElementsByName("unitId");
						var qty1 = document.getElementsByName("qty");
						var bin1 = document.getElementsByName("bin");
						var lotStatus1 = document.getElementsByName("lotStatus");
						if (lotStatus == 'RUNNING') {
							lotStatus = '运行中';
						}
						if (lotStatus == 'HOLD') {
							lotStatus = '暂停中';
						}
						if (lotStatus == 'WAITING') {
							lotStatus = '等待中';
						}
						if (lotStatus == 'DISPATCH') {
							lotStatus = '准备加工';
						}
						if (lotStatus == 'COMPLETED') {
							lotStatus = '已完结';
						}


						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='unitId' id='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='hidden' name='finishflag' id='finishflag' value=" + finishflag + " />" + finishflag + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='bin' id='bin' value=" + bin + " />" + bin + "</td><td> 已计数</td><td>" +
							"<input type='hidden' name='lotStatus' id='lotStatus' value=" + lotStatus + " />" + lotStatus +
							"</td></tr>";
						var luckElements = document.getElementsByName("lotId");
						if (luckElements.length > 0) {
							//获取元素的value值
							if ((barcode.startsWith("BIN") && luckElements[0].value.startsWith("BIN"))
								|| (!barcode.startsWith("BIN") && !luckElements[0].value.startsWith("BIN"))) {
								$("#sample5").append(s);

							} else {
								layer.msg("批次工段不一致！", {
									icon : 2
								});
								return false;
							}
						} else {
							$("#sample5").append(s);
						}
					}

					$("#barcode" + idd + "").val('');
					$("#ajaxB").click();
					layer.closeAll();
				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});
		} else if (ecount == "查看汇总信息") {
			$("#sample6").show();
			$("#submitBtn1").show();

			if (barcode == '') {
				layer.alert('未获取到扫描数据！', {
					icon : 2
				});
				layer.closeAll();
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tangh.action?methodstr=notest2", //自己的url
				//提交的数据
				data : {
					"tg.lotId" : barcode
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var pian = result.counter[i].pian;
						var isCoun = result.counter[i].isCoun;
						var zqty = result.counter[i].zqty;
						var jqty = result.counter[i].jqty;
						var fjqty = result.counter[i].fjqty;
						var lotStatus = result.counter[i].lotStatus;
						if (lotStatus == 'RUNNING') {
							lotStatus = '运行中';
						}
						if (lotStatus == 'HOLD') {
							lotStatus = '暂停中';
						}
						if (lotStatus == 'WAITING') {
							lotStatus = '等待中';
						}
						if (lotStatus == 'DISPATCH') {
							lotStatus = '准备加工';
						}
						if (lotStatus == 'COMPLETED') {
							lotStatus = '已完结';
						}
						var tdv = "tdv" + i;
						var tdv1 = "tdv" + i;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='pian' id='pian' value=" + pian + " />" + pian + "</td><td>" +
							"<input type='hidden' name='isCoun' id='isCoun' value=" + isCoun + " />" + isCoun + "</td><td >" +
							"<input type='hidden' name='jqty' id='jqty' value= " + jqty + " /><div id=" + tdv + ">" + jqty + "</div></td><td>" +
							"<input type='hidden' name='jqty' id='jqty' value= " + fjqty + " />" + fjqty + "</td><td>" +
							"<input type='hidden' name='zqty' id='zqty' value=" + zqty + " /><div id=" + tdv1 + ">" + zqty + "</div></td><td>" +
							"<input type='hidden' name='lotStatus' id='lotStatus' value=" + lotStatus + " />" + lotStatus + "</td><td>" +
							"<input type='hidden' name='lotStatus' id='lotStatus' value=" + lotStatus + " /><a href='tangh/index6.jsp?lotId=" + lotId + " '>详情</a></td></tr>";
						//
						var luckElements = document.getElementsByName("lotId");
						if (luckElements.length > 0) {
							//获取元素的value值
							if ((barcode.startsWith("BIN") && luckElements[0].value.startsWith("BIN"))
								|| (!barcode.startsWith("BIN") && !luckElements[0].value.startsWith("BIN"))) {
								$("#sample6").append(s);

							} else {
								layer.msg("批次工段不一致！", {
									icon : 2
								});
								layer.closeAll();
								return false;
							}
						} else {
							$("#sample6").append(s);
							if (zqty != jqty) {
								$("#tdv" + i).addClass("important red");
							//$("#ajaxA").click();
							}
						}

						layer.closeAll();
						$('#barcode').val('');
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
		}
	}
</script>
<script>
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var aInput = document.getElementsByName("lotId");

		//$("#tdv0").addClass("important red"); 
		});
	});
</script>
<style type="text/css">
.important {
	font-weight: bold;
	font-size: 24px;
}

.red {
	color: red;
}
</style>
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
