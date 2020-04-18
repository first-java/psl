$(function() {
	$("#demo1").hide();
	$("#demo").hide();
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
})

function selectGoodBag() {
	var bagName = $("#bagName").prop("value");
	if (!bagName.startsWith("Y")) {
		layer.msg("静电袋不符合规范，请扫描Y开头的静电袋！！！", {
			icon : 2
		});
		return;
	}
	$.post("/selectGoodBag",{
		"bagName" : bagName.trim()
	},
	function(data) {
		if (data.code == 1) {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#bagName").select();

			});
			return;
		}
		var bagName = document.getElementsByName("bagName")
		var BAGNAME = data.BAGNAME;
		var LOTTYPE = data.LOTTYPE;
		var BINID = data.BINID;
		var LOTTYPE = data.LOTTYPE;
		var SPECID = data.SPECID;

		for (var i = 0; i < bagName.length; i++) {
			if (bagName == bagName[i].value) {
				layer.msg("数据重复，此袋号[" + bagName + "]已经在下列表当中！",
						{
							icon : 2
						});
				return;
			}
		}
		s = "<tr name='sss'><td>"
				+ (Number(bagName.length) + 1)
				+ "</td><td>"
				+ "<input type='hidden' name='bagName'  value="
				+ BAGNAME
				+ " />"
				+ BAGNAME
				+ "</td><td>"
				+ "<input type='hidden' name='lotType'  value="
				+ LOTTYPE
				+ " />"
				+ LOTTYPE
				+ "</td><td>"
				+ "<input type='hidden' name='binId'  value="
				+ BINID
				+ " />"
				+ BINID
				+ "</td><td>"
				+ "<input type='hidden' name='specId'  value="
				+ SPECID
				+ " />"
				+ SPECID
				+ "</td><td>"
				+ "<div class='layui-input-inline'><input type='number' name='qty' lay-verify='required'"
				+ "autocomplete='off' class='layui-input'></div>"
				+ "</td><td>"
				+ "<button type='button' onclick='deleteRow(this)' class='layui-btn layui-btn-sm layui-btn-normal'><i class='layui-icon'></i> 删除</button></tr>";
		$("#demo").append(s);
		$("#demo").show();
		$("#bagName").select();

	});
}

function deleteRow(r) {
	var i = r.parentNode.parentNode.rowIndex;
	document.getElementById('demo').deleteRow(i);
}

function putIn() {
	var lo = layer.load();
	var qtyName = document.getElementsByName("qty")
	var bagNameName = document.getElementsByName("bagName")
	if (bagNameName.length<1) {
			layer.msg("没有数据提交，请不要瞎点！", {
				icon : 2
			});
			layer.close(lo);
			return;
		}
	
	for (var i = 0; i < qtyName.length; i++) {
		if (qtyName[i].value == "") {
			layer.msg("数量不能有空！", {
				icon : 2
			});
			layer.close(lo);
			return;
		}
	}

	var bagName = "[";
	$("[name=bagName]").each(function() {
		bagName += '{"bagName":"' + this.value + '"},';
	});

	var reg = /,$/gi;
	bagName = bagName.replace(reg, "");
	bagName += "]";

	var binId = "[";
	$("[name=binId]").each(function() {
		binId += '{"binId":"' + this.value + '"},';
	});
	// 去掉最后一个","
	var reg = /,$/gi;
	binId = binId.replace(reg, "");
	binId += "]";

	var specId = "[";
	$("[name=specId]").each(function() {
		specId += '{"specId":"' + this.value + '"},';
	});
	// 去掉最后一个","
	var reg = /,$/gi;
	specId = specId.replace(reg, "");
	specId += "]";

	var qty = "[";
	$("[name=qty]").each(function() {
		qty += '{"qty":"' + this.value + '"},';
	});
	// 去掉最后一个","
	var reg = /,$/gi;
	qty = qty.replace(reg, "");
	qty += "]";

	var lotType = "[";
	$("[name=lotType]").each(function() {
		lotType += '{"lotType":"' + this.value + '"},';
	});
	// 去掉最后一个","
	var reg = /,$/gi;
	lotType = lotType.replace(reg, "");
	lotType += "]";
	var workId = $("#workId").prop("value");

	$.post("/saveBagNameToQc", {
		"bagName" : bagName,
		"specId" : specId,
		"qty" : qty,
		"binId" : binId,
		"workId" : workId,
		"lotType" : lotType
	}, function(data) {
		layer.close(lo);
		layer.alert(data.msg, function() {
			window.location.reload();
		});

	});
}