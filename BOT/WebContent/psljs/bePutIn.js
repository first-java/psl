
$(function() {
	$("#demo1").hide();
	$("#demo").hide();
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
})

function selectBacthByLotId() {
	var maxId = $("#batchLot").prop("value");
	if (!maxId.startsWith("BIN")) {
		layer.msg("批号不符合规范，请扫描BIN开头的批号！！！", {
			icon : 2
		});
		return;
	}
	$.post("csppailiao.action?methodstr=selectBacthByLotId", {
		"binUnit.batchLot" : maxId.trim()
	}, function(data) {
		var data = eval("(" + data + ")");
		if (data.counter.length == 0) {
			layer.alert("未找到输入的批号相关蓝膜信息！", function() {
				layer.closeAll();
				$("#batchLot").select();
				return;
			});

		} else {
			$("#demo").show();
		}
		for (var i = 0; i < data.counter.length; i++) {

			var unitId = data.counter[i].unitId;
			var qty = data.counter[i].qty;
			var binId = data.counter[i].binId;
			var lotType = data.counter[i].lotType;
			var specId = data.counter[i].specId;

			s = "<tr name='sss'><td>" + (i + 1) + "</td><td>" +
				"<input type='hidden' name='unit'  value=" + unitId + " />" + unitId + "</td><td>" +
				qty + "</td><td>" +
				lotType + "</td><td>" +
				binId + "</td><td>" +
				specId + "</td></tr>";
			$("#demo").append(s);
			$("#demo").show();
			$("#unitId").select();

		}

	});
}
function selectBinUnit() {
	var unitId = $("#unitId").prop("value");
	unitId = unitId.trim();
	var batchLot = $("#batchLot").prop("value");
	batchLot = batchLot.trim();
	var luckElements = document.getElementsByName("unitId");
	var odd = Number(luckElements.length) + 1;
	if (batchLot == "") {
		layer.alert("批号不能为空，输入片号前请先输入批号！", function() {
			layer.closeAll();
			$("#batchLot").select();
		});
		return;
	}
	if (unitId == "") {
		layer.alert("请输入片号！", function() {
			layer.closeAll();
			$("#unitId").select();
		});
		return;
	}
	var unit = document.getElementsByName("unit");
	for (var i = 0; i < unit.length; i++) {
		var y = "";
		if (unitId == unit[i].value) {
			y = "1";
			break;
		}
	}
	if (y == "") {
		layer.msg("该片号不存在下列列表！", {
			icon : 2
		});
		return;
	}

	var maxId = luckElements.length
	$.post("csppailiao.action?methodstr=selectShelfByLotId", {
		"binUnit.batchLot" : batchLot,
		"binUnit.unitId" : unitId,
		"binUnit.maxId" : maxId,
		"binUnit.odd" : odd
	}, function(data) {
		var luckElements = document.getElementsByName("unitId");
		if (data.startsWith("ERROR:")) {
			layer.msg(data, {
				icon : 2
			});
			return;
		}
		var data = eval("(" + data + ")");

		s = "<tr name='sss'><td>" + (Number(luckElements.length) + 1) + "</td><td>" +
			"<input type='hidden' name='unitId'   value=" + data.counter[0].unitId + " />" + data.counter[0].unitId + "</td><td>" +
			"<input type='hidden' name='pno'  value=" + data.counter[0].pno + " />" + data.counter[0].pno + "</td><td>" +
			"<input type='hidden' name='lotType'  value=" + data.counter[0].lotType + " />" + data.counter[0].lotType + "</td><td>" +
			"<input type='hidden' name='qty'   value=" + data.counter[0].qty + " />" + data.counter[0].qty + "</td><td>" +
			"<input type='hidden' name='specId'  value=" + data.counter[0].specId + " />" + data.counter[0].specId + "</td><td>" +
			"<input type='hidden' name='binId'   value=" + data.counter[0].binId + " />" + data.counter[0].binId + "</td><td>" +
			"<button type='button' onclick='deleteRow(this)' class='layui-btn layui-btn-sm layui-btn-normal'><i class='layui-icon'></i> 删除</button></tr>";


		var unitId1 = document.getElementById("unitId").value;
		unitId1 = unitId1.trim();
		for (var i = 0; i < luckElements.length; i++) {
			//获取元素的value值
			if (unitId1 == luckElements[i].value) {
				layer.alert("数据重复！", function() {
					layer.closeAll();
					$("#unitId").select();
				});
				return false;
			}
		}
		var unit = document.getElementsByName("unit");
		unitId.trim();
		for (var i = 0; i < unit.length; i++) {
			if (unitId == unit[i].value) {
				//$("#" + id + "").attr("disabled", "disabled");
				unit[i].parentNode.parentNode.style.background = 'red';
				$("#demo1").append(s);
				$("#demo1").show();
				$("#unitId").select();
				return;
			}
		}
	})

}

function deleteRow(r) {
	var i = r.parentNode.parentNode.rowIndex;
	var unitId = document.getElementsByName("unitId");
	var unit = document.getElementsByName("unit");



	for (var j = 0; j < unit.length; j++) {
		if (unitId[i - 1].value == unit[j].value) {

			unit[j].parentNode.parentNode.style.background = 'black';
			break;

		}

	}
	document.getElementById('demo1').deleteRow(i);
}
function putIn() {
	var lo = layer.load();
	var aInput = document.getElementsByName("unit");
	if (aInput.length < 1) {
		layer.msg("没有数据提交，不要瞎点！", {
			icon : 2
		});
		layer.close(lo);
		$("#unitId").select();
		return false;
	}
	for (var i = 0; i < aInput.length; i++) {

		if (aInput[i].parentNode.parentNode.style.backgroundColor != "red") {
			layer.alert("有片号没校验！" + aInput[i].value);
			layer.close(lo);
			return false;
		}
	}
	var unitId = "[";
	$("[name=unitId]").each(function() {
		unitId += '{"unitId":"' + this.value + '"},';
	});

	var reg = /,$/gi;
	unitId = unitId.replace(reg, "");
	unitId += "]";

	var binId = "[";
	$("[name=binId]").each(function() {
		binId += '{"binId":"' + this.value + '"},';
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	binId = binId.replace(reg, "");
	binId += "]";

	var specId = "[";
	$("[name=specId]").each(function() {
		specId += '{"specId":"' + this.value + '"},';
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	specId = specId.replace(reg, "");
	specId += "]";

	var qty = "[";
	$("[name=qty]").each(function() {
		qty += '{"qty":"' + this.value + '"},';
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	qty = qty.replace(reg, "");
	qty += "]";


	var lotType = "[";
	$("[name=lotType]").each(function() {
		lotType += '{"lotType":"' + this.value + '"},';
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	lotType = lotType.replace(reg, "");
	lotType += "]";


	var pno = "[";
	$("[name=pno]").each(function() {
		pno += '{"pno":"' + this.value + '"},';
	});
	//去掉最后一个"," 
	var reg = /,$/gi;
	pno = pno.replace(reg, "");
	pno += "]";
	var workId = $("#workId").prop("value");
	var batchLot = $("#batchLot").prop("value");
	batchLot = batchLot.trim();
	$.post("csppailiao.action?methodstr=saveUnit", {
		"binUnit.unitId" : unitId,
		"binUnit.specId" : specId,
		"binUnit.qty" : qty,
		"binUnit.binId" : binId,
		"binUnit.workId" : workId,
		"binUnit.lotType" : lotType,
		"binUnit.pno" : pno,
		"binUnit.batchLot" : batchLot
	}, function(data) {
		layer.close(lo);
		layer.alert(data, function() {
			window.location.reload();
		});

	});
}