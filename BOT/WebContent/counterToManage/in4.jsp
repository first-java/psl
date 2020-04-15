
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

		$("#ajaxB").click(function() {
			var shelfNames = $("#q").prop("value");
			s = shelfNames.split(",");
			var shelfName = s[0];
			var floors = s[2];
			$('#shelfName').val(shelfName);
			$('#shelfName1').val(shelfName);
			$('#floors').val(floors);
		});
		$("#ajaxD").click(function() {
			var obj = $("#caseNo").prop("value");
			var floors = $('#sam option:selected').val();
			var shelfName = $("#shelfName").prop("value");
			var workId = $("#workId").prop("value");

			var checkbox = $("#checkbox").is(':checked');
			if (obj === "") {
				layer.msg("还没输入箱号", {
					icon : 2
				});
				return false;
			}
			if (floors === "请选择···") {
				layer.msg("还没选择货架层数！", {
					icon : 2
				});
				return false;
			}
			//将多个同name的值组成一个json数组字符串 
			var jsondata = "[";
			$("[name=caseNo]").each(function() {
				jsondata += '{"caseNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			jsondata = jsondata.replace(reg, "");
			jsondata += "]";

			//将多个同name的值组成一个json数组字符串 
			var cntargs = "[";
			$("[name=cntargs]").each(function() {
				cntargs += '{"cntargs":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			cntargs = cntargs.replace(reg, "");
			cntargs += "]";
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=shelf1", //1.1
				//提交的数据
				data : {
					"counter.caseNo" : jsondata,
					"counter.shelfName" : shelfName,
					"counter.workId" : workId,
					"counter.floors" : floors,
					"counter.cntargs" : cntargs,
					'checkbox' : checkbox
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == '新建失败,数据库异常！+insert into JNBDT.SHELF') {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == '新建失败,数据库异常！insert into jnbdt.goods_shelf') {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == '新建失败！') {
						layer.msg(result, {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == '货架新建成功！') {
						layer.msg(result, {
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

		$("#shelfName").click(function() {
			var shelfName = $("#shelfName").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=addC", //11.2
				//提交的数据
				data : {
					"counter.shelfName" : shelfName,
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var floors = result.counter[i].floors;
						s = "<option value=" + floors + ">" + floors + "</option>"
						var luckElements = document.getElementsByName("materialname");

						$("#sam").append(s);
					/* 	$('.page-header input').val(''); */
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
		$("#sam").change(function() {
			var floors = $('#sam option:selected').val();
			var shelfName = $("#shelfName").prop("value");

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=sCaseno", //11.2
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
					var result = eval("(" + result + ")");
					$("td[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var caseNo = result.counter[i].caseNo;
						s = " <td name='sss'>" +
							"<input type='text' readonly='true'  style='border-style:none' name='shelfName' id='s' value=" + caseNo + " />" + "</td>";

						$("#samCase").append(s);

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
	function check() {
		$("#ajaxB").click();
		$("#shelfName").click();
	}
</script>
</head>
<body onload="check();">
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="赋值" />
	<table id="case">
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<input type="hidden" id="q" value="<%=floors%>" />
			<td id="shelfName1">货架名称：<%=floors%> <input type="hidden"
				id="shelfName" />
			</td>
			<td>第 <select id="sam"><option>请选择···</option></select>层
			</td>
		</tr>
		<tr id="samCase">

		</tr>
		<tr>
			<td colspan="2"><a href="#" id="MoreFileBox"
				class="btn btn-info">增加箱子</a></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>

			<td>箱 &nbsp;&nbsp;号：<input type="hidden" value="1" id="s"
				name="cntargs" /> <input type="text" id="caseNo" size="10"
				name="caseNo" /></td>
			<input type="hidden" value="<%=workId%>" id="workId" />
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>

	</table>
	<br>
	<table>
		<tr>
			<td>&nbsp;<input class="btn btn-primary" type="button"
				id="ajaxD" value="确定" /></td>

		</tr>
	</table>
	</div>
	<hr>
</body>
</html>
<script>
	$(document).ready(function() {
		var MaxInputs = 24; //maximum input boxes allowed  
		var sample = $("#sample-table-1"); //Input boxes wrapper ID  
		var sample1 = $("#case"); //箱子  
		var AddButton = $("#AddMoreFileBox"); //Add button ID  
		var Button = $("#MoreFileBox"); //Add button ID  
		var x = sample.length; //initlal text box count  
		var FieldCount = 1; //to keep track of text box added  
		var FieldCount1 = 1;

		$(Button).click(function(e) //on add input button click  
		{
			if (x <= MaxInputs) //max input box allowed  
			{
				FieldCount1++; //text box added increment  
				//add input box  

				$(sample1).append("<tr><td colspan='2'><input readonly='readonly'  type='text' value=" + FieldCount1 + " size='2' name='cntargs'/>" + '&nbsp;&nbsp;<input size="10" type="text" name="caseNo" />&nbsp;<a href="#" class="removeclass">移除</a></td></tr>');
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