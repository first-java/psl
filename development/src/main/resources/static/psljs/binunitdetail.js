$(function() {
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/showData',
			page : { // 支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
				layout : [ 'limit', 'count', 'prev', 'page', 'next', 'skip' ] // 自定义分页布局
				// ,curr: 5 //设定初始在第 5 页
				,
				groups : 5
			// 只显示 1 个连续页码

			}, 
			cellMinWidth : 80,
			cols : [ [ {
				field : 'ODD',
				width : 70,
				title : '序号',
				fixed : 'left',
				type : 'number'
			}, {
				field : 'CREATETIME',
				  width : 180,
				title : '入库时间',
				templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				field : 'WORKID',
				// width : 100,
				title : '入库者'
			}, {
				field : 'UNIT_TYPE',
				width : 100,
				title : '入库类型',
				templet:"<div>{{ d.UNIT_TYPE=='0'?'正常入库':d.UNIT_TYPE=='1'?'尾料入库':'未知' }}</div>",
				sort : true
			}, {
				field : 'LOTID',
				// width : 80,
				title : '批号'
			}, {
				field : 'UNITID',
				title : '蓝膜号',
			// width : 280
			}, {
				field : 'STATUS',
				// width : 80,
				title : '状态',
				templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				sort : true
			}, {
				field : 'P_NO',
				// width : 80,   p_no, lottype,  binid,spec_id,  qty,outtime,  outworkid,flag_type
				title : '位置号',
				sort : true
			}, {
				field : 'LOTTYPE',
				width : 80,
				title : '种类'
			}, {
				field : 'SPEC_ID',
				width : 135,
				title : 'ID',
				sort : true
			} , {
				field : 'BINID',
				width : 135,
				title : 'BIN',
				sort : true
			}, {
				field : 'QTY',
				width : 85,
				title : '计算数量',
				sort : true
			} , {
				field : 'OUTTIME',
				width : 135,
				title : '出库时间',
				templet:"<div>{{!d.OUTTIME?'':layui.util.toDateString(d.OUTTIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			} , {
				field : 'OUTWORKID',
				width : 135,
				title : '出库者',
				sort : true
			}  , {
				field : 'FLAG_TYPE',
				width : 135,
				title : '出库类型',
				templet:"<div>{{d.FLAG_TYPE== undefined ?'在库':d.FLAG_TYPE }}</div>",
				sort : true
			}  ] ]

		});
		// 监听行单击事件（双击事件为：rowDouble）
		table.on('row(test)', function(obj) {
			setPwd(obj);
			/*
			 * layer.alert(JSON.stringify(data), { title : '当前行数据：' });
			 */

			// 标注选中样式
			obj.tr.addClass('layui-table-click').siblings().removeClass(
					'layui-table-click');
		});
	});
})
function setPwd(obj) {
	var data = obj.data;
	var lotId = JSON.stringify(data);
	var obj1 = JSON.parse(lotId);
	var unitId = obj1.UNITID
	$.post("/detail/unitDateil", {
		"unitId" : unitId

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