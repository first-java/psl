
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
<title>底板散芯入库（待分光）重打标签</title>
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
<body class="main-body">
	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>
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
							<!-- <form id="printForm" action="#" data-parsley-validate=""
								novalidate="" role="form" method="post"> -->

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
							<!-- </form> -->
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
			$("#ajaxA").click();
		}
	
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var lotId = $("#lotId").prop("value");
	
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
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=putInDFGLabel", //1.1
					//提交的数据
					data : {
						"putIn.lotId" : lotId,
						"putIn.workId" : workId,
						"bagLabel.project1" : "底板散芯入库"
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
	
						if (result.startsWith("error:")) {
							layer.msg(result, {
								icon : 2
							}, function() {
								var e = document.createEvent("MouseEvents");
								e.initEvent("click", true, true);
								document.getElementById("clickMe").dispatchEvent(e);
							});
						}
	
						var result = eval("(" + result + ")");
						var shelfName = result.counter[0].shelfName;
						var caseNo = result.counter[0].caseNo;
						var bag = result.counter[0].bagName;
						var lo = result.counter[0].lotId;
						var weight = result.counter[0].jingWeight;
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
		//var ip_port = "192.168.6.145,9100";
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
	
				/* printparamsJsonArray.push({
					"PTK_Connect" : ip_port
				}); */ //网络打印
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
					timeout : 2000, // in milliseconds
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
						$("#tip").delay(3000000).hide(0);
					}
				});
			});
	
		});
	</script>
</body>
</html>