package comm.fix;

public interface FixDateDefine {

	// int VALUETYPE_STRING=0;
	// int VALUETYPE_DOUBLE=1;

	int DATATYPE_ECHO = 0;
	int DATATYPE_OBJECT = 1;
	int DATATYPE_QUOTE = 2;

	int LENGTHHEADLEN = 8;

	int IDX_TYPE = 0;
	int IDX_OBJECT = 1;
	int IDX_INSTRUMENT = 2;
	int IDX_INSTRUMENTTYPE = 3;
	int IDX_QUOTETIME = 4;
	int IDX_OPENPRICE = 5;
	int IDX_HIGHPRICE = 6;
	int IDX_LOWPRICE = 7;
	int IDX_YCLOSEPRICE = 8;
	int IDX_BID = 9;
	int IDX_ASK = 10;
	int IDX_LASTBID = 11;
	int IDX_TRADEABLE = 12;
	int IDX_CLOSE = 13;
	int IDX_QUOTEDAY = 14;
	int IDX_TRADEVOLUME = 15;
	int IDX_LOTS = 16;

}
