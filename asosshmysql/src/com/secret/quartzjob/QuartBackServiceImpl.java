package com.secret.quartzjob;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Zip;
import org.apache.tools.ant.types.FileSet;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class QuartBackServiceImpl implements QuartBackService {

	@Override
	public  void backImage() {
		try {
			String  in  ="D:\\apache-tomcat-7.0.42\\webapps\\asosshoracle\\photo";
			String backPhoto="D:\\ASOSSH\\asosshoracle\\";
			GregorianCalendar   calendar  = new GregorianCalendar();
			SimpleDateFormat   format   = new SimpleDateFormat("yyyyMMddSSmmss");
			String format2 = format.format(calendar.getTime());
			backPhoto=backPhoto+format2+"\\";	
			new File(backPhoto).mkdirs();		//创建文件夹
			
			//获取源文件夹中的全部的文件或文件夹
			File[] file = (new File(in)).listFiles();
			for (int i = 0; i < file.length; i++) {
				if (file[i].isFile()) {
					//复制文件
					String type  =file[i].getName().substring(file[i].getName().lastIndexOf(".")+1);
					if (type.equalsIgnoreCase("txt")) {//转码处理
						copyFile(file[i], new File(backPhoto+file[i].getName()),"UTF-8","GBK");
					}else{
						copyFile(file[i], new File(backPhoto+file[i].getName()));
					}
				if (file[i].isDirectory()) {
					//复制目录
					String sourceDir  = in+File.separator+file[i].getName();
					String targetDir  = backPhoto+File.separator+file[i].getName();
					copyDirectiory(sourceDir, targetDir);
				}
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//复制文件
	public static void copyFile(File sourceFile ,File targetFile) throws IOException{
		BufferedInputStream   inputStream  = null;
		BufferedOutputStream   outputStream  = null;
		try{
		//创建文件输入流并对它进行缓冲
		inputStream= new BufferedInputStream(new FileInputStream(sourceFile));
		//创建文件输出流并对其缓冲
		outputStream  = new BufferedOutputStream(new FileOutputStream(targetFile));
		
		//创建缓冲数组
		byte[]  b  = new byte[1024*5];
		int len  ;
		while ((len = inputStream.read(b))!=-1) {
			outputStream.write(b, 0,len);
		}
		//刷新此缓冲的输出流
		outputStream.flush();
		
		}finally{
			if (inputStream!=null) {
				inputStream.close();
			}
			if (outputStream!=null) {
				outputStream.close();
			}
		}
	}
	
	//复制文件夹
	public static void copyDirectiory(String sourceDir,String targetDir) throws IOException{
		//创建目标目录
		(new File(targetDir)).mkdirs();
		//获取源文件夹当前的文件或目录、
		File[] file  = (new File(sourceDir)).listFiles();
		for (int i = 0; i < file.length; i++) {
			if (file[i].isFile()) {
				File  sourceFile  = file[i];
				//目标文件
				File targetFile  = new File(new File(targetDir).getAbsoluteFile()+File.separator+file[i].getName());
				copyFile(sourceFile, targetFile);
			}
			if (file[i].isDirectory()) {
				//准备复制的源文件夹
				String dir1  =sourceDir+"\\"+file[i].getName();
				//准备复制的目标文件夹
				String dir2  =targetDir+"\\"+file[i].getName();
				copyDirectiory(dir1, dir2);
			}
		}
		
	}
	
	//把文件转成GBK在复制
	public static void copyFile(File srcFileName,File destFileName ,String srcCoding,String destCoding) throws IOException{
		BufferedReader  br  = null;
		BufferedWriter   bw  = null;
		try{
			br  = new BufferedReader(new InputStreamReader(new FileInputStream(srcFileName),srcCoding));
			bw  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(destFileName),destCoding));
			char[] cbuf  = new char[1024*5];
			int len  = cbuf.length;
			int off  = 0;
			int ret  = 0;
			while ((ret=br.read(cbuf, off, len))>0) {
				off+= ret;
				len -= ret;
			}
			bw.write(cbuf,0,off);
			bw.flush();
		}finally{
			if (br!=null) {
				br.close();
			}
			if (bw!=null) {
				bw.close();
			}
		}
	}
	//文件的删除
	public static void deleteFile(String filePath){
		File  file  = new File(filePath);	
		if (file.exists()&&file.isDirectory()) {//判断是目录还是文件
			if (file.listFiles().length==0) {//若目录下没有文件则直接删除
				file.delete();
			}else{				//若有则把文件放进数组，并判断是否有下级目录
				File[]   delFile=file.listFiles();
				int i =file.listFiles().length;
				for (int j = 0; j < i; j++) {
					if (delFile[j].isDirectory()) {
						deleteFile(delFile[j].getAbsolutePath());	//递归调用删除方法
					}
					delFile[j].delete();	//删除文件
				}
				
			}
			
		}
		
	}
	
	
	//Base64解密
	public static byte[] decryptBase64(String key) throws IOException{
		return (new BASE64Decoder()).decodeBuffer(key);
	}
	
	//Base64加密
	public static String encryptBase64(byte[] key){
		return (new BASE64Encoder()).encodeBuffer(key);
	}
	
	//获取路径下的所有文件名
	public static String[] getFile(String filePath){
		File file  = new File(filePath);
		String[] name  = file.list();
		return name;
	}
	//读取文件的内容
	public static String readFileToString(String path) throws IOException{
		String resultStr = null;
		FileInputStream fis  = null;
		try{
			fis = new FileInputStream(path);
			byte[] inBuf  = new byte[2000];
			int len = inBuf.length;
			int off  = 0;
			int ret  = 0;
			while ((ret = fis.read(inBuf,off,len))>0) {
				off +=ret;
				len -=ret;
			}
			resultStr= new String (new String(inBuf,0,off, "GBK").getBytes());
		}finally{
			if (fis!=null) {
				fis.close();
			}
		}
		return resultStr;
	}
	
	//文件转成字节数组
	public static byte[] readFileToBytes(String path) throws IOException{
		byte[] b  = null;
		InputStream is  = null;
		File f  = new File(path);
		try{
			is= new FileInputStream(f);
			b  = new byte[(int)f.length()];
			is.read(b);
		}finally{
			if (is!=null) {
				is.close();
			}
		}
		return b;
	}
		
	//将byte写入文件中
	@SuppressWarnings("resource")
	public static void byteToFile(byte[] fileByte,String filePath) throws IOException{
		OutputStream os  = null;
		try{
			os = new FileOutputStream(new File(filePath));
			os.write(fileByte);
			os.flush();
		}finally{
			if (os!=null) {
				os.flush();
			}
		}
	}
	//判空字串
	public static boolean strIsNull(String str){
		return str == null||str.equals("");
	}
	//将目录文件打包成Zip  主注意需要ANT的架包，ant.jar
	public static boolean compress(String srcPathName,String zipFilePath){
		if (strIsNull(srcPathName)||strIsNull(zipFilePath)) {
			return false;
		}
		File zipFile = new File(zipFilePath);
		File srcdir  = new File(srcPathName);
		if (!srcdir.exists()) {
			return false;
		}
		Project  prj  = new Project();
		Zip   zip  = new Zip();
		zip.setProject(prj);
		zip.setDestFile(zipFile);
		FileSet fileSet  = new FileSet();
		fileSet.setProject(prj);
		fileSet.setDir(srcdir);
		zip.addFileset(fileSet);
		zip.execute();
		return zipFile.exists();
	}
	//拆分数组 
	public static List<List<Object>> splitAry(Object[] ary,int subSize){
		int count  = ary.length % subSize == 0?ary.length /subSize:ary.length /subSize +1;
		List<List<Object>> subAryList  = new ArrayList<List<Object>>();
		for (int i = 0; i < count; i++) {
			int index  =i*subSize;
			List<Object> list  = new ArrayList<Object>();
			int j  =0 ;
			while (j<subSize && index <ary.length) {
				list.add(ary[index++]);
				j++;
			}
			subAryList.add(list);
		}
		return subAryList;
	}
	  public static String ArrayToString(Object[] mobile){
		  String destId="";
		  for (Object object : mobile) {
			destId+=" "+(String)object;
		}
		return destId.trim();
	  }
	
	
	
	
	
	
	
	
	
	
	
	
}
