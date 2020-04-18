$(function() {
	queryScrollToBeamSplitDataByKeyWord()
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
function queryScrollToBeamSplitDataByKeyWord(){
	var keyWord = $("#keyWord").prop("value");
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/scrollToBeamSplitData?keyWord='+ keyWord,
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
				field : 'LOTHEAD',
				//width : 100,
				title : '种类',
				//templet:"<div>{{ d.UNIT_TYPE=='0'?'正常入库':d.UNIT_TYPE=='1'?'尾料入库':'未知' }}</div>",
				sort : true
			}, {
				field : 'BARCODE',
				
				// width : 80,
				title : '卷轴号'
			}, {
				field : 'QTY',
				title : '原始数量',
			// width : 280
			}, {
				field : 'TOTAL_OUT_DIE_QTY',
				// width : 80,
				title : '原始总数量',
				//templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				sort : true
			}, {
				field : 'BAGNAME',
				// width : 80,   p_no, lottype,  binid,spec_id,  qty,outtime,  outworkid,flag_type
				title : '静电袋',
				sort : true
			}, {
				field : 'FLAG',
				//width : 80,
				templet:"<div>{{ d.FLAG==null?'NORMAL':'HOLD' }}</div>",
				title : '状态'
			}, {
				field : 'WEIGHT',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '重量g（含袋子）',
				sort : true
			}, {
				field : 'BAGWEIGHT',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '袋子重量g',
				sort : true
			} , {
				field : 'LABELWEIGHT',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '标签重量g',
				sort : true
			}  , {
				field : 'JING_WEIGHT',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '净重g',
				sort : true
			} , {
				field : 'EACHWEIGHT',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '单颗重量g',
				sort : true
			}, {
				field : 'ZH_QTY',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '重量转换颗粒数',
				sort : true
			}, {
				field : 'NOW_DIE_QTY',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '计算数量',
				sort : true
			} , {
				field : 'NG_QTY',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '损失数量',
				sort : true
			} , {
				field : 'OUTTIME',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '出库日期',
				sort : true
			}, {
				field : 'OUTWORKID',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '出库操作人',
				sort : true
			} , {
				field : 'CHULEI',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '出库类型',
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

}