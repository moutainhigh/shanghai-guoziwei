package com.softline.client.show;

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
 * ShowWebserviceService service = new ShowWebserviceService();
 * IShowWebservice portType = service.getShowWebservicePort();
 * portType.getAllDefTaskDEF(...);
 * </pre>
 * 
 * </p>
 * 
 */
@WebServiceClient(name = "ShowWebserviceService", targetNamespace = "http://imp.webService.softline.com/", wsdlLocation = "http://127.0.0.1:8080/bim_show/cxf/cxfService?WSDL")
public class ShowWebserviceService extends Service {

	private final static URL SHOWWEBSERVICESERVICE_WSDL_LOCATION;
	private final static Logger logger = Logger
			.getLogger(com.softline.client.show.ShowWebserviceService.class
					.getName());

	static {
		URL url = null;
		try {
			URL baseUrl;
			baseUrl = com.softline.client.show.ShowWebserviceService.class
					.getResource(".");
			url = new URL(baseUrl,
					"http://127.0.0.1:8080/bim_show/cxf/cxfService?WSDL");
		} catch (MalformedURLException e) {
			logger.warning("Failed to create URL for the wsdl Location: 'http://127.0.0.1:8080/bim_show/cxf/cxfService?WSDL', retrying as a local file");
			logger.warning(e.getMessage());
		}
		SHOWWEBSERVICESERVICE_WSDL_LOCATION = url;
	}

	public ShowWebserviceService(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	public ShowWebserviceService() {
		super(SHOWWEBSERVICESERVICE_WSDL_LOCATION, new QName(
				"http://imp.webService.softline.com/", "ShowWebserviceService"));
	}

	/**
	 * 
	 * @return returns IShowWebservice
	 */
	@WebEndpoint(name = "ShowWebservicePort")
	public IShowWebservice getShowWebservicePort() {
		return super.getPort(new QName("http://imp.webService.softline.com/",
				"ShowWebservicePort"), IShowWebservice.class);
	}

}