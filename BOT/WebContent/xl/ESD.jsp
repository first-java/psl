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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>ESD入库</title>
<base href="<%=basePath%>">
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

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var itemId = $("#barcode").prop("value");
			var reelId = $("#barcode1").prop("value");
			var qty = $("#barcode2").prop("value");
			if (itemId.trim() == "") {
				layer.msg("还没录入型号！", {
					icon : 2
				});
				document.getElementById('itemId').focus();
				return false;
			}

			if (qty.trim() == "") {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			if (reelId.trim() == "") {
				layer.msg("还没录入片号！", {
					icon : 2
				});
				document.getElementById('barcode').focus();
				return false;
			}


			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "xlku.action?methodstr=putIn2", //5.1
				//提交的数据
				data : {
					"counter.reelId" : reelId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if ("error" == result) {
						layer.msg("数据重复！此片已入过库！", {
							icon : 2
						});
						document.getElementById('barcode1').focus();
						return false;
					}
					var luckElements = document.getElementsByName("reelId");
					var tapeId = document.getElementById("barcode").value;
					var d = Number(luckElements.length) + 1;
					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='xuhao' />" + d + "</td><td>" +
						"<input type='hidden' name='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
						"<input type='hidden' name='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
						"<input type='hidden' name='qty1'  value=" + qty + " />" + qty + "</td></tr>";


					for (var i = 0; i < luckElements.length; i++) {

						//获取元素的value值
						if (tapeId == luckElements[i].value) {
							layer.msg("数据重复！", {
								icon : 2
							})
							return false;
						}

					}
					$("#sample-table-1").append(s);
					document.getElementById('barcode1').focus();
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

		$("#ajaxB").click(function() {
			var reelId = "[";
			$("[name=reelId]").each(function() {
				reelId += '{"reelId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			reelId = reelId.replace(reg, "");
			reelId += "]";

			var qty1 = "[";
			$("[name=qty1]").each(function() {
				qty1 += '{"qty1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty1 = qty1.replace(reg, "");
			qty1 += "]";

			var itemId = "[";
			$("[name=itemId]").each(function() {
				itemId += '{"itemId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			itemId = itemId.replace(reg, "");
			itemId += "]";

			var workId = $("#workId").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "xlku.action?methodstr=putIn1", //5.1
				//提交的数据
				data : {
					"counter.reelId" : reelId,
					"counter.itemId" : itemId,
					"counter.qty1" : qty1,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
					});

					return false;
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
</script>

<script type="text/javascript">
	function t() {
		$("#barcode1").select();

	}function t3() {
		$("#barcode2").select();
	}
	function t1() {
		$("#ajaxA").click();
	}
	function setFocus() {
		document.getElementById('barcode').select();
	}
function setFocus1() {
		document.getElementById('barcode1').select();
	}

	// 两秒后模拟点击
	setTimeout(function() {
		// IE
		if (document.all) {
			document.getElementById("clickMe").click();
		}
		// 其它浏览器
		else {
			var e = document.createEvent("MouseEvents");
			e.initEvent("click", true, true);
			document.getElementById("clickMe").dispatchEvent(e);
		}
	}, 200);

	$(document).keypress(function(e) {
		// 回车键事件  
		/* if (e.which == 13) {
// 			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		} */
	});
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">型号：<input id="barcode" type="text"
					onkeypress='if(event.keyCode==13) t();'>
				</td>

				<td id="tt">片号：<input type="text" id="barcode1"
					onkeypress='if(event.keyCode==13) t3();'>
				</td>
				<td id="tt">数量：<input type="number" id="barcode2"
					onkeypress='if(event.keyCode==13) t1();'>
				</td>
			</tr>
			<button class="btn btn-primary" id="ajaxA" onclick="setFocus1()">确认</button>
			<button class="btn btn-primary" id="ajaxC" onclick="setFocus1()">确认</button>
		</table>
	</div>
	<br>
	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>序号</th>
				<th>型号</th>
				<th>片号</th>
				<th>数量</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />

</body>
</html>