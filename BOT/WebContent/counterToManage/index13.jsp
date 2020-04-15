
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>新建机台</title>
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
	function setFocus() {
		document.getElementById('eqptId').focus()
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
</script>

<script>
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var obj = $("#eqptId").prop("value");
			var workId = $('#workId').val();
			if (obj == null || obj == "") {
				document.getElementById("nameDiv1").style.display = "block";
				return false;
			} else {
				document.getElementById("nameDiv1").style.display = "none";
			}
			//将多个同name的值组成一个json数组字符串 
			var jsondata = "[";
			$("[name=eqptId]").each(function() {
				jsondata += '{"eqptId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			jsondata = jsondata.replace(reg, "");
			jsondata += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=saveEqpt", //10.1
				//提交的数据
				data : {
					"counter.eqptId" : jsondata,
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == "新建失败，数据库异常！") {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "sc") {
						layer.msg("新建失败", {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "cc") {
						layer.msg("新建成功", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}


				},
				//调用执行后调用的函数
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框

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
	function getsubId(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
	}

	function a() {
		$("#ajaxA").click();
	}
	function _b() {
		if (event.keyCode == 13)
			a();
	}
</script>

</head>
<body onKeyDown="_b()">
	<from>
	<table id="sample-table-1">
		<tr>
			<td><div class="widget-header">
					<h4>新建机台</h4>
				</div></td>

		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><a href="#" id="AddMoreFileBox"
				class="btn btn-info">增加机台：</a></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<input id="clickMe" type="hidden" onclick="setFocus()" />
			<td>机台编号： <input type="text" id="eqptId" size="10" name="eqptId"
				id="eqptId" onkeypress='if(event.keyCode==13) getsubId(this,2);' /></td>
			</td>
			<td id="nameDiv1" style="display:none"><p
					style="color:red;font-size:16px;">请输入机台名称！</p> <input type="hidden"
				value="<%=workId%>" id="workId" />
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>

	</div>
	<table>
		<tr>
			<td><button class="btn btn-primary" id="ajaxA" value="ss">提交</button></td>
			<input id="ce" type="hidden" onclick="a()" />
		</tr>
	</table>
	<hr>
</body>
</html>
<script>
	$(document).ready(function() {

		var MaxInputs = 24; //maximum input boxes allowed  
		var sample = $("#sample-table-1"); //Input boxes wrapper ID  
		var AddButton = $("#AddMoreFileBox"); //Add button ID  

		var x = sample.length; //initlal text box count  
		var FieldCount = 1; //to keep track of text box added  

		$(AddButton).click(function(e) //on add input button click  
		{
			if (x <= MaxInputs) //max input box allowed  
			{
				FieldCount++; //text box added increment  
				//add input box  

				$(sample).append('<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
					+ FieldCount + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input size="10" type="text" name="eqptId" /><tr><td>&nbsp;</td></tr><a href="#" class="removeclass">x</a></td></tr>');
				x++; //text box increment  
			}

			return false;
		});

		$("body").on("click", ".removeclass", function(e) { //user click on remove text  
			if (x > 0) {
				$(this).parent('td').remove(); //remove text box  
				x--; //decrement textbox  
			}
			return false;
		})

	});
</script>