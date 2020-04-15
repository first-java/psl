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
<title>工艺判定</title>
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
			var shelf = $("#shelf").prop("value");
			var status = $("#status2").prop("value");
			if (shelf == "") {
				layer.msg("请输入要查询的数据！", {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectCheckList2",
				//提交的数据
				data : {
					"counter.shelf" : shelf,
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'n') {
						layer.msg("没查到数据！", {
							icon : 2
						});
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var binUnitId = result.counter[i].binUnitId;
						var materialName = result.counter[i].materialName;
						var rootLotId = result.counter[i].rootLotId;
						var indeedqty = result.counter[i].qty;
						var sendNum = result.counter[i].sendNum;
						var status = result.counter[i].status;
						var str = $.trim($("#ss").val());
						var d;
						if (status == "OK") {
							d = "NG"
						} else if (status == "NG") {
							d = "OK"
						}
						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='binUnitId' value=" + binUnitId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='materialName' value=" + materialName + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='rootLotId'  value=" + rootLotId + " />" +
							"</td><td>" +
							"<select name='status'><option value=" + status + ">" + status + "</option><option value=" + d + ">" + d + "</option></select>" +
							"</td><td>" +
							"<input type='text' readonly='true' onChange='shuru(this);'  style='border-style:none' name='indeedqty' id='s' value=" + indeedqty + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='sendNum'  value=" + sendNum + " />" +
							"</td></tr>";
						var luckElements = document.getElementsByName("binUnitId");
						var tapeId = document.getElementById("shelf").value;
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
						$('#shelf').val('');
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
		$("#ajaxB").click(function() {
			var workId = $("#workId").prop("value");
			var status = $('select[name=status] option:selected').val();
			var materialName = "[";
			$("[name=materialName]").each(function() {
				materialName += '{"materialName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			materialName = materialName.replace(reg, "");
			materialName += "]";

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


			var indeedqty = "[";
			$("[name=indeedqty]").each(function() {
				indeedqty += '{"indeedqty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			indeedqty = indeedqty.replace(reg, "");
			indeedqty += "]";

			var sendNum = "[";
			$("[name=sendNum]").each(function() {
				sendNum += '{"sendNum":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sendNum = sendNum.replace(reg, "");
			sendNum += "]";

			var status = "[";
			$("select[name=status]").each(function() {
				status += '{"status":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			status = status.replace(reg, "");
			status += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=craftCheckList1", //11.2
				//提交的数据
				data : {
					"counter.materialName" : materialName,
					"counter.rootLotId" : rootLotId,
					"counter.binUnitId" : binUnitId,
					"counter.sendNum" : sendNum,
					"counter.indeedqty" : indeedqty,
					"counter.workId" : workId,
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.open({
						title : '提示信息',
						content : result
					}, function() {
						window.location.reload();

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
</script>
<script>
	function check() {
		var s = document.getElementById("s");

		if (s != null) {

			document.getElementById('myForm').submit(); //进行表单提交rt(s);

		} else {
			layer.msg("没有任何数据可以提交！", {
				icon : 2
			})

		}
	}
</script>
<script type="text/javascript">
	function setFocus() {
		document.getElementById('shelf').focus()
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
<script type="text/javascript">
	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('status').focus()
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
	<div class="page-header">

		<table align="left" width="30%">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()" />
				<td>报检单号或蓝膜号：<input type="text" name="shelf"
					onkeyup="this.value=this.value.toUpperCase()" id="shelf"> <input
					type="hidden" name="status" value="NG" id="status2" />
					<button class="btn btn-primary" id="ajaxA">搜索报检单</button>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>蓝膜号</th>
				<th>级别</th>
				<th>批次头</th>
				<th>蓝膜状态</th>
				<th>数量</th>
				<th>报检单号</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />
	</form>
</body>
</html>