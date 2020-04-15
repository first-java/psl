
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
<title>POSTEK博思得_条码/RFID标签打印机_设计精湛_好用耐用</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>

<style type="text/css">
html {
	overflow-x: hidden
}

.top {
	width: 100%;
	background: url(../images/top_bg.jpg) repeat-x #efefef;
	position: relative;
	z-index: 10;
}

.main-body {
	height: 100%;
	background: url(../assert/img/top_bg.jpg) repeat-x #efefef;
	position: relative;
	z-index: 10;
	line-height: 0;
}

.main-box {
	background: url(../assert/img/top_bg.jpg) repeat-x #efefef;
	position: relative;
	z-index: 10;
}

.main-center {
	padding-top: 15px;
}

.top_nav {
	width: 1020px;
	overflow: hidden;
	margin: 0 auto;
	/* padding-top: 15px; */
}

.lang-box {
	background-color: #efefef;
	position: relative;
	z-index: 10;
	margin-bottom: 40px;
}

a {
	text-decoration: none;
	color: #666;
}

a:hover {
	cursor: pointer;
	text-decoration: none;
	color: #d30a2d;
}

.btn-postek {
	font-size: 14px;
	font-family: "Microsoft YaHei";
	/**width: 30%;
			margin-top: 10px !important;
			*/
	float: left;
	border-color: #9F9D9C !important;
	background-color: #9F9D9C !important;
}

.btn-postek:hover {
	border-color: #D20B2C !important;
	background-color: #D20B2C !important;
}

.select-postek {
	font-size: 14px;
	font-family: "Microsoft YaHei";
}

.label-postek {
	text-align: right;
	line-height: 46px;
	font-family: "Microsoft YaHei";
}

.input-postek {
	font-size: 14px;
	font-family: "Microsoft YaHei";
}

.fengei-div-postek {
	height: 1px;
	margin-top: 40px;
	text-align: center;
	border-top: 1px solid #9F9D9C;
}

.fengei-span-postek {
	position: relative;
	background-color: #efefef; /*#efefef*/
	display: inline-block;
	top: -10px;
	line-height: 20px;
	padding-left: 10px;
	padding-right: 10px;
}

.p-postek {
	word-wrap: break-word;
	word-break: break-all;
	overflow: hidden;
	line-height: 100%;
}
</style>

</head>
<body class="main-body">


	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<!-- 
	<div class="top_nav"> <a href="http://www.postek.com.cn/cn/index.aspx"><img src="./assert/img/logo.jpg" alt="" class="fot_l"></a>
  	</div>
 -->

		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>

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

								<div class="form-group">
									<label for="printname"
										class="col-sm-2 control-label label-postek">打印机型号</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="printname" name="printname"
											class="form-control input-lg  mb25 select-postek">
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="printWidth"
										class="col-sm-2 control-label label-postek">标签宽度</label>
									<div class="form-group col-sm-2"
										style="padding-left:0;padding-right:0;">
										<input type="number" id="printWidth" name="printWidth"
											value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="单位:dots">
									</div>
								</div>
								<div class="form-group">
									<label for="printWidth"
										class="col-sm-2 control-label label-postek">标签高度</label>
									<div class="form-group col-sm-2"
										style="padding-left:0;padding-right:0;">
										<input type="number" id="printHeight" name="printHeight"
											value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="单位:dots">
									</div>
								</div>
								<div class="form-group">
									<label for="printGap"
										class="col-sm-2 control-label label-postek">间隙/黑标高度</label>
									<div class="form-group col-sm-2"
										style="padding-left:0;padding-right:0;">
										<input type="number" id="printGap" name="printGap" value=""
											required class="form-control input-lg mb25 input-postek"
											placeholder="单位:dots">
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">打印文字</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input type="text" id="printlabel" name="printlabel" value=""
											required class="form-control input-lg mb25 input-postek"
											placeholder="文本内容">
									</div>
								</div>

								<!-- 按钮 -->
								<div class="form-group">
									<label for="printBtn"
										class="col-sm-3 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;margin-top: 10px;">
										<button id="printBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印中...">打印</button>
									</div>
								</div>

								<div class="form-group">
									<label for="printTplBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;margin-top: 10px;">
										<button id="printTplBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印模板中...">打印模板</button>
									</div>
								</div>

								<div class="form-group">
									<label for="getRfidBtn"
										class="col-sm-3 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;">
										<button id="getRfidBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="读取中...">读取RFID</button>
									</div>
								</div>

								<div class="form-group">
									<label for="printRfidBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;">
										<button id="printRfidBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印中...">打印RFID</button>
									</div>
								</div>

								<div class="form-group">
									<label for="printPcxBtn"
										class="col-sm-3 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;">
										<button id="printPcxBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印 PCX...">打印PCX</button>
									</div>
								</div>


								<div class="form-group">
									<label for="printBmpBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;">
										<button id="printBmpBtn"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button" data-loading-text="打印 BMP...">打印BMP</button>
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
	
		var url = "http://127.0.0.1:888/postek/print";
	
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
	
			$("#printBtn").on("click", function() {
				if ($("#printlabel").val().length == 0 || $("#printWidth").val().length == 0 || $("#printHeight").val().length == 0 || $("#printGap").val().length == 0) {
					$("#tip").html("请输入完整信息").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#tip").delay(3000).hide(0);
					return;
				}
	
				$("#printBtn").text("正在打印中。。。");
				$("#printBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.printlabel = $("#printlabel").val();
				data.reqParam = "2";
				data.lang = "zh";
	
				var printparamsJsonArray = {};
				printparamsJsonArray.OpenPort = $("#printname").val();
				printparamsJsonArray.PTK_ClearBuffer = "";
				printparamsJsonArray.PTK_SetPrintSpeed = "4";
				printparamsJsonArray.PTK_SetDarkness = "10";
				printparamsJsonArray.PTK_SetLabelHeight = $("#printHeight").val() + "," + $("#printGap").val() + ",0,false";
				printparamsJsonArray.PTK_SetLabelWidth = $("#printWidth").val();
				printparamsJsonArray.PTK_DrawTextEx = "80,168,0,3,1,1,N," + $("#printlabel").val() + ",0";
				printparamsJsonArray.PTK_PrintLabel = "1,1";
				printparamsJsonArray.ClosePort = "";
	
				data.printparams = '[' + JSON.stringify(printparamsJsonArray) + ']';
				//这里是请求打印机的参数（包括函数名和参数）
	
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
							$("#printBtn").text("打印");
							$("#printBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						} else {
							$("#tip").html("发送失败，返回结果：" + result.msg).css("color", "#D20B2C");
							$("#tip").fadeIn();
							$("#printBtn").text("打印");
							$("#printBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						}
					},
					error : function(request, status, err) {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printBtn").text("打印");
						$("#printBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				});
			});
	
	
			$("#printTplBtn").on("click", function() {
				$("#printTplBtn").text("正在打印模板中。。。");
				$("#printTplBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.printlabel = $("#printlabel").val();
				data.reqParam = "2";
				data.lang = "zh";
	
				var printparamsJsonArray = [];
	
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
					"PTK_SetDarkness" : "10"
				}); //设置打印黑度
				printparamsJsonArray.push({
					"PTK_PcxGraphicsDel" : "*"
				}); //删除所有图形
				printparamsJsonArray.push({
					"PTK_SetLabelHeight" : "300,16,0,false"
				}); //设置标签纸高度  间隙高度  ！必须设置
				printparamsJsonArray.push({
					"PTK_SetLabelWidth" : "800"
				}); //设置标签纸高度  ！必须设置
				printparamsJsonArray.push({
					"PTK_DrawRectangle" : "58,15,3,558,280"
				});
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "300,28,0,1,2,2,50,B,123456789"
				}); //打印一个一维码
				printparamsJsonArray.push({
					"PTK_DrawLineOr" : "58,111,500,3"
				});
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "80,130,0,3,1,1,N,Internal Soft Font,0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawBar2D_Pdf417" : "80,180,400,300,0,0,3,7,10,2,0,0,123456789"
				}); //打印PDF417码
				printparamsJsonArray.push({
					"PTK_DrawBar2D_QR" : "80,28,180,180,0,3,2,0,0,Postek Electronics Co. Ltd."
				}); //打印二维码 
				printparamsJsonArray.push({
					"PTK_DrawTextTrueTypeW" : "80,230,19,0,Arial,1,700,0,0,0,A3,Use different ID_NAME for different Truetype font objects"
				}); //用Windows字体打印文字
				printparamsJsonArray.push({
					"PTK_PrintLabel" : "1,1"
				}); //63设置打印份数  复制份数  ！必须设置
				printparamsJsonArray.push({
					"ClosePort" : ""
				});
	
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
	
			$("#getRfidBtn").on("click", function() {
				$("#getRfidBtn").text("正在读取中。。。");
				$("#getRfidBtn").attr("disabled", "disabled");
	
				var data = {};
				data.reqParam = "4";
				data.lang = "zh";
	
				var printparamsJsonArray = {};
				printparamsJsonArray.PTK_ReadRFTagDataUSB = "255,2,0,0,$acceptMsg$";
	
				data.printparams = '[' + JSON.stringify(printparamsJsonArray) + ']';
	
				$.ajax({
					type : "POST",
					url : url,
					data : data,
					dataType : "json",
					timeout : 5000, // in milliseconds
					success : function(result) {
						//var retdata = JSON.parse (result);
						if (result.retval == '0') {
							var acceptMsg = "";
							for (var retTemp in result) {
								if (retTemp != "retval" && retTemp != "msg") {
									acceptMsg += retTemp + ":" + result[retTemp] + ";";
								}
							}
							$("#tip").html("读取成功，返回信息：" + acceptMsg).css("color", "green");
							$("#tip").fadeIn();
							$("#getRfidBtn").text("读取RFID");
							$("#getRfidBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						} else {
							$("#tip").html("发送失败").css("color", "#D20B2C");
							$("#tip").fadeIn();
							$("#getRfidBtn").text("读取RFID");
							$("#getRfidBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#getRfidBtn").text("读取RFID");
						$("#getRfidBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				});
			});
	
	
			$("#printRfidBtn").on("click", function() {
				$("#printRfidBtn").text("正在打印中。。。");
				$("#printRfidBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.printlabel = $("#printlabel").val();
				data.reqParam = "2";
				data.lang = "zh";
	
				var printparamsJsonArray = {};
				printparamsJsonArray.OpenPort = $("#printname").val();
				printparamsJsonArray.PTK_ClearBuffer = "";
				printparamsJsonArray.PTK_SetDirection = 'B';
				printparamsJsonArray.PTK_SetPrintSpeed = "4";
				printparamsJsonArray.PTK_SetPrintSpeed = "4";
				printparamsJsonArray.PTK_SetDarkness = "10";
				printparamsJsonArray.PTK_SetLabelHeight = "660,15,0,false";
				printparamsJsonArray.PTK_SetLabelWidth = "800";
				printparamsJsonArray.PTK_SetRFID = "0,0,0,1,0";
				printparamsJsonArray.PTK_DrawTextTrueTypeW = "280,360,30,0,微软雅黑,1,400,0,0,0,C4,POSTEK";
				printparamsJsonArray.PTK_RWRFIDLabel = "1,0,2,4,1,4006002368";
				printparamsJsonArray.PTK_PrintLabel = "1,1";
				printparamsJsonArray.ClosePort = "";
	
				data.printparams = '[' + JSON.stringify(printparamsJsonArray) + ']';
	
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
							$("#printRfidBtn").text("打印RFID");
							$("#printRfidBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						} else {
							$("#tip").html("发送失败，返回结果：" + result.msg).css("color", "#D20B2C");
							$("#tip").fadeIn();
							$("#printRfidBtn").text("打印RFID");
							$("#printRfidBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printRfidBtn").text("打印RFID");
						$("#printRfidBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				});
			});
	
			$("#printPcxBtn").on("click", function() {
				if ($("#printWidth").val().length == 0 || $("#printHeight").val().length == 0 || $("#printGap").val().length == 0) {
					$("#tip").html("请输入完整信息").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#tip").delay(3000).hide(0);
					return;
				}
	
				$("#printPcxBtn").text("打印PCX。。。");
				$("#printPcxBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.printlabel = $("#printlabel").val();
				data.reqParam = "2";
				data.lang = "zh";
				data.printparams = "[{\"OpenPort\":\"" + $("#printname").val() + "\"},{\"PTK_ClearBuffer\":\"\"},{\"PTK_SetPrintSpeed\":\"4\"},{\"PTK_SetDarkness\":\"10\"},{\"PTK_SetLabelHeight\":\"" + $("#printHeight").val() + "," + $("#printGap").val() + ",0,false\"},{\"PTK_SetLabelWidth\":\"" + $("#printWidth").val() + "\"},{\"PTK_EnableFLASH\":\"\"},{\"PTK_PcxGraphicsDel\":\"logo\"},{\"PTK_PcxGraphicsDownload\":\"logo,@logo.pcx@\"},{\"PTK_DrawPcxGraphics\":\"80,168,logo\"},{\"PTK_PrintLabel\":\"1,1\"},{\"ClosePort\":\"\"}]";
	
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
							$("#printPcxBtn").text("打印PCX");
							$("#printPcxBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						} else {
							$("#tip").html("发送失败，返回结果：" + result.msg).css("color", "#D20B2C");
							$("#tip").fadeIn();
							$("#printPcxBtn").text("打印PCX");
							$("#printPcxBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printPcxBtn").text("打印PCX");
						$("#printPcxBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				});
			});
	
	
			$("#printBmpBtn").on("click", function() {
				if ($("#printWidth").val().length == 0 || $("#printHeight").val().length == 0 || $("#printGap").val().length == 0) {
					$("#tip").html("请输入完整信息").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#tip").delay(3000).hide(0);
					return;
				}
	
				$("#printBmpBtn").text("打印BMP。。。");
				$("#printBmpBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.printlabel = $("#printlabel").val();
				data.reqParam = "2";
				data.lang = "zh";
				data.printparams = "[{\"OpenPort\":\"" + $("#printname").val() + "\"},{\"PTK_ClearBuffer\":\"\"},{\"PTK_PcxGraphicsDel\":\"wifi\"},{\"PTK_SetPrintSpeed\":\"4\"},{\"PTK_SetDarkness\":\"10\"},{\"PTK_SetLabelHeight\":\"" + $("#printHeight").val() + "," + $("#printGap").val() + ",0,false\"},{\"PTK_SetLabelWidth\":\"" + $("#printWidth").val() + "\"},{\"PTK_BmpGraphicsDownload\":\"wifi,@wifi.bmp@,0\"},{\"PTK_DrawPcxGraphics\":\"80,168,wifi\"},{\"PTK_PrintLabel\":\"1,1\"},{\"ClosePort\":\"\"}]";
	
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
							$("#printBmpBtn").text("打印BMP");
							$("#printBmpBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						} else {
							$("#tip").html("发送失败，返回结果：" + result.msg).css("color", "#D20B2C");
							$("#tip").fadeIn();
							$("#printBmpBtn").text("打印BMP");
							$("#printBmpBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printBmpBtn").text("打印BMP");
						$("#printBmpBtn").removeAttr("disabled");
						$("#tip").delay(3000).hide(0);
					}
				});
			});
	
			$("#username").focus();
			getPrinterList();
	
		});
	
		function getPrinterList() {
			$("#printBtn").text("正在获取打印机中。。。");
			$("#printBtn").attr("disabled", "disabled");
	
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
						$("#printBtn").text("打印");
						$("#printTplBtn").attr("disabled", "disabled");
						$("#getRfidBtn").attr("disabled", "disabled");
						$("#printRfidBtn").attr("disabled", "disabled");
						$("#printPcxBtn").attr("disabled", "disabled");
						$("#printBmpBtn").attr("disabled", "disabled");
						$("#tip").delay(3000).hide(0);
	
					} else {
						$("#printname").empty();
						//var retdata = JSON.parse (result);
						for (var i in result) {
							$("#printname").append("<option value='" + result[i].printName + "'>" + result[i].printName + "</option>");
						}
						$("#tip").hide();
						$("#printBtn").text("打印");
						$("#printBtn").removeAttr("disabled")
					}
				},
				error : function() {
					$("#tip").html("获取打印机失败，请刷新页面重试").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#printBtn").text("打印");
					$("#printTplBtn").attr("disabled", "disabled");
					$("#getRfidBtn").attr("disabled", "disabled");
					$("#printRfidBtn").attr("disabled", "disabled");
					$("#printPcxBtn").attr("disabled", "disabled");
					$("#printBmpBtn").attr("disabled", "disabled");
					$("#tip").delay(3000).hide(0);
				}
			});
		}
	</script>
</body>
</html>