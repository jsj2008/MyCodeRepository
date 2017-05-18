package jedi.ex02;

import jedi.v7.version.VersionFather;

public class Version extends VersionFather {

	@Override
	public void initVersion() {
		super.setName("CSTS1");
		super.setVersion("4.2");//xxx.xxx.xxx
		super.setSubVersion("1.1");//xxx.xxx.xx
		super.setBuildDate("2010-05-14");//yyyy-MM-dd
	}

	@Override
	public void initDescription() {		
	}
}
