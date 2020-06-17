package project.interline.report.util;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Properties;

import javax.servlet.jsp.tagext.TryCatchFinally;

import org.springframework.core.io.ClassPathResource;


public class getProperties {
	
	String IP="";
	
	
	public getProperties() {
		ClassPathResource resource = new ClassPathResource("user.properties");
		
		
		Properties properties = new Properties();
	   
	    try {
		    properties.load(resource.getInputStream());
		} catch (Exception e) {
			System.out.println(e);
		}
	    IP=properties.getProperty("IP","localhost:8888");
	    
	}


	public String getIP() {
		return IP;
	}
	public void setIP(String iP) {
		IP = iP;
	}


	@Override
	public String toString() {
		return "getProperties [IP=" + IP + "]";
	}
	

	
}
