$(function() {
	$("#demo").hide();
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
})

function selectUnit() {
	var unitId = $("#unitId").prop("value");

	if (unitId == "") {
		layer.msg("请输入流水号！", {
			icon : 2
		});
		return;
	}
	$.post("/selectUntiId", {
		"unitId" : unitId.trim()
	}, function(data) {
		if (data.code == 2) {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#unitId").select();
				return;
			});
		} else {
			$("#yfQty").select();
		}
	});
}
function addUnit() {

	var unitId = $("#unitId").prop("value");
	unitId = unitId.trim();
	var yfQty = $("#yfQty").prop("value");
	yfQty = yfQty.trim();

	if (unitId == "") {
		layer.alert("流水号不能为空，输入数量前请先输入流水号！", function() {
			layer.closeAll();
			$("#unitId").select();
		});
		return;
	}
	if (yfQty == "") {
		layer.alert("请输入数量！", function() {
			layer.closeAll();
			$("#unitId").select();
		});
		return;
	}
	var luckElements = document.getElementsByName("unitId");
	for (var i = 0; i < luckElements.length; i++) {
		// 获取元素的value值
		if (unitId == luckElements[i].value) {
			layer.alert("数据重复！", function() {
				layer.closeAll();
				$("#unitId").select();
			});
			return false;
		}
	}
	$("#demo").show();
	s = "<tr name='sss'><td>"
			+ (Number(luckElements.length) + 1)
			+ "</td><td>"
			+ "<input type='hidden' name='unitId'"
			+ "value='"
			+ unitId
			+ "' />"
			+ unitId
			+ "</td><td>"
			+ "<input type='hidden' name='yfQty'  value="
			+ yfQty
			+ " />"
			+ yfQty
			+ "</td> <td>"
			+ "<button type='button' onclick='deleteRow(this)' class='layui-btn layui-btn-sm layui-btn-normal'><i class='layui-icon'></i> 删除</button></tr>";

	$("#demo").append(s);
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
	document.getElementById('demo').deleteRow(i);
}

function putIn() {
	//var lo = layer.load();
	var aInput = document.getElementsByName("unitId");
	if (aInput.length < 1) {
		layer.msg("没有数据提交，不要瞎点！", {
			icon : 2
		});
		$("#unitId").select();
		return false;
	}

	var unitId = "[";
	$("[name=unitId]").each(function() {
		unitId += '{"unitId":"' + this.value + '"},';
	});

	var reg = /,$/gi;
	unitId = unitId.replace(reg, "");
	unitId += "]";

	var yfQty = "[";
	$("[name=yfQty]").each(function() {
		yfQty += '{"yfQty":"' + this.value + '"},';
	});

	var reg = /,$/gi;
	yfQty = yfQty.replace(reg, "");
	yfQty += "]";
	var workId = $("#workId").prop("value");

	$.post("/saveUnit", {
		"unitId" : unitId,
		"yfQty" : yfQty,
		"workId" : workId
	}, function(data) {
		layer.close(lo);
		layer.alert(data.code, function() {
			window.location.reload();
		});

	});
}