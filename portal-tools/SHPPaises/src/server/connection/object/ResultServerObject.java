package server.connection.object;

import java.util.List;

import iserver.IResultServer;
import model.Record;
import server.database.PortalInterface;

public class ResultServerObject implements IResultServer {

	@Override
	public boolean insertResult(String clientName, List<Record> data) {
		return PortalInterface.getInstance().insertResult(clientName, data);
	}

}