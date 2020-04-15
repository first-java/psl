
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%
	String sendNum = (String) request.getParameter("sendNum");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title></title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
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
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<script>

	$(document).ready(function() {
		$("#ajaxC").click(function() {
			var workId = $("#workId").prop("value");
			var els = $("input[name='badQty']");
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
			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";

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

			var badQty1 = "[";
			$("[name=badQty1]").each(function() {
				badQty1 += '{"badQty1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			badQty1 = badQty1.replace(reg, "");
			badQty1 += "]";

			var sendNum = "[";
			$("[name=sendNum]").each(function() {
				sendNum += '{"sendNum":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sendNum = sendNum.replace(reg, "");
			sendNum += "]";

			var qtys = "[";
			$("[name=qtys]").each(function() {
				qtys += '{"qtys":"' + this.value + '"},';
			});
			//去掉最后一个"," qtys
			var reg = /,$/gi;
			qtys = qtys.replace(reg, "");
			qtys += "]";

			var status1 = "[";
			$("[name=status1]").each(function() {
				status1 += '{"status1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			status1 = status1.replace(reg, "");
			status1 += "]";
			$.ajax({

				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=proCheckList1", //9.1
				//提交的数据
				data : {
					"counter.materialName" : materialName,
					"counter.rootLotId" : rootLotId,
					"counter.binUnitId" : binUnitId,
					"counter.sendNum" : sendNum,
					"counter.badQty1" : badQty1,
					"counter.workId" : workId,
					"counter.status" : status1,
					"counter.qtys" : qtys
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

					layer.msg("服务器错误", {
						icon : 2
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}
				//请求出错处理

			});

		});
		$("#ajaxB").click(function() {
			var sendNum = $('#sendNum').val();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=QcReject1",
				//提交的数据
				data : {
					"counter.sendNum" : sendNum
				},
				//返回数据的格式
				datatype : "json",
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "未找到该货架！") {
						layer.msg("该机台暂无加工信息!！", {
							icon : 2
						});
						window.opener = null;
						window.open('', '_self');
						window.close();
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
							"<input type='text' readonly='true'  style='border-style:none' name='materialName' id='s' value=" + materialName + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='rootLotId' id='s' value=" + rootLotId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='status1' id='s' value=" + status + " />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='badQty1' value='0' oninput='if(value>=" + indeedqty + ")value=" +
							indeedqty + "'  />" +
							"</td><td>" +
							"<input type='text' readonly='true' style='border-style:none' name='qtys' id='s'  value=" + indeedqty + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='sendNum' id='s' value=" + sendNum + " />" +
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
	});
	function check() {
		$("#ajaxB").click();
	}
</script>
</head>
<body onload="check()">
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="提交" />
	<input type="hidden" id="sendNum" value="<%=sendNum%>">
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>蓝膜号</th>
				<th>级别</th>
				<th>批次头</th>
				<th>蓝膜状态</th>
				<th>不良数</th>
				<th>系统数量</th>
				<th>报检单号</th>
				<input type="hidden" id="workId" name="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxC" value="重新送检" />
</body>
</html>
