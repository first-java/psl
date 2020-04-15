
$(function() {
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)

})

function tailingputin() {
	var unitId = $("#unitId").prop("value");

	$.post("csppailiao.action?methodstr=tailingputin", {
		"binUnit.unitId" : unitId.trim()
	}, function(data) {
		if (data.startsWith("ERROR")) {
			layer.alert(data, function() {
				layer.closeAll();
				$("#unitId").select();
				return;
			});
		}
		var data = eval("(" + data + ")");

		var pno = data.counter[0].pno;
		var lotType = data.counter[0].lotType;
		var specId = data.counter[0].specId;
		var binId = data.counter[0].binId;
		var qty = data.counter[0].qty;
		var batchLot = data.counter[0].batchLot;
		$("#lotType").val(lotType)
		$("#specId").val(specId)
		$("#binId").val(binId)
		$("#qty1").val(qty)
		$("#batchLot").val(batchLot)
		$("#pno").val(pno)
		$("#qty").select();

	});
}
function wputIn() {
	var unitId = $("#unitId").prop("value");
	unitId = unitId.trim();
	var pno = $("#pno").prop("value");
	var lotType = $("#lotType").prop("value");
	var specId = $("#specId").prop("value");
	var batchLot = $("#batchLot").prop("value");
	var binId = $("#binId").prop("value");
	pno = pno.trim();
	var qty = $("#qty").prop("value");
	var workId = $("#workId").prop("value");
	if (unitId == "") {
		layer.alert("请输入片号！", function() {
			layer.closeAll();
			$("#unitId").select();
		});
		return;
	}

	$.post("csppailiao.action?methodstr=wputIn", {
		"binUnit.unitId" : unitId,
		"binUnit.lotType" : lotType,
		"binUnit.binId" : binId,
		"binUnit.lotId" : batchLot,
		"binUnit.specId" : specId,
		"binUnit.qty" : qty,
		"binUnit.workId" : workId,
		"binUnit.pno" : pno
	}, function(data) {
		layer.alert(data);

	})
}
function chs() {
	var qty1 = $("#qty1").prop("value");
	var qty = $("#qty").prop("value");
	if (Number(qty) >= qty1) {
		layer.alert("输入的数量只能小于等于原始数量！")
		$("#qty").val(qty1)
	}
}