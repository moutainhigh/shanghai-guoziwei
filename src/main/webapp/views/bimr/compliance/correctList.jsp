<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>合规调查整改信息维护</title>
<link rel="stylesheet" href="<c:url value="/css/lin_1.css"/>">
		<link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>" />
		<link rel="stylesheet" href="<c:url value="/font/iconfont.css"/>" />
		<!-- 库|插件 -->
		<!-- 新加样式 -->
		<link rel="stylesheet" href="<c:url value="/css/bootstrap_self.css"/>">
		<link rel="stylesheet" href="<c:url value="/css/iframe.css"/>">
		<link rel="stylesheet" href="<c:url value="/css/jedate.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/zTreeStyle.css"/>">
		<script src="<c:url value="/js/jquery-3.1.1.min.js"/>" charset="utf-8"></script>
</head>
<body class="hn_grey">
	<h4>合规调查整改信息维护</h4>
	<div class="table_content">
		<form id="form1" class="row">
			<span class="col-md-4"><span class="search_title">调查类型：</span>
				<select name="investigationType" class="selectpicker">
					<option value="">全部</option>
					<c:forEach items="${investigationType}" var="result">
						<option value="${result.id}" <c:if test="${entity.investigationType == result.id}">selected="selected"</c:if>>${result.description}</option>
					</c:forEach>
				</select> 
			</span>
			<span class="col-md-4"><span class="search_title">状态：</span>
				<select name="status" class="selectpicker" id="status">
				    <option value="">全部</option>
					<option value="81014" <c:if test="${entity.status ==81014}">selected="selected"</c:if>>整改中</option>
					<option value="81015" <c:if test="${entity.status ==81015}">selected="selected"</c:if>>已完成</option>
				</select> 
			</span>
			<span class="col-md-4"><span class="search_title">调查时间：</span> 
			  <input type="text" name="startTime" value="${entity.startTime}" readonly="true" class="time" style="width:calc(50% - 8em);"/> 
			  &nbsp;&nbsp;-&nbsp;&nbsp; 
			  <input type="text" name="endTime" value="${entity.endTime}" readonly="true" class="time" style="width:calc(50% - 8em);"/>
			</span> 
			<span class="col-md-4"><span class="search_title">项目名称：</span>
			  <input type="text" name="projectName" value="${entity.projectName}"/> 
			</span> 
			<br>
			<br>
			<div class="form_div col-md-12">
			     <c:if test="${fn:contains(gzwsession_code,',bimWork_hgdczgxxwh_query,')==true}">
				    <input type="button" value="查询" class="form_btn" id="qrybtn" onclick="_query()">
				 </c:if>
				 <%-- <input type="button" value="导出" class="form_btn" id="exportbtn" onclick="mload('${mapurl}/export')"> --%>
			</div>
		</form>
		<div class="tablebox">
			<table>
				<tr class="table_header">
					<th style="width:3%" >序号</th>
					<th style="width:6%" >调查单位(或人员)</th>
					<th style="width:21%" >项目名称</th>
					<th style="width:23%" >调查起止时间</th>
					<th style="width:7%" >调查类型</th>
					<th style="width:10%" >调查负责人</th>
					<th style="width:7%" >项目状态</th>
					<th style="width:18%" >操作</th>
				</tr>
				
				<c:if test="${!empty requestScope.msgPage.list }">
					<c:set var="recordNumber" value="${(requestScope.msgPage.pageNum - 1) * 10 }" />
					<c:forEach items="${ requestScope.msgPage.list}" var="l" varStatus="status">
						<tr>
							<td style="text-align: center;">${recordNumber+ status.index + 1 }</td>
							<td style="text-align: center;">${l.investigationDep }</td>
							<td style="text-align: left;">${l.projectName }</td>
							<td style="text-align: left;">${l.startTime }-${l.endTime }</td>
							<td style="text-align: left;">${l.investigationTypeName }</td>
							<td style="text-align: left;">${l.responsiblePerson }</td>
							<td style="text-align: center;">${l.statusName }</td>
							<td style="text-align: left;">
							    <c:if test="${fn:contains(gzwsession_code,',bimWork_hgdczgxxwh_show,')==true}">
							          <a href="javascript:void(0)" onclick="mload('${mapurl}/correctView?id=${l.id }')">查看</a> 
							     </c:if>
							     <c:if test="${ l.followPersionId==requestScope.use.vcEmployeeId }">
								    <c:if test="${ l.status == 81014 ||l.status == 81017 }">
								         <c:if test="${fn:contains(gzwsession_code,',bimWork_hgdczgxxwh_reactify,')==true}">
										      <a href="javascript:void(0)" onclick="mload('${mapurl}/correctView?id=${l.id }&isEdit=true')">整改</a>
										 </c:if>
										 <c:if test="${fn:contains(gzwsession_code,',bimWork_hgdczgxxwh_archiving,')==true}">
										       <a href="javascript:void(0)" onclick="javascript:saveCorrectArchive(${l.id})">归档</a>
									     </c:if>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.msgPage.list}">
					<tr>
						<td colspan="13" align="center">查询无记录</td>
					</tr>
				</c:if>
			</table>
			<jsp:include page="/views/system/page.jsp" />
		</div>
	</div>
	<jsp:include page="/views/system/modal.jsp" />
</body>
<link href="<c:url value="/css/window.css"/>" rel="stylesheet" />
<script src="<c:url value="/js/window.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.jedate.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js"/>"></script>
<script src="<c:url value="/js/jquery.ztree.all.min.js"/>" type="text/javascript"></script>
<script type="text/javascript">
	$('input.time').jeDate({
		format:"YYYY-MM-DD"
	});
	
	function _query(){
		var form = document.forms[0];
		form.action = "${searchurl}";
		form.method = "post";
		form.submit();
	}
	
	function saveCorrectArchive(id){
		parent.win.confirm('确定要归档合规调查整改信息吗？',function(r){
			if(r){
				$.blockUI({ message: '归档中', css: { width: '275px' } });
				var params ={id: id};
			
				var url = "${pageContext.request.contextPath}/bimr/compliance/saveCorrectStatus";
				$.post(url, params, function(data) {
					$.unblockUI();
					if(data.result==true){
						win.successAlert('归档审核中！', _query());
					}else{
					    win.errorAlert(data.exceptionStr, _query());
					}
				});
			}
		});
		
	}
</script>
</html>