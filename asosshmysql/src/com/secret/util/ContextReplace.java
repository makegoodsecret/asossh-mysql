package com.secret.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.tools.ant.taskdefs.Copyfile;
 /**
  * 替换类
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class ContextReplace {
	private   String srcStr ;
	private   String desStr ;
	private   String srcDir ;
	private   String fileFilterendswith ;
	private   boolean statusonefile ;     		//false为替换匹配到的全部文件 
	private  String filename  ;       //需要只过滤替换的文件 ，这个是个可选值
	/**
	 * 
	 * @param srcStr   需替换的字符串
	 * @param desStr   替换后的字符串
	 * @param srcDir   替换的目标文件的目录，如D://MyEclipse//Workspaces2013//asossh//WebRoot
	 * @param fileFilterendswith  只替换什么类型结尾的文件，如.java
	 */
	public ContextReplace(String srcStr, String desStr, String srcDir,
			String fileFilterendswith, boolean statusonefile) {
		this.srcStr = srcStr;
		this.desStr = desStr;
		this.srcDir = srcDir;
		this.fileFilterendswith = fileFilterendswith;
		this.statusonefile = statusonefile;
	}
	

	public ContextReplace(String srcStr, String desStr, String srcDir,
			String fileFilterendswith, boolean statusonefile, String filename) {
		this.srcStr = srcStr;
		this.desStr = desStr;
		this.srcDir = srcDir;
		this.fileFilterendswith = fileFilterendswith;
		this.statusonefile = statusonefile;
		this.filename = filename;
	}
	
	public boolean getreadDir(){
		readDir(new File(srcDir)); //执行替换操作
		return true;
	}

	private   FileFilter filter = new FileFilter() {
		public boolean accept(File pathname) {
			// 只处理：目录 或是 .txt文件
			if (pathname.isDirectory()|| (pathname.isFile() && pathname.getName().endsWith(fileFilterendswith))) {
				return true;
			} else {
				return false;
			}
		}
	};

	 
	

	public  void readDir(File file) {
		// 以过滤器作为参数
		File[] files = file.listFiles(filter);
		for (File subFile : files) {
			// 处理目录
			if (subFile.isDirectory()) {
				readDir(subFile);
			}else {// 处理文件
				System.err.println("源文件：/t" + subFile.getAbsolutePath());
				System.err.println("---------------------------");
				try {
					if (statusonefile) {
						System.out.println("filename="+filename+"subFile.getName()=="+subFile.getName());
						System.out.println("filename.equals(subFile.getName())==="+filename.equals(subFile.getName()));
						if (filename.equals(subFile.getName())) {
							System.out.println("替换了subFile.getAbsolutePath()==="+subFile.getAbsolutePath());
							replace(subFile.getAbsolutePath(), srcStr, desStr);
							System.out.println("只修改了"+file.getName());
						}
					}else{
						replace(subFile.getAbsolutePath(), srcStr, desStr);
					}
					 
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public   void replace(String infilename, String from, String to)throws IOException, UnsupportedEncodingException {
		File infile = new File(infilename);
		BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(infile), "utf-8"));
		File outfile = new File(infile + ".tmp");
		PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outfile), "utf-8")));
		String reading;
		while ((reading = in.readLine()) != null) {
			out.println(reading.replaceAll(from, to));
		}
		out.close();
		in.close();
		infile.delete();
		new FileUtils();
		//outfile.renameTo(infile);    //失败，的原因是磁盘的格式不一样就
		FileUtils.copyFile(infile, outfile);
		
	}

/*	public static void main(String[] args) {
		System.out.println("开始");
		File srcFile = new File();
		readDir(srcFile);
		srcFile = null;
	}*/

	public String getSrcStr() {
		return srcStr;
	}

	public void setSrcStr(String srcStr) {
		this.srcStr = srcStr;
	}

	public String getDesStr() {
		return desStr;
	}

	public void setDesStr(String desStr) {
		this.desStr = desStr;
	}

	public String getSrcDir() {
		return srcDir;
	}

	public void setSrcDir(String srcDir) {
		this.srcDir = srcDir;
	}

	public String getFileFilterendswith() {
		return fileFilterendswith;
	}

	public void setFileFilterendswith(String fileFilterendswith) {
		this.fileFilterendswith = fileFilterendswith;
	}

	public boolean isStatusonefile() {
		return statusonefile;
	}

	public void setStatusonefile(boolean statusonefile) {
		this.statusonefile = statusonefile;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}


}
