<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	function downLoad(url) {
		//1、获得查询参数
		var query = document.getElementById("quer");
		//2、拼装URL+查询参数
		url = url + "&query=" + query.value;
		//3、使用document.local.href=URL

		location.href = url;
	}
</script>
<html>
<body>
	<form id="myForm" action="oemList.action?methodstr=oemListDownLoad"
		method="post" onsubmit="return sb1()">
		<input type="hidden" name="query" id="quer"> 
	</form>

	<div>
		<a href="#" onclick="downLoad('download.action?methodstr=oemListDownLoad')">下载反馈结果</a>

	</div>
	
	
</body>
</html>
