
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String shelfName = (String) request.getParameter("shelfName");//直接传递shelfName
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
<title>新建分光货架</title>
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

<script type="text/javascript">
	function setFocus() {
		document.getElementById('shelfName').focus()
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
			var obj = $("#caseNo").prop("value");
			var floors = $("#floors").prop("value");
			var floorsTargs = $("#floorsTargs").prop("value");
			var shelfName = $("#shelfName").prop("value");
			var workId = $("#workId").prop("value");
			var maxtrough = $("#maxtrough").prop("value");
			var checkbox = $("#checkbox").is(':checked');
			if (obj === "") {
				layer.msg("还没输入箱号", {
					icon : 2
				});
				return false;
			}
			if (shelfName === "") {
				layer.msg("还没输入货架名称", {
					icon : 2
				}, function() {});
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
				url : "ctm.action?methodstr=shelf", //1.1
				//提交的数据
				data : {
					"counter.caseNo" : jsondata,
					"counter.shelfName" : shelfName,
					"counter.workId" : workId,
					"counter.floors" : floors,
					"counter.floorsTargs" : floorsTargs,
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
	});
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

	<table id="case">
		<tr>
			<input id="clickMe" type="hidden" onclick="setFocus()"
				value="Set focus" />
			<td colspan="2">货架名称:
			<td><input readonly="readonly" type="text"
				value="<%=shelfName%>" id="workId" /></td>
			<td colspan="2"><a href="#" id="floorBox" class="btn btn-info">增加层数</a></td>
			<td colspan="2"><a href="#" id="caseBox" class="btn btn-info">增加箱子</a></td>
		</tr>
	</table>
	<table id="floor">
		<tr>
			<td colspan="2">当前货架层数
			<td><input readonly="readonly" type="text" value="1" id="workId" /></td>
		</tr>
	</table>
	<table id="case">
		<tr>
			<td colspan="2">箱号
			<td><input type="text" value="" id="workId" /></td>
		</tr>
	</table>
	</div>
	<label> <small class="green"> <b style="display: none;">是否启用</b>
	</small> <input name="checkbox" class="ace ace-switch ace-switch-7" values="s"
		id="checkbox" type="checkbox" style="display: none;"> <span
		style="display: none;" class="lbl"></span>
	</label>
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