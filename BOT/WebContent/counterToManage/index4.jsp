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
<title>创建蓝膜送检单</title>
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {
			var product = $("#form-field-icon-1").prop("value");
			var ss = document.getElementById('form-field-icon-1').value;

			if (ss == "") {
				layer.msg("还没录入蓝膜号", {
					icon : 2
				});
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=film", //5.1
				//提交的数据
				data : {
					"counter.product" : product
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "产品不存在") {
						layer.msg("蓝膜不存在！", {
							icon : 2
						});
						return false;
					}
					if (result == "产品已经存在送单中！") {
						layer.msg("该产品已创建过送检单！", {
							icon : 2
						});
						return false;
					}
					var result = eval("(" + result + ")");
					var s = document.getElementById("form-field-icon-1").value;
					if (s === "") {
						layer.msg("请先输入蓝膜号！", {
							icon : 2
						});
						return false;
					}

					for (var i = 0; i < result.counter.length; i++) {
						var h = $('#length').val().trim();
						var d = Number(h) + i + 1;
						var remark = result.counter[i].remark;
						var rootlotid = result.counter[i].rootLotId;
						var dieqty = result.counter[i].dieqty;
						var binUnitId = result.counter[i].binUnitId;
						var bin = result.counter[i].binId;
						bin = Number(bin);

						s = "<tr><td>" + "<input type='text' readonly='true'   style='border-style:none' id='s'  name='id' value=" + d + " />" +
							"</td><td>" + "<input type='text' readonly='true'  style='border-style:none' name='binUnitId' id='s' value=" + binUnitId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' value=" + bin + " />" + "</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='remark' value=" + remark + " />" +

							"</td><td>" +
							"<input type='text' readonly='true' id='rootLotId' style='border-style:none' name='rootLotId'  value=" + rootlotid + " />" +
							"</td><td>" +
							"<input type='text'  readonly='true' name='dieqtys' id='s' value=" + dieqty + " />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);' name='dieqty' id='s' oninput='if(value>=" + dieqty + ")value=" +
							dieqty + "' />" +
							"</td></tr>";
						var luckElements = document.getElementsByName("binUnitId");
						var luckElements1 = document.getElementsByName("rootLotId");
						var tapeId = document.getElementById("form-field-icon-1").value;
						for (var i = 0; i < luckElements.length; i++) {
							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("蓝膜号已经在以下列表中存在", {
									icon : 2
								}
								);$('.page-header input').val('');
								return false;
							}

							if (luckElements1[i].value !== rootlotid) {
								layer.msg("该蓝膜批次头不一致！", {
									icon : 2
								}
								);$('.page-header input').val('');
								return false;
							}
						}
						$("#sample-table-1").append(s);
						$('.page-header input').val('');
					}
					var aInput = document.getElementsByName("remark");

					if (bin >= 94) {
						if (bin <= 99) {
							aInput[d - 1].parentNode.parentNode.style.background = 'red';
						}
					}
					if (bin >= 138) {
						if (bin <= 150) {
							aInput[d - 1].parentNode.parentNode.style.background = 'red';
						}
					}

					$("#length").val(aInput.length);
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
			var workId = $("#workId").prop("value");
			var materialName = "[";
			$("[name=remark]").each(function() {
				materialName += '{"remark":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";

			var id = "[";
			$("[name=id]").each(function() {
				id += '{"id":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			id = id.replace(reg, "");
			id += "]";

			var binUnitId = "[";
			$("[name=binUnitId]").each(function() {
				binUnitId += '{"binUnitId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			binUnitId = binUnitId.replace(reg, "");
			binUnitId += "]";

			var rootLotId = "[";
			$("[name=rootLotId]").each(function() {
				rootLotId += '{"rootLotId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			rootLotId = rootLotId.replace(reg, "");
			rootLotId += "]";

			var dieqtys = "[";
			$("[name=dieqtys]").each(function() {
				dieqtys += '{"dieqtys":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			dieqtys = dieqtys.replace(reg, "");
			dieqtys += "]";

			var dieqty = "[";
			$("[name=dieqty]").each(function() {
				dieqty += '{"dieqty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			dieqty = dieqty.replace(reg, "");
			dieqty += "]";

			var els = $("input[name='dieqty']");
			for (var i = 0; i < els.length; i++) {
				var psl = els[i].value;
				if (psl.trim() == "") {
					layer.msg("还没输入数量！", {
						icon : 2
					});
					return false;
				}
				if (!/^[0-9]*$/.test(els[i].value)) {
					layer.msg("只能输入数字！", {
						icon : 2
					});
					return false;
				}

			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=sendList", //11.2
				//提交的数据
				data : {
					"counter.materialName" : materialName,
				 	"counter.id" : id,
					"counter.rootLotId" : rootLotId,
					"counter.binUnitId" : binUnitId,
					"counter.dieqty" : dieqty, //输入数量
					"counter.dieqtys" : dieqtys, //系统数量
					"counter.workId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.msg(result, {
						icon : 1
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
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
<script>
	function check() {
		var els = $("input[name='dieqty']");
		for (var i = 0; i < els.length; i++) {
			var psl = els[i].value;
			if (psl.trim() == "") {
				layer.msg("还没输入数量！", {
					icon : 2
				});
				return false;
			}
			if (!/^[0-9]*$/.test(els[i].value)) {
				layer.msg("只能输入数字！", {
					icon : 2
				});
				return false;
			}

		}

		return false;
	}
</script>
<script type="text/javascript">
	function setFocus() {
		var s = document.getElementById('form-field-icon-1').focus();

	}
	function loseFocus() {
		document.getElementById('form-field-icon-1').blur()
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
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>
	<input type="hidden" id="length" value="" />
	<div class="page-header">
		<h1>输入蓝膜：</h1>
		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />
				<td><input id="form-field-icon-1" type="text" name="filmNo"
					onkeyup="this.value=this.value.toUpperCase()"
					onfocus="this.select()">

					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table" id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>序号</th>
				<th>蓝膜号</th>
				<th>BINID</th>
				<th>级别</th>
				<th>批次头</th>
				<th>系统数量</th>
				<th>实有数量</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />

</body>
</html>
<script>
	function shuru(txt) {
		var reg = /\d/g;
		if (isNaN(txt.value)) {
			layer.msg("只能输入数字！", {
				icon : 2
			});
			txt.value = '';
			return false;
		}
	}
</script>