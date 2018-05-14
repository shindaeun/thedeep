<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<meta content="width=device-width, initial-scale=1" name="viewport">
<meta content="Webflow" name="generator">
<link href="/css/normalize.css" rel="stylesheet" type="text/css">
<link href="/css/webflow.css" rel="stylesheet" type="text/css">
<link href="/css/home.css" rel="stylesheet" type="text/css">
<link href="/css/product.css" rel="stylesheet" type="text/css">
<link href="/css/board.css" rel="stylesheet" type="text/css">
<link href="/css/jquery-ui.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
	!function(o, c) {
		var n = c.documentElement, t = " w-mod-";
		n.className += t + "js", ("ontouchstart" in o || o.DocumentTouch
				&& c instanceof DocumentTouch)
				&& (n.className += t + "touch")
	}(window, document);
</script>
<link href="https://daks2k3a4ib2z.cloudfront.net/img/favicon.ico"
	rel="shortcut icon" type="image/x-icon">
<link href="https://daks2k3a4ib2z.cloudfront.net/img/webclip.png"
	rel="apple-touch-icon">
</head>


<body class="body">

	<tiles:insertAttribute name="topMenu" />
	<header class="section"></header>
	<div>
		<div class="w-row">
			<div class="w-col w-col-1"></div>
			<div class="w-col w-col-2">
				<tiles:insertAttribute name="leftMenu" />
			</div>
			<div class="w-col w-col-7">
				<tiles:insertAttribute name="content" />
			</div>
			<div class="w-col w-col-2"></div>
		</div>
	</div>

	<div>

		<div class="w-row">
			
				<tiles:insertAttribute name="footer" />
			
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		type="text/javascript"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
	<script src="js/webflow.js" type="text/javascript"></script>
	<!-- [if lte IE 9]><script src="https://cdnjs.cloudflare.com/ajax/libs/placeholders/3.0.2/placeholders.min.js"></script><![endif] -->

</body>


</html>
