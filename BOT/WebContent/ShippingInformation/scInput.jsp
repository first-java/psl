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
<title>首尔半导体芯片入库</title>
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
		var i = r.parentNode.parentNode.rowIndex;
		document.getElementById('sample-table-1').deleteRow(i);
		var luck = document.getElementsByName("qty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);

		}
		var luckElements = document.getElementsByName("lotNo");
		$("td[name='s']").remove();
		ss = "<td name='s'><font size='5' color='red'>当前已扫" + (luckElements.length) + "片</font></td>"
		$("#tt").append(ss);

		$("td[name='count']").remove();
		c = "<td name='count' style='color:red'><font size='5' color='red'>总" + count1 + "颗粒</font></td>"
		$("#tt").append(c);

	}
	$(document).ready(function() {

		$("#ajaxA").click(function() {

			var type = $("#barcode1").prop("value");
			if (type.trim() == "") {
				layer.msg("还没录入TYPE", {
					icon : 2
				});
				document.getElementById('barcode1').focus();
				return false;
			}
			var t = type.split(";");
			var pn = t[0];
			var lotNo = t[1];
			var qty = t[2];


			var wdmin = t[4];
			var wdtyp = t[5];
			var wdmax = t[6];
			var pomin = t[7];
			var potyp = t[8];
			var pomax = t[9];
			var vfmin = t[10];
			var vftyp = t[11];
			var vfmax = t[12];
			var irmin = t[13];
			var irtyp = t[14];
			var irmax = t[15];
			var tovmin = t[16];
			var tovtyp = t[17];
			var tovmax = t[18];


			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=scLotNo", //5.1
				//提交的数据
				data : {
					"shippingInformation.lotNo2" : lotNo
				},
				//返回数据的格式
				datatype : "jsonp", //"xml", "html", "script", "json", "jsonp", "text".
				async : true, // 使用异步操作
				//成功返回之后调用的函数

				success : function(result) {
					if (result == 'error') {
						layer.msg("该片已经入库！", {
							icon : 2
						});
						$('.page-header input').val('');
						return false;
					}

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='type' value=" + pn + " />" + pn + "</td><td>" +
						"<input type='hidden' name='lotNo' value=" + lotNo + " />" + lotNo + "</td><td>" +
						"<input type='hidden' name='qty' value=" + qty + " />" + qty + "</td>" +

						"<input type='hidden' name='scWdMin' value=" + wdmin + " />" +
						"<input type='hidden' name='scWdTyp' value=" + wdtyp + " />" +
						"<input type='hidden' name='scWdMax' value=" + wdmax + " />" +

						"<input type='hidden' name='scPoMin' value=" + pomin + " />" +
						"<input type='hidden' name='scPoTyp' value=" + potyp + " />" +
						"<input type='hidden' name='scPoMax' value=" + pomax + " />" +

						"<input type='hidden' name='scVfMin' value=" + vfmin + " />" +
						"<input type='hidden' name='scVfTyp' value=" + vftyp + " />" +
						"<input type='hidden' name='scVfMax' value=" + vfmax + " />" +

						"<input type='hidden' name='scIrMin' value=" + irmin + " />" +
						"<input type='hidden' name='scIrTyp' value=" + irtyp + " />" +
						"<input type='hidden' name='scIrMax' value=" + irmax + " />" +

						"<input type='hidden' name='scTovMin' value=" + tovmin + " />" +
						"<input type='hidden' name='scTovTyp' value=" + tovtyp + " />" +
						"<input type='hidden' name='scTovMax' value=" + tovmax + " /><td>" +

						"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";
					var luckElements = document.getElementsByName("lotNo");
					var tapeId = lotNo;


					for (var i = 0; i < luckElements.length; i++) {

						//获取元素的value值
						if (tapeId == luckElements[i].value) {
							layer.msg("数据重复！", {
								icon : 2
							})
							return false;
						}

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
					document.getElementById('barcode1').select();
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

			var lotNo = "[";
			$("[name=lotNo]").each(function() {
				lotNo += '{"lotNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotNo = lotNo.replace(reg, "");
			lotNo += "]";

			var type = "[";
			$("[name=type]").each(function() {
				type += '{"type":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			type = type.replace(reg, "");
			type += "]";

			var qty = "[";
			$("[name=qty]").each(function() {
				qty += '{"qty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			qty = qty.replace(reg, "");
			qty += "]";

			var scWdMin = "[";
			$("[name=scWdMin]").each(function() {
				scWdMin += '{"scWdMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scWdMin = scWdMin.replace(reg, "");
			scWdMin += "]";


			var scWdTyp = "[";
			$("[name=scWdTyp]").each(function() {
				scWdTyp += '{"scWdTyp":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scWdTyp = scWdTyp.replace(reg, "");
			scWdTyp += "]";


			var scWdMax = "[";
			$("[name=scWdMax]").each(function() {
				scWdMax += '{"scWdMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scWdMax = scWdMax.replace(reg, "");
			scWdMax += "]";

			var scPoMin = "[";
			$("[name=scPoMin]").each(function() {
				scPoMin += '{"scPoMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scPoMin = scPoMin.replace(reg, "");
			scPoMin += "]";


			var scPoTyp = "[";
			$("[name=scPoTyp]").each(function() {
				scPoTyp += '{"scPoTyp":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scPoTyp = scPoTyp.replace(reg, "");
			scPoTyp += "]";


			var scPoMax = "[";
			$("[name=scPoMax]").each(function() {
				scPoMax += '{"scPoMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scPoMax = scPoMax.replace(reg, "");
			scPoMax += "]";


			var scVfMin = "[";
			$("[name=scVfMin]").each(function() {
				scVfMin += '{"scVfMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scVfMin = scVfMin.replace(reg, "");
			scVfMin += "]";


			var scVfTyp = "[";
			$("[name=scVfTyp]").each(function() {
				scVfTyp += '{"scVfTyp":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scVfTyp = scVfTyp.replace(reg, "");
			scVfTyp += "]";

			var scVfMax = "[";
			$("[name=scVfMax]").each(function() {
				scVfMax += '{"scVfMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scVfMax = scVfMax.replace(reg, "");
			scVfMax += "]";

			var scIrMin = "[";
			$("[name=scIrMin]").each(function() {
				scIrMin += '{"scIrMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scIrMin = scIrMin.replace(reg, "");
			scIrMin += "]";

			var scIrTyp = "[";
			$("[name=scIrMin]").each(function() {
				scIrTyp += '{"scIrTyp":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scIrTyp = scIrTyp.replace(reg, "");
			scIrTyp += "]";

			var scIrMax = "[";
			$("[name=scIrMax]").each(function() {
				scIrMax += '{"scIrMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scIrMax = scIrMax.replace(reg, "");
			scIrMax += "]";

			var scTovMin = "[";
			$("[name=scTovMin]").each(function() {
				scTovMin += '{"scTovMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scTovMin = scTovMin.replace(reg, "");
			scTovMin += "]";

			var scTovTyp = "[";
			$("[name=scTovTyp]").each(function() {
				scTovTyp += '{"scTovTyp":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scTovTyp = scTovTyp.replace(reg, "");
			scTovTyp += "]";

			var scTovMax = "[";
			$("[name=scTovMax]").each(function() {
				scTovMax += '{"scTovMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			scTovMax = scTovMax.replace(reg, "");
			scTovMax += "]";

			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=scPutIn", //11.2
				//提交的数据
				data : {
					"shippingInformation.lotNo2" : lotNo,
					"shippingInformation.workId" : workId,
					"shippingInformation.qty" : qty,
					"shippingInformation.type" : type,
					"shippingInformation.scWdMin" : scWdMin,
					"shippingInformation.scWdTyp" : scWdTyp,
					"shippingInformation.scWdMax" : scWdMax,

					"shippingInformation.scPoMin" : scPoMin,
					"shippingInformation.scPoTyp" : scPoTyp,
					"shippingInformation.scPoMax" : scPoMax,

					"shippingInformation.scVfMin" : scVfMin,
					"shippingInformation.scVfTyp" : scVfTyp,
					"shippingInformation.scVfMax" : scVfMax,

					"shippingInformation.scIrMin" : scIrMin,
					"shippingInformation.scIrTyp" : scIrTyp,
					"shippingInformation.scIrMax" : scIrMax,

					"shippingInformation.scTovMin" : scTovMin,
					"shippingInformation.scTovTyp" : scTovTyp,
					"shippingInformation.scTovMax" : scTovMax
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
<script>
	function check() {
		var workId = $("#workId").prop("value");
		layer.load();
		$.ajax({
			//提交数据的类型 POST GET
			type : "POST",
			//提交的网址
			url : "ShippingInformationC.action?methodstr=select1",
			//提交的数据
			data : {
				"shippingInformation.workId" : workId
			},
			//返回数据的格式
			datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
			async : true, // 使用异步操作
			//成功返回之后调用的函数

			success : function(result) {
				if (result == 'noUser') {

					layer.open({
						area : [ '500px', '300px' ],
						closeBtn : 0,
						type : 1,
						content : '很抱歉，您無此權限' //这里content是一个普通的String
					});
					return false;

				} else {
					layer.closeAll();
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
	}
</script>
<script type="text/javascript">

	function t() {
		$("#ajaxA").click();
	}
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body>

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">请扫二维码：<input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t();'
					onkeyup="this.value=this.value.toUpperCase()">
					<button class="btn btn-primary" id="ajaxA" onclick="setFocus()">确认</button>
				</td>
			</tr>
		</table>
	</div>
	<br>

	<!--5.2  -->
	<table class="table table-striped table-bordered table-hover"
		id="sample-table-1" width="50%">
		<thead>
			<tr>
				<th>P/N码</th>
				<th>片号</th>
				<th>数量</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId%>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交"
		onclick="check()" />

</body>
</html>

