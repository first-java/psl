<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
	String odd = (String) request.getParameter("odd");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function t(obj, id) {
		var idd = Number(id);
		var barcode = $("#" + id + "").val();
		if (barcode == '') {
			layer.alert('还没输入片号！', {
				icon : 2
			}, function() {
				$("#" + id + "").val('');
				$("#" + id + "").select();
				layer.closeAll();
			});

			return false;
		}
		var df = Number(id) + 1;
		$("#" + df + "").select();
		return false;
	}
	function s() {
		$("#ajaxC").click();
	}
	$(document).ready(function() {
		$("#ddd").click(function() {
			var workId = $('#workId').val().trim();
			var aInput = document.getElementsByName("lotId");
			var lotId = $('#tapei').val().trim();
			var lotId = $('#tapei').val().trim();
			if (aInput.length < 1) {
				layer.alert("没有数据！");
				return false;
			}

			var unitId1 = document.getElementsByName("unitId1");
			var unitId = document.getElementsByName("unitId");
			var o = []; //片号
			for (var i = 0; i < unitId.length; i++) {
				if (unitId[i] !== "") {
					o.push(unitId[i].value.trim());
				} else {
					o.push(unitId[i].value);
				}

			}
			var t = []; //输入的片号
			for (var i = 0; i < unitId1.length; i++) {
				if (unitId1[i] !== "") {
					t.push(unitId1[i].value.trim());
				} else {
					t.push(unitId1[i].value);
				}
			}

			for (var i = 0; i < (o.length * t.length * o.length * t.length); i++) {
				for (var f = 0; f < (o.length * t.length * o.length * t.length); f++) {
					if (t[f] != undefined) {
						if (o[i] == t[f]) {
							var index1 = o.indexOf(o[i]);
							o.splice(index1, 1);
							var index = t.indexOf(t[f]);
							t.splice(index, 1);

						}
					}
				}
			}
			for (var i = 0; i < (o.length * t.length * o.length * t.length); i++) {
				for (var f = 0; f < (o.length * t.length * o.length * t.length); f++) {
					if (o[i] == t[f]) {
						var index1 = o.indexOf(o[i]);
						o.splice(index1, 1);
						var index = t.indexOf(t[f]);
						t.splice(index, 1);
					}
				}

			}
			for (var i = 0; i < (o.length * t.length * o.length * t.length); i++) {
				for (var f = 0; f < (o.length * t.length * o.length * t.length); f++) {
					if (o[i] == t[f]) {
						var index1 = o.indexOf(o[i]);
						o.splice(index1, 1);
						var index = t.indexOf(t[f]);
						t.splice(index, 1);
					}
				}

			}
			if (o.length > 0 || t.length > 0) {
				layer.alert("有片号没校验！" + o[0]);
				return false;
			}

			for (var i = 0; i < unitId1.length; i++) {
				if (unitId1[i].value == "") {
					layer.alert("有片号没校验！");
					return false;
				}

			}

			var n = []; //一个新的临时数组
			//遍历当前数组
			for (var i = 0; i < aInput.length; i++) {
				//如果当前数组的第i已经保存进了临时数组，那么跳过，否则把当前项push到临时数组里面
				if (n.indexOf(aInput[i].value) == -1)
					n.push(aInput[i].value);
			}
			var lotId = "[";
			$("[name=lotId]").each(function() {
				lotId += '{"lotId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotId = lotId.replace(reg, "");
			lotId += "]";

			var unitId = "[";
			$("[name=unitId]").each(function() {
				unitId += '{"unitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			unitId = unitId.replace(reg, "");
			unitId += "]";


			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "boliao.action?methodstr=boliao1", //5.1
				//提交的数据
				data : {
					"boliao.unitId" : unitId,
					"boliao.lotId" : lotId,
					"boliao.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#tapei").select();
						return false;
					}
					if (result == 'wei') {
						layer.alert("此批次没有过回流焊");
						$("#tapei").select();
						return false;
					} else {
						layer.alert("校验成功！", {
							icon : 1
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
						$("#tapei").select();
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

		})

		$("#ajaxC").click(function() {

			var lotId = $('#tapei').val().trim();
			if (lotId == "") {
				layer.alert("没有输入批次！");

				return;
			}
			var aInput = document.getElementsByName("lotId");
			for (var i = 0; i < aInput.length; i++) {
				var ins = aInput[i].value.trim();

				if (ins == lotId) {
					layer.alert("此批次已在以下列表！");

					return;
				}

			}
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "boliao.action?methodstr=boliao", //5.1
				//提交的数据
				data : {
					"boliao.lotId" : lotId //产品型号

				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.alert("未找到此片信息");
						$("#tapei").select();
						return false;
					}
					var result = eval("(" + result + ")");
					var h = $('#length').val().trim();
					for (var i = 0; i < result.boliao.length; i++) {
						var lotId = $('#tapei').val().trim();
						var unitId = result.boliao[i].unitId;
						var testFile = result.boliao[i].testFile;
						if (h != " ") {
							var idd = i + Number(h) + 1;
						} else {
							var idd = i + h;
						}
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='lotId'  value=" + lotId + " />" + lotId + "</td><td>" +
							"<input type='hidden' name='unitId'  value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='text' name='unitId1'id=" + idd + "  onkeypress='if(event.keyCode==13) t(this," + idd + ");'value='' /></td><td>" +
							"<input type='hidden' name='testFile' value=" + testFile + " />" + testFile + "</td></tr>";
						$("#InputsWrapper").append(s);

					}
					var putArr = document.getElementsByName("unitId1");

					$("#length").val(putArr.length);
					$("#tapei").val('');

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

		$("#ajaxD").click(function() {
			var tapei = $('#tapei1').val().trim();
			var aInput = document.getElementsByName("unitId");
			var myBoolean = false;

			for (var i = 0; i < aInput.length; i++) {
				var ins = aInput[i].value.trim();

				if (ins == tapei) {
					$("#" + (i + 1) + "").find("option[value = '是']").attr("selected", "selected");
					aInput[i].parentNode.parentNode.style.background = 'red';
					myBoolean = true;
					break;
				} else {
					myBoolean = false;
				}
			}
			if (myBoolean) {
				layer.msg("卷轴存在！", {
					icon : 1,
				});
				$('.page-header input').val('');
				return false;
			} else {
				layer.msg("卷轴不存在以下列表！", {
					icon : 2
				});
				$('.page-header input').val('');
				return false;
			}
		});
	});


	/* $(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			var tapei = $('#tapei').val().trim();
			var tapei1 = $('#tapei1').val().trim();
			if (tapei1 == '') {
				$("#ajaxC").click();
				document.getElementById('tapei').focus();
			}

			if (tapei == '') {
				$("#ajaxD").click();
				document.getElementById('tapei1').focus();
			}

		}

	}); */
</script>

<style>
body {
	padding: 0;
	margin: 0;
	font: normal 24px/48px "\5FAE\8F6F\96C5\9ED1";
	color: #444;
}

table {
	width: 70%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
}

table th {
	background: #0090D7;
	font-weight: normal;
	line-height: 30px;
	font-size: 18px;
	color: #FFF;
}

table tr:nth-child(odd) {
	background: #F4F4F4;
}

table td:nth-child(even) {
	color: #C00;
}

table tr:nth-child(1) {
	background: #73B1E0;
	color: #FFF;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}

table td, table th {
	border: 1px solid #EEE;
}
</style>
<title>剥料确认</title>
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
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
	src="<%=request.getContextPath()%>/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<input type="hidden" id="odd" value="<%=odd%>" />
	<input type="hidden" id="length" value="" />
	<input type="hidden" id="workId" value="<%=workId%>" />
	<center>
		<div class="page-header">
			<table>
				<tr>
					<td><br>输入批次号：<input type="text" id="tapei"
						onkeypress="if(event.keyCode==13) s();"
						onkeyup="this.value=this.value.toUpperCase()">&nbsp;
						<button class="btn btn-primary" id="ajaxC">确定</button></td>
				</tr>
			</table>
			<br>
		</div>

		<div>
			<table id="InputsWrapper" border="1">

				<tr>
					<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
				<tr>
					<td>批次号</td>
					<td>片号</td>
					<td>校验片号</td>
					<td>测试档</td>
				</tr>
				<tr>
					<input type="button" class="btn btn-primary" id="ddd" value="完成校验" />
				</tr>
			</table>
		</div>

	</center>
</body>
</html>