package service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import file.dao.Psp_detial_2Dao;
import service.Psp_detial_2Service;

@Service("psp_detial_2Service")
@Transactional
public class Psp_detial_2ServiceImpl implements Psp_detial_2Service {

	@Resource
	Psp_detial_2Dao pd;

	@Override
	public boolean del() {

		return pd.del();
	}

	@Override
	public boolean creatTable() {

		return pd.creatTable();
	}

}
