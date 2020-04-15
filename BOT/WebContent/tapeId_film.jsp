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
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>补料</title>
<script>
	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var obj = $("#tapeId").prop("value");
			if (obj === "") {
				layer.msg("还没输入卷轴号", {
					icon : 2
				});
				return false;
			}
			var obj1 = $("#filmNo").prop("value");
			var obj2 = $("#qty").prop("value");
			if (obj1 === "" || obj2 === "") {
				layer.msg("还没输入蓝膜和数量", {
					icon : 2
				});

				return false;
			}
			//将多个同name的值组成一个json数组字符串 
			var jsondata = "[";
			$("[name=filmNo]").each(function() {
				jsondata += '{"filmNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			jsondata = jsondata.replace(reg, "");
			jsondata += "]";

			var jsondata1 = "[";
			$("[name=qty]").each(function() {
				jsondata1 += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg1 = /,$/gi;
			jsondata1 = jsondata1.replace(reg1, "");
			jsondata1 += "]";

		
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "tion.action?methodstr=notest", //自己的url
				//提交的数据
				data : {
					"filmNo" : jsondata,
					"qty" : jsondata1,
					"tapeId" : obj
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "沒有查到數據") {
						layer.msg("沒有查到數據", {
							icon : 2
						}, function() {
							window.location.reload();
						});
					}
					if (result == "补料数量大于总数量") {
						layer.msg("补料数量大于总数量", {
							icon : 2
						}, function() {
							window.location.reload();
						});
					}
					if (result == "保存成功") {
						layer.msg("保存成功", {
							icon : 1
						}, function() {
							window.location.reload();
						});
					}if (result == "蓝膜号有误") {
						layer.msg("蓝膜号有误", {
							icon : 2
						}, function() {
							window.location.reload();
						});
					}
					var result = eval("(" + result + ")");

					if (result.scroll.length < 1) {
						//alert("卷轴号有误！");setTimeout()
						//layer.confirm("dfdfdf","qw");
						layer.msg("卷轴号有误", {
							icon : 2
						});
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
</script>
</head>
<body>
	<div class="page-header">
		<div class="widget-header">
			<h4>补料</h4>
		</div>
		<table align="left"
			class="table table-striped table-bordered table-hover"
			id="sample-table-1">
			<tr>
				<td colspan="2"><a href="#" id="AddMoreFileBox"
					class="btn btn-info">增加输入框</a></td>
			</tr>

			<tr>
				<td><h1>卷轴号：</h1></td>
				<td><h1>
						<input type="text" size="15" name="tapeId" id="tapeId"> <input
							type="hidden" name="creater" value="<%=workId%>">
					</h1></td>
			</tr>
			<tr>
				<td><h1>蓝膜号：</h1></td>
				<td><h1>数&nbsp;&nbsp;&nbsp;量：</h1></td>
			</tr>
			<tr>
				<td><input size="15" type="text" name="filmNo" id="filmNo" /></td>
				<td><input type="text" name="qty" size="15" id="qty" /></td>
			</tr>
		</table>
		<table align="left">
			<tr>
				<td><button class="btn btn-primary" id="ajaxA">提交</button></td>
			</tr>
		</table>
	</div>

</body>
</html>
<script>
	$(document).ready(function() {

		var MaxInputs = 8; //maximum input boxes allowed  
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

				$(sample).append('<tr><td><input size="15" type="text" name="filmNo" /><a href="#" class="removeclass">x</a></td><td> <input type="text" name="qty" size="15" /><a href="#" class="removeclass">×</a></td></tr>');
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
<%-- <script type="text/javascript">
	$(function() {
		if (event.keyCode == 13) {
			$("#AddMoreFileBox").click(function() {

				alert("123");
			});
		}
	});
</script> --%>