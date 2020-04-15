package action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import com.opensymphony.xwork2.ActionSupport;

import entity.Psp;
import service.PspService;

public class DownloadAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String methodstr;
	public InputStream inputStream;
	public String fileName;
	private String query;
	private String querys;

	public String getMethodstr() {
		return methodstr;
	}

	public void setMethodstr(String methodstr) {
		this.methodstr = methodstr;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getQuerys() {
		return querys;
	}

	public void setQuerys(String querys) {
		this.querys = querys;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getFileName() throws UnsupportedEncodingException {
		return new String(fileName.getBytes(), "ISO8859-1");

	}

	public void setFileName(String fileName) throws UnsupportedEncodingException {
		this.fileName = new String(fileName.getBytes("utf-8"), "ISO8859-1");

	}

	@Resource
	private PspService pspService;

	private String downLoad() {
		StringBuffer sb = new StringBuffer();
		Psp bi = new Psp();

		List<Psp> blist = pspService.downLoad(bi);

		sb.append("机种号,");
		sb.append("产品,");
		sb.append("显指,");
		sb.append("色区,");
		sb.append("亮度,");
		sb.append("电压,");

		sb.append("\n");

		for (Psp prefix : blist) {
			sb.append(prefix.getModelNo() + ",");
			sb.append(prefix.getProduct() + ",");
			sb.append(prefix.getsRa() + ",");
			sb.append(prefix.getCz() + " ,");
			sb.append(prefix.getLuminance() + ",");
			sb.append(prefix.getTension() + ",");
			sb.append("\n");
		}
		inputStream = new ByteArrayInputStream(sb.toString().getBytes());

		fileName = "三星机种号拆分结果.csv";

		return "success";
	}

	public String execute() throws Exception {

		if ("downLoad".equals(methodstr)) {

			return downLoad();

		}

		return methodstr;

	}
}
