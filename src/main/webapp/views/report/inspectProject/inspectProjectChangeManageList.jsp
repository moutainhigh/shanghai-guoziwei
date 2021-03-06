<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>稽核整改信息维护</title>
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
	<h4>稽核整改信息维护</h4>
	<div class="table_content">
		<form id="form1" class="row">
			<span class="col-md-4"> <span class="search_title">年份： </span><input type="text" name="year"
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
				<input name="compName" id="compName" value="" readonly title="">
				<div class="com_ztree_box"
					style="display:none;height:auto;overflow:auto;max-height:300px;box;min-width:63%;position:absolute;left:6rem;background-color:#fff;z-index: 1;">
					<ul id="com_ztree" class="ztree">
					</ul>
				</div> <i class="clear iconfont icon-guanbi"></i> 
			</span> 
			<span class="col-md-4"><span class="search_title">稽核状态：</span>
				<select name="status" class="selectpicker">
					<option value="">全部</option>
					<option value="80043" <c:if test="${entity.status == 80043}">selected="selected"</c:if>>办结确认</option>
					<option value="80044" <c:if test="${entity.status == 80044}">selected="selected"</c:if>>整改中</option>
					<option value="80045" <c:if test="${entity.status == 80045}">selected="selected"</c:if>>稽核完结</option>
				</select> 
			</span>
			<span class="col-md-4">稽核财务事项名称：
				<input type="text" name=itemName value="${entity.itemName}"  class="w25" style="width: calc(100% - 11em);" />
			</span>
			<br>
			<br>
			<div class="form_div col-md-12">
				<c:if test="${fn:contains(gzwsession_code,',bimWork_jhzgxxwh_query,')==true }">
					<input type="button" value="查询" class="form_btn" id="qrybtn" onclick="_query()">
				</c:if>
				<input type="button" value="导出" class="form_btn" id="exportbtn" onclick="_export()">
				
				<!-- <input type="button" value="导出" class="form_btn" id="exportbtn" onclick="mload('${mapurl}/export')"> -->
			</div>
		</form>
		<div class="tablebox">
			<table>
				<tr class="table_header">
					<th style="width:3%" >序号</th>
					<th style="width:6%" >年份</th>
					<th style="width:16%" >稽核公司</th>
					<th style="width:23%" >稽核财务事项名称</th>
					<th style="width:7%" >稽核事项负责人</th>
					<th style="width:7%" >状态标识</th>
					<th style="width:15%" >操作</th>
				</tr>
				
				<c:if test="${!empty requestScope.msgPage.list }">
					<c:set var="recordNumber"
						value="${(requestScope.msgPage.pageNum - 1) * 10 }" />
					<c:forEach items="${ requestScope.msgPage.list}" var="l"
						varStatus="status">
						<tr>
							<td style="text-align: center;">${recordNumber+ status.index + 1 }</td>
							<td style="text-align: center;">${l.year}</td>
							<td style="text-align: left;">${l.compName}</td>
							<td style="text-align: left;">${l.itemName}</td>
							<td style="text-align: left;">${l.itemPerson}</td>
							<td>${l.statusName}</td>
							<td style="text-align: left;">
							    <c:if test="${fn:contains(gzwsession_code,',bimWork_jhzgxxwh_view,')==true }">
									<a href="javascript:void(0)" onclick="mload('${mapurl}/changeManageView?op=modify&id=${l.id}')">查看</a>
								 </c:if>
								<c:if test="${ l.status!=80045}">
								    <c:if test="${fn:contains(gzwsession_code,',bimWork_jhzgxxwh_edit,')==true }">
										<a href="javascript:void(0)" onclick="mload('${mapurl}/changeManageView?id=${l.id}&isEdit=true')">整改</a>
									</c:if>
									<c:if test="${fn:contains(gzwsession_code,',bimWork_jhzgxxwh_archive,')==true }">
										<a href="javascript:void(0);" onclick="changeArchive(${l.id})">归档</a>
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
    		<c:if test="${entity.compId != null && entity.compId!=''}">
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
		
		function _export() {
		var form = document.forms[0];
		form.action = "${pageContext.request.contextPath}/inspectproject/leaderShExport";
		form.method = "post";
		form.submit();
		}
		function changeArchive(id){
			 
			parent.win.confirm('确定要归档吗？',function(r){
				if(r){
					var url = "${pageContext.request.contextPath}/inspectproject/saveChangeManageArchive";
					var param = {id: id};
					$.post(url, param, function(data) {
						if(data.result){
							win.successAlert('归档成功！',_query);
						}else{
							win.errorAlert(data.exceptionStr,_query);
						}
					});
				}
			});
		}
		
		$('.clear').on('click',function(){
			$(this).siblings("input[name='compId']").val("");
			$(this).siblings("input[name='compName']").val("");
		});
	</script>
</html>