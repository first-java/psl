
$(function() {
	$("#demo1").hide();
	$("#demo").hide();
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
})


function selectBinUnit() {
	var barcode = $("#barcode").prop("value");
	barcode = barcode.trim();
	var luckElements = document.getElementsByName("barcode");
	var odd = Number(luckElements.length) + 1;
	if (barcode == "") {
		layer.alert("请输入卷轴号！", function() {
			layer.closeAll();
			$("#unitId").select();
		});
		return;
	}

	s = "<tr name='sss'><td>" + (Number(luckElements.length) + 1) + "</td><td>" +
		"<input type='hidden' name='barcode'   value=" + barcode + " />" + barcode + "</td><td>" +
		"<button type='button' onclick='deleteRow(this)' class='layui-btn layui-btn-sm layui-btn-normal'><i class='layui-icon'></i> 删除</button></tr>";


	var unitId1 = document.getElementById("barcode").value;
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

	$("#demo1").append(s);
	$("#demo1").show();

}

function deleteRow(r) {
	var i = r.parentNode.parentNode.rowIndex;

	document.getElementById('demo1').deleteRow(i);
}
function putIn() {
	var lo = layer.load();
	var aInput = document.getElementsByName("barcode");
	if (aInput.length < 1) {
		layer.msg("没有数据提交，不要瞎点！", {
			icon : 2
		});
		layer.close(lo);
		$("#barcode").select();
		return false;
	}

	var barcode = "[";
	$("[name=barcode]").each(function() {
		barcode += '{"barcode":"' + this.value + '"},';
	});

	var reg = /,$/gi;
	barcode = barcode.replace(reg, "");
	barcode += "]";

	$.post("boliao.action?methodstr=savebarcode", {
		"boliao.barcode" : barcode
	}, function(data) {
		layer.close(lo);
		layer.alert(data, function() {
			window.location.reload();
		});

	});
}