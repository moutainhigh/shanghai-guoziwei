package com.softline.dao.report.impl;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.softline.common.Base;
import com.softline.common.Common;
import com.softline.controller.common.commonController;
import com.softline.dao.report.IReportOverseasAssetDao;
import com.softline.entity.Purchase;
import com.softline.entity.ReportOverseasAsset;

@Repository(value = "reportOverseasAssetDao")
/**
 * 
 * @author tch
 *
 */
public class ReportOverseasAssetDao implements IReportOverseasAssetDao{
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	/**
	 * 查询
	 * @param id 查询ID
	 * @return
	 */
	public ReportOverseasAsset getReportOverseasAsset(Integer id)
	{
		if(id==null)
			return new ReportOverseasAsset();
		StringBuilder  hql = new StringBuilder();
		hql.append(" from ReportOverseasAsset s where 1=1 and isdel=0 and id="+id);
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		return (ReportOverseasAsset) query.uniqueResult();
	}
	
	/**
	 * 根据审核实体ID和审核种类获取
	 * @param examineentityid
	 * @param examinekind
	 * @return
	 */
	public List<ReportOverseasAsset> getReportOverseasAssetList(ReportOverseasAsset entity ,Integer offsize,Integer pagesize)
	{
		if(entity==null)
			return new ArrayList<ReportOverseasAsset>();
		StringBuilder  hql = new StringBuilder();
		hql.append(" from ReportOverseasAsset s where 1=1 and isdel=0 ");
		if(entity!=null)
		{
			if(Common.notEmpty(entity.getOrg()) )
			{
				hql.append(" and s.org in( "+Common.dealinStr(entity.getOrg())+ ") ");
			}
			if(entity.getMonth()!=null )
			{
				hql.append(" and s.month = "+entity.getMonth()+ " ");
			}
			if(Common.notEmpty(entity.getStarttime()))
			{
				
				hql.append(" and s.date >= '"+entity.getStarttime()+ "' ");
			}
			if(Common.notEmpty(entity.getEndtime()))
			{
				hql.append(" and s.date <= '"+entity.getEndtime()+ "' ");
			}
			if(entity.getYear()!=null)
			{
				hql.append(" and s.year = "+entity.getYear()+ " ");
			}
			if(entity.getStatus()!=null)
			{
				hql.append(" and s.status = "+entity.getStatus()+ " ");
			}
			if(entity.getId()!=null)
			{
				hql.append(" and s.id = "+entity.getId()+ " ");
			}
			if(entity.getGetOperateType()!=null && entity.getGetOperateType().equals(Base.fun_examine))
			{
				hql.append(" and s.status != "+Base.examstatus_1+ " ");
			}
			if(Common.notEmpty(entity.getParentorg())){
				hql.append(" and (");
				String [] dd = entity.getParentorg().split(",");
				for(int i = 0; i < dd.length;i++){
					if(i == (dd.length -1)){
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' )");
					}else{
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' or ");
					}
				}
			}else{
				hql.append(" and s.parentorg like '%--%' ");
			}
			
		}
		hql.append(" order by year desc,month desc");
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		
		
		if(offsize!=null)
			query.setFirstResult(offsize);
		if(pagesize!=null)
			query.setMaxResults(pagesize);
		
		return query.list();
	
	}
	
	/**
	 * 数据导出
	 
	 * @return
	 */
	public List<ReportOverseasAsset> getExportReportOverseasAssetList(ReportOverseasAsset entity)
	{
		
		StringBuilder  hql = new StringBuilder();
		hql.append(" from ReportOverseasAsset s where 1=1 and isdel=0  ");
		if(entity!=null)
		{
			if(Common.notEmpty(entity.getOrg()) )
			{
				hql.append(" and s.org in( "+Common.dealinStr(entity.getOrg())+ ") ");
			}
			if(entity.getMonth()!=null )
			{
				hql.append(" and s.month = "+entity.getMonth()+ " ");
			}
			if(Common.notEmpty(entity.getStarttime()))
			{
				
				hql.append(" and s.date >= '"+entity.getStarttime()+ "' ");
			}
			if(Common.notEmpty(entity.getEndtime()))
			{
				hql.append(" and s.date <= '"+entity.getEndtime()+ "' ");
			}
			if(entity.getYear()!=null)
			{
				hql.append(" and s.year = "+entity.getYear()+ " ");
			}
			if(entity.getStatus()!=null)
			{
				hql.append(" and s.status = "+entity.getStatus()+ " ");
			}
			if(entity.getId()!=null)
			{
				hql.append(" and s.id = "+entity.getId()+ " ");
			}
			if(Common.notEmpty(entity.getParentorg())){
				hql.append(" and (");
				String [] dd = entity.getParentorg().split(",");
				for(int i = 0; i < dd.length;i++){
					if(i == (dd.length -1)){
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' )");
					}else{
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' or ");
					}
				}
			}else{
				hql.append(" and s.parentorg like '%--%' ");
			}
		}
		hql.append(" order by year desc,month desc");
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		
		return query.list();
	
	}
	
	/**
	 * 境外资产占比数据审核导出
	 
	 * @return
	 */
	public List<ReportOverseasAsset> getEReportOverseasAssetListViewExport(ReportOverseasAsset entity)
	{
		
		StringBuilder  hql = new StringBuilder();
		hql.append(" from ReportOverseasAsset s where 1=1 and isdel=0  ");
		if(entity!=null)
		{
			if(Common.notEmpty(entity.getOrg()) )
			{
				hql.append(" and s.org in( "+Common.dealinStr(entity.getOrg())+ ") ");
			}
			if(entity.getMonth()!=null )
			{
				hql.append(" and s.month = "+entity.getMonth()+ " ");
			}
			if(Common.notEmpty(entity.getStarttime()))
			{
				
				hql.append(" and s.date >= '"+entity.getStarttime()+ "' ");
			}
			if(Common.notEmpty(entity.getEndtime()))
			{
				hql.append(" and s.date <= '"+entity.getEndtime()+ "' ");
			}
			if(entity.getYear()!=null)
			{
				hql.append(" and s.year = "+entity.getYear()+ " ");
			}
			if(entity.getStatus()!=null)
			{
				hql.append(" and s.status = "+entity.getStatus()+ " ");
			}
			if(entity.getId()!=null)
			{
				hql.append(" and s.id = "+entity.getId()+ " ");
			}
			if(entity.getGetOperateType()!=null && entity.getGetOperateType().equals(Base.fun_examine))
			{
				hql.append(" and s.status != "+Base.examstatus_1+ " ");
			}
			if(Common.notEmpty(entity.getParentorg())){
				hql.append(" and (");
				String [] dd = entity.getParentorg().split(",");
				for(int i = 0; i < dd.length;i++){
					if(i == (dd.length -1)){
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' )");
					}else{
						hql.append(" s.parentorg like '%-"+dd[i]+ "-%' or ");
					}
				}
			}else{
				hql.append(" and s.parentorg like '%--%' ");
			}
			
		}
		hql.append(" order by year desc,month desc");
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		
		return query.list();
	
	}
	/**
	 * 根据审核实体ID和审核种类获取
	 * @param examineentityid
	 * @param examinekind
	 * @return
	 */
	public int getReportOverseasAssetListCount(ReportOverseasAsset entity)
	{
		if(entity==null)
			return 0;
		StringBuilder  hql = new StringBuilder();
		hql.append("select count(0) from ReportOverseasAsset s where 1=1 and isdel=0 ");
		if(entity!=null)
		{
			if(Common.notEmpty(entity.getOrg()) )
			{
				hql.append(" and s.org in( "+Common.dealinStr(entity.getOrg())+ ") ");
			}
			if(entity.getMonth()!=null )
			{
				hql.append(" and s.month = "+entity.getMonth()+ " ");
			}
			if(Common.notEmpty(entity.getStarttime()))
			{
				
				hql.append(" and s.date >= '"+entity.getStarttime()+ "' ");
			}
			if(Common.notEmpty(entity.getEndtime()))
			{
				hql.append(" and s.date <= '"+entity.getEndtime()+ "' ");
			}
			if(entity.getYear()!=null)
			{
				hql.append(" and s.year = "+entity.getYear()+ " ");
			}
			if(entity.getStatus()!=null)
			{
				hql.append(" and s.status = "+entity.getStatus()+ " ");
			}
			if(entity.getId()!=null)
			{
				hql.append(" and s.id = "+entity.getId()+ " ");
			}
			if(entity.getGetOperateType()!=null && entity.getGetOperateType().equals(Base.fun_examine))
			{
				hql.append(" and s.status != "+Base.examstatus_1+ " ");
			}
			if(Common.notEmpty(entity.getParentorg())){
				hql.append(" and (");
				String [] dd = entity.getParentorg().split(",");
				for(int i = 0; i < dd.length;i++){
					if(i == (dd.length -1)){
						hql.append(" s.authOrg like '%-"+dd[i]+ "-%' )");
					}else{
						hql.append(" s.authOrg like '%-"+dd[i]+ "-%' or ");
					}
				}
			}else{
				hql.append(" and s.authOrg like '%--%' ");
			}
			
		}
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		return Integer.parseInt(query.uniqueResult().toString());
	}
	
	
	/**
	 * 保存时校验重复的方法
	 * @param entity
	 * @return
	 */
	public boolean saveReportOverseasAssetRepeatCheck(ReportOverseasAsset entity)
	{

		StringBuilder  hql = new StringBuilder();
		hql.append("select count(0) from ReportOverseasAsset s where 1=1 and isdel=0  ");
		if(entity!=null)
		{
			if(Common.notEmpty(entity.getOrg()))
			{
				hql.append(" and s.org = '"+entity.getOrg()+ "' ");
			}
			if(entity.getMonth()!=null )
			{
				hql.append(" and s.month = "+entity.getMonth()+ " ");
			}
			if(entity.getYear()!=null)
			{
				hql.append(" and s.year = "+entity.getYear()+ " ");
			}
		
			if(entity.getId()!=null)
			{
				hql.append(" and s.id != "+entity.getId()+ " ");
			}
			
		}
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		Integer a= Integer.parseInt(query.uniqueResult().toString());
		if(a!=null && a.equals(0))
			return true;
		else
			return false;
	}
	
	/**
	 * 保存时检查数据是否被能修改
	 * @param entity
	 * @return
	 */
	public boolean checkCanEdit(ReportOverseasAsset entity)
	{
		StringBuilder  hql = new StringBuilder();
		hql.append("select count(0) from ReportOverseasAsset s where 1=1 and isdel=0 and status in("+Base.examCanEdit+") ");
		if(entity!=null)
		{
			
			if(entity.getId()!=null)
			{
				hql.append(" and id ="+entity.getId()  +"");
			}
			else
				return true;
		}
		
		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		Integer a= Integer.parseInt(query.uniqueResult().toString());
		if(a!=null && a.equals(0))
			return false;
		else
			return true;
	}
	
	

}
