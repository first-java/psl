package file.dao;

import java.util.Map;

public interface FileUpDao {

	int exportData(Map<String, Object> mapList) throws Exception;
}
