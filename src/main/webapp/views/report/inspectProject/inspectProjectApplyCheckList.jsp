<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>申请办结项目审核</title>
<link rel="stylesheet" href="<c:url value="/css/lin_1.css"/>">
<link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>" />
<link rel="stylesheet" href="<c:url value="/font/iconfont.css"/>" />
<!-- 库|插件 -->
<!-- 新加样式 -->
<link rel="stylesheet" href="<c:url value="/css/bootstrap_self.css"/>">
<link rel="stylesheet" href="<c:url value="/css/iframe.css"/>">
<link rel="stylesheet" href="<c:url value="/css/jedate.css"/>">
<script src="<c:url value="/js/jquery-3.1.1.min.js"/>" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/zTreeStyle.css"/>">
</head>
<body>
	<h4>申请办结项目审核</h4>
	<div class="table_content">
		<form id="form1" class="row">
			<span class="col-md-4"><span class="search_title">年份：</span>  <input type="text" name="year"
				value="${entity.year}" readonly="true" class="time" /> 
			</span> 
			<span class="col-md-4"> <span class="search_title">稽核类型：</span>
				<select name="inspectType" class="selectpicker">
					<option value="">全部</option>
					<c:forEach items="${requestScope.inspectType}" var="result">
						<option value="${result.id }" <c:if test="${entity.inspectType == result.id}">selected="selected"</c:if>>${result.description}</option>
					</c:forEach>
				</select> 
			</span> 
			<span class="col-md-4"> <span class="search_title">稽核公司：</span>
				<input type="hidden" id="compId" name="compId" value="">
				<input name="compName" id="compName" value="" readonly title="" >
				<div class="com_ztree_box"
					style="display:none;height:auto;overflow:auto;max-height:300px;box;min-width:63%;position:absolute;left:6rem;background-color:#fff;z-index: 1;">
					<ul id="com_ztree" class="ztree">
					</ul>
				</div> <i class="clear iconfont icon-guanbi"></i> 
			</span> 
			<span class="col-md-4">稽核财务事项名称：
				<input type="text" name=itemName value="${entity.itemName}"  class="w25" style="width: calc(100% - 11em);"/>
			</span>
			<br>
			<br>
			<div class="form_div col-md-12">
			    <c:if test="${fn:contains(gzwsession_code,',bimWork_sqbjxmsh_query,')==true }">
				  <input type="button" value="查询" class="form_btn" id="qrybtn" onclick="_query()">
				</c:if>
				<!-- <input type="button" value="导出" class="form_btn" id="exportbtn" onclick="mload('${mapurl}/export')"> -->
			</div>
		</form>
		<div class="tablebox">
			<table>
				<tr class="table_header">
					<th style="width:3%" >序号</th>
					<th style="width:25%" >稽核财务事项名称</th>
					<th style="width:10%">稽核事项负责人</th>
					<th style="width:15%" >稽核起止时间</th>
					<th style="width:10%" >发现问题数</th>
					<th style="width:10%" >需整改问题数</th> 
					<th style="width:15%" >操作</th>
				</tr>
				
				<c:if test="${!empty requestScope.msgPage.list }">
					<c:set var="recordNumber"
						value="${(requestScope.msgPage.pageNum - 1) * 10 }" />
					<c:forEach items="${ requestScope.msgPage.list}" var="item" varStatus="status">
						<tr>
							<td style="text-align: center;">${recordNumber+ status.index + 1 }</td>
							<td style="text-align: left;">${item[1]}</td>
							<td style="text-align: left;">${item[2]}</td>
							<td style="text-align: center;">${item[3]}~${item[4]}</td>
							<td style="text-align: right;">${item[5]}</td>
							<td style="text-align: right;">${item[6]}</td>
							<td style="text-align: center;">
							  <c:if test="${fn:contains(gzwsession_code,',bimWork_sqbjxmsh_view,')==true }">
							  	<a href="javascript:void(0)" onclick="mload('${mapurl}/applyCheckView?id=${item[0]}')">查看</a>
							  </c:if>
							  <c:if test="${fn:contains(gzwsession_code,',bimWork_sqbjxmsh_check,')==true }">
							  	<a href="javascript:void(0)" onclick="mload('${mapurl}/applyCheckView?id=${item[0]}&isEdit=true')">审核</a>
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
<script src="<c:url value="/js/jquery.ztree.all.min.js"/>" type="text/javascript"></script>
<script type="text/javascript">
		var timeoutId
 		$('#compName').on('focus click',function(){
 			$(this).next('.com_ztree_box').css('display','block')
 		}).parent().on('mouseenter',function(){
 			clearTimeout(timeoutId)
 		}).on('mouseleave',function(){
 			clearTimeout(timeoutId)
 			timeoutId = setTimeout(function(el){
 				$(el).find('.com_ztree_box').css('display','none')
 			},3e2,this);
 		})
	
		var zTreeObj;
	    var com_ztree_setting = {
			check:{
				enable:false,
				chkStyle: "checkbox",
				chkboxType: { "Y": "ps", "N": "ps" }
			},
			data:{
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pId",
					rootPId: 0
				}
			}
	    };
	    
	    $(function () {
		     //所有企业数据	
		    var com_data = ${allCompanyTree};
	    	zTreeObj = $.fn.zTree.init($("#com_ztree"), com_ztree_setting, com_data);
	    	//将每一个tree节点进行遍历，获取Id，与此角色已保存的Id（checked_data）进行比较，Id相同择设为选中
	    	var treeObj = $.fn.zTree.getZTreeObj("com_ztree");
			var nodes = treeObj.getNodes();
			
			//transformToArray()此方法获取所有节点（父节点和子节点）
    		var childrenNodes = treeObj.transformToArray(nodes);
    		if(childrenNodes[0]!=null)
    			treeObj.expandNode(childrenNodes[0],true);
    		<c:if test="${entity.compId != null && entity.compId!='' }">
    		var nodes = treeObj.getNodeByParam("id", "${entity.compId}", null);
    		if(nodes){
    			 $("#compId").val(nodes.id)
				 $("#compName").val(nodes.name);
    		}
    		</c:if>
	    });
	
		$("#com_ztree").click(function(){
				setTimeout(function(){
	   				if($.fn.zTree.getZTreeObj("com_ztree").getSelectedNodes()[0])
						{
							 $("#compId").val($.fn.zTree.getZTreeObj("com_ztree").getSelectedNodes()[0].id)
							 $("#compName").val($.fn.zTree.getZTreeObj("com_ztree").getSelectedNodes()[0].name);
						}
			   	});
			
		})

		$(' input.time').jeDate({
				format:"YYYY"
			}
		);
	
		function _query(){
			var form = document.forms[0];
			form.action = "${searchurl}";
			form.method = "post";
			form.submit();
		}
		
		$('.clear').on('click',function(){
			$(this).siblings("input[name='compId']").val("");
			$(this).siblings("input[name='compName']").val("");
		});
	</script>

</html>