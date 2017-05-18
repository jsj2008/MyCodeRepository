package allone.MTP.VerBank01.Ctrl.gl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import allone.MTP.VerBank01.Ctrl.config.ConfigCaptain;
import allone.MTP.VerBank01.comm.datastruct.DB.GlDetails;

public class FileGenerator {

	private int totalNo = 0;
	private double drAmount = 0.0; 
	private double crAmount = 0.0;
	
	private StringBuilder sb = new StringBuilder();
	
	public String createFile(GlDetails[] records) {
		if (records == null || records.length == 0) {
			return "";
		}

		totalNo = records.length;
		
		for (GlDetails rd : records) {
			createRecord(rd);
			sb.append("\r\n");
			
			String cd = rd.getFD_DWTF_CRDB();
			if (cd.equals("D")) {
				drAmount += rd.getFD_DWTF_TXAMT();
			} else if (cd.equals("C")) {
				crAmount += rd.getFD_DWTF_TXAMT();
			}
		}

		createSummary();
		sb.append("\r\n");
		return sb.toString();
	}

	private void createRecord(GlDetails rd) {
		String day = rd.getFD_DWTF_DATA();
		sb.append(day);

		String branchId = FieldFormatter.preposeZero(rd.getFD_DWTF_BRNO(), 4);
		sb.append(branchId);

		sb.append(rd.getFD_DWTF_EXCUR());

		sb.append(rd.getFD_DWTF_ACNO());

		String acctAppend = FieldFormatter.appendSpace(rd.getFD_DWTF_ACCNO(), 13);
		sb.append(acctAppend);

		String acctType = FieldFormatter.preposeZero(rd.getFD_DWTF_ACCTP(), 2);
		sb.append(acctType);

		String amount = FieldFormatter.formatDouble(rd.getFD_DWTF_TXAMT(), 15,
				rd.getFD_DWTF_DECIMAL());
		sb.append(amount);

		sb.append(rd.getFD_DWTF_DECIMAL());

		sb.append(rd.getFD_DWTF_CRDB());

		String twdRate = FieldFormatter.formatDouble(rd.getFD_DWTF_RATE(), 9, 5);
		sb.append(twdRate);

		String twdAmount = FieldFormatter
				.formatDouble(rd.getFD_DWTF_TWDEQAMT(), 15, 2);
		sb.append(twdAmount);

		String desc = FieldFormatter.appendSpace(rd.getFD_DWTF_DESCPT(), 20);
		sb.append(desc);

		String tradeId = FieldFormatter.preposeZero(rd.getFD_DWTF_REFNO(), 16);
		sb.append(tradeId);
	}

	private void createSummary() {
		String filter = FieldFormatter.appendSpace("MGT", 5);
		sb.append(filter);
		
		String totalNo = FieldFormatter.preposeZero(String.valueOf(this.totalNo), 5);
		sb.append(totalNo);
		
		String drAmount = FieldFormatter.formatDouble(this.drAmount, 15, 2);
		sb.append(drAmount);
		
		String crAmount = FieldFormatter.formatDouble(this.crAmount, 15, 2);
		sb.append(crAmount);
		
		String filler = FieldFormatter.appendSpace("", 76);
		sb.append(filler);
	}
	
	public void writeFile(String fileData, String path, String fileName)
			throws Exception {
		File fpath = new File(path);
		if (!fpath.exists()) {
			fpath.mkdirs();
		}
		
		FileChannel fc = new FileOutputStream(path + File.separator + fileName).getChannel();
		try {
			ByteBuffer buf = ByteBuffer.wrap(fileData.getBytes());
			fc.write(buf);
		} finally {
			if (fc != null) {
				fc.close();
			}
		}
	}
	
	public static void main(String[] args) {
		ConfigCaptain cc = new ConfigCaptain();
		cc.init("E:\\work\\project\\Ctrl\\WebRoot\\WEB-INF");
		
		FileGenerator fg = new FileGenerator();

		GlDetails rd = new GlDetails();
		rd.setFD_DWTF_DATA("20120605");
		rd.setFD_DWTF_BRNO("899");
		rd.setFD_DWTF_EXCUR("CHF");
		rd.setFD_DWTF_ACNO("192105000");
		rd.setFD_DWTF_TXAMT(182540);
		rd.setFD_DWTF_DECIMAL(2);
		rd.setFD_DWTF_CRDB("D");
		rd.setFD_DWTF_RATE(28.0571471);
		rd.setFD_DWTF_TWDEQAMT(5121552);
		rd.setFD_DWTF_DESCPT("MTCnv");
		rd.setFD_DWTF_REFNO("111017589");

		GlDetails rd1 = new GlDetails();
		rd1.setFD_DWTF_DATA("20120605");
		rd1.setFD_DWTF_BRNO("899");
		rd1.setFD_DWTF_EXCUR("TWD");
		rd1.setFD_DWTF_ACNO("555006001");
		rd1.setFD_DWTF_TXAMT(2);
		rd1.setFD_DWTF_DECIMAL(0);
		rd1.setFD_DWTF_CRDB("D");
		rd1.setFD_DWTF_RATE(1);
		rd1.setFD_DWTF_TWDEQAMT(2);
		rd1.setFD_DWTF_DESCPT("CintExpn");
		rd1.setFD_DWTF_REFNO("111017589");

		String file = fg.createFile(new GlDetails[] { rd, rd1 });
		System.out.println(file);

		String fileName = "gldata{time}.txt";
		SimpleDateFormat sdf = new SimpleDateFormat(cc.getGlTimeFormat());
		String now = sdf.format(new Date());
		String standardFileName = fileName.replaceFirst("\\{time\\}", now);
		
		try {
			fg.writeFile(file, "D:\\", standardFileName);
			System.out.println("OK");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public static void main1(String[] args) throws Exception {
		FileGenerator fg = new FileGenerator();
		
		GlDetails[] details = fg.readFile();
		String file = fg.createFile(details);
		fg.writeFile(file, "D:\\", "gldata20120613.txt");
	}
	
	private GlDetails[] readFile() {
		try {
			String fileName = "E:\\some_file\\MARGIN.0018";
			File file = new File(fileName);
			BufferedReader br = new BufferedReader(new FileReader(file));
			ArrayList<GlDetails> list = new ArrayList<GlDetails>();
			for (;;) {
				String line = br.readLine();
				if (line == null) {
					break;
				}
				
				GlDetails d = parseLine(line);
				if (d != null) {
					list.add(d);
				}
			}
			
			return list.toArray(new GlDetails[0]);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private GlDetails parseLine(String line) {
		if (line.isEmpty()) {
			return null;
		}
		if (line.startsWith("MGT")) {
			return null;
		}
		
		GlDetails d = new GlDetails();
		d.setFD_DWTF_DATA(line.substring(0, 8));
		d.setFD_DWTF_BRNO(line.substring(8, 12));
		d.setFD_DWTF_EXCUR(line.substring(12, 15));
		d.setFD_DWTF_ACNO(line.substring(15, 24));
		d.setFD_DWTF_ACCNO(line.substring(24, 37));
		d.setFD_DWTF_ACCTP(line.substring(37, 39));
		double amount = Double.parseDouble(line.substring(39, 54));
		int decimal = Integer.parseInt(line.substring(54, 55));
		if (decimal == 2) {
			amount /= 100;
		}
		d.setFD_DWTF_TXAMT(amount);
		d.setFD_DWTF_DECIMAL(decimal);
		d.setFD_DWTF_CRDB(line.substring(55, 56));
		double rate = Double.parseDouble(line.substring(56, 65));
		long twdamount = Long.parseLong(line.substring(65, 80)); 
		
		rate /= 100000;
		twdamount /= 100;
		d.setFD_DWTF_RATE(rate);
		d.setFD_DWTF_TWDEQAMT(twdamount);
		d.setFD_DWTF_DESCPT(line.substring(80, 100));
		d.setFD_DWTF_REFNO(line.substring(100, 116));
		
		return d;
	}
}
