$(function() {
	queryFgLotIdDataByKeyWord()
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
function queryFgLotIdDataByKeyWord(){
	var keyWord = $("#keyWord").prop("value");
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/queryFgLotIdData?keyWord='+ keyWord,
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
				title : '分光批次号',
				//templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				field : 'CREATETIME',
				templet:"<div>{{!d.CREATETIME?'':layui.util.toDateString(d.CREATETIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				title : '创建时间'
			}, {
				field : 'QCTIME',
				//width : 100,
				title : '品质结束时间',
				templet:"<div>{{!d.QCTIME?'':layui.util.toDateString(d.QCTIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				sort : true
			}, {
				field : 'SCTIME',
				templet:"<div>{{!d.SCTIME?'':layui.util.toDateString(d.SCTIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				title : '生产结束时间'
			}, {
				field : 'LOTTYPE',
				title : '种类'
			}, {
				field : 'SPECID',
				title : 'ID',
				sort : true
			}, {
				field : 'QTY',
				// width : 80,   p_no, lottype,  binid,spec_id,  qty,outtime,  outworkid,flag_type
				title : '总投入',
				sort : true
			}, {
				field : 'GOODBIN_QTY',
				title : '良品BIN产出'
			}, {
				field : 'NG_QTY',
				title : 'NG品BIN产出',
				sort : true
			}, {
				field : 'SC_QTY',
				title : '报废BIN产出',
				sort : true
			} , {
				field : 'WL_QTY',
				title : '尾料产出',
				sort : true
			}  , {
				field : 'NGP_QTY',
				title : 'NG品产出',
				sort : true
			} , {
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
			} , {
				field : 'NOW_DIE_QTY',
				//width : 135,
			//	templet:"<div>{{ d.STATUS==''?'NORMAL':'HOLD' }}</div>",
				title : '在制',
				sort : true
			} , {
				field : '0',
				title : '报废',
				sort : true
			}, {
				field : '0',
				title : '地料采集',
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

}