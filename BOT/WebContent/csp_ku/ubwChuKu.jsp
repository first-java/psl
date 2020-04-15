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
<title>UBW出库</title>
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
			var barcode1 = $("#barcode1").prop("value");
			var lotId1 = $("#lotId1").prop("value");

			var instanceId = $("#instanceId").prop("value");
			var qty1 = $("#qty1").prop("value");
			if (barcode1.trim() == "") {
				layer.msg("还没录入片号！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ubw.action?methodstr=notestOut", //5.1
				//提交的数据
				data : {
					"ubw.reelId" : barcode1,
					"ubw.unitId" : instanceId,
					"ubw.lotId" : lotId1
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result.startsWith("error:")) {
						layer.alert(result);
						return;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var unitId = result.counter[i].unitId;
						var qty = result.counter[i].qty;
						var op = 0
						var luck = document.getElementsByName("qty");
						for (var i = 0; i < luck.length; i++) {
							op += Number(luck[i].value);
						}
						/* if (op < Number(qty1)) {
							layer.msg("出库数量不允许大于创批数量！", {
								icon : 2
							})
							return false;
						} */
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId' id='lotId' value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='unitId' id='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("unitId");
						var tapeId = document.getElementById("barcode1").value;
						//获取元素的value值
						if (luckElements.length > 0) {
							if (barcode1.substring(0, 7) != luckElements[0].value.substring(0, 7)) {
								layer.msg("批次头不一致！", {
									icon : 2
								})
								return false;
							}
						}

						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
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
					if (count1 > Number(qty1)) {

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

			var unitId = "[";
			$("[name=unitId]").each(function() {
				unitId += '{"unitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			unitId = unitId.replace(reg, "");
			unitId += "]";


			var workId = $("#workId").prop("value");
			var meslot = $("#lotId1").prop("value");
			var aInput = document.getElementsByName("lotId");
			if (aInput.length < 1) {
				layer.msg("没有数据提交，不要瞎点！请先扫描片号", {
					icon : 2
				});
				layer.close(lo);
				$("#lotId").select();
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ubw.action?methodstr=outPut", //5.1
				//提交的数据
				data : {
					"ubw.unitId" : unitId,
					"ubw.lotId" : meslot,
					"ubw.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
					});

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

	function t2(obj, id) {
		layer.load();
		var lotId = $("#lotId").prop("value");

		if (lotId == "") {
			layer.alert("批号不能为空，请先输入批号！", function() {
				layer.closeAll();
				$("#lotId").select();
			})

			return;
		} else {
			$("#barcode1").select();
		}

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ubw.action?methodstr=selectLotId", //5.1
			//提交的数据
			data : {
				"ubw.lotId" : lotId
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 'ERROR') {
					layer.alert("未找到此批次信息！ 这个批次还没到芯片领取检验工步！", function() {
						layer.closeAll();
						$("#lotId").select();
					})
					return;
				}
				var result = eval("(" + result + ")");
				var instanceId = result.counter[0].stockId;
				var lotId = result.counter[0].lotId;
				var qty = result.counter[0].qty;
				$("#instanceId").val(instanceId)
				$("#lotId1").val(lotId)
				$("#qty1").val(qty)
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

	}
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
				<input type="text" id="instanceId" value="" />
				<input type="text" id="lotId1" value="" />
				<input type="text" id="meslot" value="" />
				<input type="text" id="qty1" value="" />
				<input type="hidden" id="status" value="" />
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td id="tt">
				<td id="tt">批号：<input id="lotId" type="text"
					onkeypress='if(event.keyCode==13) t2(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">片号：<input
					id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">

					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()"></button>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>批号</th>
				<th>底板号</th>
				<th>数量（颗）</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />

</body>
</html>
