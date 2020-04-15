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
<title>三安入库</title>
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
		var luck = document.getElementsByName("sanQty");
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

			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=sanLotNo", //5.1
				//提交的数据
				data : {
					"shippingInformation.type" : type
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

					var result = eval("(" + result + ")");
					var sanType = result.sf[0];
					var lotNo = result.sf[1];
					var sanSpec = result.sf[2];
					var sanQty = result.sf[3];
					var sanVfMin = result.sf[4];
					var sanVfAvg = result.sf[5];
					var sanVfMax = result.sf[6];
					var sanVfStd = result.sf[7];
					var sanIvMin = result.sf[8];
					var sanIvAvg = result.sf[9];
					var sanIvMax = result.sf[10];
					var sanIvStd = result.sf[11];
					var sanWdMin = result.sf[12];
					var sanWdAvg = result.sf[13];
					var sanWdMax = result.sf[14];
					var sanWdStd = result.sf[15];
					var sanOther = result.sf[16];
					var sandate = result.sf[17];

					s = "<tr name='sss'><td>" +
						"<input type='hidden' name='sanType' value=" + sanType + " />" + sanType + "</td><td>" +
						"<input type='hidden' name='lotNo' value=" + lotNo + " />" + lotNo + "</td><td>" +
						"<input type='hidden' name='sanSpec' value=" + sanSpec + " />" + sanSpec + "</td><td>" +
						"<input type='hidden' name='sanQty' value=" + sanQty + " />" + sanQty + "</td><td>" +
						"<input type='hidden' name='sanVfMin' value=" + sanVfMin + " />" + sanVfMin + "</td><td>" +
						"<input type='hidden' name='sanVfAvg' value=" + sanVfAvg + " />" + sanVfAvg + "</td><td>" +
						"<input type='hidden' name='sanVfMax' value=" + sanVfMax + " />" + sanVfMax + "</td><td>" +
						"<input type='hidden' name='sanVfStd' value=" + sanVfStd + " />" + sanVfStd + "</td><td>" +
						"<input type='hidden' name='sanIvMin' value=" + sanIvMin + " />" + sanIvMin + "</td><td>" +
						"<input type='hidden' name='sanIvAvg' value=" + sanIvAvg + " />" + sanIvAvg + "</td><td>" +
						"<input type='hidden' name='sanIvMax' value=" + sanIvMax + " />" + sanIvMax + "</td><td>" +
						"<input type='hidden' name='sanIvStd' value=" + sanIvStd + " />" + sanIvStd + "</td><td>" +
						"<input type='hidden' name='sanWdMin' value=" + sanWdMin + " />" + sanWdMin + "</td><td>" +
						"<input type='hidden' name='sanWdAvg' value=" + sanWdAvg + " />" + sanWdAvg + "</td><td>" +
						"<input type='hidden' name='sanWdMax' value=" + sanWdMax + " />" + sanWdMax + "</td><td>" +
						"<input type='hidden' name='sanWdStd' value=" + sanWdStd + " />" + sanWdStd + "</td><td>" +
						"<input type='hidden' name='sanOther' value=" + sanOther + " />" + sanOther + "</td><td>" +
						"<input type='hidden' name='sandate' value=" + sandate + " />" + sandate + "</td><td>" +
						"<input type='button'class='btn btn-primary' onclick='deleteRow(this)' value='移除' /></td></tr>";
					var luckElements = document.getElementsByName("lotNo");
					var tapeId = document.getElementById("barcode1").value;
					var lotid = tapeId.substr(10, 17);

					for (var i = 0; i < luckElements.length; i++) {

						//获取元素的value值
						if (lotid == luckElements[i].value) {
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
					var luck = document.getElementsByName("sanQty");
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
			var sanType = "[";
			$("[name=sanType]").each(function() {
				sanType += '{"sanType":"' + this.value + '"},';
			});
			var reg = /,$/gi;
			sanType = sanType.replace(reg, "");
			sanType += "]";



			var lotNo = "[";
			$("[name=lotNo]").each(function() {
				lotNo += '{"lotNo":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			lotNo = lotNo.replace(reg, "");
			lotNo += "]";



			var sanSpec = "[";
			$("[name=sanSpec]").each(function() {
				sanSpec += '{"sanSpec":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanSpec = sanSpec.replace(reg, "");
			sanSpec += "]";





			var sanQty = "[";
			$("[name=sanQty]").each(function() {
				sanQty += '{"sanQty":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanQty = sanQty.replace(reg, "");
			sanQty += "]";




			var sanVfMin = "[";
			$("[name=sanVfMin]").each(function() {
				sanVfMin += '{"sanVfMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanVfMin = sanVfMin.replace(reg, "");
			sanVfMin += "]";



			var sanVfAvg = "[";
			$("[name=sanVfAvg]").each(function() {
				sanVfAvg += '{"sanVfAvg":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanVfAvg = sanVfAvg.replace(reg, "");
			sanVfAvg += "]";



			var sanVfMax = "[";
			$("[name=sanVfMax]").each(function() {
				sanVfMax += '{"sanVfMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanVfMax = sanVfMax.replace(reg, "");
			sanVfMax += "]";



			var sanVfStd = "[";
			$("[name=sanVfStd]").each(function() {
				sanVfStd += '{"sanVfStd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanVfStd = sanVfStd.replace(reg, "");
			sanVfStd += "]";



			var sanIvMin = "[";
			$("[name=sanIvMin]").each(function() {
				sanIvMin += '{"sanIvMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanIvMin = sanIvMin.replace(reg, "");
			sanIvMin += "]";

			var sanIvAvg = "[";
			$("[name=sanIvAvg]").each(function() {
				sanIvAvg += '{"sanIvAvg":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanIvAvg = sanIvAvg.replace(reg, "");
			sanIvAvg += "]";

			var sanIvMax = "[";
			$("[name=sanIvMax]").each(function() {
				sanIvMax += '{"sanIvMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanIvMax = sanIvMax.replace(reg, "");
			sanIvMax += "]";

			var sanIvStd = "[";
			$("[name=sanIvStd]").each(function() {
				sanIvStd += '{"sanIvStd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanIvStd = sanIvStd.replace(reg, "");
			sanIvStd += "]";

			var sanWdMin = "[";
			$("[name=sanWdMin]").each(function() {
				sanWdMin += '{"sanWdMin":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanWdMin = sanWdMin.replace(reg, "");
			sanWdMin += "]";

			var sanWdAvg = "[";
			$("[name=sanWdAvg]").each(function() {
				sanWdAvg += '{"sanWdAvg":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanWdAvg = sanWdAvg.replace(reg, "");
			sanWdAvg += "]";

			var sanWdMax = "[";
			$("[name=sanWdMax]").each(function() {
				sanWdMax += '{"sanWdMax":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanWdMax = sanWdMax.replace(reg, "");
			sanWdMax += "]";

			var sanWdStd = "[";
			$("[name=sanWdStd]").each(function() {
				sanWdStd += '{"sanWdStd":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanWdStd = sanWdStd.replace(reg, "");
			sanWdStd += "]";

			var sanOther = "[";
			$("[name=sanOther]").each(function() {
				sanOther += '{"sanOther":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sanOther = sanOther.replace(reg, "");
			sanOther += "]";

			var sandate = "[";
			$("[name=sandate]").each(function() {
				sandate += '{"sandate":"' + this.value + '"},';
			});
			//去掉最后一个"," 
			var reg = /,$/gi;
			sandate = sandate.replace(reg, "");
			sandate += "]";
			var workId = $("#workId").prop("value");
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : "ShippingInformationC.action?methodstr=putIn4", //11.2
				//提交的数据
				data : {
					"shippingInformation.sanType" : sanType,
					"shippingInformation.lotNo" : lotNo,
					"shippingInformation.sanSpec" : sanSpec,
					"shippingInformation.sanQty" : sanQty,
					"shippingInformation.sanVfMin" : sanVfMin,
					"shippingInformation.sanVfAvg" : sanVfAvg,
					"shippingInformation.sanVfMax" : sanVfMax,
					"shippingInformation.sanVfStd" : sanVfStd,
					"shippingInformation.sanIvMin" : sanIvMin,
					"shippingInformation.sanIvAvg" : sanIvAvg,
					"shippingInformation.sanIvMax" : sanIvMax,
					"shippingInformation.sanIvStd" : sanIvStd,
					"shippingInformation.sanWdMin" : sanWdMin,
					"shippingInformation.sanWdAvg" : sanWdAvg,
					"shippingInformation.sanWdStd" : sanWdStd,
					"shippingInformation.sanWdMax" : sanWdMax,
					"shippingInformation.sanOther" : sanOther,
					"shippingInformation.workId" : workId,
					"shippingInformation.sandate" : sandate
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
	function t(obj, id) {
		var idd = Number(id) + 1;
		$("#barcode" + idd + "").select();
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

	$(document).keypress(function(e) {
		// 回车键事件  
		/* if (e.which == 13) {
			$("#ajaxA").click();
			document.getElementById('form-field-icon-1').focus()
		} */
	});
</script>
<style type="text/css">
input {
	border: none;
}
</style>
</head>
<body onload="check()">

	<div class="page-header">
		<table align="left">
			<tr>
				<input id="clickMe" type="hidden" onclick="setFocus()"
					value="Set focus" />

				<td id="tt">扫描条码： <input id="barcode1" type="text"
					onkeypress='if(event.keyCode==13) t(this,1);'
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
				<th>芯片类型</th>
				<th>片号</th>
				<th>规格</th>
				<th>数量</th>
				<th>VFMIN</th>
				<th>VFAVG</th>
				<th>VFMAX</th>
				<th>VFSTD</th>
				<th>IVMIN</th>
				<th>IVAVG</th>
				<th>IVMAX</th>
				<th>IVSTD</th>
				<th>WDMIN</th>
				<th>WDAVG</th>
				<th>WDMAX</th>
				<th>WDSTD</th>
				<th>OTHER</th>
				<th>时间</th>
				<th>操作</th>
				<input type="hidden" name="workId" id="workId" value="<%=workId %>" />
			</tr>
		</thead>
	</table>
	<input class="btn btn-primary" type="button" id="ajaxB" value="提交" />

</body>
</html>
<script>
	$("#barcode3").blur(function() {

		$("#ajaxA").click();
	});
</script>
<script>
	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//常规用法
		laydate.render({
			elem : '#test1'
		});

		//常规用法
		laydate.render({
			elem : '#test2'
		});


	});
</script>