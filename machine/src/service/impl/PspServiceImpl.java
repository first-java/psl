package service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import entity.Psp;
import file.dao.PspDao;
import service.PspService;

@Service("pspService")
@Transactional
public class PspServiceImpl implements PspService {

	@Resource
	PspDao pd;

	@Override
	public boolean save(List<Psp> batchPrefix) {
		for (int i = 0; i < batchPrefix.size(); i++) {

			pd.save(batchPrefix.get(i));
		}
		return false;

	}

	@Override
	public List<Psp> getOne(Psp psp) {

		return pd.getOne(psp);
	}

	@Override
	public List<Psp> getTwo(Psp psp) {

		return pd.getTwo(psp);
	}

	@Override
	public int del(Psp psp) {

		return pd.del(psp);
	}

	@Override
	public boolean saveTmp(List<Psp> psp) {
		for (int i = 0; i < psp.size(); i++) {

			pd.saveTmp(psp.get(i));
		}
		return false;
	}

	@Override
	public List<Psp> downLoad(Psp psp) {
		
		return pd.downLoad(psp);
	}

}
