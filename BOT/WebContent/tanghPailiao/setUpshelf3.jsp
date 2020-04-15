
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
<title>新建蓝膜货架</title>
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

			var shelfNo = $("#shelfName").prop("value");
			var workId = $("#workId").prop("value");
			var checkbox = $("#checkbox").is(':checked');
			if (floors === "") {
				layer.msg("还没输入箱号", {
					icon : 2
				});
				return false;
			}
			if (shelfNo === "") {
				layer.msg("还没输入货架名称", {
					icon : 2
				}, function() {});
				return false;
			}
			//将多个同name的值组成一个json数组字符串 
			var floors = "[";
			$("[name=floors]").each(function() {
				floors += '{"floors":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			floors = floors.replace(reg, "");
			floors += "]";

			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=saveLanmoShelf", //1.1
				//提交的数据
				data : {
					"lanmoShelf.floors" : floors,
					"lanmoShelf.shelfNo" : shelfNo,
					"lanmoShelf.workId" : workId,
		
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == 'success') {
						layer.msg("新建成功", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					} else {
						layer.msg("新建失败", {
							icon : 2
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

			<td colspan="2">新建货架名称：<input type="text" id="shelfName"
				size="10" /></td>
			<td id="nameDiv1" style="display:none"><p
					style="color:red;font-size:16px;">货架名称不能为空！</p></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr id="dis" style="display: none;">
			<td colspan="2">当前货架已有<span id="f"></span>层,<span id="cas"></span>，正在新建第<span
				id="d"></span>层
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>

		<tr>
			<td colspan="2"><a href="#" id="MoreFileBox"
				class="btn btn-info">增加层数</a></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>

			<td>层 &nbsp;&nbsp;数：<input type="hidden" value="1" id="s"
				name="cntargs" /> <input type="text" id="caseNo" size="10"
				name="floors" /></td>
			<input type="hidden" value="<%=workId%>" id="workId" />
		</tr>
		<tr>
			<td>&nbsp;</td>
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

				$(sample1).append("<tr><td colspan='2'><input readonly='readonly'  type='text' value=" + FieldCount1 + " size='2' name='cntargs'/>" + '&nbsp;&nbsp;<input size="10" type="text" name="floors" />&nbsp;<a href="#" class="removeclass">移除</a></td></tr>');
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
	$("#shelfName").blur(function() {
		var shelfName = $("#shelfName").prop("value");

		if (shelfName == null || shelfName == "") {
			document.getElementById("nameDiv1").style.display = "block";
			return false;
		} else {
			document.getElementById("nameDiv1").style.display = "none";
		}

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "csppailiao.action?methodstr=selectlanmoShelf", //12.4
			//提交的数据
			data : {
				"lanmoShelf.shelfNo" : shelfName
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				var result = eval("(" + result + ")");
				$("td[name='sss']").remove();

				var product = result.counter;
				s = "<td name='sss'><input type='hidden' value=" + product.length + "/>" + product.length + "</td>";
				e = "<td name='sss'><input type='hidden' id='shelfFloors' value=" + (parseInt(product.length) + 1) + ">" + (parseInt(product.length) + 1) + "</td>";
				if (result.counter.length > 0) {
					for (var i = 0; i < result.counter.length; i++) {
						var product = result.counter[i].caseNo;
						ss = "<td name='sss'>" + product + "，</td>";
						$("#cas").append(ss);
					}

				}

				$("#f").append(s);
				$("#d").append(e);

				$("#dis").show();

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
</script>