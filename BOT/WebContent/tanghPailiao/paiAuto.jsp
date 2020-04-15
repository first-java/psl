
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
<title>分光机台派料(自动派料)</title>
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
<body class="main-body" topmargin=0; leftmargin=0>
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
						<input type="hidden" id="fgLotId" value=""> <input
							type="hidden" id="lotId1" value=""> <input type="hidden"
							id="lotType" value=""> <input type="hidden" id="lotHead"
							value=""> <input type="hidden" id="id" value="">
						<input type="hidden" id="leiXing" value="">
						<div class="p15 main-box">
							<form id="printForm" action="#" data-parsley-validate=""
								novalidate="" role="form" method="post">

								<div class="form-group">
									<label for="printname"
										class="col-sm-2 control-label label-postek">打印机型号</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="printname" name="printname" style="width:250px;"
											class="form-control input-lg  mb25 select-postek">
										</select>
									</div>
								</div>
								<input type="hidden" id="shelfName" value=""> <input
									type="hidden" id="bag" value=""> <input type="hidden"
									id="bagweight" value=""> <input type="hidden"
									id="bagqty" value="">
								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">输入分光批次号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input onkeypress='if(event.keyCode==13) t();' type="text"
											onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
											id="lotId" autocomplete="off" required
											class="form-control input-lg mb25 input-postek"
											style="width:250px;" placeholder="分光批次号">
									</div>
								</div>

								<div style="display:none" class="form-group" id="div">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">静电袋号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input readonly="readonly" type="text" id="bagName"
											style="width:250px;" autocomplete="off" required
											class="form-control input-lg mb25 input-postek">
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">输入袋号：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input onkeypress='if(event.keyCode==13) t1();'
											style="width:250px;" type="text" id="bagName1"
											onkeyup="this.value=this.value.toUpperCase().replace(/[\u4e00-\u9fa5]/ig,'') "
											autocomplete="off" required
											class="form-control input-lg mb25 input-postek"
											placeholder="袋号">
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
											type="hidden" />
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
									<input type="hidden" id="workId" value="<%=workId%>"> <input
										type="hidden" id="project1" value="">
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
			layer.load();
			var lotId = $("#lotId").prop("value");
			if (lotId.length < 5) {
				layer.msg("分光批次号太短！！", {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=printFglabel", //1.1
				//提交的数据
				data : {
					"fgPailiao.lotId" : lotId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
	
				success : function(result) {
	
					if ("error" == result) {
						layer.alert("未找到合适的静电袋！", {
							icon : 2
						}, function() {
							layer.closeAll();
						});
	
						return false;
					}
					if ("noFglot" == result) {
						layer.alert("该分光批次已完结或不存在！！", {
							icon : 2
						}, function() {
							layer.closeAll();
						});
	
						return false;
					}
					if ("other" == result) {
						layer.alert("该分光批次已完结！", {
							icon : 2
						}, function() {
							layer.closeAll();
						});
	
						return false;
					}
	
					var result = eval("(" + result + ")");
					var bagName = result.counter[0].bagName;
					var project1 = result.counter[0].product;
					$("#bagName").val(bagName);
					$("#project1").val(project1);
					document.getElementById("div").style.display = "block";
					$("#bagName1").select();
					layer.closeAll();
	
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
		function t1() {
			var bagName1 = $("#bagName1").prop("value");
			var bagName = $("#bagName").prop("value");
			if (bagName1 != bagName) {
				layer.msg("静电袋号不一致！！", {
					icon : 2
				});
				return false;
			}
	
			$("#ajaxA").click();
		}
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var lotId = $("#lotId").prop("value");
				var bagName = $("#bagName").prop("value");
				var workId = $("#workId").prop("value");
				var bagName1 = $("#bagName1").prop("value");
				if (lotId === "") {
					layer.closeAll();
					layer.msg("还没输入批号", {
						icon : 2
					});
					return false;
				}
				if (bagName1 === "") {
					layer.closeAll();
					layer.msg("还没输入袋号", {
						icon : 2
					});
	
					return false;
				}
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=Fglabel", //1.1
					//提交的数据
					data : {
						"fgPailiao.lotId" : lotId,
						"fgPailiao.bagName" : bagName,
						"fgPailiao.bagName1" : bagName1,
						"fgPailiao.workId" : workId,
						"fgPailiao.chuLei" : "分光出库",
						"eqpt.lotId" : lotId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						if ("error" == result) {
							layer.msg("输入的袋号和系统袋号不一致！", {
								icon : 2
							});
							return false;
						}
						if ("error1" == result) {
							layer.msg("没有合适的袋子！", {
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
						var result = eval("(" + result + ")");
						var fgLotId = result.counter[0].fgLotId;
						var lotType = result.counter[0].lotType;
						var lotHead = result.counter[0].lotHead;
						var sexian = result.counter[0].sexian;
						var lotId = result.counter[0].lotId;
						var id = result.counter[0].id;
						var leiXing = result.counter[0].leiXing;
						$("#fgLotId").val(fgLotId);
						$("#lotType").val(lotType);
						$("#lotHead").val(lotHead);
						$("#sexian").val(sexian);
						$("#lotId1").val(lotId);
						$("#id").val(id);
						$("#leiXing").val(leiXing);
	
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
	
				var id = $("#id").prop("value");
				var lotHead = $("#lotHead").prop("value");
				var sexian = $("#sexian").prop("value");
				var fgLotId = $("#fgLotId").prop("value");
				var lotId = $("#lotId1").prop("value");
				var leiXing = $("#leiXing").prop("value");
				var project1 = $("#project1").prop("value");
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
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "30,25,0,3,1,1,N,分光出库（" + id + "）,0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "20,50,0,3,1,1,N,分光批次号:" + fgLotId + ",0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "20,190,0,3,1,1,N,注释,0"
				}); //打印文字
				var d = "";
				if (leiXing == '底板散芯') {
					lotId = lotId;
	
					d = lotHead + "#" + id + "#A#"
				} else if (leiXing == '分光NG') {
					lotId = 'chongfen';
					d = lotHead + "#" + id + "#0#"
				} else if (leiXing == '编带尾料') {
					d = lotHead + "#" + id + "#1#"
					lotId = 'chonggong';
				} else {
					d = lotHead + "#" + id + "#2#"
					lotId = 'fenguangweiliao';
				}
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "100,165,0,1,2,2,35,B," + lotId
				}); //打印一个一维码
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "20,250,0,3,1,1,N,程序名,0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "100,240,0,1,2,2,35,B," + project1
				}); //打印一个一维码
	
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "100,90,0,1,2,2,35,B," + d
				}); //打印一个一维码
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "20,85,0,3,1,1,N,批量号,0"
				}); //打印文字
	
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
						$("#bagName1").val("");
						$("#lotId").val("");
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