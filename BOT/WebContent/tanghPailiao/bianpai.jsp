
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
<title>编带机派料</title>
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
<body onload="check();" class="main-body">
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
									<label for="printname"
										class="col-sm-2 control-label label-postek">编带机台</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="bianEqpt" name="bianEqpt"
											class="form-control input-lg  mb25 select-postek">
											<option>请选择机台号...</option>
										</select>
									</div>
								</div>
								<input type="hidden" id="shelfName" value=""> <input
									type="hidden" id="bag" value=""> <input type="hidden"
									id="bagweight" value=""> <input type="hidden"
									id="sexian" value="">
								<div style="display:none" class="form-group" id="div4">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">机台状态</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="status" value=""
											required class="form-control input-lg mb25 input-postek"
											placeholder="机台状态">
									</div>
								</div>

								<div style="display:none" class="form-group" id="div5">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">BIN</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="bin" value=""
											required class="form-control input-lg mb25 input-postek"
											placeholder="BIN">
									</div>
								</div>
								<div style="display:none" class="form-group" id="div1">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">ID：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="id" value=""
											required class="form-control input-lg mb25 input-postek">
									</div>
								</div>
								<input type="hidden" id="barcode"> <input type="hidden"
									id="qty">
								<div style="display:none" class="form-group" id="div2">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">种类：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="lotType" value=""
											required class="form-control input-lg mb25 input-postek">
									</div>
								</div>
								<div style="display:none" class="form-group" id="div3">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">编带批次号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="bdLotId" required
											class="form-control input-lg mb25 input-postek">
									</div>
								</div>


								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">输入袋号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input type="text" id="bagName" autocomplete="off"
											onkeypress='if(event.keyCode==13) t();'
											onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
											value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="袋号">
									</div>
								</div>
								<table id="bags">
									<p font=''>静电袋号：</p>
								</table>
								<!-- 按钮 -->
								<div class="form-group">

									<label for="printTplBtn"
										class="col-sm-1 control-label label-postek"></label>
									<div class="form-group col-sm-3"
										style="padding-left:0;padding-right:0;margin-top: 10px;">
										<input id="printTplBtn" readonly="readonly"
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
			<input type="hidden" id="ajaxC">
		</div>
	</div>
	<script type="text/javascript">
		function check() {
			$("#ajaxC").click();
		}
		$("#ajaxC").click(function() {
	
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selbdeqpt", //机台
				data : {
					"eqpt.status" : "1"
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
	
				success : function(result) {
					var result = eval("(" + result + ")");
	
					for (var i = 0; i < result.counter.length; i++) {
						var eqpt = result.counter[i].eqpt;
	
						ss = "<option value=" + eqpt + ">" + eqpt + "</option>"
	
						$("#bianEqpt").append(ss);
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
	
		function t() {
			var bianEqpt = $("select[name='bianEqpt']").val();
			var bagName = $("#bagName").prop("value");
			var id = $("#id").prop("value");
			var lotType = $("#lotType").prop("value");
			var bin = $("#bin").prop("value");
			var status = $("#status").prop("value");
			var bdLotId = $("#bdLotId").prop("value");
	
			if (bianEqpt == "请选择机台号...") {
				layer.msg("还没选择机台号！", {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=baidai", //1.1
				//提交的数据
				data : {
					"eqpt.eqpt" : bianEqpt,
					"eqpt.bdLotId" : bdLotId,
					"eqpt.id" : id,
					"eqpt.bin" : bin,
					"eqpt.lotType" : lotType,
					"fgShelf.bagName" : bagName,
					"eqpt.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
	
				success : function(result) {
					if (result.startsWith("error:")) {
						layer.msg(result, {
							icon : 2
						});
						return false;
					}
					if (result == "have") {
						layer.msg("此袋号已经被使用！", {
							icon : 2
						});
						return false;
					}
					if ("noBIN" == result) {
						layer.msg("该静电袋BIN档不在该机台设置的产品的范围内！", {
							icon : 2
						});
						return false;
					}
					if ("noID" == result) {
						layer.msg("该静电袋ID不在该机台设置的产品的范围内！", {
							icon : 2
						});
						return false;
					}
					if ("noLOT" == result) {
						layer.msg("该静电袋C产品不在该机台设置的产品的范围内！", {
							icon : 2
						});
						return false;
					}
					if ("noCanshu" == result) {
						layer.msg("该静电袋参数不符合！", {
							icon : 2
						});
						return false;
					}
					if ("error" == result) {
						layer.msg("未找到该静电袋！！", {
							icon : 2
						});
						return false;
					}
					if ("error2" == result) {
						layer.msg("该静电袋未经品质判定！", {
							icon : 2
						});
						return false;
					}
					if ("error3" == result) {
						layer.msg("该静电袋品质判定为NG，不允许派料！", {
							icon : 2
						});
						return false;
					}
					var result = eval("(" + result + ")");
					var bagName = result.counter[0].bagName;
					var bdlotid = result.counter[0].bdLotId
					var bin = result.counter[0].bin
					var id = result.counter[0].id
					var lotType = result.counter[0].lotType
					var seri = result.counter[0].seri
					var sexian = result.counter[0].sexian
					var barcode = result.counter[0].barcode;
					var qty = result.counter[0].qty;
					$("#bagName").val(bagName);
					if (status != "运行中...") {
						$("#bdLotId").val(bdlotid);
					}
					$("#barcode").val(barcode);
					$("#qty").val(qty);
					$("#bin").val(bin);
					$("#id").val(id);
					$("#lotType").val(lotType);
					$("#seri").val(seri);
					$("#sexian").val(sexian);
					document.getElementById("div5").style.display = "block";
					document.getElementById("div1").style.display = "block";
					var s = "<tr><td><input type='text' class='form-control input-lg mb25 input-postek' readonly='readonly' name='bagname' value= " + bagName + "><td></tr>";
	
					var luckElements = document.getElementsByName("bagname");
					var tapeId = document.getElementById("bagName").value;
	
					for (var i = 0; i < luckElements.length; i++) {
	
						if (tapeId == luckElements[i].value) {
							layer.msg("数据重复！", {
								icon : 2
							})
							$("#bagName").select();
							return false;
						}
	
					}
					$("#bags").append(s);
					$("#bagName").select();
	
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
	
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var reelId = document.getElementsByName("bagname");
				if (reelId.length < 1) {
					layer.msg("没有数据可以提交", {
						icon : 2
					}, function() {
						layer.closeAll();
					});
					return false;
				}
				var bianEqpt = $("select[name='bianEqpt']").val();
				var id = $("#id").prop("value");
				var status = $("#status").prop("value");
				var lotType = $("#lotType").prop("value");
				var bdLotId = $("#bdLotId").prop("value");
				var workId = $("#workId").prop("value");
				var bin = $("#bin").prop("value");
				var seri = $("#seri").prop("value");
				var bagname = "[";
				$("[name='bagname']").each(function() {
					bagname += '{"bagname":"' + this.value + '"},';
				});
				//去掉最后一个"," 
				var reg = /,$/gi;
				bagname = bagname.replace(reg, "");
				bagname += "]";
	
				var id = $("#id").prop("value");
				var lotType = $("#lotType").prop("value");
				var sexian = $("#sexian").prop("value");
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=BDlabel", //1.1
					//提交的数据
					data : {
						"eqpt.id" : id,
						"eqpt.bin" : bin,
						"eqpt.eqpt" : bianEqpt,
						"eqpt.bdLotId" : bdLotId,
						"eqpt.bagName" : bagname,
						"eqpt.lotType" : lotType,
						"eqpt.status" : status,
						"eqpt.workId" : workId,
						"eqpt.sexian" : sexian,
						"eqpt.chuLei" : "编带出库"
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						if (result.startsWith("<html")) {
							layer.alert(result, {
								icon : 2
							});
							return false;
						}
						if (result.startsWith("error:")) {
							layer.msg(result, {
								icon : 2
							});
							return false;
						}
						if ("error" == result) {
							layer.msg("输入的袋号和系统袋号不一致！", {
								icon : 2
							});
							return false;
						}
						if ("success" == result) {
	
							layer.alert("派料成功", {
								icon : 1
							}, function() {
								$("#printTplBtn").click();
								history.go(0);
							});
						}
						if ("error1" == result) {
							layer.msg("没有合适的袋子！", {
								icon : 2
							});
							return false;
						}
	
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
				var bin = $("#bin").prop("value");
				var qty = $("#qty").prop("value");
				var barcode = $("#barcode").prop("value");
				var id = $("#id").prop("value");
				var lotHead = $("#lotType").prop("value");
				var sexian = $("#sexian").prop("value");
				var bdLotId = $("#bdLotId").prop("value");
				$("#printTplBtn").text("正在打印中。。。");
				$("#printTplBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.reqParam = "1";
				data.lang = "zh";
	
				var printparamsJsonArray = [];
				//循环打印张数起始位置
	
				var luckElements = document.getElementsByName("bagname");
	
				var lotHead1 = $("#status").prop("value");
				var o = 0;
				if (lotHead1 == "待机中...") {
					o = Number(luckElements.length) + 1;
				} else {
					o = Number(luckElements.length);
				}
				for (var i = 0; i < o; i++) {
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
						"PTK_DrawTextEx" : "20,45,0,3,1,1,N,编带批次号(" + barcode + "/" + qty + "),0"
					}); //打印文字
	
					/* printparamsJsonArray.push({
						"PTK_DrawTextEx" : "13,70,0,3,2,2,N,袋号：,0"
					}); //打印文字 */
					/* printparamsJsonArray.push({
						"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
					}); //打印文字
					 */
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "30,235,0,3,1,1,N,ID：" + id + ",0"
					}); //打印文字
	
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "250,235,0,3,1,1,N,BIN：" + bin + ",0"
					}); //打印文字
	
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "30,185,0,3,1,1,N,种类:" + lotHead + ",0"
					}); //打印文字
	
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "320,185,0,3,1,1,N,色温显指:" + sexian + ",0"
					}); //打印文字
	
					printparamsJsonArray.push({
						"PTK_DrawBarcode" : "100,85,0,1,2,2,50,B," + bdLotId
					}); //打印一个一维码
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "30,270,0,3,1,1,N,电：,0"
					}); //打印文字
					printparamsJsonArray.push({
						"PTK_DrawTextEx" : "270,270,0,3,1,1,N,膜：,0"
					}); //打印文字
	
					/* printparamsJsonArray.push({
						"PTK_DrawBarcode" : "145,70,0,1,2,2,50,B," + bag
					}); */ //打印一个一维码
	
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
	
				}
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
	
		$("#bianEqpt").change(function() {
			var bianEqpt = $("select[name='bianEqpt']").val();
			if (bianEqpt == "请选择机台号...") {
				layer.msg("还没选择机台号！", {
					icon : 2
				});
				return false;
			}
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=bdpai", //9.2
				//提交的数据
				data : {
					"eqpt.eqpt" : bianEqpt
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
	
				success : function(result) {
					layer.closeAll();
					var result = eval("(" + result + ")");
					$("option[name='sss']").remove();
	
	
					for (var i = 0; i < result.counter.length; i++) {
	
	
						document.getElementById("div2").style.display = "block";
						document.getElementById("div3").style.display = "block";
						document.getElementById("div4").style.display = "block";
	
	
						var id = result.counter[i].id;
						var lotType = result.counter[i].lotType;
						var bdLotId = result.counter[i].bdLotId;
						var bin = result.counter[i].bin;
						if (bdLotId == "") {
							$("#status").val("待机中...");
							$("#bdLotId").val("无");
							$("#lotType").val(lotType);
							$("#id").val(id);
							$("#bin").val(bin);
	
						} else {
							document.getElementById("div5").style.display = "block";
							document.getElementById("div1").style.display = "block";
							$("#status").val("运行中...");
							$("#bdLotId").val(bdLotId);
							$("#lotType").val(lotType);
							$("#id").val(id);
							$("#bin").val(bin);
							$("#bdLotId").val(bdLotId);
						}
	
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
		//设置右键事件 
		/* function noMenuOne() {
			layer.msg("右键菜单被禁止！", {
				icon : 2
			});
			return false;
		}
		oncontextmenu="return false"
		onselectstart="return false" oncopy="return false"
		document.oncontextmenu = noMenuOne */
	</script>
</body>
</html>