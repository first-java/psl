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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<head>
<title>登录成功</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
	function handleEnter(field, event) {
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13) {
			var i;
			for (i = 0; i < field.form.elements.length; i++)
				if (field == field.form.elements[i])
					break;
			i = (i + 1) % field.form.elements.length;
			field.form.elements[i].focus();
			return false;
		}
		else
			return true;
	}
</script>
<script>
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交
	}
</script>
<script>
	function check1() {
		document.getElementById('myForm1').submit(); //进行表单提交
	}


	function downLoad(url) {
		location.href = url;
	}
</script>
</head>
<body>

	<form id="myForm" action="<%=path%>/re.action?methodstr=statusCount"
		method="post" enctype="multipart/form-data">
		查询状态数量
		<p style="font-size:12px;">
			<select name="status">
				<option value="0">0，状态正常</option>
				<option value="1">1，异常待定</option>
				<option value="2">2，待手动换/补灯</option>
				<option value="3">3，待返回振动盘重做</option>
			</select> <input class="btn btn-primary" type="submit" class="btn" value="查找" />
		</p>
	</form>
	<table>
		<tr>
			<td>
				<form id="myForm1"
					action="<%=path%>/re.action?methodstr=queryStatus" method="post"
					enctype="multipart/form-data">
					卷轴号查状态 <br> <input type="text" name="tapeId" /> <input
						class="btn btn-primary" type="button" value="提交"
						onclick="check1()" />
				</form>
			</td>
			<td>
				<button class="btn btn-primary"
					onclick="downLoad('download.action?methodstr=batch')">下载卷轴号状态清单</button>

			</td>
		</tr>
	</table>
	<c:if test="${empty statusCount}">
		<c:if test="${ empty  requestScope.list}">
			<c:if test="${ empty queryStatus }">
		沒有查到結果
		</c:if>
		</c:if>
	</c:if>

	<c:if test="${not empty statusCount}">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1">
			<tr>
				<td>卷轴号</td>
				<td>状态</td>
				<td>创建时间</td>
				<td>级别</td>
				<td>批次头</td>
				<td colspan="4">操作</td>
			</tr>

			<c:forEach var="i" items="${statusCount}">
				<tr>
					<td>${i.tapeId}</td>
					<td>${i.status}</td>
					<td>${i.createtime}</td>
					<td>${i.remark}</td>
					<td>${i.root_lot_id}</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}"
								readonly="readonly" /> <input type="hidden"
								name="scroll.status" value="0" /> <input type="submit"
								value="状态正常" />
						</form>
					</td>

					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="1" /> <input
								type="submit" value="异常待定" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="2" /> <input
								type="submit" value="待手动换/补灯" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="3" /> <input
								type="submit" value="待返回振动盘重做" />
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

	<c:if test="${not empty  requestScope.list}">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1">
			<tr>
				<td>卷轴号</td>
				<td>状态</td>
				<td colspan="4">操作</td>
			</tr>
			<c:forEach var="i" items="${requestScope.list}">
				<tr>
					<td>${i.tapeId}</td>
					<td>${i.status}</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}"
								readonly="readonly" /> <input type="hidden"
								name="scroll.status" value="0" /> <input type="submit"
								value="状态正常" />
						</form>
					</td>

					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="1" /> <input
								type="submit" value="异常待定" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="2" /> <input
								type="submit" value="待手动换/补灯" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="3" /> <input
								type="submit" value="待返回振动盘重做" />
						</form>
					</td>
				</tr>
			</c:forEach>

			第${page.pageno}/${page.totalpage }页
			<a href="findPage.action?page.pageno=1">首页</a>&nbsp;
			<c:choose>
				<c:when test="${page.pageno>1}">
					<a href="findPage.action?page.pageno=${page.pageno-1 }">上一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是第一页了！');">上一页</a>&nbsp;
        
        </c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${page.pageno<page.totalpage}">
					<a href="findPage.action?page.pageno=${page.pageno+1 }">下一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是最后一页了！');">下一页</a>&nbsp; 
        </c:otherwise>
			</c:choose>
			<a
				href="findPage.action?page.pageno=${page.totalpage}&&workId=<%=workId%>">末页</a>&nbsp;
			总${page.totalcount }条

		</table>
	</c:if>

	<c:if test="${not empty  queryStatus}">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1">
			<tr>
				<td>卷轴号</td>
				<td>状态</td>
				<td>创建时间</td>
				<td>级别</td>
				<td>批次头</td>
				<td colspan="4">操作</td>
			</tr>
			<c:forEach var="i" items="${queryStatus}">
				<tr>
					<td>${i.tapeId}</td>
					<td>${i.status}</td>
					<td>${i.createtime}</td>
					<td>${i.remark}</td>
					<td>${i.root_lot_id}</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}"
								readonly="readonly" /> <input type="hidden"
								name="scroll.status" value="0" /> <input type="submit"
								value="状态正常" />
						</form>
					</td>

					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="1" /> <input
								type="submit" value="异常待定" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="2" /> <input
								type="submit" value="待手动换/补灯" />
						</form>
					</td>
					<td>
						<form action="update.action" method="post">
							<input type="hidden" name="scroll.tapeId" value="${i.tapeId}" />
							<input type="hidden" name="scroll.status" value="3" /> <input
								type="submit" value="待返回振动盘重做" />
						</form>
					</td>
				</tr>
			</c:forEach>

			第${page.pageno}/${page.totalpage }页
			<a href="findPage.action?page.pageno=1">首页</a>&nbsp;
			<c:choose>
				<c:when test="${page.pageno>1}">
					<a href="findPage.action?page.pageno=${page.pageno-1 }">上一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是第一页了！');">上一页</a>&nbsp;
        
        </c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${page.pageno<page.totalpage}">
					<a href="findPage.action?page.pageno=${page.pageno+1 }">下一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是最后一页了！');">下一页</a>&nbsp; 
        </c:otherwise>
			</c:choose>
			<a
				href="findPage.action?page.pageno=${page.totalpage}&&workId=<%=workId%>">末页</a>&nbsp;
			总${page.totalcount }条
		</table>
	</c:if>
</body>
</html>