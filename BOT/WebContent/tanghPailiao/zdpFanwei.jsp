
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	String zdpMax = (String) request.getParameter("zdpMax");//直接传递
	String zdpMin = (String) request.getParameter("zdpMin");//直接传递
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
<title>震动盘编带在制范围</title>
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
		<img src="../assert/img/1.jpg" alt="" width="100%">
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
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">最大值：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input autocomplete="off" id="zdpMax" value="<%=zdpMax%>"
											required type="number"
											class="form-control input-lg mb25 input-postek"
											placeholder="上限">
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">最小值：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input id="zdpMin" value="<%=zdpMin%>" autocomplete="off"
											type="number" required
											class="form-control input-lg mb25 input-postek"
											placeholder="下限">
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
											type="button">提交</button>
									</div>
								</div>
								<p id="tip" class="p15  p-postek"
									style="margin-top:20px; margin-left: 25%;float:left;display:none"></p>
							</form>
						</div>
						<input type="hidden" id="<%=workId%>">
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
	
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var zdpMax = $("#zdpMax").prop("value");
				var zdpMin = $("#zdpMin").prop("value");
				var workId = $("#workId").prop("value");
				if (Number(zdpMax) <= Number(zdpMin)) {
					layer.msg("最大值不能小于最小值！", {
						icon : 2
					}, function() {
						layer.closeAll();
	
					});
	
					return;
				}
	
				if (zdpMax == "") {
					layer.msg("还没输入最大值！", {
						icon : 2
					}, function() {
						layer.closeAll();
	
					});
					return;
				}
				if (zdpMin == "") {
					layer.msg("还没输入最小值！", {
						icon : 2
					}, function() {
						layer.closeAll();
	
					});
					return;
				}
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=zdpMinToMax", //1.1
					//提交的数据
					data : {
						"calculate.zdpMin" : zdpMin,
						"calculate.zdpMax" : zdpMax,
						"calculate.workId" : workId
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
	
						layer.alert(result);
	
	
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
	</script>

</body>
</html>