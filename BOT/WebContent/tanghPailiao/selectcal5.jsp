
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
<title>分光机台查询</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
</head>
<body>
	<header class="panel-heading no-b text-center"
		style="font-size:30px;padding: 0;">
		<img src="../assert/img/banner.jpg" alt="" width="100%">
	</header>

	<div class="page-header">
		<h1>输入信息查询</h1>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td><input autocomplete="off" type="text" id="lotHead"
					onkeyup="this.value=this.value.toUpperCase()"
					onfocus="this.select()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">查询</button>
				</td>
			</tr>
		</table>
	</div>

	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>机台</th>
				<th>批次</th>
				<th>ID</th>

				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#ajaxA").click(function() {
				layer.load();
				var lotHead = $("#lotHead").prop("value");
	
				$.ajax({
					//提交数据的类型 POST GET
					type : "POST",
					//提交的网址
					url : "csppailiao.action?methodstr=selectYuEqpt", //11.2selectShelft
					//提交的数据
					data : {
						"eqpt.lotHead" : lotHead
					},
					//返回数据的格式
					datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
					async : true, // 使用异步操作
					//成功返回之后调用的函数
	
					success : function(result) {
						layer.closeAll();
						$("[name='sss']").remove();
						var result = eval("(" + result + ")");
						for (var i = 0; i < result.counter.length; i++) {
							/*  ;
							private String ;
							private String ;
							private String ;*/
							var project1 = result.counter[i].eqpt;
							var bagWeight = result.counter[i].lotType;
							var labelWeight = result.counter[i].id;
	
	
							/* var adtime = "";
							if (createtime == null) {
								adtime = "无";
							} else {
								var time = new Date(createtime.time);
								var y = time.getFullYear();
								var m = time.getMonth() + 1;
								var da = time.getDate();
								var h = time.getHours();
								var mm = time.getMinutes();
								var s = time.getSeconds();
								s = s < 10 ? '0' + s : s;
								adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;
							} */
	
							s = "<tr name='sss'><td>" +
								project1 + "</td><td>" +
								bagWeight + "</td><td>" +
								labelWeight + "</td></tr>";
							$("#sample-table-1").append(s);
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
				var weight = $("#weight").prop("value");
				var qty = $("#bagqty").prop("value");
				$("#printTplBtn").text("正在打印中。。。");
				$("#printTplBtn").attr("disabled", "disabled");
	
				var data = {};
				data.printname = $("#printname").val();
				data.reqParam = "2";
				data.lang = "zh";
	
				var printparamsJsonArray = [];
				//循环打印张数起始位置
	
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
					"PTK_DrawTextEx" : "13,30,0,3,2,1,N,分光良品入库,0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,70,0,3,2,2,N,袋号：,0"
				}); //打印文字
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,160,0,3,1,1,N,QTY:" + qty + ",0"
				}); //打印文字
	
				printparamsJsonArray.push({
					"PTK_DrawTextEx" : "240,165,0,3,1,1,N,净重:" + weight + "g" + ",0"
				}); //打印文字
				/* printparamsJsonArray.push({
					"PTK_DrawTextEx" : "13,220,0,3,1,1,N,批号:" + lotId + ",0"
				}); //打印文字
				 */
				printparamsJsonArray.push({
					"PTK_DrawBarcode" : "145,70,0,1,2,2,50,B," + bagname
				}); //打印一个一维码
	
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
			$("#username").focus();
			getPrinterList();
	
		});
	
		function getPrinterList() {
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
						$("#printTplBtn").attr("disabled", "disabled");
						$("#tip").delay(3000).hide(0);
	
					} else {
						$("#printname").empty();
						//var retdata = JSON.parse (result);
						for (var i in result) {
							$("#printname").append("<option value='" + result[i].printName + "'>" + result[i].printName + "</option>");
						}
						$("#tip").hide();
					}
				},
				error : function() {
					$("#tip").html("获取打印机失败，请刷新页面重试").css("color", "#D20B2C");
					$("#tip").fadeIn();
					$("#printTplBtn").attr("disabled", "disabled");
					$("#tip").delay(3000).hide(0);
				}
			});
		}
	</script>
</body>
</html>