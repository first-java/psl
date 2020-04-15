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
<title>静电袋合袋</title>
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
	function t2() {
		$("#ajaxA").click();
	}
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);

		var luckElements = document.getElementsByName("bagName");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "袋</font></td>"
		$("#tt").append(ss);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var bagName = $("#bagName").prop("value");

			if (bagName.trim() == "") {
				layer.msg("还没录入静电袋！", {
					icon : 2
				});
				document.getElementById('bagName').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selZhuBag", //5.1
				//提交的数据
				data : {
					"putIn.bagName" : bagName.trim()
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
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var deposit1 = result.counter[i].leiXing;
						var lotType1 = result.counter[i].lotType;
						var bagName1 = result.counter[i].bagName;
						var qty = result.counter[i].qty;
						var jingWeight = result.counter[i].jingWeight;


						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='bagName1' id='bagName1' value=" + bagName1 + " />" + bagName1 + "</td><td>" +
							"<input type='hidden' name='deposit1' id='deposit1' value=" + deposit1 + " />" + deposit1 + "</td><td>" +
							"<input type='hidden' name='lotType1' id='lotType1' value=" + lotType1 + " />" + lotType1 + "</td><td>" +
							"<input type='hidden' name='seri' id='seri' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='jingWeight' id='jingWeight' value=" + jingWeight + " />" + jingWeight + "</td><td>" +
							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("bagName1");
						var tapeId = document.getElementById("bagName").value;

						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}
						}
						var leixing = document.getElementsByName("deposit1");
						var lott = document.getElementsByName("lotType1");
						for (var i = 0; i < luckElements.length; i++) {
							if (deposit1 != leixing[i].value) {
								layer.msg("类型不一致，不能合在一起！！", {
									icon : 2
								})
								return false;
							}
							if (lotType1 != lott[i].value) {
								layer.msg("种类不一致，不能合在一起！！", {
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
			layer.load();
			var luckElements = document.getElementsByName("bagName1");
			if (luckElements.length < 1) {

				layer.msg("没有数据可以提交！", {
					icon : 2
				}, function() {
					layer.closeAll();
				});

				return;
			}
			var bagName1 = "[";
			$("[name=bagName1]").each(function() {
				bagName1 += '{"bagName1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			bagName1 = bagName1.replace(reg, "");
			bagName1 += "]";


			var deposit1 = "[";
			$("[name=deposit1]").each(function() {
				deposit1 += '{"deposit1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			deposit1 = deposit1.replace(reg, "");
			deposit1 += "]";

			var lotType1 = "[";
			$("[name=lotType1]").each(function() {
				lotType1 += '{"lotType1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotType1 = lotType1.replace(reg, "");
			lotType1 += "]";

			var seri = "[";
			$("[name=seri]").each(function() {
				seri += '{"seri":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			seri = seri.replace(reg, "");
			seri += "]";

			var jingWeight = "[";
			$("[name=jingWeight]").each(function() {
				jingWeight += '{"jingWeight":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			jingWeight = jingWeight.replace(reg, "");
			jingWeight += "]";


			var zhuBagName = $("#zhuBagName").prop("value");
			var zhQty = $("#qty1").prop("value");
			var zhQty = $("#qty1").prop("value");
			var workId = $("#workId").prop("value");
			var jingWeight1 = $("#weight").prop("value");

			if (jingWeight1.trim() == "") {
				layer.msg("还没录入重量！", {
					icon : 2
				});
				document.getElementById('weight').focus();
				return false;
			}


			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=bagHe", //5.1
				//提交的数据
				data : {
					"putIn.bagName" : zhuBagName,
					"putIn.bagName1" : bagName1,
					"putIn.deposit" : deposit1,
					"putIn.seri" : seri,
					"putIn.weight" : jingWeight1,
					"putIn.zhQty" : zhQty,
					"putIn.jingWeight" : jingWeight,
					"putIn.lotType" : lotType1,
					"putIn.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result.startsWith("error:")) {
						layer.alert(result);
						return;
					}
					var t = result.split(":");
					$("#biaoti").val(t[0]);
					$("#bagname").val(t[1]);
					$("#qty").val(t[2]);
					$("#jingweight").val(t[3]);
					$("#lottype").val(t[4]);
					$("#printTplBtn").click();

				// lotId + ":" + bag + ":" + ttt + ":" + kkk + ":" + lotType1;
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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/csppailiao.css">
<script type="text/javascript">

	function setFocus() {
		document.getElementById('bagName').select();
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
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>

	<form id="printForm" action="#" data-parsley-validate="" novalidate=""
		role="form" method="post">

		<input type="hidden" id="biaoti"> <input type="hidden"
			id="bagname"> <input type="hidden" id="qty"> <input
			type="hidden" id="jingweight"> <input type="hidden"
			id="lottype">
		<%-- <div class="form-group col-sm-10"
			style="padding-left:0;padding-right:0;">

			打印机型号<select style="weight:40px;" id="printname" name="printname"
				class="form-control input-lg  mb25 select-postek">
			</select>
		</div> --%>
	</form>

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">静电袋号：<input id="bagName" type="text"
					onkeypress='if(event.keyCode==13) t2();'
					onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') ">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
				<td id="tt">重量：<input id="weight" type="number">
				</td>
			</tr>


		</table>
	</div>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>静电袋号</th>
				<th>类型</th>
				<th>种类</th>
				<th>数量</th>
				<th>净重</th>
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
				data-loading-text="打印模板中...">提交/打印</button>
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
<script type="text/javascript">
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

			var biaoti = $("#biaoti").prop("value");
			var qty = $("#qty").prop("value");
			var bagname = $("#bagname").prop("value");
			var jingweight = $("#jingweight").prop("value");
			var lottype = $("#lottype").prop("value");


			$("#printTplBtn").text("正在打印中。。。");
			$("#printTplBtn").attr("disabled", "disabled");

			var data = {};
			data.printname = $("#printname").val();
			data.reqParam = "1";
			data.lang = "zh";

			var printparamsJsonArray = [];
			//循环打印张数起始位置
			//for (var i = 0; i < 2; i++) {


			printparamsJsonArray.push({
				"OpenPort" : "255"
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
				"PTK_DrawTextEx" : "20,45,0,3,2,1,N,合袋入库（" + biaoti + "）,0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "13,70,0,3,2,2,N,袋号,0"
			}); //打印文字 */
			/* printparamsJsonArray.push({
				"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
			}); //打印文字
			 */
			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "30,235,0,3,1,1,N,数量：" + qty + ",0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "250,235,0,3,1,1,N,净重：" + jingweight + ",0"
			}); //打印文字

			printparamsJsonArray.push({
				"PTK_DrawTextEx" : "30,185,0,3,1,1,N,种类:" + lottype + ",0"
			}); //打印文字


			printparamsJsonArray.push({
				"PTK_DrawBarcode" : "110,85,0,1,2,2,50,B," + bagname
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
						history.go(0);
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

	});
</script>