package project.interline.report.util;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Properties;

import javax.servlet.jsp.tagext.TryCatchFinally;

import org.springframework.core.io.ClassPathResource;


public class getProperties {
	
	String ozIP="";
	String webIP="";
	
	
	public getProperties() {
		ClassPathResource resource = new ClassPathResource("user.properties");
		
		
		Properties properties = new Properties();
	   
	    try {
		    properties.load(resource.getInputStream());
		} catch (Exception e) {
			System.out.println(e);
		}
	    ozIP=properties.getProperty("ozIP","localhost:8888");
	    webIP=properties.getProperty("webIP","localhost:8888");
	    
	}


	public String getOzIP() {
		return ozIP;
	}


	public void setOzIP(String ozIP) {
		this.ozIP = ozIP;
	}


	public String getWebIP() {
		return webIP;
	}


	public void setWebIP(String webIP) {
		this.webIP = webIP;
	}


	@Override
	public String toString() {
		return "getProperties [ozIP=" + ozIP + ", webIP=" + webIP + "]";
	}
	
	




	
}
