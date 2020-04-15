
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
<title>分光入库(BIN桶)</title>
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
			<input type="hidden" id="workId" value="<%=workId%>">
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
								<input type="hidden" id="shelfName" value=""> <input
									type="hidden" id="bag" value=""> <input type="hidden"
									id="bagweight" value=""> <input type="hidden"
									id="bagqty" value=""><input type="hidden" id="check1"
									value="">
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">袋号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input type="text" id="bagname" autocomplete="off" required
											onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
											onkeypress='if(event.keyCode==13) t();'
											class="form-control input-lg mb25 input-postek"
											placeholder="袋号">
									</div>
								</div>
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">清档数量：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input onkeypress='if(event.keyCode==13) t1();'
											onkeyup="clearNoNum(this);" type="number" value="10600"
											id="qty" value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="清档数量">
									</div>
								</div>
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">袋重(含袋子标签g)：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<table>
											<tr>
												<label for="printlabel"
													class="col-sm-2 control-label label-postek"></label>
												<input type="number" id="weight" autocomplete="off" required
													class="form-control input-lg mb25 input-postek"
													placeholder="袋重(含袋子标签g)">
											</tr>
										</table>
									</div>
								</div>
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">备注：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<table>
											<tr>
												<label for="printlabel"
													class="col-sm-2 control-label label-postek"></label>
												<input type="text" id="remark" autocomplete="off" required
													class="form-control input-lg mb25 input-postek"
													placeholder="输入备注">
											</tr>
										</table>
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
											type="button" data-loading-text="打印模板中...">提交</button>
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
		function clearNoNum(obj) {
			obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符  
			obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是  
			obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的  
			obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
			obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d{1}).*$/, '$1$2.$3'); //只能输入6个小数  
		}
		function t1() {
			$("#weight").select();
		}
		function t() {
			$("#qty").select();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				var r = layer.load();
	
				var bagname = $("#bagname").prop("value");
				var weight = $("#weight").prop("value");
				var qty = $("#qty").prop("value");
				var workId = $("#workId").prop("value");
				var remark = $("#remark").prop("value");
				if (bagname === "") {
					layer.msg("还没输入袋号", {
						icon : 2
					});
					layer.close(r);
					return false;
				}
				if (qty === "") {
					layer.msg("还没输入数量", {
						icon : 2
					});
					layer.close(r);
					return false;
				}
				if (qty > 10600) {
					layer.alert("超出最大数量", {
						icon : 2
					});
					layer.close(r);
					return false;
				}
				if (weight == "") {
					layer.msg("还没输入裸重", {
						icon : 2
					}, function() {
						layer.close(r);
					});
					return false;
				}
	
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=liangpin", //1.1
					//提交的数据
					data : {
						"putIn.bagName" : bagname.toUpperCase().trim(),
						"putIn.weight" : weight.toUpperCase().trim(),
						"putIn.qty" : qty.toUpperCase().trim(),
						"putIn.workId" : workId,
						"putIn.remark" : remark,
						"bagLabel.project1" : "分光良品入库"
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数22
	
					success : function(result) {
						layer.closeAll();
						if ("noQc" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.alert("该袋号未经过品质判定，不允许入库", {
								icon : 2
							});
							return false;
						}
						if ("error" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.alert("该袋号对应的分光批次号已经结束，不允许入库", {
								icon : 2
							});
							return false;
						}
						if ("error1" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg("该袋子不是已分光良品，请使用其他功能入库！", {
								icon : 2
							});
							return false;
						}
						if ("errr" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg("该袋子对应的分光批次号已完结，不允许入库", {
								icon : 2
							});
							return false;
						}
						if ("errr1" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg("该袋子对应的分光批次号未进行派料，不允许入库", {
								icon : 2
							});
							return false;
						}
						if ("weizhi" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg("未知BIN不允许入库！", {
								icon : 2
							});
							return false;
						}
						if ("error2" == result) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg("袋号有误！！", {
								icon : 2
							});
							$("#bagname").select();
							return false;
						}
						if (result.startsWith("yichang")) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg(result, {
								icon : 2
							});
							return false;
						}
						if (result.startsWith("error:")) {
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							layer.msg(result, {
								icon : 2
							});
							return false;
						}
						var result = eval("(" + result + ")");
						var weight = result.counter[0].weight;
						var qty = result.counter[0].bagName1;
						var check1 = result.counter[0].check;
						var cntargs = result.counter[0].cntargs;
						if (cntargs.startsWith("error:")) {
	
							var cy = cntargs.substr(6, cntargs.length)
	
							var str = Number(cy * 100).toFixed(2);
							str += "%";
							layer.alert("误差相差：" + str);
	
						}
						$("#bagweight").val(weight);
						$("#check1").val(check1);
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
				var bagname = $("#bagname").prop("value");
				var weight = $("#bagweight").prop("value");
				var check1 = $("#check1").prop("value");
				weight = (Number(weight * 100) / 100).toFixed(2);
				var qty1 = $("#qty").prop("value");
				var qty = Math.round(qty1);
	
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
					"PTK_SetLabelHeight" : "300,12,0,false"
				}); //设置标签纸高度  间隙高度  ！必须设置
	
				printparamsJsonArray.push({
					"PTK_SetLabelWidth" : "550"
				}); //设置标签纸宽度  ！必须设置
	
				/* 	printparamsJsonArray.push({
						"PTK_DrawRectangle" : "1,1,3,300,138"
					}); */ //画矩形
	
				/* printparamsJsonArray.push({
					"PTK_PcxGraphicsDownload" : "logo1," + urls + ""
				}); //存储一个PCX格式图形
				 */
				/* printparamsJsonArray.push({
					"PTK_DrawPcxGraphics" : "1,1,logo1"
				}); //打印指定图形
				 */
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,45,0,3,2,1,N,分光良品入库,0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,85,0,3,2,2,N,袋号：,0"
				}); //打印文字
	
				/* 	printparamsJsonArray.push({
						"PTK_DrawBarcode" : "145,85,0,1,2,2,50,B," + bagname
					}); //打印一个一维码
		 */
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "145,85,0,3,1,1,N," + bagname + ",0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,175,0,3,1,1,N,QTY:" + qty + ",0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "240,180,0,3,1,1,N,净重:" + weight + "g" + ",0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,1,1,N,判定:" + check1 + ",0"
				}); //打印文字
	
	
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
				}); */ //打印文字
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,2,2,N,批号,0"
				}); */ //打印文字
	
				/* printparamsJsonArray.push({
					"PTK_DrawBarcode" : "110,210,0,1,2,2,50,B," + lotId
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
				//循环打印结束位置
				data.printparams = JSON.stringify(printparamsJsonArray);
	
				$.ajax({
					type : "POST",
					url : url,
					data : data,
					dataType : "json",
					timeout : 3000, // in milliseconds
					success : function(result) {
						$("#bagname").val("");
						$("#weight").val("");
						$("#qty").val("10300");
						//var retdata = JSON.parse (result);
						if (result.retval == '0') {
	
							$("#bagname").val("");
							$("#weight").val("");
							$("#qty").val("");
							$("#weight").select();
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