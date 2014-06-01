 package com.secret.ipAddress;
 
 import java.io.UnsupportedEncodingException;
 import java.util.StringTokenizer;
 import org.apache.log4j.Level;
 
 public class Util
 {
   private static StringBuilder sb = new StringBuilder();
 
   public static byte[] getIpByteArrayFromString(String ip)
   {
     byte[] ret = new byte[4];
      StringTokenizer st = new StringTokenizer(ip, ".");
     try {
        ret[0] = ((byte)(Integer.parseInt(st.nextToken()) & 0xFF));
        ret[1] = ((byte)(Integer.parseInt(st.nextToken()) & 0xFF));
        ret[2] = ((byte)(Integer.parseInt(st.nextToken()) & 0xFF));
       ret[3] = ((byte)(Integer.parseInt(st.nextToken()) & 0xFF));
     } catch (Exception e) {
       LogFactory.log("从ip的字符串形式得到字节数组形式报错", Level.ERROR, e);
     }
      return ret;
   }
 
   public static String getIpStringFromBytes(byte[] ip)
   {
     sb.delete(0, sb.length());
     sb.append(ip[0] & 0xFF);
    sb.append('.');
      sb.append(ip[1] & 0xFF);
      sb.append('.');
      sb.append(ip[2] & 0xFF);
      sb.append('.');
      sb.append(ip[3] & 0xFF);
     return sb.toString();
   }
 
   public static String getString(byte[] b, int offset, int len, String encoding)
   {
     try
     {
        return new String(b, offset, len, encoding); } catch (UnsupportedEncodingException e) {
     }
      return new String(b, offset, len);
   }
 }
 