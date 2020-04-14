$(function() {
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/eqpt/eqptboard',
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
				width : 80,
				title : '序号',
				fixed : 'left',
				type : 'number'
			}, {
				field : 'BDLOTID',
				// width : 180,
				title : '贴带批次号',
				sort : true
			}, {
				field : 'CREATETIME',
				// width : 100,
				title : '创建时间'
			}, {
				field : 'LOTTYPE',
				// width : 80,
				title : '种类',
				sort : true
			}, {
				field : 'ID',
				// width : 80,
				title : 'ID',
				sort : true
			}, {
				field : 'BIN',
				// width : 80,
				title : 'BIN',
				sort : true
			}, {
				field : 'BIN',
				// width : 80,
				title : '总投入',
				sort : true
			}, {
				field : 'BIN',
				// width : 80,
				title : '卷轴产出',
				sort : true
			}, {
				field : 'BIN',
				// width : 80,
				title : '在制',
				sort : true
			} ] ]

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
	var lotType = obj1.LOTTYPE
	$("#divid").hide();
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test1',
			url : '/detail/unitDateil?lotType=' + lotType,
			page : { // 支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem）
				// - 详见文档
				layout : [ 'limit', 'count', 'prev', 'page', 'next', 'skip' ] // 自定义分页布局
				// ,curr: 5 //设定初始在第 5 页
				,
				groups : 5
			// 只显示 1 个连续页码

			},
			cellMinWidth : 80,
			cols : [ [ {
				field : 'ODD',
				width : 80,
				title : '序号',
				fixed : 'left',
				type : 'number'
			}, {
				field : 'UNITID',
				// width : 180,
				title : '蓝膜号',
				sort : true
			}, {
				field : 'LOTTYPE',
				// width : 180,
				title : '种类-ID-BIN',
				sort : true
			}, {
				field : 'QTY',
				// width : 180,
				title : '数量',
				sort : true
			}, {
				field : 'P_NO',
				// width : 100,
				title : '位置号'
			}, {
				field : 'CREATETIME',
				// width : 100,
				title : '入库日期'
			}, {
				field : 'STATUS',
				// width : 80,
				title : '状态',
				sort : true
			} ] ]

		});
		// 监听行单击事件（双击事件为：rowDouble）
		table.on('row(test1)', function(obj) {
			setPwd(obj);
			/*
			 * layer.alert(JSON.stringify(data), { title : '当前行数据：' });
			 */

			// 标注选中样式
			obj.tr.addClass('layui-table-click').siblings().removeClass(
					'layui-table-click');
		});
	});
}