<%@ page language="java" import="java.util.* " pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
    String path = request.getContextPath();
    String basePath =
        request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%
    InetAddress hostAndIP = null;

    byte[] mac = new byte[0];
    try {
        hostAndIP = hostAndIP.getLocalHost();
        mac = NetworkInterface.getByInetAddress(hostAndIP).getHardwareAddress();
    } catch (SocketException e) {
    } catch (UnknownHostException e) {
    }
    StringBuffer buffer = new StringBuffer("");
    for (int i = 0; i < mac.length; i++) {
        if (i != 0) {
            buffer.append("-");
        }
        //字节转换为整数
        int temp = mac[i] & 0xff;
        String str = Integer.toHexString(temp);
        if (str.length() == 1) {
            buffer.append("0" + str);
        } else {
            buffer.append(str);
        }
    }
    String mac1 = buffer.toString();
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html class="signin no-js" lang="zh">
<head>
<link type="favicon" rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="description" content="postek browser printer">
<meta name="keywords" content="postek">
<title> </title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assert/bootstrap/css/bootstrap.min.css">
<script
	src="<%=request.getContextPath()%>/assert/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/assert/js/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/csppailiao.css">
</head>
<body class="main-body">

	<input value=<%=mac1%> name="userMacAddr" size="20" style="width:150px"
		readonly="yes">

</body>
</html>