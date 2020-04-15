
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
<title>创建分光批次号</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>

<style type="text/css">
html {
	overflow-x: auto;
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
										class="col-sm-2 control-label label-postek">机台号</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="eqpt" name="eqpt"
											class="form-control input-lg  mb25 select-postek">
											<option>请选择机台号...</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="printname"
										class="col-sm-2 control-label label-postek">产品</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="product1" name="product1"
											class="form-control input-lg  mb25 select-postek">
											<option>请选择产品...</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="printname"
										class="col-sm-2 control-label label-postek">ID</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="id" name="id"
											class="form-control input-lg  mb25 select-postek">
											<option>请选择ID...</option>
										</select>
									</div>
								</div>
								<input type="hidden" id="eqpt1" value=""> <input
									type="hidden" id="id" value=""> <input type="hidden"
									id="sexian" value=""> <input type="hidden" id="fgLotId"
									value="">
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
											type="button" data-loading-text="打印模板中...">设置/打印</button>
									</div>
									<input type="hidden" id="ajaxC"> <input type="hidden"
										id="ajaxD">
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
		$("#product1").change(function() {
			var lotType = $("select[name='product1']").val();
			var eqpt = $("select[name='eqpt']").val();
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selectId", //9.2
				//提交的数据
				data : {
					"eqpt.lotType" : lotType,
					"eqpt.eqpt" : eqpt
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
	
				success : function(result) {
					layer.closeAll();
					var result = eval("(" + result + ")");
					$("option[name='ss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var lotHead = result.counter[i].id;
	
						ss = "<option name='ss' value=" + lotHead + ">" + lotHead + "</option>"
	
						$("#id").append(ss);
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
		function check() {
			$("#ajaxD").click();
		}
		$(document).ready(function() {
	
			$("#ajaxD").click(function() {
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selectEqpt1", //11.2
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
							$("#eqpt").append(ss);
						}
	
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
						//layer.closeAll();
						//layer.msg("--" + errorThrown)
						alert("出错");
					//请求出错处理
					}
				});
	
			});
			$("#ajaxA").click(function() {
				var eqpt = $("select[name='eqpt']").val();
				var product1 = $("select[name='product1']").val();
				var id = $("select[name='id']").val();
				var workId = $("#workId").prop("value");
				if (eqpt == "请选择机台号...") {
					layer.alert("还没选择机台号！");
					return;
	
				}
				if (product1 == "请选择产品...") {
					layer.alert("还没选择产品！");
					return;
	
				}
				if (id == "请选择ID...") {
					layer.alert("还没选择ID！");
					return;
	
				}
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=printFg", //1.1
					//提交的数据
					data : {
						"eqpt.eqpt" : eqpt,
						"eqpt.lotHead" : product1,
						"eqpt.id" : id,
						"eqpt.workId" : workId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
	
						if ("error" == result) {
							layer.alert("创建分光批次号失败！");
							return;
						}
						if ("have" == result) {
							layer.alert("该机台创建的分光批次号未完结，不允许在此创建分光批次号！");
							return;
						}
						if (result.startsWith("error:")) {
							layer.alert(result);
							return;
						}
	
						var result = eval("(" + result + ")");
						var eqpt = result.counter[0].eqpt;
						var id = result.counter[0].id;
						var fgLotId = result.counter[0].fgLotId;
						var sexian = result.counter[0].sexian;
	
						$("#sexian").val(sexian);
						$("#eqpt1").val(eqpt);
						$("#id").val(id);
						$("#fgLotId").val(fgLotId);
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
	
				var eqpt1 = $("#eqpt1").prop("value");
				var id = $("#id").prop("value");
				var lotHead = $("select[name='product1']").val();
	
				var sexian = $("#sexian").prop("value");
				var fgLotId = $("#fgLotId").prop("value");
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
					"PTK_SetDarkness" : "10"
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
					"PTK_DrawTextEx" : "20,50,0,3,2,1,N,分光批次号,0"
				}); //打印文字
	
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,70,0,3,2,2,N,袋号：,0"
				}); //打印文字 */
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + bagqty + ",0"
				}); //打印文字
				 */
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "30,240,0,3,1,1,N,ID：" + id + ",0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "30,190,0,3,1,1,N,种类:" + lotHead + ",0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "320,190,0,3,1,1,N,色温显指:" + sexian + ",0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "100,90,0,1,2,2,50,B," + fgLotId
				}); //打印一个一维码
	
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
	
	
		$("#eqpt").change(function() {
			var eqpt = $("select[name='eqpt']").val();
	
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selectPro1", //9.2
				//提交的数据
				data : {
					"eqpt.eqpt" : eqpt
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
						var lotHead = result.counter[i].lotType;
	
						ss = "<option name='sss' value=" + lotHead + ">" + lotHead + "</option>"
	
						$("#product1").append(ss);
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
	</script>

</body>
</html>