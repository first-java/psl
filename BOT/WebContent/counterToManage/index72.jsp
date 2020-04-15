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
<title>导出查询批次</title>
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
			var tapeId = $("#barcode1").prop("value");
			if (tapeId.trim() == "") {
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
				url : "cspBarcode.action?methodstr=ipqc", //5.1
				//提交的数据
				data : {
					"picking.tapeId" : tapeId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#barcode1").select();
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var tapeId = result.counter[i].tapeId;

						var binId = result.counter[i].binId;
						var qty = result.counter[i].qty;
						var materialName = result.counter[i].materialName;
						var lotHeader = result.counter[i].lotHeader;
						var odd = result.counter[i].odd;
						var createTime = result.counter[i].createTime;
						var createTime1 = result.counter[i].createTime;
						createTime1 = createTime1.trim().replace(" ", "!");
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='tapeId' value=" + tapeId + " />" + tapeId + "</td><td>" +
							"<input type='hidden' name='binId'  value=" + binId + " />" + binId + "</td><td>" +
							"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='materialName' value=" + materialName + " />" + materialName + "</td><td>" +
							"<input type='hidden' name='lotHeader'  value=" + lotHeader + " />" + lotHeader + "</td><td>" +
							"<input type='hidden' name='createTime' value=" + createTime1 + " />" + createTime + "</td><td>" +
							"<input type='hidden' name='odd' value=" + odd + " />" + odd + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

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
			var tapeId = "[";
			$("[name=tapeId]").each(function() {
				tapeId += '{"tapeId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			tapeId = tapeId.replace(reg, "");
			tapeId += "]";

			var binId = "[";
			$("[name=binId]").each(function() {
				binId += '{"binId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			binId = binId.replace(reg, "");
			binId += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";

			var lotHeader = "[";
			$("[name=lotHeader]").each(function() {
				lotHeader += '{"lotHeader":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotHeader = lotHeader.replace(reg, "");
			lotHeader += "]";

			var createTime = "[";
			$("[name=createTime]").each(function() {
				createTime += '{"createTime":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			createTime = createTime.replace(reg, "");
			createTime += "]";


			var odd = "[";
			$("[name=odd]").each(function() {
				odd += '{"tapeId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			odd = odd.replace(reg, "");
			odd += "]";



			var workId = $("#workId").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspBarcode.action?methodstr=ipqcPutIn", //5.1
				//提交的数据

				data : {
					"picking.tapeId" : tapeId,
					"picking.binId" : binId,
					"picking.qty" : qty,
					"picking.materialName" : materialName,
					"picking.lotHeader" : lotHeader,
					"picking.createTime" : createTime,
					"picking.odd" : odd
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
					});
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
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>
	<td colspan="4">选择日期 从
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
		</div>
	</td>
	<input class="btn btn-primary"
		onclick="downLoad('downloadC.action?methodstr=batchs')"
		value="导出批次">

</body>
</html>
<script>
	function downLoad(url) {
		//1、获得查询参数
		var status = $('select[name=st] option:selected').val();
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");
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