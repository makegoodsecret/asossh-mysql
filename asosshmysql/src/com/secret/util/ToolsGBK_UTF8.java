package com.secret.util;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.logging.Logger;

import org.apache.commons.io.FileUtils;


public class ToolsGBK_UTF8 {
	
	private static Logger  logger =   Logger.getLogger(ToolsGBK_UTF8.class.getName());
	public static void main(String[] args) {
		  String srcDirPath = "D:\\MyEclipse\\Workspaces2013new\\tarenahibernate\\src\\com\\tarena\\tts\\test\\";
		    //转为UTF-8编码格式源码路径
		  String [] filename = new String[]{"java"};
		  gbkreplaceutf(  srcDirPath ,  filename);
	}
	/**
	 * 
	 * @param srcDirPath   gbk格式的xx.java //原始的路径D://MyEclipse//Workspaces2013new//
	 * @param utf8DirPath	utf-8的现在路径//
	 * @param filename      new String[]{"java"}  //替换后缀为.java的
	 */
   @SuppressWarnings("unchecked")
public static void gbkreplaceutf(String srcDirPath ,  String [] filename ){
	   try {
	   String utf8DirPath = "D:\\UTF8\\";
	   Collection<File> javaGbkFileCol =  FileUtils.listFiles(new File(srcDirPath), filename, true);
	   for (File javaGbkFile : javaGbkFileCol) {
		   String utf8FilePath = utf8DirPath+javaGbkFile.getName();
			   File destFile = new File(utf8FilePath);
			   logger.info("正在操作"+javaGbkFile.getName());
			   FileUtils.writeLines(destFile, "UTF-8", FileUtils.readLines(javaGbkFile, "GBK"));
				if (javaGbkFile.exists()) {
					javaGbkFile.delete();
					javaGbkFile.createNewFile();
				} 
			   FileUtils.copyFile(destFile, javaGbkFile);
			   if (destFile.exists()) {
				   destFile.delete();
			}
	   }
	  if (new File(utf8DirPath).isFile()) {
		  new File(utf8DirPath).delete();
	  }
	   } catch (IOException e) {
		   e.printStackTrace();
	   }		
   }
}
