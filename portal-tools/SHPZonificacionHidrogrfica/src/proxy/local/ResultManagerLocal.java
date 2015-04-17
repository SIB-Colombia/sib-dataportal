package proxy.local;

import java.util.List;

import iclient.IResultManager;
import model.Record;
import server.connection.object.ResultServerObject;

public class ResultManagerLocal implements IResultManager {

	private ResultServerObject rserver;

	public ResultManagerLocal() {
		rserver = new ResultServerObject();
	}

	@Override
	public boolean insertResult(String clientName, List<Record> data) {
		return rserver.insertResult(clientName, data);
	}

}