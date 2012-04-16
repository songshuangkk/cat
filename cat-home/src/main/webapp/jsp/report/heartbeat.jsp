<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="w" uri="/web/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<jsp:useBean id="ctx" type="com.dianping.cat.report.page.heartbeat.Context" scope="request" />
<jsp:useBean id="payload" type="com.dianping.cat.report.page.heartbeat.Payload" scope="request" />
<jsp:useBean id="model" type="com.dianping.cat.report.page.heartbeat.Model" scope="request" />
<c:set var="report" value="${model.report}"/>

<a:report title="Heartbeat Report" navUrlPrefix="domain=${model.domain}" timestamp="${w:format(model.currentTime,'yyyy-MM-dd HH:mm:ss')}">

<jsp:attribute name="subtitle">From ${w:format(report.startTime,'yyyy-MM-dd HH:mm:ss')} to ${w:format(report.endTime,'yyyy-MM-dd HH:mm:ss')}</jsp:attribute>

<jsp:body>

<res:useCss value="${res.css.local.heartbeat_css}" target="head-css"/>
<res:useJs value="${res.js.local['jquery-1.7.1.js']}" target="head-js"/>

<br>
<table class="graph">
<svg version="1.1" width="980" height="380" xmlns="http://www.w3.org/2000/svg">
  ${model.activeThreadGraph}
  ${model.deamonThreadGraph}
  ${model.totalThreadGraph}
</svg>
</table>
<table class="heartbeat">
	<tr>
		<th>Minute</th>
		<th>ActiveThread</th>
		<th>DeamonThread</th>
		<th>StartedThead</th>
	</tr>
	<c:forEach var="item" items="${model.result.periods}" varStatus="status">
		<tr class="${status.index  mod 2==1 ? 'even' : 'odd'}">
		<td>${item.minute}</td>
		<td>${item.threadCount}</td>
		<td>${item.daemonCount}</td>
		<td>${item.totalStartedCount}</td>
		</tr>
	</c:forEach>
</table>

</jsp:body>
</a:report>