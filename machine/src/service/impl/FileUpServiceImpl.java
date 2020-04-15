package service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import entity.Psp;
import file.dao.FileUpDao;
import file.dao.PspDao;
import service.FileUpService;
import service.PspService;
import service.Psp_detialService;
import service.Psp_detial_2Service;

@Service("fileUpService")
@Transactional
public class FileUpServiceImpl implements FileUpService {
	@Resource
	FileUpDao fileUpDao;
	@Resource
	PspDao smd;
	@Resource
	private PspService pspService;
	@Resource
	private Psp_detialService psp_detialService;
	@Resource
	private Psp_detial_2Service psp_detial_2Service;
	Psp oemList = new Psp();

	@SuppressWarnings("unchecked")
	@Transactional
	@Override
	public int exportData(Map<String, Object> mapList) throws Exception {
		// HttpServletRequest request = ServletActionContext.getRequest();
	
		if (mapList != null) {
			del();
			try {

				saveSpe((List<Psp>) mapList.get("binData"));
				saveSpe1((List<Psp>) mapList.get("binData"));
				del1();
				createTable();
				del2();
				createTable2();
			} catch (Exception e) {
				mapList.put("errorCode", 2);

				System.out.println(e);
				throw new Exception();

			}

		}

		return 0;
	}

	private void saveSpe(List<Psp> psp) throws Exception {

		if (psp != null && psp.size() > 0) {

			pspService.save(psp);

		}

	}

	private void saveSpe1(List<Psp> psp) throws Exception {

		if (psp != null && psp.size() > 0) {

			pspService.saveTmp(psp);
		}
	}

	public void del() throws IOException {

		pspService.del(oemList);

	}

	public void del1() throws IOException {

		psp_detialService.del();
	}

	public void del2() throws IOException {

		psp_detial_2Service.del();

	}

	public void createTable() throws IOException {

		psp_detialService.creatTable();

	}

	public void createTable2() throws IOException {

		psp_detial_2Service.creatTable();

	}

}
