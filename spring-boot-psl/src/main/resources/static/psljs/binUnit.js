/**
 * 修改用户密码
 */
$(function() {
	var loc = location.href;
	var n1 = loc.length;
	var n2 = loc.indexOf('=');
	var txt = decodeURI(loc.substr(n2 + 1, n1 - n2));
	$("#workId").val(txt)
	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		// 确认修改密码
		form.on("submit(setPwd)", function() {
			setPwd();
			return false;
		});
	})
})
function setPwd() {

	var maxId = $("#maxId").prop("value");
	var lotId = $("#lotId").prop("value");
	var workId = $("#workId").prop("value");
	$.post("/psl/binUnit", {
		"maxId" : maxId,
		"lotId" : lotId,
		"workId" : workId
	}, function(data) {
		console.log("data:" + data);
		if (data.code == "1") {
			layer.alert("创建位置号成功", function() {
				layer.closeAll();
				window.location.href = "/psl/query";
			});
		} else {
			layer.alert(data.msg, function() {
				layer.closeAll();
				$("#lotId").select();
			});
		}
	});
}
