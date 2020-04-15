
var qcchk = {}

qcchk.ddd = function() {

	var workId = $('#workId').val().trim();
	var aInput = document.getElementsByName("reelId");
	var reelId1 = document.getElementsByName("reelId1");
	if (aInput.length < 1) {
		layer.alert("没有数据！");
		return false;
	}
	for (var i = 0; i < aInput.length; i++) {

		if (aInput[i].parentNode.parentNode.style.backgroundColor != "red") {
			layer.alert("有片号没校验！" + aInput[i].value);
			return false;

		}
	}
	for (var i = 0; i < reelId1.length; i++) {
		if (reelId1[i].value == "") {
			layer.alert("有片号没校验！");
			return false;
		}

	}
	if ($("input[type='checkbox']").is(':checked') == false) {

		layer.msg("请选择出货指令", {
			icon : 2
		});
		return false;
	}

	var id = "[";
	$("input[name='checkbox']:checked").each(function() {

		id += '{"id":"' + $(this).parent("td").parent("tr").find("[name='id']").val() + '"},'
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	id = id.replace(reg, "");
	id += "]";

	var stockIdcheck = "[";
	$("input[name='checkbox']:checked").each(function() {

		stockIdcheck += '{"stockIdcheck":"' + $(this).parent("td").parent("tr").find("[name='stockIdcheck']").val() + '"},'
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	stockIdcheck = stockIdcheck.replace(reg, "");
	stockIdcheck += "]";
	$.ajax({
		//提交数据的类型 POST GET
		type : "POST",
		//提交的网址
		url : "cspku.action?methodstr=qcqueren", //5.1
		//提交的数据
		data : {
			"counter.id" : id,
			"counter.workId" : workId,
			"counter.stockId" : stockIdcheck
		},
		//返回数据的格式
		datatype : "json", //"xml", "html", "script", "json", "jsonp", "text".
		async : true, // 使用异步操作
		//成功返回之后调用的函数

		success : function(result) {

			layer.alert(result);
			return;

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