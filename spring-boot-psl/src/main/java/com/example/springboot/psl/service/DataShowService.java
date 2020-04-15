package com.example.springboot.psl.service;

import java.util.List;

import com.example.springboot.psl.entity.SysUser;

/**
 * @ClassNmame SysUserService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午9:04:18
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface DataShowService  {
	 List<SysUser> queryAllDataFromTable(int page, int limit, String keyWord);
	 
	    int queryAllCount(String keyWord);
}
