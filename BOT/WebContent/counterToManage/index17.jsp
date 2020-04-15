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
<title>查询货架</title>
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
			var status = $('#sample option:selected').val();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectHs", //4.1
				//提交的数据
				data : {
					"counter.status" : status
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作

				success : function(result) {
					if (result == "没有查到此状态货架货架!") {
						layer.msg(result, {
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
						var status = result.counter[i].status;
						var s;
						if (status == "未启用") {
							s = "已启用"
						} else if (status == "已启用") {
							s = "未启用"
						}
						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'onclick='removeTr(this)'  style='border-style:none' name='shelfName' id='s' value=" + shelfName + " />" + "</td><td>" +
							"<select name='status2'><option value=" + status + ">" + status + "</option><option value=" + s + ">" + s + "</option></select>" + "</td><td>" +
							"<a id=" + shelfName + " onclick='test(this);' ><input type='hidden' readonly='true'  style='border-style:none' name='shelfName1' id=" + shelfName + " value=" + shelfName + " />" + "增加箱子" + "</a>" + "</td></tr>";
						var luckElements = document.getElementsByName("materialname");

						$("#sample-table-1").append(s);
					/* 	$('.page-header input').val(''); */
					}

				},

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					layer.msg("服务器错误！", {
						icon : 2
					}, function() {
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});

				}
			});

		});


		$("#ajaxB").click(function() {

			var status2 = "[";
			$("select[name='status2']").each(function() {
				status2 += '{"status2":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			status2 = status2.replace(reg, "");
			status2 += "]";

			var shelfName = "[";
			$("[name='shelfName']").each(function() {
				shelfName += '{"shelfName":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			shelfName = shelfName.replace(reg, "");
			shelfName += "]";

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=updateShelfStatus", //4.2
				//提交的数据
				data : {
					"counter.status" : status2,
					"counter.shelfName" : shelfName
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作

				success : function(result) {
					layer.open({
						title : '信息提示',
						content : result
					});

				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					layer.msg("服务器出错！", {
						icon : 2
					}, function() {
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				}
			});

		});

	});
	function test(obj) { //用jQuery获取table中td值     
		layer.open({
			type : 2,
			area : [ '500px', '300px' ],
			content : "<%=request.getContextPath()%>/counterToManage/in4.jsp?floors=" + obj.id + ""
		});

	}
</script>
<body>
		<div class="page-header">
			<h4>
				<span class="badge badge-pink">&nbsp;&nbsp;&nbsp;&nbsp;查询货架&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<hr>
				<input type="hidden" id="ajaxD" />
			</h4>
			<table align="left" width="30%" id="">
				<tr>
					<td>选择状态： <select id="sample"><option value="2">全部</option>
							<option value="已启用">已启用</option>
							<option value="未启用">未启用</option></select>
						<button class="btn btn-primary" id="ajaxA">查找</button>
					</td>
				</tr>
			</table>
		</div> <br>
		<form id="myForm" action="<%=path%>/ctm.action?methodstr=checkList1"
			method="post" enctype="multipart/form-data">
			<table class="table table-striped table-bordered table-hover"
				id="sample-table-1" width="50%">
				<thead>
					<tr>
						<th>货架</th>
						<th>货架状态</th>
						<th>操作</th>
						<input type="hidden" name="workId" value="<%=workId%>" />
					</tr>
				</thead>
			</table>
			<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />
		</form>
</body>
</html>
