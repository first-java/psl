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
<title>借料</title>
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
	$(function() { //用jQuery获取table中td值     
		var workId = $("#workId").prop("value");
		$("#mytable tr").click(function() {
			var ss = $(this).text(); //jQuery获取table中点击位置所在行的id  
			layer.open({
				type : 2,
				title : "借料",
				area : [ '800px', '500px' ],
				content : "<%=request.getContextPath()%>/counterToManage/in3.jsp?product=" + ss + "&&workId=" + workId + ""
			});
		});

	});
</script>

<script type="text/javascript">
	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$("#ajaxC").click();
			document.getElementById('form-field-icon-1').focus()
		}
	});
</script>
<body>

	<form action="<%=path%>/ctm.action?methodstr=selectP1" method="post"
		enctype="multipart/form-data">
		<div class="page-header">
			<h1>所有产品列表</h1>
		</div>
		<p class="form-search">
			<span></span> <label>输入产品：</label> <input name="counter.product"
				onkeyup="this.value=this.value.toUpperCase()" type="text"
				placeholder="请输入产品模糊搜索">

			<button class="btn btn-danger btn-sm">
				<i class="icon-search icon-on-right bigger-110"></i> 搜 索
			</button>
		</p>
	</form>
	<br>
	<input type="hidden" value="6277" id="workId" />
	<c:if test="${not empty ques }">
		<div class="page-header">
			<h1>没有查到数据</h1>
		</div>
	</c:if>
	<c:if test="${not empty que }">
		<table class="table table-striped table-bordered table-hover"
			id="mytable" width="50%">
			<tr>
				<td>蓝膜号</td>
				<td>5位批次头</td>
				<td>级别</td>
				<td>数量</td>
				<td>货架号</td>
				<td>箱号</td>
				<td>入库时间</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${que }" var="bath">
				<tr>
					<td>${bath.product },</td>
					<td>${bath.lotHead }</td>
					<td>${bath.materialName }</td>
					<td>${bath.qty }</td>
					<td>${bath.shelfName }</td>
					<td>${bath.caseNo }</td>
					<td>${bath.intime }</td>
					<td><a>借料</a></td>
				</tr>
			</c:forEach>
		</table>
		<ul class="pagination pull-right">
			<li class="disabled"><a title="首页">首页</a></li>
			<li class="disabled"><a title="上一页">上一页</a></li>
			<li class="active"><span>1</span></li>
			<li><a>2</a></li>
			<li><a>3</a></li>
			<li><a title="下一页">下一页</a></li>
			<li><a title="尾页">尾页</a></li>
		</ul>
	</c:if>

</body>
</html>