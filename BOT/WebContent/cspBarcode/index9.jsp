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
<title>包装接收</title>
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
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luck = document.getElementsByName("qty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);

		}
		var luckElements = document.getElementsByName("reelId");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片</font></td>"
		$("#tt").append(ss);

		$("td[name='count']").remove();
		c = "<td name='count' style='color:red'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var barcode = $("#barcode1").val();
			var bar = barcode.split("^");
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
				url : "cspBarcode.action?methodstr=pickingReceive", //5.1
				//提交的数据
				data : {
					"barcodeQC.barcode" : bar[2]
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'error1') {
						layer.alert("此片已在库房");

						$("#barcode1").val('');
						$("#barcode1").select();
						return false;
					}
					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#barcode1").val('');
						$("#barcode1").select();
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var barcode = result.counter[i].barcode;
						var lotHeader = result.counter[i].lotHeader;
						var qty = result.counter[i].qty;
						var lotHeader = result.counter[i].lotHeader;
						var createTime = result.counter[i].createtime;

						var time = new Date(createTime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var createTime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s; //投入时间
						var createTime1 = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s; //投入时间

						createTime1 = createTime1.replace(" ", "!");

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='barcode' value=" + barcode + " />" + barcode + "</td><td>" +
							"<input type='hidden' name='lotHeader'  value=" + lotHeader + " />" + lotHeader + "</td><td>" +
							"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='createTime' value=" + createTime1 + " />" + createTime + "</td><td>" +
							"<input type='text' name='workIdc' value= '' /></td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("barcode");
						var barcode = $("#barcode1").val();
						var bar = barcode.split("^");
						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (bar[2] == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}
						}
						$("td[name='s']").remove();
						ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "片<font size='8' color='red'></td>"
						$("#tt").append(ss);

					}
					$("td[name='s']").remove();
					ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "片<font size='8' color='red'></td>"
					$("#tt").append(ss);
					$("#sample-table-1").append(s);
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

		});

		$("#ajaxB").click(function() {
			var barcode = "[";
			$("[name=barcode]").each(function() {
				barcode += '{"barcode":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			barcode = barcode.replace(reg, "");
			barcode += "]";

			var lotHeader = "[";
			$("[name=lotHeader]").each(function() {
				lotHeader += '{"lotHeader":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotHeader = lotHeader.replace(reg, "");
			lotHeader += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			var workIdc = "[";
			$("[name=workIdc]").each(function() {
				workIdc += '{"workIdc":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			workIdc = workIdc.replace(reg, "");
			workIdc += "]";

			var createTime = "[";
			$("[name=createTime]").each(function() {
				createTime += '{"createTime":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			createTime = createTime.replace(reg, "");
			createTime += "]";

			var workId = $("#workId").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspBarcode.action?methodstr=reveivePutIn", //5.1
				//提交的数据

				data : {
					"barcodeQC.barcode" : barcode,
					"barcodeQC.qty" : qty,
					"barcodeQC.lotHeader" : lotHeader,
					"barcodeQC.createTime" : createTime,
					"barcodeQC.workId" : workId,
					"barcodeQC.workIdC" : workIdc
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "error") {
						layer.alert("保存失败", function() {
							window.location.reload();
						});
					} else {
						layer.alert("保存成功", function() {
							window.location.reload();
						});
					}
					return false;
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
		var idd = Number(id);
		var barcode = $("#barcode" + idd + "").val();
		var bar = barcode.split("^");
		var y = bar.length;

		if (y != 3) {
			layer.alert('请扫描正确的小标签二维码！！', {
				icon : 2
			}, function() {
				$("#barcode" + idd + "").val('');
				$("#barcode" + idd + "").select();
				layer.closeAll();
			});
			return false;
		}
		if (barcode == '') {
			layer.alert('还没输入卷轴！', {
				icon : 2
			}, function() {
				$("#barcode" + idd + "").val('');
				$("#barcode" + idd + "").select();
				layer.closeAll();
			});
			return false;
		}
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "cspBarcode.action?methodstr=barcodeVerify", //5.1
			//提交的数据

			data : {
				"picking.tapeId" : bar[2],
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result.startsWith("error:")) {
					layer.alert("卷轴有误！卷轴未打标", function() {
						window.location.reload();
					});
					return false;
				}
				var result = eval("(" + result + ")");
				var qrSplit = result.counter[0].qrSplit;
				var qrIdSec = result.counter[0].qrIdSec;
				var rpdString = result.counter[0].rpdString;
				$("#qrSplit").val(qrSplit);
				$("#qrIdSec").val(qrIdSec);
				$("#rpdString").val(rpdString);
				$("#barcode2").select();
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
	function t2(obj, id) {
		var barcode1 = $("#barcode1").val();
		var barcode2 = $("#barcode2").val();
		if (barcode1 == barcode2) {
			layer.alert('两个输入框内容不能一样！！！', {
				icon : 2
			}, function() {
				$("#barcode2").val('');
				$("#barcode2").select();
				layer.closeAll();
			});
			return false;
		}
		var qrSplit = $("#qrSplit").val();
		var qrIdSec = $("#qrIdSec").val();
		var rpdString = $("#rpdString").val();
		var bar2 = barcode2.split(qrSplit);
		var bar1 = barcode1.split("^");

		var qrIdSec1 = "";
		if (rpdString == "") {
			qrIdSec1 = qrIdSec - 1;
		} else {
			qrIdSec1 = qrIdSec;
		}

		if (bar1[qrIdSec1] != bar2[qrIdSec - 1].replace(rpdString.toUpperCase(), "")) {
			layer.alert('两张二维码标签卷轴号不匹配！！', {
				icon : 2
			}, function() {
				$("#barcode2").val('');
				$("#barcode2").select();
				layer.closeAll();
			});
			return false;
		}
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

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">小标签卷轴号：
				<td><input type="text" size="18" id="barcode1"
					onkeyup="this.value=this.value.toUpperCase()"
					onkeypress='if(event.keyCode==13) t(this,1);' /></td> 大标签卷轴确认：
				<input type="text" size="18" id="barcode2"
					onkeyup="this.value=this.value.toUpperCase()"
					onkeypress='if(event.keyCode==13) t2(this,2);' />
				<input class="btn btn-primary" id="ajaxA" onclick="setFocus()"
					type="hidden" />

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
				<th>卷轴号</th>
				<th>批次头</th>
				<th>数量（颗）</th>
				<th>时间</th>
				<th>工号</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />
	<input type="hidden" id="qrIdSec" />
	<input type="hidden" id="qrSplit" />
	<input type="hidden" id="rpdString" />
</body>
</html>

<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//常规用法
		laydate.render({
			elem : '#test1'
		});

		//常规用法
		laydate.render({
			elem : '#test2'
		});


	});
</script>