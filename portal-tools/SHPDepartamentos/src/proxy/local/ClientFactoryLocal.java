package proxy.local;

import iclient.*;

public class ClientFactoryLocal extends ClientFactory {

        public IWorkManager createWorkManager() {
                return new WorkManagerLocal();
        }

        public IResultManager createResultManager() {
                return new ResultManagerLocal();
        }

}