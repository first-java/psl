package service;

import java.util.List;

import entity.Psp;

public interface PspService {

	public boolean save(List<Psp> psp);// �ϴ�

	public boolean saveTmp(List<Psp> psp);// �ϴ�

	public List<Psp> getOne(Psp psp);// 查询

	public List<Psp> getTwo(Psp psp);// 查询

	public int del(Psp psp);
	
	public List<Psp> downLoad(Psp psp);
}
