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
<title>调整货架顺序</title>
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
			var status = $('#status option:selected').val();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=notest", //2.1 
				//提交的数据
				data : {
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
				success : function(result) {

					if (result === "没有未启用的货架可以调整！") {
						layer.msg(result, {
							icon : 2
						});
						return false;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var targs1 = result.counter[i].targs;
						var shelfName = result.counter[i].shelfName;
						var workId = result.counter[i].workId;
						var status = result.counter[i].status;

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='shelfName' id='shelfName' value=" + shelfName + " />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'  style='border-style:none' name='targs1' id='targs1' value=" + targs1 + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='workId' id='workId' value=" + workId + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none'  id='status' value=" + status + " />" + "</td></tr>";
						$("#sample-table-1").append(s);

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
		$("#ajaxC").click(function() {

			var els = $("input[name='targs1']");
			for (var i = 0; i < els.length; i++) {
				var psl = els[i].value;
				if (psl.trim() == "") {
					layer.msg("还没输入货架序号！", {
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
			var s = document.getElementById("shelfName");
			if (s == null) {
				layer.msg("没有任何数据可以提交！", {
					icon : 2
				});
				return false;
			}
			var shelfName = "[";
			$("[name=shelfName]").each(function() {
				shelfName += '{"shelfName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			shelfName = shelfName.replace(reg, "");
			shelfName += "]";

			var targs1 = "[";
			$("[name=targs1]").each(function() {
				targs1 += '{"targs1":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			targs1 = targs1.replace(reg, "");
			targs1 += "]";
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=update", //2.2
				//提交的数据
				data : {
					"targs" : targs1,
					"counter.shelfName" : shelfName
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数
				success : function(result) {

					if (result == "修改失败") {
						layer.msg("修改失败！", {
							icon : 2
						});
						return false;
					}
					if (result == "修改成功！") {
						layer.msg("修改成功！", {
							icon : 1
						});
						return false;
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
		<table align="left" width="30%">
			<tr>
				<td>货架状态：<select name="status" id="status">
						<option value="2">全部</option>
				</select>
					<button class="btn btn-primary" id="ajaxA">搜索</button>
				</td>
			</tr>
		</table>
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>货架名称</th>
					<th>货架序号</th>
					<th>货架创建人</th>
					<th>货架状态</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
		</table>
		<table align="left">
			<tr>
				<td><button class="btn btn-primary" id="ajaxC">提交修改后的数据</button></td>
			</tr>
		</table>
	</div>
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