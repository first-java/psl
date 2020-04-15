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
<title>工程出库</title>
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
<script>
	function CheckInputIntFloat(oInput) {
		if ('' != oInput.value.replace(/\d{1,}\.{0,1}\d{0,}/, '')) {
			oInput.value = oInput.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' : oInput.value.match(/\d{1,}\.{0,1}\d{0,}/);
		}
	}
	function deleteRow(r) {
		$("#test111").val('');

		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luck = document.getElementsByName("qty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);

		}
		var luckElements = document.getElementsByName("reelId");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片</font></td>"
		$("#tt").append(ss);

		$("td[name='count']").remove();
		c = "<td name='count' style='color:red'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var reelId = $("#barcode1").prop("value");
			if (reelId.trim() == "") {
				layer.msg("还没录入底板号", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=proOut", //5.1
				//提交的数据
				data : {
					"counter.reelId" : reelId
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'error1') {
						layer.msg("备货失败，白光芯片不符合出货要求或白光芯片不存在！", {
							icon : 2
						})
						return false;
					}
					var result = eval("(" + result + ")");
					for (var i = 0; i < result.counter.length; i++) {
						var reelId = result.counter[i].reelId;
						var stockId = result.counter[i].stockId;
						var qty = result.counter[i].qty;

						s = "<tr name='sss'><td>" +
							"<input type='hidden' name='reelId' id='reelId' value=" + reelId + " />" + reelId + "</td><td>" +
							"<input type='hidden' name='stockId' id='stockId' value=" + stockId + " />" + stockId + "</td><td>" +
							"<input type='hidden' name='qty' id='qty' value=" + qty + " />" + qty + "</td><td>" +

							"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";

						var luckElements = document.getElementsByName("reelId");
						var tapeId = document.getElementById("barcode1").value;

						var qty1 = 0;
						var check = $("input[name='checkbox']:checked"); //选中的复选框
						check.each(function() {
							var row = $(this).parent("td").parent("tr");
							qty1 += parseInt(row.find("[name='qty1']").val()); //注意html()和val()

						});

						var lucks = document.getElementsByName("qty");

						var c = 0;
						for (var i = 0; i < luckElements.length; i++) {

							//获取元素的value值
							if (tapeId == luckElements[i].value) {
								layer.msg("数据重复！", {
									icon : 2
								})
								return false;
							}
						}
						for (var i = 0; i < luckElements.length; i++) {
							c += parseInt(parseInt(lucks[i].value)) ;
						}
						 
						$("td[name='s']").remove();
						ss = "<td name='s'><font size='5' color='red'>当前已扫" + (Number(luckElements.length) + 1) + "片<font size='8' color='red'></td>"
						$("#tt").append(ss);

					}
					$("td[name='s']").remove();
					ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length + 1) + "片<font size='8' color='red'></td>"
					$("#tt").append(ss);
					$("#sample-table-1").append(s);
					var count1 = 0;
					var luck = document.getElementsByName("qty");
					for (var i = 0; i < luck.length; i++) {
						count1 += Number(luck[i].value);
					}
					$("td[name='count']").remove();
					c = "<td name='count' ><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
					$("#tt").append(c);

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

			//	var stockId = $('select[name=stockId] option:selected').val();
			var reelId = "[";
			$("[name=reelId]").each(function() {
				reelId += '{"reelId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			reelId = reelId.replace(reg, "");
			reelId += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";



			var stockId = "[";
			$("[name=stockId]").each(function() {
				stockId += '{"stockId":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			stockId = stockId.replace(reg, "");
			stockId += "]";

			var stockIdcheck = "[";
			$("input[name='checkbox']:checked").each(function() {

				stockIdcheck += '{"stockIdcheck":"' + $(this).parent("td").parent("tr").find("[name='stockIdcheck']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			stockIdcheck = stockIdcheck.replace(reg, "");
			stockIdcheck += "]";
			
			var createTime = "[";
			$("input[name='checkbox']:checked").each(function() {

				createTime += '{"createTime":"' + $(this).parent("td").parent("tr").find("[name='createTime']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			createTime = createTime.replace(reg, "");
			createTime += "]";

			var id = "[";
			$("input[name='checkbox']:checked").each(function() {

				id += '{"id":"' + $(this).parent("td").parent("tr").find("[name='id']").val() + '"},'
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			id = id.replace(reg, "");
			id += "]";

			var workId = $("#workId").prop("value");


			var check = $("input[name='checkbox']:checked"); //选中的复选框
			check.each(function() {
				var row = $(this).parent("td").parent("tr");
				var client1 = row.find("[name='client']").val(); //注意html()和val()

			});
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "cspku.action?methodstr=proOutPut", //5.1
				//提交的数据
				data : {
					"counter.reelId" : reelId,
					"counter.stockId" : stockId,
					"counter.qty" : qty,
					"counter.stockIdcheck" : stockIdcheck,
					"counter.createTime" : createTime,
					"counter.id" : id,
					"counter.outWorkId" : workId
				},
				//返回数据的格式
				datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					layer.alert(result, function() {
						window.location.reload();
					});
					return false;
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
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#ajaxA").click();
	}
	function setFocus() {
		document.getElementById('barcode1').select();
	}
	// 两秒后模拟点击
	setTimeout(function() {
		// IE
		if (document.all) {
			document.getElementById("clickMe").click();
		}
		// 其它浏览器
		else {
			var e = document.createEvent("MouseEvents");
			e.initEvent("click", true, true);
			document.getElementById("clickMe").dispatchEvent(e);
		}
	}, 200);
</script>

</head>
<body>
	<input type="hidden" id="ajaxC" />
	<input type="hidden" id="test111" value="" />
	<div class="page-header">
		<table align="left">
			<tr>
				<td id="tt"></td>
			</tr>
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus " />
				<td>底板号： <input id="barcode1" type="text"
					onkeypress='if(event.keyCode ==13) t (this, 1);'
					onkeyup="this.value=this.value.toUpperCase ()">
					<button class="btn btn-primary " id="ajaxA" onclick="setFocus()">确认
					</button>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<!-- 5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>片号</th>
				<th>存货编码</th>
				<th>颗粒数（颗）</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%> " />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary " type="button" id="ajaxB" value="提交" />
</body>
</html>
