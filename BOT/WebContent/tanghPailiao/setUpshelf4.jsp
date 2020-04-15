
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
		}
	}, 200);
</script>

<script>
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var shelfNo = $("select[name='shelfNo']").val();
			var floors = $("select[name='floors']").val();
			if (floors == "请选择...") {
				layer.alert("请选择层数！");
				return;
			}

			var site = "[";
			$("[name=site]").each(function() {
				site += '{"site":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			site = site.replace(reg, "");
			site += "]";

			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=saveLanmoSite", //1.1
				data : {
					"lanmoShelf.shelfNo" : shelfNo,
					"lanmoShelf.floors" : floors,
					"lanmoShelf.site" : site
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.coloseAll();
					if ("success" == result) {
						layer.alert("创建成功！");
						return;
					} else if ("error" == result) {
						layer.alert("创建失败！");
						return;
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

					});
				}
			//请求出错处理
			});

		});

		$("#ajaxD").click(function() {

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selShelfNo", //1.1

				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");

					for (var i = 0; i < result.counter.length; i++) {
						var shelfNo = result.counter[i].shelfNo;
						ss = "<option value=" + shelfNo + ">" + shelfNo + "</option>"
						$("#shelfNo").append(ss);
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
	function check() {
		$("#ajaxD").click();
	}
</script>

</head>
<body onload="check()">

	<table id="case">
		<tr>
			<td colspan="2">选择货架号：<select id="shelfNo" name="shelfNo"><option>请选择...</option>
			</select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">选择&nbsp;层数：<select id="floors" name="floors"><option>请选择...</option></select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><a href="#" id="MoreFileBox"
				class="btn btn-info">增加位置号</a></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>位 &nbsp;置&nbsp;号：<input type="hidden" value="1" id="s"
				name="cntargs" /> <input type="text" id="caseNo" size="10"
				name="site" /></td>
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
			<input type="hidden" id="ajaxD" />
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

				$(sample1).append("<tr><td colspan='2'><input readonly='readonly'  type='text' value=" + FieldCount1 + " size='2' name='cntargs'/>" + '&nbsp;&nbsp;<input size="10" type="text" name="site" />&nbsp;<a href="#" class="removeclass">移除</a></td></tr>');
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
	$("#shelfNo").blur(function() {
		var shelfNo = $("select[name='shelfNo']").val();
		if (shelfNo == "请选择...") {
			layer.alert("请选择货架！");
			return;
		}

		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "csppailiao.action?methodstr=selectShelfNo", //12.4
			//提交的数据
			data : {
				"lanmoShelf.shelfNo" : shelfNo
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				var result = eval("(" + result + ")");

				for (var i = 0; i < result.counter.length; i++) {
					var floors = result.counter[i].floors;
					ss = "<option value=" + floors + ">" + floors + "</option>"
					$("#floors").append(ss);
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
</script>