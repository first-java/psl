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
<title>入库</title>
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
		var luck = document.getElementsByName("qty1");
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
			var reelId = $("#barcode1").prop("value");
			if (reelId.trim() == "") {
				layer.msg("还没录入TYPE", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			//jna2 
			var options = $("#conp option:selected").val();
			if (options == '请选择...') {
				layer.msg("还没选择公司", {
					icon : 2
				});

				return false;
			}
			if (options == '其他') {
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "xlku.action?methodstr=notest", //5.1
					//提交的数据
					data : {
						"counter.reelId" : reelId
					},
					//返回数据的格式
					datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数

					success : function(result) {
						if (result == 'error') {
							layer.alert("不存在此片！");
							$("#barcode1").select();
							return false;
						}
						if (result == 'error1') {
							layer.alert("此片产线已经做过入库！");
							$("#barcode1").select();
							return false;
						}
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
							var reelId = result.counter[i].reelId;
							var stockId = result.counter[i].stockId;
							var itemId = result.counter[i].itemId;
							var qty = result.counter[i].qty;
							var ssVfcode = result.counter[i].ssVfcode;
							var reelId1 = "";
							if (reelId == '') {
								reelId = result.counter[i].barcodeString;
								reelId1 = result.counter[i].barcodeString;
								reelId1 = reelId1.replace("  ", "!");
								reelId1 = reelId1.replace(" ", "*");
							}
							if (reelId1 == "") {
								reelId1 = reelId;
							}
							if (qty == '') {
								qty = result.counter[i].cQty;
								if (qty == '') {
									qty = result.counter[i].jyQty;
									if (qty == '') {
										qty = result.counter[i].ssQty;
									}
								}
							}
							if (stockId == '') {
								stockId = result.counter[i].cType;
								if (stockId == '') {
									stockId = result.counter[i].jyType;
								}
								if (stockId == '') {
									stockId = result.counter[i].jyType;
									if (stockId == '') {
										stockId = result.counter[i].ssCode;
									}
								}
							}
							if (itemId == '') {
								itemId = result.counter[i].ssSpec;
							}
							if (ssVfcode !== undefined) {
								ssVfcode = ssVfcode;
							} else {
								ssVfcode = "";
							}

							s = "<tr name='sss'><td>" +
								"<input type='hidden' name='reelId' id='reelId' value=" + reelId1 + " />" + reelId + "</td><td>" +
								"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
								"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
								"<input type='hidden' name='ssVfcode' id='ssVfcode' value=" + ssVfcode + " />" + ssVfcode + "</td><td>" +
								"<input type='hidden' name='qty1' id='qty' value=" + qty + " />" + qty + "</td><td>" +

								"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

							var luckElements = document.getElementsByName("reelId");
							var tapeId = document.getElementById("barcode1").value;

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
						var luck = document.getElementsByName("qty1");
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
			}

			if (options == '晶能') {
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "jna2.action?methodstr=notest", //5.1
					//提交的数据
					data : {
						"counter.reelId" : reelId
					},
					//返回数据的格式
					datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数

					success : function(result) {
						if (result == 'error') {
							layer.alert("不存在此片！");
							$("#barcode1").select();
							return false;
						}
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
							var reelId = result.counter[i].binUnitId;
							var stockId = result.counter[i].modelId;
							var ssVfcode = result.counter[i].ssVfcode;
							var itemId = result.counter[i].cstorageId;
							var qty = result.counter[i].qty;
							qty = Math.ceil(qty * 1000);
							if (ssVfcode !== undefined) {
								ssVfcode = ssVfcode;
							} else {
								ssVfcode = "";
							}
							s = "<tr name='sss'><td>" +
								"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
								"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
								"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
								"<input type='hidden' name='ssVfcode' id='ssVfcode' value=" + ssVfcode + " />" + ssVfcode + "</td><td>" +
								"<input type='hidden' name='qty1' id='qty' value=" + qty + " />" + qty + "</td><td>" +
								"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

							var luckElements = document.getElementsByName("reelId");
							var tapeId = document.getElementById("barcode1").value;

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
						var luck = document.getElementsByName("qty1");
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
			}
		});

		$("#ajaxB").click(function() {
			var reelId = "[";
			$("[name=reelId]").each(function() {
				reelId += '{"reelId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			reelId = reelId.replace(reg, "");
			reelId += "]";

			var ssVfcode = "[";
			$("[name=ssVfcode]").each(function() {
				ssVfcode += '{"ssVfcode":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			ssVfcode = ssVfcode.replace(reg, "");
			ssVfcode += "]";

			var stockId = "[";
			$("[name=stockId]").each(function() {
				stockId += '{"stockId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			stockId = stockId.replace(reg, "");
			stockId += "]";

			var itemId = "[";
			$("[name=itemId]").each(function() {
				itemId += '{"itemId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			itemId = itemId.replace(reg, "");
			itemId += "]";

			var qty1 = "[";
			$("[name=qty1]").each(function() {
				qty1 += '{"qty1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty1 = qty1.replace(reg, "");
			qty1 += "]";

			var workId = $("#workId").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "xlku.action?methodstr=putIn", //5.1
				//提交的数据
				data : {
					"counter.reelId" : reelId,
					"counter.stockId" : stockId,
					"counter.itemId" : itemId,
					"counter.qty1" : qty1,
					"counter.workId" : workId,
					"counter.ssVfcode" : ssVfcode
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
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

<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id) + 1;
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
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>
	<a href="<%=request.getContextPath()%>/xl/ESD.jsp?workId=<%=workId%>">ESD录入</a>
	<a href="<%=request.getContextPath()%>/xl/ESD.jsp?workId=<%=workId%>">隔离清单导入</a>
	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">选择公司：<select id="conp"><option>请选择...</option>
						<option value="其他">其他</option>
						<option value="晶能">晶能</option></select> 底板号：<input id="barcode1"
					type="text" onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>

				<td><form id="myForm"
						action="<%=path%>/downloadKu.action?methodstr=downloadKu"
						method="post" enctype="multipart/form-data">
						<td><button class="btn btn-primary">导出库存</button></td>
					</form></td>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>底板号</th>
				<th>存货编码</th>
				<th>存货参数</th>
				<th>SS_VFCODE</th>
				<th>数量（颗）</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />

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