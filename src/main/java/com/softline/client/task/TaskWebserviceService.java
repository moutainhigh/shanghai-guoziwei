package com.softline.client.task;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Logger;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;

/**
 * This class was generated by the JAX-WS RI. JAX-WS RI 2.1.3-hudson-390-
 * Generated source version: 2.0
 * <p>
 * An example of how this class may be used:
 * 
 * <pre>
 * TaskWebserviceService service = new TaskWebserviceService();
 * ITaskWebservice portType = service.getTaskWebservicePort();
 * portType.saveTaskInstruction(...);
 * </pre>
 * 
 * </p>
 * 
 */
@WebServiceClient(name = "TaskWebserviceService", targetNamespace = "http://imp.webService.softline.com/", wsdlLocation = "http://127.0.0.1:8080/bim_task/cxf/cxfService?WSDL")
public class TaskWebserviceService extends Service {

	private final static URL TASKWEBSERVICESERVICE_WSDL_LOCATION;
	private final static Logger logger = Logger
			.getLogger(com.softline.client.task.TaskWebserviceService.class
					.getName());

	static {
		URL url = null;
		try {
			URL baseUrl;
			baseUrl = com.softline.client.task.TaskWebserviceService.class
					.getResource(".");
			url = new URL(baseUrl,
					"http://127.0.0.1:8080/bim_task/cxf/cxfService?WSDL");
		} catch (MalformedURLException e) {
			logger.warning("Failed to create URL for the wsdl Location: 'http://127.0.0.1:8080/bim_task/cxf/cxfService?WSDL', retrying as a local file");
			logger.warning(e.getMessage());
		}
		TASKWEBSERVICESERVICE_WSDL_LOCATION = url;
	}

	public TaskWebserviceService(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	public TaskWebserviceService() {
		super(TASKWEBSERVICESERVICE_WSDL_LOCATION, new QName(
				"http://imp.webService.softline.com/", "TaskWebserviceService"));
	}

	/**
	 * 
	 * @return returns ITaskWebservice
	 */
	@WebEndpoint(name = "TaskWebservicePort")
	public ITaskWebservice getTaskWebservicePort() {
		return super.getPort(new QName("http://imp.webService.softline.com/",
				"TaskWebservicePort"), ITaskWebservice.class);
	}

}
