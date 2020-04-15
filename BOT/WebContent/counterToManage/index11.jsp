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
<title>QC检外观</title>
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

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var shelf = $("#shelf").prop("value");
			var status = $("#status").prop("value");
			if (shelf == "") {
				layer.msg("请输入要查询的数据！", {
					icon : 2
				}, function() {
					window.location.reload();
					var e = document.createEvent("MouseEvents");
					e.initEvent("click", true, true);
					document.getElementById("clickMe").dispatchEvent(e);
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selCheckList", //8.1
				//提交的数据
				data : {
					"counter.shelf" : shelf,
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'n') {
						layer.open({
							title : '提示消息',
							content : "没有查到数据！"
						});
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");

					for (var i = 0; i < result.counter.length; i++) {
						var binUnitId = result.counter[i].binUnitId;
						var materialName = result.counter[i].materialName;
						var rootLotId = result.counter[i].rootLotId;
						var indeedqty = result.counter[i].residueQty;
						var sendNum = result.counter[i].sendNum;
						var status = result.counter[i].status;
						var str = $.trim($("#ss").val());

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='binUnitId' id='s' value=" + binUnitId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='materialName' value=" + materialName + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='rootLotId' value=" + rootLotId + " />" +
							/* "</td><td>" +
							"<select name='status'><option value='OK'>OK</option><option value='NG'>NG</option></select>" +
							*/ "</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='yiwu' placeholder='异物' value='0'" +
							"'  />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='qipao' placeholder='气泡' value='0' " +
							"'  />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='anlie' placeholder='暗裂' value='0' " +
							"'  />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='lens' placeholder='LE刮伤NS' value='0' " +
							"'  />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='badQty1' placeholder='其他' value='0' " +
							"'  />" +
							"</td><td>" +
							"<input type='text'  readonly='true'  style='border-style:none' name='indeedqty'  value=" + indeedqty + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='sendNum'  value=" + sendNum + " />" +
							"</td></tr>";
						var luckElements = document.getElementsByName("materialname");

						$("#sample-table-1").append(s);
						$('.page-header input').val('');
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
			var workId = $("#workId").prop("value");

			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";
			var yiwu = "[";
			$("[name=yiwu]").each(function() {
				yiwu += '{"yiwu":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			yiwu = yiwu.replace(reg, "");
			yiwu += "]";

			var qipao = "[";
			$("[name=qipao]").each(function() {
				qipao += '{"qipao":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qipao = qipao.replace(reg, "");
			qipao += "]";

			var anlie = "[";
			$("[name=anlie]").each(function() {
				anlie += '{"anlie":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			anlie = anlie.replace(reg, "");
			anlie += "]";

			var lens = "[";
			$("[name=lens]").each(function() {
				lens += '{"lens":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lens = lens.replace(reg, "");
			lens += "]";

			var binUnitId = "[";
			$("[name=binUnitId]").each(function() {
				binUnitId += '{"binUnitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			binUnitId = binUnitId.replace(reg, "");
			binUnitId += "]";

			var rootLotId = "[";
			$("[name=rootLotId]").each(function() {
				rootLotId += '{"rootLotId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			rootLotId = rootLotId.replace(reg, "");
			rootLotId += "]";


			var indeedqty = "[";
			$("[name=indeedqty]").each(function() {
				indeedqty += '{"indeedqty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			indeedqty = indeedqty.replace(reg, "");
			indeedqty += "]";

			var sendNum = "[";
			$("[name=sendNum]").each(function() {
				sendNum += '{"sendNum":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sendNum = sendNum.replace(reg, "");
			sendNum += "]";

			var status = "[";
			$("select[name=status]").each(function() {
				status += '{"status":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			status = status.replace(reg, "");
			status += "]";

			var s = document.getElementById("s");
			if (s == null) {

				layer.msg("没有任何数据可以提交！", {
					icon : 2
				})
				return false;
			}
			var els = $("input[name='dieqty']");
			for (var i = 0; i < els.length; i++) {
				var psl = els[i].value;
				if (psl.trim() == "") {
					layer.msg("还没输入数量！", {
						icon : 2
					});
					return false;
				}
				if (!/^[0-9]*$/.test(els[i].value)) {
					layer.msg("只能输入数字！", {
						icon : 2
					});
					return false;
				}

			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=craftCheckList", //11.2
				//提交的数据
				data : {
					"counter.materialName" : materialName,
					"counter.rootLotId" : rootLotId,
					"counter.binUnitId" : binUnitId,
					"counter.sendNum" : sendNum,
					"counter.indeedqty" : indeedqty,
					"counter.workId" : workId,
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
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

		});$("#ajaxC").click(function() {
			var workId = $("#workId").prop("value");
			var sendNum = "[";
			$("[name=sendNum]").each(function() {
				sendNum += '{"sendNum":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sendNum = sendNum.replace(reg, "");
			sendNum += "]";

			var s = document.getElementById("s");
			if (s == null) {

				layer.msg("没有任何数据可以提交！", {
					icon : 2
				})
				return false;
			}
			var els = $("input[name='dieqty']");
			for (var i = 0; i < els.length; i++) {
				var psl = els[i].value;
				if (psl.trim() == "") {
					layer.msg("还没输入数量！", {
						icon : 2
					});
					return false;
				}
				if (!/^[0-9]*$/.test(els[i].value)) {
					layer.msg("只能输入数字！", {
						icon : 2
					});
					return false;
				}

			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectCheckList1", //11.2
				//提交的数据
				data : {
					"counter.sendNum" : sendNum,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
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
	function setFocus() {
		document.getElementById('shelf').focus();
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
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('status').focus()
		}
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

		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()" />
				<td>报检单号或蓝膜号：<input type="text"
					onkeyup="this.value=this.value.toUpperCase()" name="shelf"
					id="shelf">&nbsp; <input id="clickMe" type="hidden"
					onclick="setFocus()" value="Set focus" /> <input type="hidden"
					name="status" value="OK" id="status" />
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">搜索报检单</button>
				</td>

			</tr>
		</table>
	</div>

	<br>
	<!--8.2  -->

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>蓝膜号</th>
				<th>级别</th>
				<th>批次头</th>
				<!-- 	<th>蓝膜状态</th> -->
				<th>异物</th>
				<th>气泡</th>
				<th>底板暗裂</th>
				<th>LENS刮伤</th>
				<th>其他</th>
				<th>数量</th>
				<th>报检单号</th>
				<input type="hidden" id="workId" name="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<!-- <input class="btn btn-primary" type="button" id="ajaxC" value="判退"
		onclick="check()" />&nbsp;&nbsp;&nbsp;&nbsp; -->
	<input class="btn btn-primary" type="button" id="ajaxB" value="接收"
		onclick="check()" />

</body>
</html>