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
<title>仓库换货</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/json2.js"></script>
<script>

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
		$("#ajaxD").click(function() {
			var stockIdcheck = "";
			$("input[name='checkbox']:checked").each(function() {

				stockIdcheck = $(this).parent("td").parent("tr").find("[name='stockIdcheck']").val();
			});

			var id = "";
			$("input[name='checkbox']:checked").each(function() {

				id = $(this).parent("td").parent("tr").find("[name='id']").val();
			});

			var sewen = "";
			$("input[name='checkbox']:checked").each(function() {

				sewen = $(this).parent("td").parent("tr").find("[name='sewen']").val();
			});
			var light = "";
			$("input[name='checkbox']:checked").each(function() {

				light = $(this).parent("td").parent("tr").find("[name='light']").val();
			});

			var xianzhi = "";
			$("input[name='checkbox']:checked").each(function() {

				xianzhi = $(this).parent("td").parent("tr").find("[name='xianzhi']").val();
			});

			var dianya = "";
			$("input[name='checkbox']:checked").each(function() {

				dianya = $(this).parent("td").parent("tr").find("[name='dianya']").val();
			});
			var bochang = "";
			$("input[name='checkbox']:checked").each(function() {

				bochang = $(this).parent("td").parent("tr").find("[name='bochang']").val();
			});
			var reelId = $("#barcode1").prop("value");
			if (reelId.trim() == "") {
				layer.msg("还没录入片号", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=notestBu", //5.1
				//提交的数据
				data : {
					"counter.sewen" : sewen,
					"counter.light" : light,
					"counter.xianzhi" : xianzhi,
					"counter.dianya" : dianya,
					"counter.bochang" : bochang,
					"counter.reelId" : reelId,
					"counter.id" : id,
					"counter.stockIdcheck" : stockIdcheck
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result.startsWith("error")) {
						layer.alert(result);
						$("#barcode1").select();
						return false;
					}

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var reelId = result.counter[i].reelId;
						var stockId = result.counter[i].stockId;
						var itemId = result.counter[i].itemId;
						var qty = result.counter[i].qty;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
							"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
							"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +

							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("reelId");
						var tapeId = document.getElementById("barcode1").value;

						var qty1 = 0;
						var check = $("input[name='checkbox']:checked"); //选中的复选框
						check.each(function() {
							var row = $(this).parent("td").parent("tr");
							qty1 += parseInt(row.find("[name='qty1']").val()); //注意html()和val()

						});

						var lucks = document.getElementsByName("qty");

						var c = 0;
						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}
						}
						for (var i = 0; i < luckElements.length; i++) {
							c += parseInt(parseInt(lucks[i].value)) ;
						}
						$("#id").val()
						if (test111 == 'value') {
							layer.msg("数量已达到！", {
								icon : 2
							})
							return false;
						}
						if (c + parseInt(qty) > parseInt(qty1)) {
							$("#test111").val("value");
							layer.msg("数量已达到！", {
								icon : 2
							})
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
		$("#ajaxA").click(function() {
			if ($("input[type='checkbox']").is(':checked') == false) {

				layer.msg("请选择出货指令", {
					icon : 2
				});
				return false;
			}

			var id = "[";
			$("input[name='checkbox']:checked").each(function() {

				id += '{"id":"' + $(this).parent("td").parent("tr").find("[name='id']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			id = id.replace(reg, "");
			id += "]";

			var stockIdcheck = "[";
			$("input[name='checkbox']:checked").each(function() {

				stockIdcheck += '{"stockIdcheck":"' + $(this).parent("td").parent("tr").find("[name='stockIdcheck']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			stockIdcheck = stockIdcheck.replace(reg, "");
			stockIdcheck += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=huanhuo", //5.1
				//提交的数据
				data : {
					"counter.id" : id,
					"counter.stockId" : stockIdcheck
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var reelId = result.counter[i].reelId;
						var stockId = result.counter[i].stockId;
						var itemId = result.counter[i].itemId;
						var qty = result.counter[i].qty;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
							"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
							"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						$("#sample-table-1").append(s);
					}
					var luckElements = document.getElementsByName("reelId");
					ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片<font size='8' color='red'></td>"
					$("#tt").append(ss);
					var count1 = 0;
					var luck = document.getElementsByName("qty");
					for (var i = 0; i < luck.length; i++) {
						count1 += Number(luck[i].value);
					}

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
		$("#ajaxE").click(function() {
			if ($("input[type='checkbox']").is(':checked') == false) {

				layer.msg("请选择出货指令", {
					icon : 2
				});
				return false;
			}

			var id = "[";
			$("input[name='checkbox']:checked").each(function() {

				id += '{"id":"' + $(this).parent("td").parent("tr").find("[name='id']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			id = id.replace(reg, "");
			id += "]";


			var reelId = "[";
			$("[name=reelId]").each(function() {
				reelId += '{"reelId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			reelId = reelId.replace(reg, "");
			reelId += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=huanBei", //5.1
				//提交的数据
				data : {
					"counter.id" : id,
					"counter.reelId" : reelId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					layer.alert(result) ;

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
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=selZhiL1", //5.1

				success : function(result) {
					layer.closeAll();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var stockId = result.counter[i].stockId;
						s = '<option>' + stockId + '</option>'

						$("#select").append(s);
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

		})
	})
</script>

<script type="text/javascript">
	function fff() {
		if ($("input[type='checkbox']").is(':checked') == true) {

			$("input[name='checkbox']").attr("disabled", "disabled");

		}
	}
	function check() {
		$("#table").hide();
		$("#ajaxC").click();
	}
	function t(obj, id) {
		var idd = Number(id) + 1;
		var idd = Number(id);
		var barcode = $("#" + id + "").val();
		if (barcode == '') {
			layer.alert('还没输入片号！', {
				icon : 2
			}, function() {
				$("#" + id + "").val('');
				$("#" + id + "").select();
				layer.closeAll();
			});

			return false;
		}
		var df = Number(id) + 1;
		$("#" + df + "").select();
		return false;
	}
	/* function setFocus() {
		document.getElementById('barcode1').select();
	} */
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

<style type="text/css">
table.hovertable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}

table.hovertable th {
	background-color: #c3dde0;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}

table.hovertable tr {
	background-color: #d4e3e5;
}

table.hovertable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
</style>

</head>
<body onload="check();">
	<input type="hidden" id="ajaxC" />
	<input type="hidden" id="test111" value="" />
	<input type="hidden" id="length" value="" />
	<table class="hovertable" id="table" width="50%">
		<thead>
			<tr>
				<th>指令ID</th>
				<th>出货客户</th>
				<th>出货原因</th>
				<th>出货编码</th>
				<th>出货参数</th>
				<th>色温</th>
				<th>亮度</th>
				<th>显指</th>
				<th>电压</th>
				<th>波长</th>
				<th>出货数量</th>
				<th>指令下达时间</th>
				<th>指令下达人</th>
				<th>选择出货指令</th>
				<th><button class="btn btn-primary " id="ajaxA">查询</button></th>

			</tr>
		</thead>
	</table>
	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">底板号：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxD" onclick="setFocus()">确认</button>
				</td>

			</tr>


		</table>
	</div>
	<div class="page-header">
		<table>
			<tr>
				<td id="tt"></td>
			</tr>
			<tr>
				<td><input id="clickMe" type="hidden" /></td>
				<td>选择出货编码：<select id="select" name="stockId"
					style="height:40px;" onchange="func();"><option>请选择存货编码</option>
				</select></td>

			</tr>
		</table>
	</div>
	<br>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>底板号</th>
				<th>存货编码</th>
				<th>存货参数</th>
				<th>数量（颗）</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxE" value="提交" />
	<input type="hidden" id="test111" value="" />
</body>
</html>
<script>

	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#ajaxD").click();
	}
	function func() {
		layer.load();
		$("#table").show();
		var stockId = $('select[name=stockId] option:selected').val();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "cspku.action?methodstr=selZhiL", //5.1
			data : {
				"counter.stockId" : stockId
			},
			success : function(result) {
				layer.closeAll();
				if (result == 'ss') {
					layer.msg("未找到查询信息！", {
						icon : 2
					}, function() {
						window.location.reload();

					});
				}
				var result = eval("(" + result + ")");
				$("tr[name='sss']").remove();
				for (var i = 0; i < result.counter.length; i++) {
					var client = result.counter[i].client;
					var id = result.counter[i].id;
					var cuase = result.counter[i].cuase;
					var stockId = result.counter[i].stockId;
					var itemId = result.counter[i].itemId;
					var qty = result.counter[i].qty;
					var workId = result.counter[i].workId;
					var createTime = result.counter[i].createTime;
					var sewen = result.counter[i].sewen;
					var light = result.counter[i].light;
					var xianzhi = result.counter[i].xianzhi;
					var dianya = result.counter[i].dianya;
					var bochang = result.counter[i].bochang;


					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='id' id='id' value=" + id + " />" + id + "</td><td>" +
						"<input type='hidden' name='client' id='client' value=" + client + " />" + client + "</td><td>" +
						"<input type='hidden' name='cuase' id='cuase' value=" + cuase + " />" + cuase + "</td><td>" +
						"<input type='hidden' name='stockIdcheck' id='stockIdcheck' value=" + stockId + " />" + stockId + "</td><td>" +
						"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='sewen' id='sewen' value=" + sewen + " />" + sewen + "</td><td>" +
						"<input type='hidden' name='light' id='light' value=" + light + " />" + light + "</td><td>" +
						"<input type='hidden' name='xianzhi' id='xianzhi' value=" + xianzhi + " />" + xianzhi + "</td><td>" +
						"<input type='hidden' name='dianya' id='dianya' value=" + dianya + " />" + dianya + "</td><td>" +
						"<input type='hidden' name='bochang' id='bochang' value=" + bochang + " />" + bochang + "</td><td>" +
						"<input type='hidden' name='qty1' id='qty1' value=" + qty + " />" + qty + "</td><td>" +
						"<input type='hidden' name='createTime' id='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
						"<input type='hidden' name='workId' id='workId' value=" + workId + " />" + workId + "</td><td>" +
						"<input type='checkbox' name='checkbox' onclick='fff()' value='' /></td></tr>";

					$("#table").append(s);
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

	function t1() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '800px', '600px' ],
			content : "<%=request.getContextPath()%>/csp_ku/index10.jsp"
		});

	}
</script>
