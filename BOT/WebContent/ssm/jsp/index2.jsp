<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");
	/* if (workId == " " || workId == null) {
	
		out.print("<script>alert('工号有误！')</script>");
		out.print("<a href='#' onClick='javascript :history.back(-1);'>返回上一页</a>");
		return;
	} */
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>登录成功</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	function aa() {
		var s = document.getElementById("div1").innerHTML += document.getElementById("txt").value + ",";
		document.getElementById('txt').focus()
		document.getElementById("txt1").value = document.getElementById('div1').innerText;
	}
	$("#word").click(function() {
		$(this).focus().select();
		this.selectionStart = 0;
		this.selectionEnd = this.val().length;
	})
</script>

<script type="text/javascript">
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交
	}
	function setFocus() {
		document.getElementById('txt').focus();


	}
	function loseFocus() {
		document.getElementById('txt').blur()
	}
	// 两秒后模拟点击
	setTimeout(function() {
		// IE
		if (document.all) {
			document.getElementById("clickMe").click();
		}
		// 其它浏览器
		else {
			var e = document.createEvent("MouseEvents");
			e.initEvent("click", true, true);
			document.getElementById("clickMe").dispatchEvent(e);
		}
	}, 200);

	$(document).keypress(function(e) {
		// 回车键事件  
		if (e.which == 13) {
			$(this).focus().select();

			$("#word").click();

		}
	});
</script>

</head>
<body>
<body class="b" onload="javascript:window.alert(' 操作成功  ')">
	操作成功

	<a href="javascript:history.back(-1)">返回上一页</a>
</body>
</html>