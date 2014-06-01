package com.wpn.web.util;

public class Distance {
	private final static double PI = 3.14159265358979323;// 圆周率
	private final static double R = 6371229;  // 地球的半径

	private Distance() {
	}

	/**
	 * 纬度lat 经度lon
	 * @param longt1
	 * @param lat1
	 * @param longt2
	 * @param lat2
	 * @return
	 */
	public static double getDistance(double longt1, double lat1, double longt2, double lat2) {
		double x, y, distance;
		x = (longt2 - longt1) * PI * R * Math.cos(((lat1 + lat2) / 2) * PI / 180) / 180;
		y = (lat2 - lat1) * PI * R / 180;
		distance = Math.hypot(x, y);
		return distance;
	}

	/*public enum GaussSphere {
		Beijing54, Xian80, WGS84,
	}

	private static double Rad(double d) {
		return d * Math.PI / 180.0;
	}
	public static double DistanceOfTwoPoints(double lng1, double lat1, double lng2, double lat2, GaussSphere gs) {
		double radLat1 = Rad(lat1);
		double radLat2 = Rad(lat2);
		double a = radLat1 - radLat2;
		double b = Rad(lng1) - Rad(lng2);
		double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
		s = s * (gs == GaussSphere.WGS84 ? 6378137.0 : (gs == GaussSphere.Xian80 ? 6378140.0 : 6378245.0));
		s = Math.round(s * 10000) / 10000;
		return s;
	}*/
	
	public static void main(String[] arg){
		double longt1 = 116.515502;
		double lat1 = 39.863898;
		double longt2 = 116.304187;
		double lat2 = 40.052584;
		System.out.println(getDistance(longt1,lat1,longt2,lat2));
	}
}
