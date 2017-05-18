package jedi.ex02.CSTS3.comm.fix.data;

import jedi.ex02.CSTS3.comm.fix.BasicFIXData;
import jedi.ex02.CSTS3.comm.fix.FIXbyteBuffer;
import jedi.ex02.CSTS3.comm.fix.FIXcommInterface;
import jedi.ex02.CSTS3.comm.fix.FIXdataUtil;
import jedi.ex02.CSTS3.comm.util.C3FormatUtil;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;

public class ObjectData4FIX extends BasicFIXData{
	
	public ObjectData4FIX() {
		super(FIXcommInterface.DATATYPE_OBJECT);
		
	}

	private Object obj;

	@Override
	public byte[] format() throws Exception {
		FIXbyteBuffer buffer = FIXbyteBuffer.getWriteInstance();
		buffer.writeInt(dataType, 2);
		buffer.writeInt(isZip, 1);
		buffer.writeInt(isEncrypt, 1);
		byte[] buf=C3FormatUtil.objectToByte(obj);
		if(isEncrypt==MTP4CommDataInterface.TRUE&&key!=null){
			buf=FIXdataUtil.encrypt(buf, key);
		}
		if(isZip==MTP4CommDataInterface.TRUE){
			buf=FIXdataUtil.zip(buf);
		}
		buffer.writeBuffer(buf);
		return buffer.getBuffer();
	}

	@Override
	public void parse() throws Exception {
		byte[] buf=this.dataBuffer;
		if(isZip==MTP4CommDataInterface.TRUE){
			buf=FIXdataUtil.unzip(buf);
		}
		if(isEncrypt==MTP4CommDataInterface.TRUE&&key!=null){
			buf=FIXdataUtil.decrypt(buf, key);
		}
		obj=C3FormatUtil.byteToObject(buf);
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

}
