<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
</head>
 
<body>
    <p>
        <input type="text" name="luck" value="我中奖了，中了一个亿" onclick="aa()" id="luck1" />
    </p>
    <p>
        <input type="text" name="luck" value="我交了女朋友" id="luck2" />
    </p>
    <p>
        <input type="text" name="luck" value="我升迁了" id="luck3" />
    </p>
    <p>
        <input type="text" name="luck" value="我买房了" id="luck4" />
    </p>
     
    <script>
        /*
        1、获取每一个文本框的值
        2、获取每一个文本框的类型
        3、为每一个文本框增加点击事件
        */
         
        /*
            第一步 获取name属性为luck值得对象数组(节点数组)
        */
        var luckElements = document.getElementsByName("luck");
         
        /*
            第二步 遍历节点数组
        */
        for(var i=0;i<luckElements.length;i++){
            //获取元素的value值
            alert(luckElements[i].value);
    
            //为每一个元素的onclick属性赋值即为文本框增加点击事件
            luckElements[i].onclick=function(){
                alert(this.value);
            }
        }
    </script>
</body>
</html>