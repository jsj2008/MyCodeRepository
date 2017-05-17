package comm.fix.data;

import server.define.DataTypeDefine;

import comm.CommDataUtil;
import comm.fix.BasicFIXData;
import comm.fix.FixByteBuffer;
import comm.fix.FixDataUtil;
import comm.fix.FixDateDefine;

public class ObjectData4FIX extends BasicFIXData {

	public ObjectData4FIX() {
		super(FixDateDefine.DATATYPE_OBJECT);

	}

	private Object obj;

	@Override
	public byte[] format() throws Exception {
		FixByteBuffer buffer = FixByteBuffer.getWriteInstance();
		buffer.writeInt(dataType, 2);
		buffer.writeInt(isZip, 1);
		buffer.writeInt(isEncrypt, 1);
		byte[] buf = CommDataUtil.objectToByte(obj);
		if (isZip == DataTypeDefine.TRUE) {
			buf = FixDataUtil.zip(buf);
		}
		if (isEncrypt == DataTypeDefine.TRUE && key != null) {
			buf = FixDataUtil.encrypt(buf, key);
		}

		buffer.writeBuffer(buf);
		return buffer.getBuffer();
	}

	@Override
	public void parse() throws Exception {
		byte[] buf = this.dataBuffer;
		if (isEncrypt == DataTypeDefine.TRUE && key != null) {
			buf = FixDataUtil.decrypt(buf, key);
		}
		if (isZip == DataTypeDefine.TRUE) {
			buf = FixDataUtil.unzip(buf);
		}
		obj = CommDataUtil.byteToObject(buf);
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

}
