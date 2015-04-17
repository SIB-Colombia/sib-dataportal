package iclient;

import java.util.List;
import model.Record;

/**
 * 
 * A communication interface for requesting work
 *
 */
public interface IWorkManager {

	/**
	 * @param clientName
	 *            to identify from where the request came
	 * @param quantity
	 *            of requesting records
	 * @return records to work
	 * @throws Exception
	 */
	public List<Record> getWork(String clientName) throws Exception;

}