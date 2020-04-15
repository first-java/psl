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
<title>csp晶能半导体</title>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>

	$(document).ready(function() {

		$("#ajaxA").click(function() {

			layer.load();
			//	var shelf = $("#bagName").prop("value");
			var startTime = $("#test11").prop("value");
			var endTime = $("#test12").prop("value");
			if (startTime == "") {
				layer.alert('还没选择开始时间！', {
					icon : 2
				});
				return false;
			}
			if (endTime == "") {
				layer.alert('还没选择结束时间！', {
					icon : 2
				});
				return false;
			}
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ctm.action?methodstr=selectBatchs",
				//提交的数据
				data : {
					"counter.startTime" : startTime,
					"counter.endTime" : endTime
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					if (result == 'n') {
						layer.open({
							title : '存放位置',
							content : "没有查到数据！"
						});
						return false;
					}
					$("tr[name='sss']").remove();
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {

						var eqpt = result.counter[i].eqpt;

						var bagname = result.counter[i].bagname;

						var batchs = result.counter[i].batchs;
						var testFile = result.counter[i].testFile;

						var intime = result.counter[i].intime;

						var adtime = "";
						var time = new Date(intime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;

						s = "<tr name='sss'><td>" +
							"<input type='text' readonly='true' name='rowno' style='border-style:none'  value=" + eqpt + " />" + "</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none' value=" + bagname + " />" + "</td><td>" +
							"<input type='text' readonly='true'  style='border-style:none'  value=" + batchs + " />" + "</td><td>" +
							"<input type='text' style='border-style:none'  value=" + testFile + " />" + "</td><td>" +
							adtime + "</td></tr>";

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

	});
</script>

</head>
<body>
	<div class="page-header">

		<table align="left">
			<tr>
				<td colspan="4">选择日期 从
					<div class="layui-inline">
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="test11"
								name="startTime" placeholder="yyyy/MM/dd">
						</div>
					</div>到
					<div class="layui-inline">
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="test12" name="endTime"
								placeholder="yyyy/MM/dd">
						</div>
					</div>
				</td>
				<td> <input type="hidden" autocomplete="off"
					onkeyup="this.value=this.value.toUpperCase()" id="bagName">&nbsp;
					<button class="btn btn-primary" id="ajaxA">搜索</button>
				</td>
			</tr>
		</table>
	</div>

	<br>
	<!-- 7.2 -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>机台号</th>
				<th>批次号</th>
				<th>静电袋号</th>
				<th>测试档</th>
				<th>派料时间</th>
				<input type="hidden" id="workId" name="workId" value="<%=workId%>" />
			</tr>
		</thead>
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

	function t() {
		var opt = $("#workId").val();
		layer.open({
			type : 2,
			area : [ '1300px', '900px' ],
			content : "<%=request.getContextPath()%>/counterToManage/in5.jsp?workId='" + opt + "'"
		});

	}
</script>
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