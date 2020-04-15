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
<title>查看出货指令</title>
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

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
</head>
<body onload="check();">
	<input type="hidden" id="ajaxC" />
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>出货客户</th>
				<th>出货备注</th>
				<th>存货编码</th>
				<th>级别参数</th>
				<th>数量</th>
				<th>指令下达时间</th>
				<th>指令完成时间</th>
				<th>指令状态</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%> " />
			</tr>
		</thead>
	</table>
</body>
</html>
<script>
	function check() {
		$("#ajaxC").click();
	}
	$(document).ready(function() {
		$("#ajaxC").click(function() {
			layer.load();
			$.ajax({
				type : "POST",
				url : "cspku.action?methodstr=selZhiL2", //5.1

				success : function(result) {
					layer.closeAll();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var client = result.counter[i].client;
						var cuase = result.counter[i].cuase;
						var stockId = result.counter[i].stockId;
						var itemId = result.counter[i].itemId;
						var qty = result.counter[i].qty;
						var createTime = result.counter[i].createTime;
						var status = result.counter[i].status;
						var doneTime = result.counter[i].doneTime;

						if (status == '0') {
							status = '未完成';
						}
						if (status == '1') {
							status = '已完成';
						}
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='client' id='client' value=" + client + " />" + client + "</td><td>" +
							"<input type='hidden' name='cuase' id='cuase' value=" + cuase + " />" + cuase + "</td><td>" +
							"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
							"<input type='hidden' name='itemId' id='itemId' value=" + itemId + " />" + itemId + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +
							"<input type='hidden' name='createTime' id='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
							"<input type='hidden' name='doneTime' id='doneTime' value=" + doneTime + " />" + doneTime + "</td><td>" +
							"<input type='hidden' name='status' id='status' value=" + status + " />" + status + "</td></tr>";

						$("#sample-table-1").append(s);
					}
					ss = "<td name='s'><font size='5' color='red'>总共" + (result.counter.length) + "记录<font size='8' color='red'></td>"
					$("#tt").append(ss);
					c = "<td name='count' ><font size='5' color='red'>其中已完成指令" + count1 + "条记录，</font><font size='5' color='red'>其中未完成指令" + count1 + "条记录，</font></td>"
					$("#tt").append(c);
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					alert("出错");

				}
			});

		})
	})
</script>