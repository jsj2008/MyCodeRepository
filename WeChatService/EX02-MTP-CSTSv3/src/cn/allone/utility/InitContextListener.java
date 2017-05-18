package cn.allone.utility;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class InitContextListener implements ServletContextListener {   
	public InitContextListener() {

    }
	
    
    @Override
    public void contextInitialized( ServletContextEvent arg0)  { 
    	Log4jWrapper.infoo( "%s - contextInitialized.", this.getClass().getName());
    	
    	ServletContext sc = arg0.getServletContext();
    }

    @Override
    public void contextDestroyed( ServletContextEvent arg0)  { 
    	Log4jWrapper.infoo( "%s - contextDestroyed.", this.getClass().getName());
    }
    	
}
