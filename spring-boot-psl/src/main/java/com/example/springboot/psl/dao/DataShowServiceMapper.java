package com.example.springboot.psl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.springboot.psl.entity.SysUser;

/**
 * @ClassNmame SysUserService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午9:03:02
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface DataShowServiceMapper {
	List<SysUser> queryAllDataFromTable(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	int queryAllCount(String keyWord);
}
