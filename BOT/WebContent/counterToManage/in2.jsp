
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%
	String floors = (String) request.getParameter("floors");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title></title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
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
<script
	src="<%=request.getContextPath()%>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function() {
		$("#ajaxC").click(function() {
			var floors = $("#floors").prop("value");
			var shelfName = $("#shelfName").prop("value");

			if ((shelfName == null || shelfName == "") || (floors == null || floors == "")) {
				document.getElementById("nameDiv1").style.display = "block";
				return false;
			} else {
				document.getElementById("nameDiv1").style.display = "none";
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=shelfProduct3", //11.2
				//提交的数据
				data : {
					"counter.shelfName" : shelfName,
					"counter.floors" : floors
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.open({
						title : '信息提示',
						content : result
					});
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
		/* $("input").unbind('keydown').bind('keydown', function() {
			$(this).width(textWidth($(this).val()));
		}); */
		$("#ajaxB").click(function() {
			var shelfNames = $("#q").prop("value");
			s = shelfNames.split(",");
			var shelfName = s[0];
			var floors = s[2];
			$('#shelfName').val(shelfName);
			$('#floors').val(floors);
		});
		$("#ajaxA").click(function() {
			var floors = $("#floors").prop("value");
			var shelfName = $("#shelfName").prop("value");
			var workId = $("#workId").prop("value");
			var product = $("#product").prop("value");
			var opt = $("#product").val();
			if (opt == null || opt == "") {
				document.getElementById("nameDiv1").style.display = "block";
				return false;
			} else {
				document.getElementById("nameDiv1").style.display = "none";
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=updateGoodsShelf", //11.2
				//提交的数据
				data : {
					"counter.shelfName" : shelfName,
					"counter.floors" : floors,
					"counter.product" : product,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.open({
						title : '信息提示',
						content : result
					});

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
	function check() {
		$("#ajaxB").click();
	}
</script>
</head>
<body onload="check();">
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="赋值" />
	<table>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<input type="hidden" id="q" value="<%=floors%>" />
			<td>货架名称： <input type="text" id="shelfName" value=""
				readonly="readonly" /></td>
			<td>第 <input type="text" readonly="readonly" size="2"
				id="floors" value="" />层
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>设置产品 <input type="text" size="12" id="product" /></td>
			<td id="nameDiv" style="display:none"><p
					style="color:red;font-size:16px;">未找到该蓝膜</p></td>
			<td id="nameDiv1" style="display:none"><p
					style="color:red;font-size:16px;">请输入产品！</p></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;<input class="btn btn-primary" type="button"
				id="ajaxA" value="确定" /></td>
			<td><button class="btn btn-primary" id="ajaxC" />重置
				</button></td>
		</tr>
	</table>
	</div>
	<hr>
</body>
</html>