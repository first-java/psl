<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>错误信息</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	background: #CCE8CF url(images/bg3.jpg) no-repeat center top;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	background-size: cover;
}
</style>
</head>

<body class="b" onload="javascript:window.alert(' 文件上传失败  ')">
	<!-- 文件内容有误  -->
	${chackFile }
	${chackError}
	<!-- 存货编码未添加或者规格型号存在异常 -->
	${chackCode }
	<br>
	<c:if test="${not empty chackCode }">
		<table border="1">
			<tr>
				<td>nSize</td>
				<td>nElec</td>
				<td>nBin</td>
				<td>nLight</td>
				<td>nStorage</td>
				<td>nModel</td>
				<td>nProductType</td>
				<td>nVolid</td>
				<td>nLightDesc</td>
				<td>ChipVer</td>
				<td>LopCaption</td>
				<td>WldCaption</td>
				<td>IrCaption</td>
				<td>VfCaption</td>
				<td>RaCaption</td>
				<td>CCTCaption</td>
				<td>WLPCaption</td>
			</tr>
			<c:forEach items="${Code }" var="s">
				<tr>
					<td>${s.nSize }</td>
					<td>${s.nElec }</td>
					<td>${s.nBin }</td>
					<td>${s.nLight }</td>
					<td>${s.nStorage }</td>
					<td>${s.nModel }</td>
					<td>${s.nProductType }</td>
					<td>${s.nVolid }</td>
					<td>${s.nLightDesc }</td>
					<td>${s.chipVer }</td>
					<td>${s.lopCaption }-</td>
					<td>${s.wldCaption }</td>
					<td>${s.irCaption }</td>
					<td>${s.vfCaption }</td>
					<td>${s.raCaption }</td>
					<td>${s.cCTCaption }</td>
					<td>${s.wLPCaption }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 单位依旧为k的 -->
	${errork_glag }
	<br>
	<c:if test="${not empty errork_glag }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${BatchPrefix }" var="k">
				<tr>
					<td>${k.relationID }</td>
					<td>${k.productType }</td>
					<td>${k.unitType }</td>
					<td>${k.unitSize }</td>
					<td>${k.unitElec }</td>
					<td>${k.relationVol }</td>
					<td>${k.productID }</td>
					<td>${k.k_Flag}</td>
					<td>${k.delQty }</td>
					<td>${k.modFlag }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 圆片无编码 -->
	${waferFreeCoding }
	<c:if test="${not empty waferFreeCoding }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${BatchPrefix }" var="k">
				<tr>
					<td>${k.relationID }</td>
					<td>${k.productType }</td>
					<td>${k.unitType }</td>
					<td>${k.unitSize }</td>
					<td>${k.unitElec }</td>
					<td>${k.relationVol }</td>
					<td>${k.productID }</td>
					<td>${k.k_Flag}</td>
					<td>${k.delQty }</td>
					<td>${k.modFlag }</td> 
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!--  方片无编码-->
	${squareFreeCoding }
	<c:if test="${not empty squareFreeCoding }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${BatchPrefix }" var="k">
				<tr>
					<td>${k.relationID }</td>
					<td>${k.productType }</td>
					<td>${k.unitType }</td>
					<td>${k.unitSize }</td>
					<td>${k.unitElec }</td>
					<td>${k.relationVol }</td>
					<td>${k.productID }</td>
					<td>${k.k_Flag}</td>
					<td>${k.delQty }</td>
					<td>${k.modFlag }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!--  查看是否存在无法找到BIN表的命名规则-->
	${chackBinName }
	<c:if test="${not empty chackBinName }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${BatchPrefix }" var="k">
				<tr>
					<td>${k.relationID }</td>
					<td>${k.productType }</td>
					<td>${k.unitType }</td>
					<td>${k.unitSize }</td>
					<td>${k.unitElec }</td>
					<td>${k.relationVol }</td>
					<td>${k.productID }</td>
					<td>${k.k_Flag}</td>
					<td>${k.delQty }</td>
					<td>${k.modFlag }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 查看是否存在无法找到参数规则的命名规则 -->
	${chackParaName }
	<c:if test="${not empty chackBinName }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${BatchPrefix }" var="k">
				<tr>
					<td>${k.relationID }</td>
					<td>${k.productType }</td>
					<td>${k.unitType }</td>
					<td>${k.unitSize }</td>
					<td>${k.unitElec }</td>
					<td>${k.relationVol }</td>
					<td>${k.productID }</td>
					<td>${k.k_Flag}</td>
					<td>${k.delQty }</td>
					<td>${k.modFlag }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!--  查看有编码没参数范围的BIN表-->
	${codeNoScope }
	<c:if test="${not empty codeNoScope }">
		<table border="1">
			<tr>
				<td>nSize</td>
				<td>nElec</td>
				<td>nBin</td>
				<td>nLight</td>
				<td>nStorage</td>
				<td>nModel</td>
				<td>nProductType</td>
				<td>nVolid</td>
				<td>nLightDesc</td>
				<td>ChipVer</td>
				<td>LopCaption</td>
				<td>WldCaption</td>
				<td>IrCaption</td>
				<td>VfCaption</td>
				<td>RaCaption</td>
				<td>CCTCaption</td>
				<td>WLPCaption</td>
			</tr>
			<c:forEach items="${Code }" var="s">
				<tr>
					<td>${s.nSize }</td>
					<td>${s.nElec }</td>
					<td>${s.nBin }</td>
					<td>${s.nLight }</td>
					<td>${s.nStorage }</td>
					<td>${s.nModel }</td>
					<td>${s.nProductType }</td>
					<td>${s.nVolid }</td>
					<td>${s.nLightDesc }</td>
					<td>${s.chipVer }</td>
					<td>${s.lopCaption }-</td>
					<td>${s.wldCaption }</td>
					<td>${s.irCaption }</td>
					<td>${s.vfCaption }</td>
					<td>${s.raCaption }</td>
					<td>${s.cCTCaption }</td>
					<td>${s.wLPCaption }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!--  查看有参数没参数范围的BIN表-->
	${paraNoScope }
	<c:if test="${not empty paraNoScope }">
		<table border="1">
			<tr>
				<td>nSize</td>
				<td>nElec</td>
				<td>nBin</td>
				<td>nLight</td>
				<td>nStorage</td>
				<td>nModel</td>
				<td>nProductType</td>
				<td>nVolid</td>
				<td>nLightDesc</td>
				<td>ChipVer</td>
				<td>LopCaption</td>
				<td>WldCaption</td>
				<td>IrCaption</td>
				<td>VfCaption</td>
				<td>RaCaption</td>
				<td>CCTCaption</td>
				<td>WLPCaption</td>
			</tr>
			<c:forEach items="${Code }" var="s">
				<tr>
					<td>${s.nSize }</td>
					<td>${s.nElec }</td>
					<td>${s.nBin }</td>
					<td>${s.nLight }</td>
					<td>${s.nStorage }</td>
					<td>${s.nModel }</td>
					<td>${s.nProductType }</td>
					<td>${s.nVolid }</td>
					<td>${s.nLightDesc }</td>
					<td>${s.chipVer }</td>
					<td>${s.lopCaption }-</td>
					<td>${s.wldCaption }</td>
					<td>${s.irCaption }</td>
					<td>${s.vfCaption }</td>
					<td>${s.raCaption }</td>
					<td>${s.cCTCaption }</td>
					<td>${s.wLPCaption }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 查看跳转参数与BIN表范围冲突 -->
	${paraJumpBinCon }
	<c:if test="${not empty paraJumpBinCon }">
		nVolID--nLight--sPBinID--nBinFrom --nBinTo
	<c:forEach items="${Bin }" var="b">
     	${ b.nVolID}--${ b.nLight}--${ b.sPBinID}--${b.nBinFrom }--${b.nBinTo }     	
		</c:forEach>
	</c:if>
</body>
</html>
