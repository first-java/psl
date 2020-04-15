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
<title>静电袋合袋</title>
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

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/csppailiao.css">

</head>
<body>

	<td><a href="{:U('Single/single',['sid'=>$ls['sid']])}"
		rel="external nofollow" class="layui-btn layui-btn-mini"> 编辑 </a> <a
		href="javascript:;" rel="external nofollow" data-id="test"
		class="layui-btn layui-btn-danger layui-btn-mini del"> 删除 </a></td>


	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>静电袋号</th>
				<th>类型</th>
				<th>种类</th>
				<th>数量</th>
				<th>净重</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<div class="form-group">

		<label for="printTplBtn" class="col-sm-1 control-label label-postek"></label>
		<div class="form-group col-sm-3"
			style="padding-left:0;padding-right:0;margin-top: 10px;">
			<button id="ajaxB"
				class="btn btn-primary btn-lg btn-block btn-postek" type="button"
				data-loading-text="打印模板中...">提交/打印</button>
		</div>

	</div>
	<!-- 按钮 -->
	<div class="form-group">

		<label for="printTplBtn" class="col-sm-1 control-label label-postek"></label>
		<div class="form-group col-sm-3"
			style="padding-left:0;padding-right:0;margin-top: 10px;">
			<input id="printTplBtn" readonly="readonly"
				class="btn btn-primary btn-lg btn-block btn-postek" type="hidden"
				data-loading-text="打印模板中..." />
		</div>
	</div>
	<button class="btn btn-primary" id="ajaxA">查询</button>

</body>
</html>
<script type="text/javascript">
	layui.use('layer', function() {
		var $ = layui.jquery;
		// 删除操作
		$('a.del').click(function() {

			layer.confirm(" ",{
				btn : [ '提交', '取消' ],
				title : "删除确认尾料收集确认"
			}, function(index) {
				$("#ajaxA").click();
			});

		})
	})
</script>
<script type="text/javascript">

	$(document).ready(function() {
		$("#ajaxA").click(function() {
			layer.load();
			/* var shelfName = $("#shelfName").prop("value");
			 */
			var lotid = $("#lotid").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "csppailiao.action?methodstr=selzdpbd", //11.2selectShelft
				//提交的数据
				data : {
					"eqpt.bdLotId" : lotid
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.closeAll();
					$("[name='sss']").remove();
					var result = eval("(" + result + ")");

					if (result.counter.length == 0) {
						layer.alert("没有查到数据！", {
							icon : 2
						}, function() {
							layer.closeAll();
						});
					}

					for (var i = 0; i < result.counter.length; i++) {

						var bdLotId = result.counter[i].bdLotId;
						var createtime = result.counter[i].createTime;
						var lotType = result.counter[i].lotType;
						var id = result.counter[i].id;
						var bin = result.counter[i].bin;
						var zongPai = result.counter[i].zongPai;
						var inQty = result.counter[i].inQty;
						var tapeOutQty = result.counter[i].tapeOutQty;
						var weiliao = result.counter[i].weiliao;
						var momian = result.counter[i].momian;
						var dianji = result.counter[i].dianji;
						var diliao = result.counter[i].diliao;
						var zongQty = result.counter[i].zongQty;
						var nowDieQty = result.counter[i].nowDieQty;
						var adtime = "";
						var time = new Date(createtime.time);
						var y = time.getFullYear();
						var m = time.getMonth() + 1;
						var da = time.getDate();
						var h = time.getHours();
						var mm = time.getMinutes();
						var s = time.getSeconds();
						s = s < 10 ? '0' + s : s;
						adtime = y + "-" + m + "-" + da + " " + h + ":" + mm + ":" + s;

						s = "<tr name='sss'><td>" + bdLotId + "</td><td>" +
							adtime + "</td><td>" +
							lotType + "</td><td>" +
							id + "</td><td>" +
							bin + "</td><td>" +
							zongPai + "</td><td>" +
							inQty + "</td><td>" +
							tapeOutQty + "</td><td>" +
							weiliao + "</td><td>" +
							momian + "</td><td>" +
							dianji + "</td><td>" +
							diliao + "</td><td>" +
							zongQty + "</td><td>" +
							nowDieQty + "</td></tr>";
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

	});
</script>