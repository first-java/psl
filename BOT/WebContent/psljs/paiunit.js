/**蓝膜派贴待机
*/
$(function() {

	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)

	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		$.post("csppailiao.action?methodstr=selectBinUnitEqpt", {
		}, function(data) {
			var code = eval("(" + data + ")");
			console.log("data:" + data);
			for (var i = 0; i < code.counter.length; i++) {
				var eqpt = code.counter[i].eqpt;
				ss = "<option value=" + eqpt + ">" + eqpt + "</option>"
				$("#bianEqpt").append(ss);
			}
			form.render();
		});
	})

})

$(function() {
	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		$("#divlotType").hide();
		$("#divspecId").hide();
		$("#divbinId").hide();
		$("#divstatus").hide();
		$("#divbdLotType").hide();
		$("#pwdBtn").hide();
		$("#divtable").hide();

		form.on('select(modules)', function(data) {
			proviceId = data.value;
			proviceName = data.elem[data.elem.selectedIndex].text

			$.post("csppailiao.action?methodstr=selectBinUnitEqptStatus", {
				"binUnit.eqpt" : proviceName
			}, function(data) {
				var code = eval("(" + data + ")");
				console.log("data:" + data);
				var lotType = code.counter[0].lotType;
				var binId = code.counter[0].binId;
				var specId = code.counter[0].specId;
				var bdLotId = code.counter[0].bdLotId;
				var status = code.counter[0].status;
				if (status == "") {
					$("#divstatus").show();
					$("#status").val("待机中。。。")
					$("#lotType").val("")
					$("#specId").val("")
					$("#binId").val("")
					$("#divlotType").hide();
					$("#divspecId").hide();
					$("#divbinId").hide();
					$("#divbdLotType").hide();

				} else {
					$("#status").val("运行中。。。")
					$("#lotType").val("")
					$("#specId").val("")
					$("#binId").val("")
					$("#bdLotType").val("")
					$("#lotType").val(lotType)
					$("#specId").val(specId)
					$("#binId").val(binId)
					$("#bdLotId").val(bdLotId)

					$("#divlotType").show();
					$("#divspecId").show();
					$("#divbinId").show();
					$("#divstatus").show();
					$("#divbdLotType").show();
				}
				/*var table = document.getElementById("demo");
				while (table.hasChildNodes()) {
					table.removeChild(table.lastElementChild)
				}*/
				$("#unitId").select();
				$("#pwdBtn").hide();
			});


		});
	})

})

function tailingputin() {
	var lotType = $("#lotType").prop("value");
	var binId = $("#binId").prop("value");
	var specId = $("#specId").prop("value");

	var unitId = $("#unitId").prop("value");
	var status = $("#status").prop("value");
	var lotId = $("select[name='modules']").val();

	$("#pwdBtn").show();
	$.post("csppailiao.action?methodstr=selectBinUnitStatus", {
		"binUnit.unitId" : unitId,
		"binUnit.specId" : specId,
		"binUnit.binId" : binId,
		"binUnit.lotId" : lotId,
		"binUnit.lotType" : lotType
	}, function(data) {
		if (data.startsWith("ERROR")) {
			layer.alert(data, function() {
				layer.closeAll();
				$("#unitId").select();
			});
			return false;
		}
		var code = eval("(" + data + ")");
		console.log("data:" + data);
		var lotType1 = code.counter[0].lotType;
		var binId1 = code.counter[0].binId;
		var specId1 = code.counter[0].specId;
		var qty = code.counter[0].qty;
		var bdLotId = code.counter[0].bdLotId;
		var pno = code.counter[0].pno;
		var luckElements = document.getElementsByName("unitId");
		if (luckElements.length > 0 || status.startsWith("运行")) {
			if (lotType != lotType1 || binId != binId1 || specId1 != specId) {
				layer.alert("信息不一致，不允许派料！<br>蓝膜的SPECID为：" + specId1 + "<br>机台在做的产品SPECID为：" + specId +
					"<br>蓝膜的种类为：" + lotType1 + "<br>机台在做的产品种类为：" + lotType1 +
					"<br>蓝膜的BIN为：" + binId1 + "<br>机台在做的产品BIN为：" + binId, function() {
						layer.closeAll();
						$("#unitId").select();
					});

				return false;
			}
		}
		s = "<tr name='sss'><td>" + (Number(luckElements.length) + 1) + "</td><td>" +
			"<input type='hidden' name='unitId'   value=" + code.counter[0].unitId + " />" + code.counter[0].unitId + "</td><td>" +
			"<input type='hidden' name='lotType'  value=" + code.counter[0].lotType + " />" + code.counter[0].lotType + "</td><td>" +
			"<input type='hidden' name='specId'  value=" + code.counter[0].specId + " />" + code.counter[0].specId + "</td><td>" +
			"<input type='hidden' name='binId'   value=" + code.counter[0].binId + " />" + code.counter[0].binId + "</td><td>" +
			"<input type='hidden' name='qty'   value=" + code.counter[0].qty + " />" + code.counter[0].qty + "</td><td>" +
			"<input type='hidden' name='pno'  value=" + code.counter[0].pno + " />" + code.counter[0].pno + "</td><td>" +
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
		$("#demo").append(s);
		var luck = document.getElementsByName("qty");
		var count1 = 0;
		for (var i = 0; i < luck.length; i++) {
			count1 += Number(luck[i].value);
		}
		$("#zQty").val(count1)
		$("#lotType").val(lotType1);
		$("#binId").val(binId1);
		$("#specId").val(specId1);
		if (status.startsWith("待机") && !bdLotId == "") {
			$("#bdLotId").val(bdLotId);
		}
		$("#divlotType").show();
		$("#divspecId").show();
		$("#divbinId").show();
		$("#divstatus").show();
		$("#divbdLotType").show();
		$("#divtable").show();
		$("#unitId").select();
	});

}
function paiinput() {
	var eqpt = $("select[name='modules']").val();
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

	var qty = "[";
	$("[name=qty]").each(function() {
		qty += '{"qty":"' + this.value + '"},';
	});
	var reg = /,$/gi;
	qty = qty.replace(reg, "");
	qty += "]";

	var pno = "[";
	$("[name=pno]").each(function() {
		pno += '{"pno":"' + this.value + '"},';
	});
	var reg = /,$/gi;
	pno = pno.replace(reg, "");
	pno += "]";
	
	var lotType = $("#lotType").prop("value");
	var binId = $("#binId").prop("value");
	var specId = $("#specId").prop("value");
	var bdLotId = $("#bdLotId").prop("value");
	var workId = $("#workId").prop("value");
	$.post("csppailiao.action?methodstr=unitIdToEqpt", {
		"binUnit.unitId" : unitId,
		"binUnit.bdLotId" : bdLotId,
		"binUnit.specId" : specId,
		"binUnit.binId" : binId,
		"binUnit.eqpt" : eqpt,
		"binUnit.qty" : qty,
		"binUnit.pno" : pno,
		"binUnit.workId" : workId,
		"binUnit.lotType" : lotType
	}, function(data) {
		if (data.startsWith("ERROR")) {
			layer.alert(data, function() {
				layer.closeAll();
				$("#unitId").select();
			});
			return false;

		} else {
			layer.alert(data, function() {
				window.location.reload();
			});
			return false;

		}
	});

}

function deleteRow(r) {
	var i = r.parentNode.parentNode.rowIndex;
	document.getElementById('demo').deleteRow(i);
	var luck = document.getElementsByName("qty");
	var count1 = 0;
	for (var i = 0; i < luck.length; i++) {
		count1 += Number(luck[i].value);
	}
	$("#zQty").val(count1)
}