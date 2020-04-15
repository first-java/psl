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
	response.setHeader("Refresh", "3");
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
<title>机台看板</title>
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
	setTimeout(function() {
		window.location.reload(); //刷新当前页面.
	}, 10000)
	$(document).ready(function() {

		$("#ajaxA").click(function() {
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectEqptStatus1", //自己的url
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				timeout : 1000,
				success : function(result) {

					if (result == 's') {
						layer.msg("未找到该两位批次", {
							icon : 2
						}, function() {
							window.location.reload();

						});
					}
					if (result == "d") {
						layer.msg("货架上未找到此产品", {
							icon : 2
						}, function() {
							window.location.reload();
						});
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var eqptid = result.counter[i].eqptId;
						var materialName = result.counter[i].materialName;
						var lotHead = result.counter[i].rootLotId;
						var product = result.counter[i].product;
						var qty = result.counter[i].qty;
						var intime = result.counter[i].createTime;
						/* var str = $.trim($("#ss").val()); */

						s = "<tr><td>" + eqptid + "</td><td>" + lotHead + "</td><td>"
							+ materialName + "</td><td>" + product + "</td><td>"
							+ qty + "</td><td>" + intime + "</td></tr>";

						$("#sample-table-1").replace(s);
					}
				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					layer.open({
						title : '信息提示',
						content : '<!DOCTYPE html><html><head><title>MyHtml.html</title><meta name="keywords" content="keyword1,keyword2,keyword3"><meta name="description" content="this is my page"><meta name="content-type" content="text/html; charset=UTF-8"></head><body><h1>无法访问此网站</h1><h3>localhost 拒绝了我们的连接请求。</h3>请试试以下办法：<br>检查网络连接<br>检查代理服务器和防火墙	<br> ERR_CONNECTION_REFUSED</body></html>'
					}, function() {
						window.location.reload();
						var e = document.createEvent("MouseEvents");
						e.initEvent("click", true, true);
						document.getElementById("clickMe").dispatchEvent(e);
					});
				//请求出错处理
				}
			});

		});

	});
	function check() {
		$("#ajaxA").click();
	}
	setInterval("check()", 10000);
</script>
<body onload="check()">
	<input type="hidden" id="ajaxA" />
	<c:if test="${not empty que }">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>贴带机台号</th>
					<th>正在加工的产品</th>
					<th>正在加工的级别</th>
					<th>派上机台的材料</th>
					<th>派料时间</th>
					<th>派料员</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
			<c:forEach items="${que }" var="bath">
				<tr>
					<td id="d"><a
						href="<%=request.getContextPath()%>/counterToManage/index27.jsp?eqptId=${bath.eqptId }">
							${bath.eqptId }</a></td>
					<td>${bath.rootLotId }</td>
					<td>${bath.materialName }</td>
					<td>${bath.product }</td>
					<td>${bath.createTime }</td>
					<td>${bath.workId }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>