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
	String eqptId = (String) request.getParameter("eqptId");//直接传递
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
<title>机台派料历史</title>
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

		$("#ajaxB").click(function() {
			var eqptId = $('#eqptId').val();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=shelfMan2", //12.1 查询预设机台
				//提交的数据
				data : {
					"counter.eqptId" : eqptId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					if (result == "未找到该货架！") {
						layer.msg("该机台暂无加工信息!！", {
							icon : 2
						});
						window.opener = null;
						window.open('', '_self');
						window.close();
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {

						var lotHead = result.counter[i].eqptId;
						var materialName = result.counter[i].rootLotId;
						var product = result.counter[i].materialName;
						var intime = result.counter[i].product;
						var shelfName = result.counter[i].createTime;
						var caseNo = result.counter[i].workId;
						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true'  name='lotHead' id='lotHead' value=" + lotHead + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + materialName + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + product + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + intime + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='shelfName' id='curDieQty' value=" + shelfName + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='caseNo' id='curDieQty' value=" + caseNo + " />" +
							"</td></tr>";

						$("#sample5").append(s);

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
	function check() {
		$("#ajaxB").click();
	}
</script>
<body onload="check()">
	<input class="btn btn-primary" type="hidden" id="ajaxB" value="提交" />
	<div class="page-header">
		<input type="hidden" id="eqptId" value="<%=eqptId%>">
		</td>
		<hr>
		<table class="table table-striped table-bordered table-hover"
			id="sample5" width="50%">
			<tr>
				<th>贴带机台号</th>
				<th>历史加工的产品</th>
				<th>历史加工的级别</th>
				<th>历史派上机台的材料</th>
				<th>历史派料时间</th>
				<th>派料员</th>
			</tr>
		</table>
	</div>
</body>
</html>