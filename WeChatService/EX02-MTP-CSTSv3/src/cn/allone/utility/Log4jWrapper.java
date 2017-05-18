package cn.allone.utility;

import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;

/**
 * A wrapper of org.apache.log4j.Logger to avoid unnecessary string concatenation
 * of disabled log level.
 * 
 * @author Brian
 */
public class Log4jWrapper
{
    private static final ThreadLocal<Log4jWrapper> threadLogger_;
    private static final Log4jWrapper genericLogger_;
    
    static {
        threadLogger_ = new ThreadLocal<Log4jWrapper>();
        genericLogger_ = new Log4jWrapper( "generic" );
        DailyRollingFileAppender appender = (DailyRollingFileAppender) genericLogger_.logger_.getAppender( "generic");
        appender.setEncoding("UTF-8");
    }    
    
    public static Level switchDebugging() {
        return genericLogger_._switchDebugging();
    }
    
    /** Sets the logger within current thread */
    public static void setThreadLogger( String loggerId ) {
        setThreadLogger( loggerId, "yyyy-MM", true, true );
    }
    public static void setThreadLogger( String loggerId, String fileNamePattern, boolean log2Console, boolean log2Generic ) {
        threadLogger_.set( _createThreadLogger(loggerId, fileNamePattern, log2Console, log2Generic ) );
    }
    
    public static Level getLevel() {
        return _getThreadLogger().logger_.getLevel();
    }
    
    public static void setLevel( Level logLevel ) {
        _getThreadLogger().logger_.setLevel( logLevel );
    }
    
    
    public static void debugg( String msgPattern, Object... args ) {
        _getThreadLogger().debug( msgPattern, args );
    }

    public static void infoo( String messagePattern, Object... args ) {
        _getThreadLogger().info( messagePattern, args );
    }
    
    public static void warnn( String messagePattern, Object... args ) {
        _getThreadLogger().warn( messagePattern, args );
    }
    
    public static void warnn( Throwable t, String messagePattern, Object... args ) {
        _getThreadLogger().warn( t, messagePattern, args );
    }
    
    public static void errorr( String messagePattern, Object... args ) {
        _getThreadLogger().error( messagePattern, args );
    }
    
    public static void errorr( Throwable t, String messagePattern, Object... args ) {
        _getThreadLogger().error( t, messagePattern, args );
    }

    public static void fatall( String messagePattern, Object... args ) {
        _getThreadLogger().fatal( messagePattern, args );
    }
    
    public static void fatall( Throwable t, String messagePattern, Object... args ) {
        _getThreadLogger().fatal( t, messagePattern, args );
    }
    
    
    private static Log4jWrapper _getThreadLogger() {
        Log4jWrapper rv = threadLogger_.get();
        return rv!=null? rv : genericLogger_;
    }

    private static synchronized Log4jWrapper _createThreadLogger( String loggerId, String fileNamePattern, boolean log2Console, boolean log2Generic ) {
        Log4jWrapper rv = new Log4jWrapper( loggerId );
        rv.logger_.setLevel( Logger.getLogger("thread").getLevel() );
        DailyRollingFileAppender appender = (DailyRollingFileAppender) rv.logger_.getAppender( loggerId );
        if( appender == null ) {
            appender = new DailyRollingFileAppender();
            appender.setName( loggerId );
            appender.setLayout( new PatternLayout("%d %-5p - %m%n") );
            appender.setFile( String.format("log/%s.log", loggerId) );
            appender.setDatePattern( fileNamePattern );
            appender.setAppend( true );
            appender.activateOptions();
            appender.setImmediateFlush( true );
            appender.setEncoding("UTF-8");
            
            rv.logger_.addAppender( appender );
            if( log2Console )
                rv.logger_.addAppender( Logger.getLogger("generic").getAppender("console") );
            if( log2Generic )
                rv.logger_.addAppender( Logger.getLogger("generic").getAppender("generic") );
        }
        return rv;
    }


    
    //================================================================================================================
    // instance declaration
    //================================================================================================================
    private Logger logger_;
    private Level level_;
    
    public Log4jWrapper( String log4jCategory )
    {
        logger_ = Logger.getLogger( log4jCategory );
    }
    
    public Logger getLogger_() {
    	return logger_;
    }

    private Level _switchDebugging() {
        if( level_ == null ) {
            level_ = logger_.getLevel();
            logger_.setLevel( Level.DEBUG );
        }
        else {
            logger_.setLevel( level_ );
            level_ = null;
        }
        return logger_.getLevel();
    }
    
    private void debug( String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.DEBUG ) )
            logger_.debug( String.format(messagePattern,args) );
    }
    
    private void info( String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.INFO ) )
            logger_.info( String.format(messagePattern,args) );
    }
    
    private void warn( String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.WARN ) )
            logger_.warn( String.format(messagePattern,args) );
    }
    
    private void warn( Throwable t, String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.WARN ) )
            logger_.warn( String.format(messagePattern,args), t );
    }
    
    private void error( String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.ERROR ) )
            logger_.error( String.format(messagePattern,args) );
    }
    
    private void error( Throwable t, String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.ERROR ) )
            logger_.error( String.format(messagePattern,args), t );
    }

    private void fatal( String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.FATAL ) )
            logger_.fatal( String.format(messagePattern,args) );
    }
    
    private void fatal( Throwable t, String messagePattern, Object... args )
    {
        if( logger_.isEnabledFor( Level.FATAL ) )
            logger_.fatal( String.format(messagePattern,args), t );
    }
}
