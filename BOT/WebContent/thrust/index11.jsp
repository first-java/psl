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
<title>入库达成</title>
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
<script>
	function deleteRow(r) {
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('table').deleteRow(i);

	}
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			var endTime = $("#test12").prop("value");
			var startTime = $("#test11").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "thrust.action?methodstr=notest22", //5.1
				//提交的数据
				data : {
					"thrust.startTime" : startTime,
					"thrust.endTime" : endTime
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'error') {
						layer.msg("没有查到信息！！", {
							icon : 2
						});
						return;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var fileName = result.counter[i].fileName;
						var unitId = result.counter[i].unitId; //批次头
						var testTime = result.counter[i].testTime; //mes投入时间
						var createTime = result.counter[i].createTime; //投入量
						var dataTypeId = result.counter[i].dataTypeId; //良率
						var dataType = result.counter[i].dataType; //交期
						var eqpt = result.counter[i].eqpt; //交货量
						var stafferId = result.counter[i].stafferId; //交货量
						var testResult = result.counter[i].testResult; //达成量
						var idx = result.counter[i].idx; //差异
						var seq = result.counter[i].seq;
						var testValue = result.counter[i].testValue; //差异
						/* var time = new Date(inTime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						var adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s; //投入时间

						var time1 = new Date(inTime1.time);
						var y1 = time1.getFullYear();
						var m1 = time1.getMonth() + 1;
						var da1 = time1.getDate();
						var h1 = time1.getHours();
						var mm1 = time1.getMinutes();
						var s1 = time1.getSeconds();
						s1 = s1 < 10 ? '0' + s1 : s1;
						var adtime1 = y1 + "-" + m1 + "-" + da1 + " " + h1 + ":" + mm1 + ":" + s1; //投入时间
						
 */
						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='fileName' id='fileName' value=" + fileName + " />" + fileName + "</td><td>" +
							"<input type='hidden' name='unitId' id='unitId' value=" + unitId + " />" + unitId + "</td><td>" +
							"<input type='hidden' name='testTime' id='testTime' value=" + testTime + " />" + testTime + "</td><td>" +
							"<input type='hidden' name='createTime' id='createTime' value=" + createTime + " />" + createTime + "</td><td>" +
							"<input type='hidden' name='dataTypeId' id='dataTypeId' value=" + dataTypeId + " />" + dataTypeId + "</td><td>" +
							"<input type='hidden' name='dataType' id='dataType' value=" + dataType + " />" + dataType + "</td><td>" +
							"<input type='hidden' name='eqpt' id='eqpt' value=" + eqpt + " />" + eqpt + "</td><td>" +
							"<input type='hidden' name='stafferId' id='stafferId' value=" + stafferId + " />" + stafferId + "</td><td>" +
							"<input type='hidden' name='testResult' id='testResult' value=" + testResult + " />" + testResult + "</td><td>" +
							"<input type='hidden' name='idx' id='idx' value=" + idx + " />" + idx + "</td><td>" +
							"<input type='hidden' name='seq' id='seq' value=" + seq + " />" + seq + "</td><td>" +
							"<input type='hidden' name='testValue' id='testValue' value=" + testValue + " />" + testValue + "</td></tr>";

						$("#table").append(s);
					}
				},
				//调用执行后调用的函数

				error : function(XMLHttpRequest, textStatus, errorThrown) { //出错弹框
					//layer.closeAll();
					//layer.msg("--" + errorThrown)
					layer.closeAll();
					alert("出错");
				//请求出错处理
				}
			});
		});
	});
	function downLoad(url) {
		var endTime = document.getElementById("test12");
		var startTime = document.getElementById("test11");

		//1、获得查询参数
		var query = document.getElementById("quer");

		//2、拼装URL+查询参数
		url = url + "&endTime=" + endTime.value + "&startTime=" + startTime.value;
		//3、使用document.local.href=URL

		location.href = url;
	}
</script>
</head>
<body>

	<table class="table table-striped table-bordered table-hover"
		id="table" width="50%">
		<thead>
			<tr>
				<td colspan="4">选择日期 从
					<div class="layui-inline">
						<div class="layui-input-inline">
							<input type="text" autocomplete="off" class="layui-input"
								id="test11" placeholder="yyyy/MM/dd">
						</div>
					</div>到
					<div class="layui-inline">
						<div class="layui-input-inline">
							<input autocomplete="off" type="text" class="layui-input"
								id="test12" placeholder="yyyy/MM/dd">
						</div>
					</div>
					<button class="btn btn-primary" id="ajaxA">查询数据</button>
				</td>
			</tr>
			<tr>
				<th>测试文件</th>
				<th>片号</th>
				<th>测试时间</th>
				<th>CREATE_TIME</th>
				<th>DATA_TYPE_ID</th>
				<th>DATA_TYPE</th>
				<th>机台</th>
				<th>STAFFER_ID</th>
				<th>测试结果</th>
				<th>IDX</th>
				<th>SQE</th>
				<th>TST_VALUE</th>
			</tr>
		</thead>
	</table>
	<br>
	<td><button class="btn btn-primary"
			onclick="downLoad('<%=request.getContextPath()%>/downTht.action?methodstr=downloadReport')">导出明细</button></td>



</body>
</html>
<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//自定义格式
		laydate.render({
			elem : '#test11',
			format : 'yyyy/MM/dd'
		});
		//自定义格式
		laydate.render({
			elem : '#test12',
			format : 'yyyy/MM/dd'
		});

	});
</script>
