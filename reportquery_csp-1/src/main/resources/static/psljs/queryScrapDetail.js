$(function() {
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/queryScrapDetail',
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
				field : 'CREATETIME',
				  width : 180,
				title : '创建时间',
				templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				/*Columns: ID, BAGNAME, CREATETIME, WORKID, ODD, LOTHEAD, LEIXING, QTY, REMARK, BIN*/
				field : 'WORKID',
				// width : 100,
				title : '操作人'
			}, {
				field : 'BAGNAME',
				//width : 100,
				title : '袋号',
				//templet:"<div>{{ d.UNIT_TYPE=='0'?'正常入库':d.UNIT_TYPE=='1'?'尾料入库':'未知' }}</div>",
				sort : true
			}, {
				field : 'BIN',
				
				// width : 80,
				title : 'BIN'
			}, {
				field : 'QTY',
				title : '数量',
			// width : 280
			}, {
				field : 'LOTHEAD',
				// width : 80,
				title : '种类',
				//templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				sort : true
			}, {
				field : 'LEIXING',
				// width : 80,   p_no, lottype,  binid,spec_id,  qty,outtime,  outworkid,flag_type
				title : '类型',
				sort : true
			}, {
				field : 'ODD',
				//width : 80,
				title : '报废单号'
			}, {
				field : 'RAMARK',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '备注',
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

	layui.use('laydate', function() {
		var laydate = layui.laydate;

		//自定义格式
		laydate.render({
			elem : '#test11',
			format : 'yyyy/MM/dd'
		});
		//自定义格式
		laydate.render({
			elem : '#test12',
			format : 'yyyy/MM/dd'
		});

	});
})
 	function download(url) {
	 
		var endTime = $("#test12").prop("value");
		var startTime = $("#test11").prop("value");
		if (startTime == '') {
			layer.msg("还没选择开始日期", {
				icon : 2
			});
			return;
		}
		if (endTime == '') {
			layer.msg("还没选择结束日期", {
				icon : 2
			});
			return;
		}
		//2、拼装URL+查询参数
		url = url + "?startTime=" + startTime + "&endTime=" + endTime ;
		//3、使用document.local.href=URL

		location.href = url;
	}
