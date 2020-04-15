/**蓝膜创建位置号
*/
$(function() {
	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		// 确认修改密码
		form.on("submit(setPwd)", function() {
			setPwd();
			return false;
		});
	})
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
})
function setPwd() {
 
	var unitId = $("#unitId").prop("value");
	var workId = $("#workId").prop("value");
	$.post("csppailiao.action?methodstr=binfed", {
		"binUnit.unitId" : unitId,
		"binUnit.workId" : workId 
	}, function(data) {
		var code = eval("(" + data + ")");
		console.log("data:" + data);
		if (code.code == "1") {
			layer.alert("创建位置号成功", function() {
				layer.closeAll();
				window.location.reload();
			});
		} else {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#lotId").select();
			});
		}
	});
}