<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   <title>无标题文档</title>
</head>
<script type="text/javascript">
var id;
var weekday = "";
function ti(){
	var d=new Date();
	var year=d.getFullYear();
	var MM=d.getMonth();
	var dd=d.getDate();
	var hh=d.getHours();
	var mm=d.getMinutes();
	var ss=d.getSeconds();
	var wd=d.getDay();
	
	if (hh == 0) {
		hours = "12";
		xfile = "PM ";
		} else if (hh < 12) { 
		hours = hh;
		xfile = "AM ";
		} else if (hh == 12) {
		hours = "12";
		xfile = "AM";
		} else {
		hh = hh - 12
		hours = hh;
		xfile = "PM";
		}
		
		if(wd== 0)
		weekday=" 星期日";
		else if(wd== 1)
		weekday=" 星期一";
		else if(wd== 2)
		weekday=" 星期二";
		else if(wd == 3)
		weekday=" 星期三";
		else if(wd == 4)
		weekday=" 星期四";
		else if(wd == 5)
		weekday=" 星期五";
		else if(wd == 6)
		weekday=" 星期六";
		
		var time="<h3>"+year+"年"+MM+"月"+dd+"日&nbsp;&nbsp;"+hh+":"+mm+":"+ss+" &nbsp;&nbsp;"+xfile+" &nbsp;&nbsp;"+weekday+"</h3>";
		document.getElementById("time").innerHTML=time;
}
	var id=setInterval("ti()",1000);

</script>
<body>
<div id="time"></div>
</body>
</html>