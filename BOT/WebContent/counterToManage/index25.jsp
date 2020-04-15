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
<title>中段看板</title>
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
<script src="<%=request.getContextPath()%>/layui/layui.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/layui/css/layui.css" media="all">
<script src="layui/layui.js" charset="utf-8"></script>
<script>
	function downLoad(url) {
		location.href = url;
	}
	$(document).ready(function() {
		$("#ajaxA").click(function() {
			/* $("#sample5").hide(); */
			var ecount = $('#count option:selected').val();
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "zlook.action?methodstr=zLook", //12.1 查询预设机台
				//提交的数据
				data : {
					"ecount" : ecount //每页显示条数
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					layui.use([ 'laypage', 'layer' ], function() {
						var laypage = layui.laypage,
							layer = layui.layer;

						for (var i = 0; i < result.counter.length; i++) {
							var lotId = result.counter[i].lotId;
							var id = result.counter[i].id;
							var testFile = result.counter[i].testFile;
							var endTimeStamp = result.counter[i].endTimeStamp;
							var unitId = result.counter[i].unitId;
							var curDieQty = result.counter[i].curDieQty;
							var flag = result.counter[i].flagDesc;
							//测试数据

							s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
								lotId + "</td><td>" +
								testFile + "</td><td>" +
								endTimeStamp + "</td><td>" +
								unitId + "</td><td>" +
								flag + "</td><td>" +
								+curDieQty +
								"</td></tr>";

							$("#sample5").append(s);

						}
						var set = [];
						$('table tr').each(function() {
							var row = [];

							$(this).find('td').each(function() {
								row.push($(this).text());
							});
							set.push(row);
						});

						//调用分页
						laypage.render({
							elem : 'demo20',
							count : result.counter.length,
							jump : function(obj) {
								//模拟渲染
								document.getElementById('biuuu_city_list').innerHTML = function() {
									var arr = [],
										thisData = set.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
									layui.each(thisData, function(index, item) {
										arr.push('<li>' + item + '</li>');
									});
									return arr.join('');
								}();
							}
						});

					});
					layer.closeAll();
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
			var lotId = $('#s').val();
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "zlook.action?methodstr=zLook3", //12.1 查询预设机台
				//提交的数据
				data : {
					"lotId" : lotId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();

					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var id = result.counter[i].id;
						var testFile = result.counter[i].testFile;
						var endTimeStamp = result.counter[i].endTimeStamp;
						var unitId = result.counter[i].unitId;
						var curDieQty = result.counter[i].curDieQty;
						var flag = result.counter[i].flagDesc;

						s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
							"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
							"</td></tr>";

						$("#sample5").append(s);

					}
					layer.closeAll();

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
		$("#ajaxD").click(function() {
			var ecount = $('#count option:selected').val();
			var co = parseInt($('#co').val());
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "zlook.action?methodstr=zLook", //12.1 查询预设机台
				//提交的数据
				data : {
					"ecount" : ecount, //每页显示条数
					"ecount2" : co
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();

					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var id = result.counter[i].id;
						var testFile = result.counter[i].testFile;
						var endTimeStamp = result.counter[i].endTimeStamp;
						var unitId = result.counter[i].unitId;
						var curDieQty = result.counter[i].curDieQty;
						var flag = result.counter[i].flagDesc;

						s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
							"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
							"</td></tr>";

						$("#sample5").append(s);

					}
					layer.closeAll();

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
			var ecount = $('#count option:selected').val();
			var cos = parseInt($('#cos').val());
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "zlook.action?methodstr=zLook", //12.1 查询预设机台
				//提交的数据
				data : {
					"ecount" : ecount, //每页显示条数
					"ecount2" : cos
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {

					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();

					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var id = result.counter[i].id;
						var testFile = result.counter[i].testFile;
						var endTimeStamp = result.counter[i].endTimeStamp;
						var unitId = result.counter[i].unitId;
						var curDieQty = result.counter[i].curDieQty;
						var flag = result.counter[i].flagDesc;

						s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
							"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
							"</td></tr>";

						$("#sample5").append(s);

					}
					layer.closeAll();

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
		$("#ajaxE").click(function() {

			var ecount = $('#count option:selected').val();
			var cos = parseInt($('#jump').val());
			var star = parseInt($('#coss').val());
			if (isNaN(star)) {
				layer.open({
					title : '信息提示',
					content : '还没输入跳转页码！'
				});

				return false;
			}
			if (star < 0) {
				layer.open({
					title : '信息提示',
					content : '页码不能小于1'
				});

				return false;
			}
			layer.load();
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "zlook.action?methodstr=zLook", //12.1 查询预设机台
				//提交的数据
				data : {
					"ecount" : ecount, //每页显示条数
					"ecount2" : cos,
					"star" : star
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == '页数过大！') {
						layer.open({
							title : '信息提示',
							content : '页数过大！'
						});
						return false;
					}
					var result = eval("(" + result + ")");
					$("tr[name='sss']").remove();
					for (var i = 0; i < result.counter.length; i++) {
						var lotId = result.counter[i].lotId;
						var id = result.counter[i].id;
						var testFile = result.counter[i].testFile;
						var endTimeStamp = result.counter[i].endTimeStamp;
						var unitId = result.counter[i].unitId;
						var curDieQty = result.counter[i].curDieQty;
						var flag = result.counter[i].flagDesc;

						s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
							"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
							"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
							"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
							"</td></tr>";

						$("#sample5").append(s);

					}
					layer.closeAll();
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
		$("#ajaxA").click();
	}
</script>
<body onload="check()">

	<div class="page-header">
		<input type="hidden" id="ajaxA" />
		<table align="left" width="30%" id="sample-table-1">
			<tr>
				<td>选择状态 <select id="sample"><option>请选择...</option>
						<option value="待分选">待分选</option>
						<option value="待剥料">待剥料</option></select>
				</td>
				<td>输入批次或测试档：<input type="text" onkeyup="this.value=this.value.toUpperCase()"
					id="s" name="lotId">
				</td>
				<td><button class="btn btn-primary" id="ajaxC">查询</button></td>
			</tr>
		</table>

		<table style.display="none"
			; class="table table-striped table-bordered table-hover" id="sample5"
			width="50%">
			<tr>
				<td>序号</td>
				<td>批次</td>
				<td>测试档</td>
				<td>结束时间</td>
				<td>底板号</td>
				<td>分选/分光</td>
				<td>剩余颗粒数</td>
			</tr>
		</table>
	</div>
	<div>
		<button class="btn btn-primary"
			onclick="downLoad('<%=request.getContextPath()%>/downloadZ.action?methodstr=batch')">下载中段数据</button>

	</div>
	<input type="hidden" value="3" id=sss /> 每页
	<select id="count"><option>10</option>
		<option>20</option>
		<option>30</option>
		<option>50</option>
	</select>条 &nbsp;&nbsp; &nbsp;&nbsp;跳转至
	<input type="text" size="3" id="coss" />页
	<input type="hidden" value="3" id="jump" />
	<button class="btn btn-primary" id="ajaxE">确定</button>
	<input type="hidden" value="1" id="co" />
	<button class="btn btn-primary" id="ajaxD">下一页</button>
	<input type="hidden" value="2" id="cos" />
	<button class="btn btn-primary" id="ajaxB">上一页</button>
</body>
</html>
<script type="text/javascript">
	$("#sample").change(function() {
		var flag = $('#sample option:selected').val();
		layer.load();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "zlook.action?methodstr=zLook2", //11.3
			//提交的数据
			data : {
				"flagDesc" : flag,
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作

			success : function(result) {

				$("tr[name='sss']").remove();
				var result = eval("(" + result + ")");
				for (var i = 0; i < result.counter.length; i++) {
					var lotId = result.counter[i].lotId;
					var id = result.counter[i].id;
					var testFile = result.counter[i].testFile;
					var endTimeStamp = result.counter[i].endTimeStamp;
					var unitId = result.counter[i].unitId;
					var curDieQty = result.counter[i].curDieQty;
					var flag = result.counter[i].flagDesc;

					s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
						"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
						"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
						"</td></tr>";

					$("#sample5").append(s);

				}
				layer.closeAll();
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
</script>
<script type="text/javascript">
	$("#count").change(function() {
		var ecount = $('#count option:selected').val();
		layer.closeAll();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "zlook.action?methodstr=zLook", //11.3
			//提交的数据
			data : {
				"ecount" : ecount //每页显示条数
			},
			//返回数据的格式
			datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {

				$("tr[name='sss']").remove();
				var result = eval("(" + result + ")");

				for (var i = 0; i < result.counter.length; i++) {
					var lotId = result.counter[i].lotId;
					var id = result.counter[i].id;
					var testFile = result.counter[i].testFile;
					var endTimeStamp = result.counter[i].endTimeStamp;
					var unitId = result.counter[i].unitId;
					var curDieQty = result.counter[i].curDieQty;
					var flag = result.counter[i].flagDesc;

					s = "<tr name='sss'><td>" + "<td'>" + id + "<td>" +
						"<input type='text' readonly='true'  name='lotId' id='lotId' value=" + lotId + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='testFile' id='testFile' value=" + testFile + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='endTimeStamp' id='endTimeStamp' value=" + endTimeStamp + " />" + "</td><td>" +
						"<input type='text' readonly='true'  name='unitId' id='unitId' value=" + unitId + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='flag' id='flag' value=" + flag + " />" + "</td><td>" +
						"<input type='text' readonly='true' name='curDieQty' id='curDieQty' value=" + curDieQty + " />" +
						"</td></tr>";

					$("#sample5").append(s);

				}
				layer.closeAll();
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
</script>

