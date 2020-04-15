
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
<title>袋重及标签重量维护</title>
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
									<label for="printname"
										class="col-sm-2 control-label label-postek">项目</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<select id="project" name="project"
											class="form-control input-lg  mb25 select-postek">
											<option>请选择...</option>
											<option>底板散芯入库</option>
											<option>分光良品入库</option>
											<option>分光不良入库</option>
											<option>编带尾料入库</option>
											<option>转分光入库</option>
											<option>静电袋合袋</option>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">袋重：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input autocomplete="off" id="bagWeight"
											onkeypress='if(event.keyCode==13) t();' value="" required
											type="number" class="form-control input-lg mb25 input-postek"
											placeholder="袋重">
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">标签重量：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input id="labelWeight" autocomplete="off" type="number"
											onkeypress='if(event.keyCode==13) t();' value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="标签重量">
									</div>
								</div>

								<div class="form-group">
									<label for="printlabel"
										class="col-sm-2 control-label label-postek">标签数量：</label>
									<div class="form-group col-sm-10"
										style="padding-left:0;padding-right:0;">
										<input id="labelQty" autocomplete="off" type="number"
											onkeypress='if(event.keyCode==13) t();' value="" required
											class="form-control input-lg mb25 input-postek"
											placeholder="标签数量">
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
										<!-- <button id="truncate"
											class="btn btn-primary btn-lg btn-block btn-postek"
											type="button">清空表</button> -->
									</div>
 <a href="../tanghPailiao/putInDFG2.jsp" id="submitBtn"
							class="btn btn-primary btn-lg btn-block btn-postek"
							data-loading-text="打印模板中...">导入</a></td>
				</tr>
			 
		 
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
		$("#project").change(function() {
			var project = $("select[name='project']").val();
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=baglabel1", //1.1
				//提交的数据
				data : {
					"bagLabel.project1" : project.trim(),
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
						var bagWeight = result.counter[i].bagWeight;
						var labelWeight = result.counter[i].labelWeight;
						var labelQty = result.counter[i].labelQty;
						$("#bagWeight").val(bagWeight);
						$("#labelWeight").val(labelWeight);
						$("#labelQty").val(labelQty);
	
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
	
	
		})
		$(document).ready(function() {
			$("#truncate").click(function() {
				layer.load();
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=truncate", //1.1
					//提交的数据
					data : {
	
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
	
						layer.msg(result, function() {
	
							layer.closeAll();
	
						});
	
	
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
			$("#ajaxA").click(function() {
				layer.load();
				var project = $("select[name='project']").val();
				var bagWeight = $("#bagWeight").prop("value");
				var labelWeight = $("#labelWeight").prop("value");
				var labelQty = $("#labelQty").prop("value");
				if (bagWeight == "") {
					layer.msg("还没输入袋重！", {
						icon : 2
					});
					layer.closeAll();
					return;
				} else if (labelWeight == "") {
					layer.msg("还没输入标签重量！", {
						icon : 2
					});
					layer.closeAll();
					return;
				} else if (labelQty == "") {
					layer.msg("还没输入标签数量！", {
						icon : 2
					});layer.closeAll();return;
				} else if (project == "请选择...") {
					layer.msg("还没选择项目！", {
						icon : 2
					});layer.closeAll();return;
				}
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=baglabel", //1.1
					//提交的数据
					data : {
						"bagLabel.project1" : project.trim(),
						"bagLabel.bagWeight" : bagWeight.trim(),
						"bagLabel.labelWeight" : labelWeight.trim(),
						"bagLabel.labelQty" : labelQty.trim()
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						if ("success" == result) {
							layer.msg("设置成功！", {
								icon : 1
							});
						} else {
							layer.msg("设置失败！", {
								icon : 2
							});
						}
	
					},
					//调用执行后调用的函数
					error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
						layer.colseAll();
						layer.msg("服务器错误", {
							icon : 2
						}, function() {
							 
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
</html><script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
		
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
</script><style>
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