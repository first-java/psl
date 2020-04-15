package service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import file.dao.Psp_detialDao;
import service.Psp_detialService;

@Service("psp_detialService")
@Transactional
public class Psp_detialServiceImpl implements Psp_detialService {

	@Resource
	Psp_detialDao pd;

	@Override
	public boolean del() {

		return pd.del();
	}

	@Override
	public boolean creatTable() {

		return pd.creatTable();
	}

}
