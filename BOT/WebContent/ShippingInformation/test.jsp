
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
<!DOCTYPE html>
<html class="signin no-js" lang="zh">
<head>
<link type="favicon" rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="description" content="postek browser printer">
<meta name="keywords" content="postek">
<title>底板散芯入库（待分光）</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/csppailiao.css">
</head>
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
		layer.load();
			//获取上传框内容
			var code = $("#excel3").val();

			if ( (code == "" || code == "null") ) {
				layer.alert("还没选择任何文件！");
				return false;
			}

			//截取文件名
			var strcode = code.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
			//截取文件名前缀
			var fileCode = strcode.substring(0, 7);
			//截取文件名后缀
			var suffixCode = (code.substr(code.lastIndexOf("."))).toUpperCase();
			if (!(code == "" || code == null) && (suffixCode != ".CSV")) {
				layer.alert("文件格式只能是.CSV");
				return false;
			}

			if (!(code == "" || code == null) && (fileCode != "数据明细信息表")) {
				alert("请选择数据明细信息表");
				return false;
			}
			$("#myForm").submit();
		});
	});
</script>
<script type="text/javascript">

	$(function() {
		$("#submitBtn1").click(function() {


			$("#myForm1").submit();
		});
	});
</script>
<body class="main-body">

	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>
	<!-- <label for="printlabel" class="col-sm-2 control-label label-postek">
		待分光信息表：</label>
	<div class="form-group col-sm-10"
		style="padding-left:0;padding-right:0;">
		<form id="myForm" action="cspdaoru.action?methodstr=execute2"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="biaoji" value="数据明细信息表">
			<table>
				<tr>
					<td><div class="uploader blue">
							<input type="text" class="filename" readonly="readonly" /> <input
								type="button" name="file" class="button" value="浏览..." /> <input
								type="file" name="excel" id="excel3" size="30" />

						</div></td>

					<td><button id="submitBtn"
							class="btn btn-primary btn-lg btn-block btn-postek"
							data-loading-text="打印模板中...">导入</button></td>
				</tr>
			</table>
		</form></div> -->
	<input type="hidden" id="workId" value="<%=workId%>">

	<div class="center-wrapper main-center">
		<div class="center-content">

			<div class="row no-m">
				<div
					class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-2 col-md-8 col-md-offset-2">
					<div class="lang-box">

						<div style="float:right;">
							<a href="./cdfpsk_Net.html" style="margin-right:10px;"><img
								title="点击切换为调用网络打印" width="32" height="32"
								src="../assert/img/net.png" /></a> <a href="../index_cdfpsk.html"
								style="margin-right: 20px;"><img title="点击切换为调用USB打印"
								width="32" height="32" src="../assert/img/driver.png" /></a> <span><a
								href="./index.html">中文</a></span> &nbsp;&nbsp;|&nbsp;&nbsp; <span><a
								href="./index_en.html">English</a></span>
						</div>
					</div>
					<section class="panel bg-white no-b fadeIn animated"
						style="background-color: #efefef;border:none;">

						<div class="p15 main-box">
							<form id="printForm" action="#" data-parsley-validate=""
								novalidate="" role="form" method="post">

								<input type="hidden" id="shelfName" value=""> <input
									type="hidden" id="bag" value=""> <input type="hidden"
									id="bagweight" value=""> <input type="hidden"
									id="bagqty" value="">
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">批号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input type="text" id="lotId" autocomplete="off" required
											onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
											onkeypress='if(event.keyCode==13) t(this,1);'
											class="form-control input-lg mb25 input-postek"
											placeholder="批号">
									</div>
								</div>
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">袋重(含袋子标签g)：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input type="number" id="eachWeight" autocomplete="off"
											required class="form-control input-lg mb25 input-postek"
											placeholder="袋重(含袋子标签g)">
									</div>
								</div>
								<!-- 按钮 -->
								<div class="form-group">

									<label for="printTplBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;margin-top: 10px;">
										<input id="printTplBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="hidden" data-loading-text="打印模板中..." />
									</div>

								</div>
								<div class="form-group">

									<label for="printTplBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;margin-top: 10px;">
										<button id="ajaxA"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印模板中...">提交/打印</button>
									</div>

								</div>
								<p id="tip" class="p15  p-postek"
									style="margin-top:20px; margin-left: 25%;float:left;display:none"></p>
							</form>
						</div>
						<div id="fengei" style="float:left;width: 100%;display:none; ">
							<div class="fengei-div-postek">
								<span class="fengei-span-postek">我是有底线的</span>
							</div>
						</div>
					</section>
				</div>
			</div>

		</div>
	</div>

	<script type="text/javascript">
		function t() {
			var lotId = $("#lotId").prop("value");
	
			if (lotId == "") {
				layer.alert("还没输入批号", {
					icon : 2
				}, function() {
					layer.closeAll();
				});
	
				return false;
			}
			$("#eachWeight").select();
		}
		function clearNoNum(obj) {
			obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符  
			obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是  
			obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的  
			obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
			obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d{1}).*$/, '$1$2.$3'); //只能输入6个小数  
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				
				var lotId = $("#lotId").prop("value");
				var weight = $("#eachWeight").prop("value");
				var workId = $("#workId").prop("value");
				if (lotId == "") {
					layer.alert("还没输入批号", {
						icon : 2
					}, function() {
						layer.closeAll();$("#lotId").select();
					});
	
					return false;
				}
				if (lotId.length < 8) {
					layer.alert("批号不符合规则！", {
						icon : 2
					}, function() {
						layer.closeAll();$("#lotId").select();
					});
					return false;
				}
				if (weight === "") {
					layer.msg("还没输入袋重", {
						icon : 2
					}, function() {
						layer.closeAll();$("#weight").select();
					});
					return false;
				}
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=print", //1.1
					//提交的数据
					data : {
						"putIn.lotId" : lotId,
						"putIn.weight" : weight,
						"putIn.workId" : workId,
						"bagLabel.project1" : "底板散芯入库"
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						if ("kuo" == result) {
							layer.msg("框子已经放满！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
	
						if ("NOT-COMPLETED" == result) {
							layer.msg("该批次状态未完结！！", {
								icon : 2
							}, function() {
								window.location.reload();
	
							});
						}
						if ("noCaseNo" == result) {
							layer.msg("货架上已经没有框子了！！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if ("error" == result) {
							layer.msg("此批次未计数，不允许上架！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if ("error1" == result) {
							layer.msg("此批次头前7位没有找到转换数据！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if ("error2" == result) {
							layer.msg("MES中未找到此批次！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if ("error3" == result) {
							layer.msg("此批次已经剥掉了。！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if ("noCase" == result) {
							layer.msg("没有箱子可以存放！", {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if (result.startsWith("yichang")) {
							layer.msg(result, {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
						if (result.startsWith("error:")) {
							layer.msg(result, {
								icon : 2
							}, function() {
								window.location.reload();
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
	
						var result = eval("(" + result + ")");
						var shelfName = result.counter[0].shelfName;
						var caseNo = result.counter[0].caseNo;
						var bag = result.counter[0].lotId;
						var weight = result.counter[0].weight;
						var qty = result.counter[0].qty;
						var cntargs = result.counter[0].cntargs;
	
						if (cntargs.startsWith("error:")) {
	
							var cy = cntargs.substr(6, cntargs.length)
	
							var str = Number(cy * 100).toFixed(2);
							str += "%";
							layer.alert("误差相差：" + str);
	
						}
						$("#shelfName").val(shelfName);
						$("#caseNo").val(caseNo);
						$("#bag").val(bag);
						$("#bagweight").val(weight);
						$("#bagqty").val(qty);
						$("#printTplBtn").click();
	
	
					},
					//调用执行后调用的函数
					error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
						layer.colseAll();
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
		});
		var ip_port = "192.168.6.145,9100";
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
	
				/* 	var productType = $('#productType option:selected').val();
					var num = $('#num option:selected').val();
					num = Number(num); */
				var lotId = $("#lotId").prop("value");
				$("#lotId").val("");
				$("#eachWeight").val("");
				var bag = $("#bag").prop("value");
				var bagweight = $("#bagweight").prop("value");
				bagweight = parseFloat(bagweight)
				bagweight = bagweight.toFixed(2);
	
				var bagqty = $("#bagqty").prop("value");
				$("#printTplBtn").text("正在打印中。。。");
				$("#printTplBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printlabel = $("#printlabel").val();
				//data.printname = $("#printname").val();
				data.reqParam = "1";
				data.lang = "zh";
	
				var printparamsJsonArray = [];
	
				/* 	printparamsJsonArray.push({
						"PTK_Connect" : ip_port
					}); */
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
					"PTK_AnyGraphicsPrint" : "10,10,cainiao,C:\\img\\logo.png,0,80,60,0"
				});
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
	
				/* printparamsJsonArray.push({
					"PTK_DrawRectangle" : "0,0,3,558,280"
				});  */ //画矩形
	
				/* printparamsJsonArray.push({
					"PTK_PcxGraphicsDownload" : "logo1," + urls + ""
				}); //存储一个PCX格式图形
				 */
				/* printparamsJsonArray.push({
					"PTK_DrawPcxGraphics" : "1,1,logo1"
				}); //打印指定图形
				 */
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,30,0,3,2,1,N,底板散芯入库（待分光）,0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,70,0,3,1,2,N,袋号：,0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "240,165,0,3,1,1,N,净重:" + bagweight + "g" + ",0"
				}); //打印文字
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,1,1,N,批号:" + lotId + ",0"
				}); //打印文字
				 */
				/* 	printparamsJsonArray.push({
						"PTK_SetLabelWidth" : "400"
					}); */
	
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "100,70,0,1,2,2,50,B," + bag
				}); //打印一个一维码
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,1,2,N,批号,0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_SetDarkness" : "15"
				});
	
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "85,210,0,1,2,2,50,B," + lotId
				}); //打印一个一维码
	
				/* printparamsJsonArray.push({
					"PTK_DrawLineOr" : "58,111,500,3"
				}); //画直线
				 */
	
				/* printparamsJsonArray.push({
					"PTK_DrawBar2D_Pdf417" : "80,180,400,300,0,0,3,7,10,2,0,0,123456789"
				}); //打印PDF417码
				 */
				/* 	printparamsJsonArray.push({
						"PTK_DrawBar2D_QR" : "80,40,200,200,0,8,4,0,0,1234"
					}); */ //打印二维码 
	
				/* printparamsJsonArray.push({
					"PTK_DrawTextTrueTypeW" : "80,230,19,0,Arial,1,700,0,0,0,A3,Use different ID_NAME for different Truetype font objects"
				}); //用Windows字体打印文字
				 */
				printparamsJsonArray.push({
					"PTK_PrintLabel" : "1,1"
				}); //63设置打印份数  复制份数  ！必须设置
	
				printparamsJsonArray.push({
					"ClosePort" : ""
				});
	
				//循环打印结束位置
				data.printparams = JSON.stringify(printparamsJsonArray);
	
				$.ajax({
					type : "POST",
					url : url,
					data : data,
					dataType : "json",
					timeout : 3000, // in milliseconds
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
							$("#tip").delay(300000).hide(0);
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printTplBtn").text("打印模板");
						$("#printTplBtn").removeAttr("disabled");
						$("#tip").delay(300000).hide(0);
					}
				});
			});
	
		});
	</script>
</body>
</html>
<style>
#nav {
	position: absolute;
	top: 80px;
	left: 26px;
}

#nav ul {
	list-style: none;
}

#nav ul li {
	display: block;
	width: 196px;
	line-height: 60px;
	border-bottom: 1px solid #999;
}

#nav ul li div.first {
	text-indent: 20px;
	border-bottom: 1px solid #999;
}

#nav ul.second {
	display: none;
}

#nav ul.second li {
	display: block;
	width: 166px;
	padding-left: 30px;
	height: 30px;
	line-height: 30px;
	border: none;
}

.uploader {
	position: relative;
	display: inline-block;
	overflow: hidden;
	cursor: default;
	padding: 0;
	margin: 10px 0px;
	-moz-box-shadow: 0px 0px 5px #ddd;
	-webkit-box-shadow: 0px 0px 5px #ddd;
	box-shadow: 0px 0px 5px #ddd;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
}

.filename {
	float: left;
	display: inline-block;
	outline: 0 none;
	height: 32px;
	width: 200px;
	margin: 0;
	padding: 8px 10px;
	overflow: hidden;
	cursor: default;
	border: 1px solid;
	border-right: 0;
	font: 9pt/80% Arial, Helvetica, sans-serif;
	color: #777;
	text-shadow: 1px 1px 0px #fff;
	text-overflow: ellipsis;
	white-space: nowrap;
	-moz-border-radius: 5px 0px 0px 5px;
	-webkit-border-radius: 5px 0px 0px 5px;
	border-radius: 5px 0px 0px 5px;
	background: #f5f5f5;
	background: -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fafafa),
		color-stop(100%, #f5f5f5));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fafafa',
		endColorstr='#f5f5f5', GradientType=0);
	border-color: #ccc;
	-moz-box-shadow: 0px 0px 1px #fff inset;
	-webkit-box-shadow: 0px 0px 1px #fff inset;
	box-shadow: 0px 0px 1px #fff inset;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.button {
	float: left;
	height: 32px;
	display: inline-block;
	outline: 0 none;
	padding: 8px 12px;
	margin: 0;
	cursor: pointer;
	border: 1px solid;
	font: bold 9pt/100% Arial, Helvetica, sans-serif;
	-moz-border-radius: 0px 5px 5px 0px;
	-webkit-border-radius: 0px 5px 5px 0px;
	border-radius: 0px 5px 5px 0px;
	-moz-box-shadow: 0px 0px 1px #fff inset;
	-webkit-box-shadow: 0px 0px 1px #fff inset;
	box-shadow: 0px 0px 1px #fff inset;
}

.uploader input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	border: 0;
	padding: 0;
	margin: 0;
	height: 30px;
	cursor: pointer;
	filter: alpha(opacity = 0);
	-moz-opacity: 0;
	-khtml-opacity: 0;
	opacity: 0;
}

input[type=button]::-moz-focus-inner {
	padding: 0;
	border: 0 none;
	-moz-box-sizing: content-box;
}

input[type=button]::-webkit-focus-inner {
	padding: 0;
	border: 0 none;
	-webkit-box-sizing: content-box;
}

input[type=text]::-moz-focus-inner {
	padding: 0;
	border: 0 none;
	-moz-box-sizing: content-box;
}

input[type=text]::-webkit-focus-inner {
	padding: 0;
	border: 0 none;
	-webkit-box-sizing: content-box;
}
/* Blue Color Scheme ------------------------ */
.blue .button {
	color: #fff;
	text-shadow: 1px 1px 0px #09365f;
	background: #064884;
	background: -moz-linear-gradient(top, #3b75b4 0%, #064884 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #3b75b4),
		color-stop(100%, #064884));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3b75b4',
		endColorstr='#064884', GradientType=0);
	border-color: #09365f;
}

.blue:hover .button {
	background: #3b75b4;
	background: -moz-linear-gradient(top, #064884 0%, #3b75b4 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #064884),
		color-stop(100%, #3b75b4));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#064884',
		endColorstr='#3b75b4', GradientType=0);
}
</style>
<script>$(function() {
		$("#excel3").change(function() {
			$(this).parents(".uploader").find(".filename").val($(this).val());
		});

		$("#excel3").each(function() {
			if ($(this).val() == "") {
				$(this).parents(".uploader").find(".filename").val("请选择《数据明细信息表》");
			}
		});
	});
	$(".first").click(function() {
		$(this).next().toggle();
		$(this).parent().siblings().children(".second").css("display", "none");
	});
</script>