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
<title>调整箱子顺序</title>
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
			if (shelf == "") {
				layer.msg("请输入货架名称！", {
					icon : 2
				}, function() {
					window.location.reload();
					var e = document.createEvent("MouseEvents");
					e.initEvent("click", true, true);
					document.getElementById("clickMe").dispatchEvent(e);
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=updateCaseNo", //3.1
				//提交的数据
				data : {
					"counter.shelf" : shelf
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == "n") {
						layer.msg("没找到该货架", {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var shelfName = result.counter[i].shelfName;
						var floors = result.counter[i].floors;
						var caseNo = result.counter[i].caseNo;
						var createtime = result.counter[i].createTime;
						var cntargs = result.counter[i].cntargs;
						var workId = result.counter[i].workId;

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='shelfName' id='shelfName' value=" + shelfName + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='floors' id='shelfName' value=" + floors + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='caseNo' id='caseNo' value=" + caseNo + " />" +
							"</td><td>" +
							"<input type='text' onChange='shuru(this);'   style='border-style:none' name='cntargs' id='s' value=" + cntargs + " />" +
							"</td><td>" +
							"<input type='text' readonly='true' style='border-style:none' name='createtime' id='s' value=" + createtime + " />" +
							"</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' name='workId' id='s' value=" + workId + " />" +
							"</td></tr>";
						var luckElements = document.getElementsByName("materialname");

						$("#sample-table-1").append(s);
						$('.page-header input').val('');
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

			var caseNo = "[";
			$("[name=caseNo]").each(function() {
				caseNo += '{"caseNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			caseNo = caseNo.replace(reg, "");
			caseNo += "]";

			var cntargs = "[";
			$("[name=cntargs]").each(function() {
				cntargs += '{"cntargs":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			cntargs = cntargs.replace(reg, "");
			cntargs += "]";

			var els = $("input[name='cntargs']");
			for (var i = 0; i < els.length; i++) {
				var psl = els[i].value;
				if (psl.trim() == "") {
					layer.msg("还没输入箱子序号！", {
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
				url : "ctm.action?methodstr=update2", //自己的url
				//提交的数据
				data : {
					"counter.shelfName" : shelfName,
					"counter.caseNo" : caseNo,
					"counter.cntargs" : cntargs
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "修改失败") {
						layer.msg("修改失败", {
							icon : 2
						}, function() {
							window.location.reload();
							var e = document.createEvent("MouseEvents");
							e.initEvent("click", true, true);
							document.getElementById("clickMe").dispatchEvent(e);
						});
					}
					if (result == "更改成功") {
						layer.msg("更改成功", {
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
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					alert("出错");
				//请求出错处理
				}
			});

		});
	});
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
				</td>
				<td>货架名称：<input type="text" name="shelf" id="shelf">&nbsp;
					<button class="btn btn-primary" id="ajaxA">搜索箱子</button>
				</td>
			</tr>
		</table>
	</div>

	<br>
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>货架名称</th>
				<th>层数</th>
				<th>箱号</th>
				<th>箱号序号</th>
				<th>创建时间</th>
				<th>货架创建人</th>
				<input type="hidden" name="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<table align="left">
		<tr>
			<td><button class="btn btn-primary" id="ajaxB">提交修改后的数据</button></td>
		</tr>
	</table>
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