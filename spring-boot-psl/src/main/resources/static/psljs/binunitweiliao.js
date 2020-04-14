$(function() {
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)

})

function tailingputin() {
	var unitId = $("#unitId").prop("value");

	$.post("/tailing/tailingputin", {
		"unitId" : unitId.trim()
	}, function(data) {
		if (data.code == 1) {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#unitId").select();
				return;
			});
		}
		var pno = data.code[0].PNO;
		var lotType = data.code[0].LOTTYPE;
		var specId = data.code[0].SPECID;
		var binId = data.code[0].BINID;
		var qty = data.code[0].QTY;
		var batchLot = data.code[0].BATCHLOT;
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

	$.post("/tailing/wputIn", {
		"unitId" : unitId,
		"lotType" : lotType,
		"binId" : binId,
		"lotId" : batchLot,
		"specId" : specId,
		"qty" : qty,
		"workId" : workId,
		"pno" : pno
	}, function(data) {
		layer.alert(data.msg);
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