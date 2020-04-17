$(function() {
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/queryBagHeData',
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
				title : '创建时间',
				templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				field : 'WORKID',
				// width : 100,
				title : '操作人'
			}, {
				field : 'LOTTYPE',
				width : 100,
				title : '种类',
				//templet:"<div>{{ d.UNIT_TYPE=='0'?'正常入库':d.UNIT_TYPE=='1'?'尾料入库':'未知' }}</div>",
				sort : true
			}, {
				field : 'LEIXING',
				
				// width : 80,
				title : '类型'
			}, {
				field : 'BAGNAME',
				title : '合并袋号',
			// width : 280
			}, {
				field : 'BAGNAME1',
				// width : 80,
				title : '原袋号',
				//templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				sort : true
			}, {
				field : 'SC_QTY',
				// width : 80,   p_no, lottype,  binid,spec_id,  qty,outtime,  outworkid,flag_type
				title : '原始数量',
				sort : true
			}, {
				field : 'QTY',
				width : 80,
				title : '合并数量'
			}, {
			 
				field : 'FLAG',
				width : 135,
				templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '状态',
				sort : true
			} , {
				field : 'WEIGHT',
				width : 135,
				title : '重量g(含袋子)',
				sort : true
			}, {
				field : 'BAGWEIGHT',
				width : 85,
				title : '袋子重量',
				sort : true
			} , {
				field : 'LABELWEIGHT',
				width : 135,
				title : '标签重量',
				//templet:"<div>{{!d.OUTTIME?'':layui.util.toDateString(d.OUTTIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			} , {
				field : 'JING_WEIGHT',
				width : 135,
				title : '净重',
				sort : true
			}  , {
				field : 'EACHWEIGHT',
				width : 135,
				title : '单颗重量（g）',
				sort : true
			} , {
				field : 'ZH_QTY',
				width : 135,
				title : '重量转换颗粒数',
				sort : true
			}, {
				field : 'NOW_DIE_QTY',
				width : 135,
				title : '计算数量',
				sort : true
			} , {
				field : 'NG_QTY',
				width : 135,
				title : '损失数量',
				sort : true
			} , {
				field : 'OUTTIME',
				width : 135,
				title : '出库日期',
				sort : true,
				templet:"<div>{{!d.OUTTIME?'':layui.util.toDateString(d.OUTTIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
			}, {
				field : 'OUTWORKID',
				width : 135,
				title : '出库操作人',
				sort : true
			}, {
				field : 'CHULEI',
				width : 135,
				title : '出库类型',
				sort : true
			}] ]

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
 