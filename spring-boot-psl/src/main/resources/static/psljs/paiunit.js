/**
 * 蓝膜派贴待机
 */
$(function() {

	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)

	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		$.post("/send/selectBinUnitEqpt", {}, function(data) {

			console.log("data:" + data);
			for (var i = 0; i < data.code.length; i++) {
				var eqpt = data.code[i].EQPT;
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

			$.post("/send/selectBinUnitEqptStatus", {
				"eqpt" : proviceName
			}, function(data) {

				console.log("data:" + data);
				var lotType = data.code[0].LOTTYPE;
				var binId = data.code[0].BINID;
				var specId = data.code[0].SPECID;
				var bdLotId = data.code[0].BDLOTID;
				var status = data.code[0].STATUS;

				if (status == undefined) {
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
				/*
				 * var table = document.getElementById("demo"); while
				 * (table.hasChildNodes()) {
				 * table.removeChild(table.lastElementChild) }
				 */
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
	var eqpt = $("select[name='modules']").val();

	$("#pwdBtn").show();
	$
			.post(
					"/send/selectBinUnitStatus",
					{
						"unitId" : unitId,
						"specId" : specId,
						"binId" : binId,
						"eqpt" : eqpt,
						"lotType" : lotType
					},
					function(data) {
						if (data.code == 2) {
							layer.alert(data.msg, function() {
								layer.closeAll();
								$("#unitId").select();
							});
							return false;
						}

						console.log("data:" + data);
						var lotType1 = data.code[0].LOTTYPE;
						var binId1 = data.code[0].BINID;
						var specId1 = data.code[0].SPEC_ID;
						var qty = data.code[0].QTY;
						var bdLotId = data.BDLOTID;
						var pno = data.code[0].PNO;
						var luckElements = document.getElementsByName("unitId");
						if (luckElements.length > 0 || status.startsWith("运行")) {
							if (lotType != lotType1 || binId != binId1
									|| specId1 != specId) {
								layer.alert("信息不一致，不允许派料！<br>蓝膜的SPECID为："
										+ specId1 + "<br>机台在做的产品SPECID为："
										+ specId + "<br>蓝膜的种类为：" + lotType1
										+ "<br>机台在做的产品种类为：" + lotType1
										+ "<br>蓝膜的BIN为：" + binId1
										+ "<br>机台在做的产品BIN为：" + binId,
										function() {
											layer.closeAll();
											$("#unitId").select();
										});

								return false;
							}
						}
						s = "<tr name='sss'><td>"
								+ (Number(luckElements.length) + 1)
								+ "</td><td>"
								+ "<input type='hidden' name='unitId'   value="
								+ data.code[0].UNITID
								+ " />"
								+ data.code[0].UNITID
								+ "</td><td>"
								+ "<input type='hidden' name='lotType'  value="
								+ data.code[0].LOTTYPE
								+ " />"
								+ data.code[0].LOTTYPE
								+ "</td><td>"
								+ "<input type='hidden' name='specId'  value="
								+ data.code[0].SPEC_ID
								+ " />"
								+ data.code[0].SPEC_ID
								+ "</td><td>"
								+ "<input type='hidden' name='binId'   value="
								+ data.code[0].BINID
								+ " />"
								+ data.code[0].BINID
								+ "</td><td>"
								+ "<input type='hidden' name='qty'   value="
								+ data.code[0].QTY
								+ " />"
								+ data.code[0].QTY
								+ "</td><td>"
								+ "<input type='hidden' name='pno'  value="
								+ data.code[0].P_NO
								+ " />"
								+ data.code[0].P_NO
								+ "</td><td>"
								+ "<button type='button' onclick='deleteRow(this)' class='layui-btn layui-btn-sm layui-btn-normal'><i class='layui-icon'></i> 删除</button></tr>";

						var unitId1 = document.getElementById("unitId").value;
						unitId1 = unitId1.trim();
						for (var i = 0; i < luckElements.length; i++) {
							// 获取元素的value值
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
	$.post("/send/unitIdToEqpt", {
		"unitId" : unitId,
		"bdLotId" : bdLotId,
		"specId" : specId,
		"binId" : binId,
		"eqpt" : eqpt,
		"qty" : qty,
		"pno" : pno,
		"workId" : workId,
		"lotType" : lotType
	}, function(data) {
		if (data.code == 1) {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#unitId").select();
			});
			return false;

		} else {
			layer.alert(data.msg, function() {
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