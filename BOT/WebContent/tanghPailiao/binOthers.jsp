
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
<title>底板散芯下BIN(其他)</title>
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
								<label for="printname"
									class="col-sm-2 control-label label-postek">选择类别</label>
								<div class="form-group col-sm-10"
									style="padding-left:0;padding-right:0;">
									<select id="others" name="others"
										class="form-control input-lg  mb25 select-postek"><option> 请选择</option>
										<option>分光NG品</option>
										<option>分光尾料</option>
										<option>分光废料</option>
										<option>分光地料</option>
									</select>
								</div>
							</div>
							<input type="hidden" id="shelfName" value=""> <input
								type="hidden" id="bag" value=""> <input type="hidden"
								id="id" value=""> <input type="hidden" id="lotHead"
								value="">
							<div class="form-group">
								<label for="printlabel"
									class="col-sm-2 control-label label-postek">分光批次号：</label>
								<div class="form-group col-sm-10"
									style="padding-left:0;padding-right:0;">
									<input onkeypress='if(event.keyCode==13) t1();'
										onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
										type="text" id="fgLotId" autocomplete="off" required
										class="form-control input-lg mb25 input-postek"
										placeholder="分光批次号">
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
								<input type="hidden" id="workId" value="<%=workId%>">
							</div>
							<p id="tip" class="p15  p-postek"
								style="margin-top:20px; margin-left: 25%;float:left;display:none"></p>
							<!-- </form> -->
						</div>
						<input type="hidden" id="leiXing" value="">
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
		function t1() {
			$("#ajaxA").click();
	
		}
		$(document).ready(function() {
	
			$("#ajaxA").click(function() {
				layer.load();
				var fgLotId = $("#fgLotId").prop("value");
				var workId = $("#workId").prop("value");
				var others = $("select[name='others']").val();
				if (others == "请选择") {
					layer.alert("还没选择类别", {
						icon : 2
					}, function() {
						layer.closeAll();
					});
					return false;
				}
				if (fgLotId.length < 8) {
					layer.alert("分光批次号太短", {
						icon : 2
					}, function() {
						$("#fgLotId").select();layer.closeAll();
					});
					return false;
				}
	
				if (fgLotId === "") {
					layer.alert("还没输入分光批次号", {
						icon : 2
					}, function() {
						$("#fgLotId").select();layer.closeAll();
					});
					return false;
				}
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=fenguangNG", //1.1
					//提交的数据
					data : {
						"eqpt.fgLotId" : fgLotId,
						"eqpt.others" : others,
						"eqpt.workId" : workId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
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
							layer.msg("该分光批次有误或已完结！", {
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
						var id = result.counter[0].id;
						var bin = result.counter[0].bin;
						var lotHead = result.counter[0].lotHead;
						var leiXing = result.counter[0].leiXing;
	
						$("#shelfName").val(shelfName);
						$("#caseNo").val(caseNo);
						$("#bag").val(bag);
						$("#id").val(id);
						$("#bin").val(bin);
						$("#leiXing").val(leiXing);
						$("#lotHead").val(lotHead);
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
				var lotId = $("#fgLotId").prop("value");
				var id = $("#id").prop("value");
				var lotHead = $("#lotHead").prop("value");
				var leiXing = $("#leiXing").prop("value");
				var bag = $("#bag").prop("value");
				$("#printTplBtn").text("正在打印中。。。");
				$("#printTplBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.reqParam = "1";
				data.lang = "zh";
	
				var printparamsJsonArray = [];
				//循环打印张数起始位置
	
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
					"PTK_DrawTextEx" : "13,45,0,3,2,1,N," + leiXing + "下料,0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,85,0,3,2,2,N,袋号：,0"
				}); //打印文字
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,ID-BIN:" + id + "-" + binCode + ",0"
				}); */ //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,175,0,3,1,1,N,种类:" + lotHead + ",0"
				}); //打印文字
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,1,1,N,批号:" + lotId + ",0"
				}); //打印文字
				 */
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "145,85,0,1,2,2,50,B," + bag
				}); //打印一个一维码
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,235,0,3,1,1,N,分光批次号：" + lotId + ",0"
				}); //打印文字
	
				/* printparamsJsonArray.push({
					"PTK_DrawBarcode" : "110,210,0,1,2,2,50,B," + lotId
				});  */ //打印一个一维码
	
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
					timeout : 5000, // in milliseconds
					success : function(result) {
	
						//var retdata = JSON.parse (result);
						if (result.retval == '0') {
							$("#fgLotId").val("");
							$("#others").get(0).selectedIndex = 0;
							$("#tip").html("发送成功").css("color", "green");
							$("#tip").fadeIn();
							$("#printTplBtn").text("打印模板");
							$("#printTplBtn").removeAttr("disabled");
							$("#tip").delay(3000).hide(0);
							layer.closeAll();
						} else {
							$("#fgLotId").val("");
							$("#others").get(0).selectedIndex = 0;
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
							layer.closeAll();
						}
					},
					error : function() {
						$("#tip").html("请求失败，请重试").css("color", "#D20B2C");
						$("#tip").fadeIn();
						$("#printTplBtn").text("打印模板");
						$("#printTplBtn").removeAttr("disabled");
						$("#tip").delay(300000).hide(0);
						layer.closeAll();
					}
				});
			});
	
		});
	</script>
</body>
</html>