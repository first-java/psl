package com.csp.reportquery.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/** @ClassNmame s.java
  * @author 奥特虾不会写代码 
  * @author E-mail:pengshiliang@latticepower.com
  * @version 1.0
  * @time 创建时间：2020年4月17日 上午11:10:53
  * @Copyright © 2020 by 奥特虾不会写代码  
*/
public interface ReportBagHeService {
    List<ReportBagHe> queryBagHe(@Param("page") int page, @Param("limit") int limit, @Param("keyWord") String keyWord);

    Integer queryAllCount(String keyWord);
}
