
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>产品入库</title>
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
<script type="text/javascript">
	function setFocus() {
		document.getElementById('product').focus()
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
</script>
<style>
.abc {
	color: #00F
}
</style>
<script>
	function t1(obj, id) {
		var idd = Number(id);

		var barcode = $("#shijiQty" + idd + "").val();
		if (barcode == '') {
			layer.alert('还没输入数量！', {
				icon : 2
			}, function() {
				$("#barcode" + id + "").select();
				layer.closeAll();
			});
			return false;
		}
		$("#shijiQty" + (idd + 1) + "").select();
	}

	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var obj = $("#product").prop("value");
			var workId = $("#workId").prop("value");
			//将多个同name的值组成一个json数组字符串 
			var sendNum = "[";
			$("[name=sendNum]").each(function() {
				sendNum += '{"sendNum":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sendNum = sendNum.replace(reg, "");
			sendNum += "]";

			//将多个同name的值组成一个json数组字符串 
			var binUnitId = "[";
			$("[name=binUnitId]").each(function() {
				binUnitId += '{"binUnitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			binUnitId = binUnitId.replace(reg, "");
			binUnitId += "]";

			//将多个同name的值组成一个json数组字符串 
			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";
			//将多个同name的值组成一个json数组字符串 
			var rootLotId = "[";
			$("[name=rootLotId]").each(function() {
				rootLotId += '{"rootLotId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			rootLotId = rootLotId.replace(reg, "");
			rootLotId += "]";

			//将多个同name的值组成一个json数组字符串 
			var residueQty = "[";
			$("[name=residueQty]").each(function() {
				residueQty += '{"residueQty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			residueQty = residueQty.replace(reg, "");
			residueQty += "]";

			//将多个同name的值组成一个json数组字符串 
			var createTime = "[";
			$("[name=createTime]").each(function() {
				createTime += '{"createTime":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			createTime = createTime.replace(reg, "");
			createTime += "]";

			//将多个同name的值组成一个json数组字符串 
			var shijiQty = "[";
			$("[name=shijiQty]").each(function() {
				shijiQty += '{"shijiQty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			shijiQty = shijiQty.replace(reg, "");
			shijiQty += "]";

			if (createTime == "") {
				layer.msg("没有任何数据可以提交！", {
					icon : 2
				}, function() {
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
				url : "ctm.action?methodstr=putIn", //9.1
				//提交的数据
				data : {
					"counter.binUnitId" : binUnitId,
					"counter.materialName" : materialName,
					"counter.rootLotId" : rootLotId,
					"counter.residueQty" : residueQty,
					"counter.sendNum" : sendNum,
					"counter.shijiQty" : shijiQty,
					"counter.workId" : workId,
					"counter.product" : obj
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == '没有查到数据！') {
						layer.msg("没有查到数据", {
							icon : 2
						});
						return false;
					}
					var strs = new Array();

					strs = result.split("-");
					if (strs[0] == 'sss') {
						var strs1 = new Array();
						strs1 = result.split("-");
						layer.open({
							title : '存放位置',
							area : [ '750px', '400px' ],
							content : '<span style="font-size:36px">' + "该产品已经在" + ' </span>' +
								'<span class="abc"  style="font-size:48px">' + strs[1] + ' </span>' +
								'<span style="font-size:36px">' + "货架上" + ' </span>'
						})
						return false;
					}
					layer.open({
						title : '存放位置',
						area : [ '750px', '400px' ],
						content : '<span style="font-size:36px">' + strs[0] + ' </span>' +
							'<span class="abc"  style="font-size:48px">' + strs[1] + ' </span>' +
							'<span style="font-size:36px">' + strs[2] + ' </span>'
					}, function() {
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
			});

		});
		$("#ajaxD").click(function() {

			var obj = $("#product").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectPutIn", //9.2
				//提交的数据
				data : {
					"counter.product" : obj
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var strs = new Array();

					strs = result.split("-");
					if (strs[0] == 'sss') {
						var strs1 = new Array();
						strs1 = result.split("-");
						layer.open({
							title : '存放位置',
							area : [ '750px', '400px' ],
							content : '<span style="font-size:36px">' + "该产品已经在" + ' </span>' +
								'<span class="abc"  style="font-size:48px">' + strs[1] + ' </span>' +
								'<span style="font-size:36px">' + "货架上" + ' </span>'
						})
						return false;
					}
					layer.closeAll();
					$("[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var sendNum = result.counter[i].sendNum;
						var binUnitId = result.counter[i].binUnitId;
						var materialName = result.counter[i].materialName;
						var rootLotId = result.counter[i].rootLotId;
						var residueQty = result.counter[i].residueQty;
						var createTime = result.counter[i].createTime;
						var workId = result.counter[i].workId;
						var str = $.trim($("#ss").val());

						s = "<tr name='sss'><td>" +
							"<input type='hidden'  name='sendNum' size='16' value=" + sendNum + " />" + sendNum +
							"</td><td>" +
							"<input type='hidden'  name='binUnitId'  value=" + binUnitId + " />" + binUnitId +
							"</td><td>" +
							"<input type='hidden' name='materialName'  value=" + materialName + " />" + materialName +
							"</td><td>" +
							"<input type='hidden'  name='rootLotId'  value=" + rootLotId + " />" + rootLotId +
							"</td><td>" +
							"<input type='number'  onkeypress='if(event.keyCode==13) t1(this," + i + ");' id='shijiQty" + i + "'  name='shijiQty' />" +
							"</td><td>" +
							"<input type='hidden'  name='residueQty'  value=" + residueQty + " />" + residueQty +
							"</td><td>" +
							"<input type='hidden'  name='createTime'  value=" + createTime + " />" + createTime +
							"</td><td>" +
							"<input type='hidden'  name='workId'  value=" + workId + " />" + workId +
							"</td></tr>";
						var luckElements = document.getElementsByName("materialname");

						$("#sample-table-2").append(s);
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
		$("#ajaxC").click(function() {
			var product = $("#products").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=s", //11.2
				//提交的数据
				data : {
					"counter.product" : product
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var strs = new Array();

					strs = result.split("-");

					layer.open({
						title : '存放位置',
						area : [ '750px', '500px' ],
						content : '<span style="font-size:36px">' + strs[0] + ' </span>' +
							'<span class="abc"  style="font-size:48px">' + strs[1] + ' </span>' +
							'<span style="font-size:36px">' + strs[2] + ' </span>'
					}, function() {
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
	function getsubId(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#ajaxA").click();
	}
	function a() {
		$("#ajaxD").click();
	}
	function _b() {
		if (event.keyCode == 13)
			a();
	}
</script>

</head>
<body>
	<div>
		<from>
		<table id="sample-table-1">
			<tr>
				<td><div class="widget-header">
						<center>
							<table>
								<tr>
									<td><h4>产品入库</h4></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td><h4>
											<a id="qwer" onclick="t();">未用完蓝膜材料入库</a>
										</h4></td>
								</tr>
							</table>
						</center>
					</div></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><input id="clickMe" type="hidden" onclick="setFocus()" />
					输入蓝膜或报检单号 ： <input type="text" onKeyDown="_b()" id="product"
					size="16" name="product" style="text-transform: uppercase;"></td>
				<input type="hidden" value="<%=workId%>" id="workId" />
				<td>查询产品所在货架：<input type="text" id="products" name="product"
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxC">确认</button>
					<button class="btn btn-primary" id="ajaxD">11</button>
				</td>
			</tr>

		</table>

		<hr>
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-2" width="50%">
			<thead>
				<tr>
					<th>送检单号</th>
					<th>蓝膜号</th>
					<th>级别</th>
					<th>批次头</th>
					<th>实际数量</th>
					<th>系统数量</th>
					<th>创建时间</th>
					<th>质检员</th>
					<input type="hidden" id="workId" name="workId"
						value="<%=workId%>666" />
				</tr>
			</thead>
		</table>
		<hr>
		<table>
			<tr>
				<td><button class="btn btn-primary" id="ajaxA">提交</button></td>
			</tr>
		</table>
		<hr>
	</div>
</body>
</html>
<script>

	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '800px', '500px' ],
			content : "<%=request.getContextPath()%>/counterToManage/index2x.jsp?workId='" + opt + "'"
		});

	}
</script>