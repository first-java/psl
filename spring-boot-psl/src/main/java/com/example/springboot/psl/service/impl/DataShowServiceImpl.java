package com.example.springboot.psl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springboot.psl.dao.DataShowServiceMapper;
import com.example.springboot.psl.entity.SysUser;
import com.example.springboot.psl.service.DataShowService;

/**
 * @ClassNmame SysUserServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午9:04:52
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class DataShowServiceImpl implements DataShowService {
	@Autowired(required=false)
	private DataShowServiceMapper dataShowServiceMapper;

	@Override
	public List<SysUser> queryAllDataFromTable(int page, int limit, String keyWord) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		page = page1;
		limit = limit1;
		return dataShowServiceMapper.queryAllDataFromTable(page, limit, keyWord);
	}

	@Override
	public int queryAllCount(String keyWord) {
		return dataShowServiceMapper.queryAllCount(keyWord);
	}

}
