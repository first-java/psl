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
<title>分选材料剥料进行分光</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function isJsonString(str) {
		try {
			if (typeof JSON.parse(str) == "object") {
				return true;
			}
		} catch (e) {}
		return false;
	}
	$(document).ready(function() {

		/*  BATCHSHEAD:批次头
		     TESTFILE:测试档
		     EQPT:机台名
		     BAGNAME:静电袋流水号
		     PARTICLENUMBER:静电袋颗粒数
		     BAGWEIGHT:静电袋重量 */
		$("#ajaxE").click(function() {

			var EQPT = $("#EQPT").prop("value");
			var BAGNAME = $("#BAGNAME").prop("value");
			var PARTICLENUMBER = $("#PARTICLENUMBER").prop("value");
			var BAGWEIGHT = $("#BAGWEIGHT").prop("value");
			var BATCHSHEAD = $("#BATCHSHEAD").prop("value");
			var TESTFILE = $("#TESTFILE").prop("value");
			var workId = $("#workId").prop("value");

			var array = new Array();
			var map = {};
			map["WORKID"] = workId;
			map["EQPT"] = EQPT;
			map["BAGNAME"] = BAGNAME
			map["PARTICLENUMBER"] = PARTICLENUMBER;
			map["BAGWEIGHT"] = BAGWEIGHT;
			map["BATCHSHEAD"] = BATCHSHEAD + "-" + BAGNAME;
			map["TESTFILE"] = TESTFILE;
			map["CONVER_FLAG "] = "number"
			map["EQPTFLAG"] = "BL";
			map["BAGINFO"] = $("#baginfo").val().toUpperCase();
			array[0] = map;
			var jsonvalue = JSON.stringify(array);

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "http://192.168.6.46:8089/jngd_ssh/jnbdt_addtrilinglightshelft?", //自己的url
				//提交的数据
				data : {
					"jsonvalue" : jsonvalue
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (isJsonString(result)) { //是对象
						var result = eval("(" + result + ")");
						$.each(result, function(name, value) {
							if (name == $.trim("status")) {
								if (value == 'success') {
									//var product = $("#sample1").prop("value");
									var bagname = $("#BAGNAME").prop("value");
									var baginfo = $("#baginfo").prop("value");
									var qty = $("#PARTICLENUMBER").prop("value");
									var weight = $("#BAGWEIGHT").prop("value");
									var testFile = $("#TESTFILE").prop("value");


									var workId = $("#workId").prop("value");

									var lanmo = "[";
									$("[name=lanmo]").each(function() {
										lanmo += '{"lanmo":"' + this.value + '"},';
									});
									//去掉最后一个"," 
									var reg = /,$/gi;
									lanmo = lanmo.replace(reg, "");
									lanmo += "]";

									$.ajax({
										//提交数据的类型 POST GET
										type : "POST",
										//提交的网址
										url : "ctm.action?methodstr=selectProduct2", //14.1
										//提交的数据
										data : {
											"counter.lanmo" : lanmo,
											"counter.bagname" : bagname,
											"counter.baginfo" : baginfo,
											"counter.qty" : qty,
											"counter.weight" : weight,
											"counter.testFile" : testFile,
											"counter.workId" : workId
										},
										//返回数据的格式
										datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
										async : true, // 使用异步操作
										//成功返回之后调用的函数
										success : function(result) {
											if ("error" == result) {
												layer.alert("失败！！！", {
													icon : 2
												})
												return;
											}
										}
									});

									layer.alert(result["message"], {
										icon : 1
									}, function() {
										window.location.reload();
									})
									var lightEqptClean = window.parent.window.weavingEqptClean;
									if (typeof (lightEqptClean) != "undefined") {
										lightEqptClean.cleanComplete();
									}
								}
								if (value == 'false') {
									layer.alert(result["message"], {
										icon : 2
									}, function() {
										window.location.reload();
									})
								}

							}
						})
					} else {
						layer.alert(result, {
							icon : 2
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
</script>
<style type="text/css">
p {
	white-space: nowrap;
}
</style>
<script type="text/javascript">

	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxC").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
<body>
	<div class="page-header">
		<h4>
			<hr>
			<span class="badge badge-pink">&nbsp;&nbsp;&nbsp;&nbsp;分选材料剥料进行分光&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<hr>

		</h4>
	</div>

	<table id="sample-table-1">
		<!-- <tr>
			<td><li class="text-primary">测试档：</li></td>
			<td><input name="TESTFILE" id="TESTFILE" type="text" /></td>
		</tr> -->
		<tr>
			<td><li class="text-primary">输入蓝膜号：</li></td>
			<td><p>
					<input type="text" id="sample1" autocomplete="off"
						onkeypress="if(event.keyCode==13) t();"
						onkeyup="this.value=this.value.toUpperCase()" name="product">
			<td id="nameDiv" style="display:none"><p
					style="color:red;font-size:16px;">未找到该蓝膜</p></td>
			<td id="nameDiv1" style="display:none"><p
					style="color:red;font-size:16px;">请输入蓝膜！</p></td>
			</p>
			</td>
			<td><input type="hidden" id="workId" value="<%=workId%>"></td>
			<td><input type="hidden" id="lanmo" value=""></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><li class="text-primary">静电袋流水号：</li></td>
			<td><input name="BAGNAME" id="BAGNAME" type="text"
				onkeyup="this.value=this.value.toUpperCase()" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><li class="text-primary">标记</li></td>
			<td><input id="baginfo" type="text"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><li class="text-primary">静电袋颗粒数：</li></td>
			<td><input name="PARTICLENUMBER" id="PARTICLENUMBER" type="text"
				onkeyup="javascript:CheckInputIntFloat(this);" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><li class="text-primary">静电袋重量：</li></td>
			<td><input name="BAGWEIGHT" id="BAGWEIGHT" type="text"
				onkeyup="javascript:CheckInputIntFloat(this);" /></td>
		<tr>
		</tr>
		<!-- BATCHSHEAD:批次头
     TESTFILE:测试档
     EQPT:机台名
     BAGNAME:静电袋流水号
     PARTICLENUMBER:静电袋颗粒数
     BAGWEIGHT:静电袋重量 -->
	</table>
	<table>
		<button class="btn btn-primary" id="ajaxE">确定</button>
	</table>
</body>
</html>
<script>
	function t() {
		var opt = $("#sample1").val();

		if (opt == null || opt == "") {
			document.getElementById("nameDiv1").style.display = "block";
			return false;
		} else {
			document.getElementById("nameDiv1").style.display = "none";
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=selectProduct1", //15.1
			//提交的数据
			data : {
				"counter.product" : opt
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == '未找到此片蓝膜！') {
					document.getElementById("nameDiv").style.display = "block";
					return false;
				} else {
					document.getElementById("nameDiv").style.display = "none";

				}
				var result = eval("(" + result + ")");
				var lotHead = result.counter[0];
				var rootLotId = result.counter[1];

				var id = $("#lanmo").prop("value");

				if (id == null || id == "") {
					$("#lanmo").val(rootLotId);
					id = $("#lanmo").prop("value");
				}
				if (id != rootLotId) {
					layer.alert("该蓝膜测试档不一致！");
					return;
				}

				var str = $.trim($("#ss").val());
				if (rootLotId != null || rootLotId != '') {
					$("[name='sss']").remove();
				}

				s = "<tr name='sss'><td>" +
					"<li class='text-primary'>测试档：</li><input type='hidden' readonly='true'  style='border-style:none' name='BATCHSHEAD' id='BATCHSHEAD' value=" + lotHead + " />" +
					"</td><td>" +
					"<input type='text' readonly='true'  style='border-style:none' name='TESTFILE' id='TESTFILE' value=" + rootLotId + " />" + "</td></tr>";
				ss = "<tr><td>" +
					"已扫蓝膜：<input type='text' readonly='true'  name='lanmo'  value=" + opt + " />" + "</td></tr>";
				$("#sample-table-1").append(s);
				var luckElements = document.getElementsByName("lanmo");
				for (var i = 0; i < luckElements.length; i++) {
					//获取元素的value值
					if (opt == luckElements[i].value) {
						layer.msg("蓝膜号已经在以下列表中存在", {
							icon : 2
						}
						);$('#sample1').val('');
						return false;
					}

				}

				$("#sample-table-1").append(ss);
				$('#sample1').val('');
				$('#sample1').select();

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
</script>
<script>
	$("#PARTICLENUMBER").blur(function() {
		var opt = $("#PARTICLENUMBER").val();
		var weight = $("#BAGWEIGHT").val();
		var batchsHead = $("#BATCHSHEAD").val();
		var testfile = $("#TESTFILE").val();

		layer.load();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=calcu", //9.2
			//提交的数据
			data : {
				"counter.qty" : opt,
				"counter.weight" : weight,
				"counter.lotHead" : batchsHead,
				"counter.testName" : testfile
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 's') {
					layer.alert('未找到该批次的重量，数量信息，请先设置颗粒数重量信息！', function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}
				var result = eval("(" + result + ")");
				var weight = result.counter
				$('#BAGWEIGHT').val(weight);

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
	});
	$("#BAGWEIGHT").blur(function() {
		var opt = $("#PARTICLENUMBER").val();
		var weight = $("#BAGWEIGHT").val();
		var batchsHead = $("#BATCHSHEAD").val();
		var testfile = $("#TESTFILE").val();
		layer.load();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ctm.action?methodstr=calcu", //9.2
			//提交的数据
			data : {
				"counter.qty" : opt,
				"counter.weight" : weight,
				"counter.lotHead" : batchsHead,
				"counter.testName" : testfile
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				if (result == 's') {
					layer.alert('未找到该批次的重量，数量信息，请先设置颗粒数重量信息！', function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}
				var result = eval("(" + result + ")");
				var weight = result.counter
				$('#PARTICLENUMBER').val(weight);

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
	});
</script>