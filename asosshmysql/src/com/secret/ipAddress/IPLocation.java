 package com.secret.ipAddress;
 
 public class IPLocation
 {
   private String country;
   private String area;
 
   public IPLocation()
   {
     this.country = (this.area = "");
   }
 
   public IPLocation getCopy() {
      IPLocation ret = new IPLocation();
      ret.country = this.country;
      ret.area = this.area;
     return ret;
   }
 
   public String getCountry() {
     return this.country;
   }
 
   public void setCountry(String country) {
     this.country = country;
   }
 
   public String getArea() {
     return this.area;
   }
 
   public void setArea(String area)
   {
      if (area.trim().equals("CZ88.NET"))
       this.area = "本机或本网络";
     else
       this.area = area;
   }
 }
 