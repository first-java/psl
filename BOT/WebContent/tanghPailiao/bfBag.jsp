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
<title>报废静电袋</title>
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

<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#ajaxA").click();
	}
	function setFocus() {
		document.getElementById('barcode').select();
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

				<td id="tt">静电袋：<input id="barcode" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
					onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') ">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
				<td id="tt">报废单号：<input id="weight" type="text">

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
				<th>静电袋</th>
				<th>种类</th>
				<th>数量</th>
				<th>类型</th>
				<th>备注</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<div class="form-group">

		<label for="printTplBtn" class="col-sm-1 control-label label-postek"></label>
		<div class="form-group col-sm-3"
			style="padding-left:0;padding-right:0;margin-top: 10px;">
			<button id="ajaxB"
				class="btn btn-primary btn-lg btn-block btn-postek" type="button"
				data-loading-text="打印模板中...">提交</button>
		</div>

	</div>
	<!-- 按钮 -->
	<div class="form-group">

		<label for="printTplBtn" class="col-sm-1 control-label label-postek"></label>
		<div class="form-group col-sm-3"
			style="padding-left:0;padding-right:0;margin-top: 10px;">
			<input id="printTplBtn" readonly="readonly"
				class="btn btn-primary btn-lg btn-block btn-postek" type="hidden"
				data-loading-text="打印模板中..." />
		</div>
	</div>
</body>
</html>
<script>
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);

		var luckElements = document.getElementsByName("barcode");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "卷</font></td>"
		$("#tt").append(ss);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var barcode = $("#barcode").prop("value");
			if (barcode.trim() == "") {
				layer.msg("还没录入卷轴号！", {
					icon : 2
				});
				document.getElementById('barcode').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selbfBag", //5.1
				//提交的数据
				data : {
					"putIn.bagName" : barcode
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result.startsWith("error:")) {
						layer.alert(result);
						$("#bagName").select();
						return false;
					}
					var luckElements = document.getElementsByName("barcode");

					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var barcode = result.counter[i].bagName;
						var lotType = result.counter[i].lotType;
						var qty = result.counter[i].qty;
						var leiXing = result.counter[i].leiXing;
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='barcode' id='barcode' value=" + barcode + " />" + barcode + "</td><td>" +
							"<input type='hidden' name='lotType' id='lotType' value=" + lotType + " />" + lotType + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='leiXing' id='leiXing' value=" + leiXing + " />" + leiXing + "</td><td>" +
							"<input type='text' name='remark' id='remark' </td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("barcode");
						var tapeId = document.getElementById("barcode").value;

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
						ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "袋<font size='8' color='red'></td>"
						$("#tt").append(ss);

					}
					$("td[name='s']").remove();
					ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "袋<font size='8' color='red'></td>"
					$("#tt").append(ss);
					$("#sample-table-1").append(s);

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

			var lotType = "[";
			$("[name=lotType]").each(function() {
				lotType += '{"lotType":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotType = lotType.replace(reg, "");
			lotType += "]";

			var leiXing = "[";
			$("[name=leiXing]").each(function() {
				leiXing += '{"leiXing":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			leiXing = leiXing.replace(reg, "");
			leiXing += "]";


			var remark = "[";
			$("[name=remark]").each(function() {
				remark += '{"remark":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			remark = remark.replace(reg, "");
			remark += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			var luckElements = document.getElementsByName("barcode");
			if (luckElements.length < 1) {
				layer.msg("没有数据可以提交！", {
					icon : 2
				});
				document.getElementById('weight').focus();
				return false;
			}
			var workId = $("#workId").prop("value");
			var weight = $("#weight").prop("value");
			if (weight.trim() == "") {
				layer.msg("还没输入报废单号！", {
					icon : 2
				});
				document.getElementById('weight').focus();
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=bfBag", //5.1
				//提交的数据
				data : {
					"putIn.barcode" : barcode,
					"putIn.lotType" : lotType,
					"putIn.leiXing" : leiXing,
					"putIn.odd" : qty,
					"putIn.workId" : workId,
					"putIn.weight" : weight, //报废单号
					"putIn.remark" : remark
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					layer.alert(result, function() {
						window.location.reload();
					});
					return;

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
	var url = "http://127.0.0.1:888/postek/print";
	var urls = "127.0.0.1:8080/img/logo1.pcx";
	$(document).ready(function() {
		$("#year").html(new Date().getFullYear());

		window.onscroll = function() {
			var top = document.getElementsByTagName("body")[0].scrollTop;
			if (top > window.innerHeight) {
				//tag.style.visibility = "visible";
				$("#fengei").hide();
			} else {
				//tag.style.visibility = "hidden";
				$("#fengei").fadeIn();
			}

		}

		$("#printTplBtn").on("click", function() {

			var bagName = $("#bagName").prop("value");
			var qty = $("#qty").prop("value");
			var lotHead1 = $("#lotHead1").prop("value");
			var weight1 = $("#weight1").prop("value");

			$("#printTplBtn").text("正在打印中。。。");
			$("#printTplBtn").attr("disabled", "disabled");

			var data = {};
			data.printname = $("#printname").val();
			data.reqParam = "2";
			data.lang = "zh";

			var printparamsJsonArray = [];
			//循环打印张数起始位置
			//for (var i = 0; i < 2; i++) {


			printparamsJsonArray.push({
				"OpenPort" : $("#printname").val()
			}); //打开打印机

			printparamsJsonArray.push({
				"PTK_ClearBuffer" : ""
			}); //清除缓存

			printparamsJsonArray.push({
				"PTK_SetDirection" : 'B'
			}); //设置打印方向

			printparamsJsonArray.push({
				"PTK_SetPrintSpeed" : "4"
			}); //设置打印速度

			printparamsJsonArray.push({
				"PTK_SetDarkness" : "15"
			}); //设置打印黑度

			printparamsJsonArray.push({
				"PTK_PcxGraphicsDel" : "*"
			}); //删除所有图形

			printparamsJsonArray.push({
				"PTK_SetLabelHeight" : "300,16,0,false"
			}); //设置标签纸高度  间隙高度  ！必须设置

			printparamsJsonArray.push({
				"PTK_SetLabelWidth" : "550"
			}); //设置标签纸宽度  ！必须设置
			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "20,45,0,3,2,1,N,卷轴转分光入库,0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "13,70,0,3,2,2,N,袋号：,0"
			}); //打印文字 */
			/* printparamsJsonArray.push({
				"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
			}); //打印文字
			 */
			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "30,235,0,3,1,1,N,数量：" + qty + ",0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "250,235,0,3,1,1,N,净重：" + weight1 + ",0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "30,185,0,3,1,1,N,种类:" + lotHead1 + ",0"
			}); //打印文字


			printparamsJsonArray.push({
				"PTK_DrawBarcode" : "100,85,0,1,2,2,50,B," + bagName
			}); //打印一个一维码

			printparamsJsonArray.push({
				"PTK_PrintLabel" : "1,1"
			}); //63设置打印份数  复制份数  ！必须设置

			printparamsJsonArray.push({
				"ClosePort" : ""
			});

			//}

			//循环打印结束位置
			data.printparams = JSON.stringify(printparamsJsonArray);

			$.ajax({
				type : "POST",
				url : url,
				data : data,
				dataType : "json",
				timeout : 5000, // in milliseconds
				success : function(result) {
					//var retdata = JSON.parse (result);
					if (result.retval == '0') {
						$("#tip").html("发送成功").css("color", "green");
						$("#tip").fadeIn();
						$("#printTplBtn").text("打印模板");
						$("#printTplBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);

					} else {
						/* $("#tip").html("发送成功").css("color", "green");
						$("#tip").fadeIn();
						$("#printTplBtn").text("打印模板");
						$("#printTplBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0); */
						$("#tip").html("发送失败，返回结果：" + result.msg).css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printBtn").text("打印模板");
						$("#printBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				},
				error : function() {
					$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#printTplBtn").text("打印模板");
					$("#printTplBtn").removeAttr("disabled");
					$("#tip").delay(3000).hide(0);
				}
			});
		});
		$("#username").focus();
		getPrinterList();


	});

	function getPrinterList() {
		var data = {};
		data.printname = $("#printname").val();
		data.reqParam = "0";
		data.lang = "zh";

		$.ajax({
			type : "POST",
			url : url,
			data : data,
			dataType : "json",
			timeout : 5000, // in milliseconds
			success : function(result) {
				if (result == null || result.length == 0) {
					$("#tip").html("获取打印机失败，请刷新页面重试").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#printTplBtn").attr("disabled", "disabled");
					$("#tip").delay(3000).hide(0);

				} else {
					$("#printname").empty();
					//var retdata = JSON.parse (result);
					for (var i in result) {
						$("#printname").append("<option value='" + result[i].printName + "'>" + result[i].printName + "</option>");
					}
					$("#tip").hide();

				}
			},
			error : function() {
				$("#tip").html("获取打印机失败，请刷新页面重试").css("color", "#D20B2C");
				$("#tip").fadeIn();
				$("#printTplBtn").attr("disabled", "disabled");
				$("#tip").delay(3000).hide(0);
			}
		});

	}
</script>

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