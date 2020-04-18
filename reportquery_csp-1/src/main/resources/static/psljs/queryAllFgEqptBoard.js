$(function() {
	layui.use('table', function() {
		var table = layui.table;
		table.render({
			elem : '#test',
			url : '/fgEqptBoard',
			page : { // 支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
				layout : [ 'limit', 'count', 'prev', 'page', 'next', 'skip' ] // 自定义分页布局
				// ,curr: 5 //设定初始在第 5 页
				,
				groups : 5
			// 只显示 1 个连续页码

			}, 
			cellMinWidth : 80,
			cols : [ [ {
				field : 'ID',
				width : 70,
				title : '序号',
				fixed : 'left',
				type : 'number'
			}, {
				field : 'FGLOTID',
				// width : 80, p_no, lottype, binid,spec_id, qty,outtime,
				// outworkid,flag_type
				title : '分光批次号',
				sort : true
			}, {
				field : 'CREATETIME',
				// width : 100,
				title : '创建时间',
				templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				field : 'LOTTYPE',
				// width : 80,
				title : '种类',
				sort : true
			}, {
				field : 'SPECID',
				title : 'ID'
			}, {
				field : 'QTY',
				title : '总投入',
			}, {
				field : 'GOODBIN_QTY',
				title : '良品BIN产出',
				sort : true
			}, {
				field : 'NG_QTY',
				title : 'NG品BIN产出',
				sort : true
			}, {
				field : 'SC_QTY',
				title : '报废BIN产出',
				sort : true
			}, {
				field : 'WL_QTY',
				title : '尾料产出',
				sort : true
			}, {
				field : 'NGP_QTY',
				title : 'NG品产出',
				sort : true
			}, {
				field : 'FL_QTY',
				title : '废料产出',
				sort : true
			}, {
				field : 'DL_QTY',
				title : '地料产出',
				sort : true
			}, {
				field : 'TOTAL_OUT_DIE_QTY',
				title : '总产出',
				sort : true
			}, {
				field : 'NOW_DIE_QTY',
				title : '在制',
				sort : true
			}] ]

		});
		 
 });

	layui.use('laydate', function() {
		var laydate = layui.laydate;

		// 自定义格式
		laydate.render({
			elem : '#test11',
			format : 'yyyy/MM/dd'
		});
		// 自定义格式
		laydate.render({
			elem : '#test12',
			format : 'yyyy/MM/dd'
		});

	});
})
 

