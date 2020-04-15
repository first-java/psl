package file.dao;

import java.util.List;

import entity.Psp;

public interface PspDao {

	public boolean save(Psp psp);// �ϴ�

	public boolean saveTmp(Psp psp);// �ϴ�

	public List<Psp> getOne(Psp psp);// 查询

	public List<Psp> getTwo(Psp psp);// 查询

	public int del(Psp psp); //删除
	
	public int drop(); //删除PSP_TMP_DETIAL 
	
	public List<Psp> downLoad(Psp psp);

}
