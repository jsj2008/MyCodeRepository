package allone.MTP.VerBank01.Ctrl.ca;

public class CAErrCodeDesc {
	
	
	private boolean en;

	private CAErrCodeDesc(boolean en) {
		this.en = en;
	}
	
	private String fnJSLanguageVer(String desc_tc, String desc_en) {
		return en ? desc_en : desc_tc;
	}
	
	public static boolean isSuccess(int errCode) {
		return errCode == 0;
	}
	
	public static String GetErrorMessage(int errCode) {
		return GetErrorMessage(errCode, false);
	}
	
	public static String GetErrorMessage(int errCode, boolean en){
		CAErrCodeDesc cd = new CAErrCodeDesc(en);
		
		String msg = "";
		switch(errCode){
		
			case 0:
		        msg += cd.fnJSLanguageVer("成功", "Success");  
		        break;
			case 5001:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 一般性錯誤", "[" + errCode + "] general error "); 
				break;
			case 5002:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 記憶體配置錯誤","[" + errCode + "] Memory Allocation Error"); 
				break;
			case 5003:
				msg += cd.fnJSLanguageVer("[" + errCode + "] Buffer too small","[" + errCode + "] Buffer too small"); 
				break;
			case 5005:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 參數錯誤","[" + errCode + "] Invalid parameter"); 
				break;
			case 5006:
				msg += cd.fnJSLanguageVer("[" + errCode + "] Invalid handle","[" + errCode + "] Invalid handle"); 
				break;
			case 5007:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 元件已過期","[" + errCode + "] TrialVersion Library is expired"); 
				break;
			case 5008:
				msg += cd.fnJSLanguageVer("[" + errCode + "] Base64 Encoding/Decoding Error","[" + errCode + "] Base64 Encoding/Decoding Error"); 
				break;

			case 5010:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到符合憑證","[" + errCode + "] certificate not found"); 
				break;
			case 5011:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 憑證已過期","[" + errCode + "] Certicate Expired"); 
				break;
			case 5012:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 憑證尚未有效","[" + errCode + "] Certificate can not be used now"); 
				break;

			case 5014:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 憑證主旨比對錯誤","[" + errCode + "] Certificate subject not match"); 
				break;

			case 5015:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到憑證發行者","[" + errCode + "] Unable to find certificate issuer"); 
				break;

			case 5016:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 憑證簽章值無效","[" + errCode + "] Certificate signature is invalid"); 
				break;

			case 5017:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 錯誤的金鑰使用方式","[" + errCode + "] Invalid ertificate keyusage"); 
				break;

			case 5020:
			case 5021:
			case 5022:
			case 5023:
			case 5024:
			case 5025:
			case 5026:
			case 5028:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 憑證已撤銷","[" + errCode + "] Certificate is revoked"); 
				break;

			case 5030:
				msg += cd.fnJSLanguageVer("[" + errCode + "] CRL 已過期","[" + errCode + "] CRL expired."); 
				break;
				
			case 5031:
				msg += cd.fnJSLanguageVer("[" + errCode + "] CRL 尚未有效","[" + errCode + "] CRL not yet valid."); 
				break;
				
			case 5032:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到 CRL ","[" + errCode + "] CRL not found."); 
				break;
				
			case 5034:
				msg += cd.fnJSLanguageVer("[" + errCode + "] CRL 的簽章值錯誤 ","[" + errCode + "] CRL signature invalid."); 
				break;
			case 5036:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 資料的簽章值錯誤 ","[" + errCode + "] Invalid data signature."); 
				break;
				
			case 5037:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 簽章的原文錯誤 ","[" + errCode + "] Content not match."); 
				break;

			case 5040:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 錯誤的憑證格式 ","[" + errCode + "] Incorrect Certificate format."); 
				break;

			case 5041:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 錯誤的 CRL 格式 ","[" + errCode + "] Incorrect CRL format."); 
				break;

			case 5042:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 錯誤的 PKCS#7 格式 ","[" + errCode + "] Incorrect PKCS7 format."); 
				break;
				
			case 5050:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到指定物件 ","[" + errCode + "] FS_RTN_OBJ_NOT_FOUND."); 
				break;
			case 5070:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 取消操作","[" + errCode + "] FS_RTN_OPERATION_CANCELED."); 
				break;
			case 5071:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 密碼不正確", "[" + errCode + "] FS_RTN_PASSWD_INVALID.");
				break;
				
			case 5204:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到私密金鑰 ","[" + errCode + "] FS_RTN_OBJ_NOT_FOUND."); 
				break;
			
			// PKCS#11 return code
			case 9005:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 此 PKCS#11 不支援此 Function ","[" + errCode + "] FSP11_RTN_OBJECT_NOT_EXIST."); 
				break;
			case 9006:
				msg += cd.fnJSLanguageVer("[" + errCode + "] PKCS#11 參數錯誤 ","[" + errCode + "] FSP11_RTN_ARGUMENTS_BAD."); 
				break;
				
			case 9039:
			case 9040:
				msg += cd.fnJSLanguageVer("[" + errCode + "] PKCS#11 Pin 碼錯誤 ","[" + errCode + "] FSP11_RTN_PIN_INCORRECT."); 
				break;
			case 9043:
				msg += cd.fnJSLanguageVer("[" + errCode + "] PKCS#11 Pin Lock ","[" + errCode + "] FSP11_RTN_PIN_INCORRECT."); 
				break;

			case 9056:
				msg += cd.fnJSLanguageVer("[" + errCode + "] Token 不存在 ","[" + errCode + "] FSP11_RTN_TOKEN_NOT_PRESENT."); 
				break;
			
			case 9100:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 物件不存在 ","[" + errCode + "] FSP11_RTN_OBJECT_NOT_EXIST."); 
				break;
			case 9101:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 物件已存在 ","[" + errCode + "] FSP11_RTN_OBJECT_EXIST."); 
				break;
			case 9102:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 物件發生問題(可能是因為一個以上) ","[" + errCode + "] FSP11_RTN_OBJECT_HAS_PROBLEM."); 
				break;

			case 9110:
			case 9111:
				msg += cd.fnJSLanguageVer("[" + errCode + "] Load Library 失敗 ","[" + errCode + "] FSP11_RTN_LIBRARY_NOT_LOAD."); 
				break;

			case 9112:
				msg += cd.fnJSLanguageVer("[" + errCode + "] 找不到 slot ","[" + errCode + "] FSP11_RTN_SLOT_NOT_FOUND."); 
				break;
			
			default:
				msg += cd.fnJSLanguageVer("其他錯誤,請參考元件手冊: (",  "Unknown Error, please reference document: (") + errCode + ") " ; 	
			  	return msg;
		}
		
		return msg;
	}

}
