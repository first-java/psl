$(function() {
	queryBagNameToQcDataByKeyWord()
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
		url = url + "?startTime=" + startTime + "&endTime=" + endTime ;
		location.href = url;
	}
function queryBagNameToQcDataByKeyWord(){
	var keyWord = $("#keyWord").prop("value");
	keyWord=keyWord.trim()
	layui.use('table', function() {
		var table = layui.table;

		table.render({
			elem : '#test',
			url : '/slectBagToQcData?keyWord='+ keyWord,
			page : { // 支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
				layout : [ 'limit', 'count', 'prev', 'page', 'next', 'skip' ] // 自定义分页布局
				,
				groups : 5
			}, 
			cellMinWidth : 80,
			cols : [ [ {
				field : 'ID',
				width : 70,
				title : '序号',
				fixed : 'left',
				type : 'number'
			}, {
				field : 'BAGNAME',
				  width : 180,
				title : '袋号',
				sort : true
			}, {
				field : 'LOTTYPE',
				title : '种类'
			}, {
				field : 'SPECID',
				title : 'ID',
				sort : true
			}, {
				field : 'BIN',
				title : 'BIN'
			}, {
				field : 'QTY',
				title : '数量',
			}, {
				field : 'STATUS',
				// width : 80,
				title : '品质判定',
				sort : true
			}, {
				field : 'SONGQC_TIME',
				templet:"<div>{{!d.SONGQC_TIME?'':layui.util.toDateString(d.SONGQC_TIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				title : '送品质时间',
				sort : true
			}, {
				field : 'PAN_TIME',
				templet:"<div>{{!d.PAN_TIME?'':layui.util.toDateString(d.PAN_TIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				title : '品质判定时间'
			}, {
				field : 'RUKU_TIME',
				templet:"<div>{{!d.RUKU_TIME?'':layui.util.toDateString(d.RUKU_TIME, 'yyyy-MM-dd HH:mm:ss') }}</div>",
				title : '入库时间',
				sort : true
			} ] ]

		});
	});

}