<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
</head>
<body>
	<table align="left" width="30%">
		<tr>
			<td>录入卷轴： <input name="tapeId" id="tapeId"
				onfocus="this.select()" />
				<button id="ajaxA" onclick="setFocus()">ajxa刷新</button></td>
		</tr>
	</table>
	<fieldset class="layui-elem-field layui-field-title"
		style="margin-top: 30px;">
		<legend>分页</legend>
	</fieldset>

	<div id="demo7"></div>
	<ul id="biuuu_city_list"></ul>
</body>
</html>
<script>
		layui.use([ 'laypage', 'layer' ], function() {
			var laypage = layui.laypage,
				layer = layui.layer;
				//将一段数组分页展示
	
			//测试数据
			var data = [
				'北京',
				'上海',
				'广州',
				'深圳',
				'杭州',
				'长沙',
				'合肥',
				'宁夏',
				'成都',
				'西安',
				'南昌',
				'上饶',
				'沈阳',
				'济南',
				'厦门',
				'福州',
				'九江',
				'宜春',
				'赣州',
				'青岛',
				'天津',
				'重庆',
				'南京',
				'九江',
				'成都',
				'西安',
				'南昌',
				'上饶',
				'沈阳',
				'济南',
				'厦门',
				'福州',
				'九江',
				'宜春',
				'赣州',
				'宁波',
				'绍兴',
				'无锡',
				'苏州',
				'徐州',
				'东莞',
				'佛山',
				'中山',
				'成都',
				'武汉',
				'青岛',
				'天津',
				'澳门',
				'台北'
			];
	
			//调用分页
			laypage.render({
				elem : 'demo7',
				count : data.length,
				jump : function(obj) {
					//模拟渲染
					document.getElementById('biuuu_city_list').innerHTML = function() {
						var arr = [],
							thisData = data.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
						layui.each(thisData, function(index, item) {
							arr.push('<li>' + item + '</li>');
						});
						return arr.join('');
					}();
				}
			});
	
		});
	</script>
