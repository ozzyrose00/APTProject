package com.oz.aptproject.web.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

public class AppProperty {

	public static String getProperty(String key) throws IOException {

		Path path = Paths.get("");
		String directoryName = path.toAbsolutePath().normalize().toString();
		//System.out.println("System.getProperty = " +System.getProperty("user.dir"));
		File filet = new File(".");
		
		File arr_filet[] = filet.listFiles();
		
		for(File filett : arr_filet ) {
			//System.out.println(filett);
		}
		String package_path = AppProperty.class.getResource("").getPath(); 
		String propFile = package_path + "mis.properties"; 
		
		//System.out.println("propFile:::"+propFile);
		
        Properties props = new Properties();
         
        // 프로퍼티 파일 스트림에 담기
        FileInputStream fis = new FileInputStream(propFile);
         
        // 프로퍼티 파일 로딩
        props.load(new java.io.BufferedInputStream(fis));
         
        // 항목 읽기
        String msg = props.getProperty(key) ;
         
        // 콘솔 출력
		return msg;
	}
	/*
	public static void main(String args[]){
		try {
			System.out.println(getProperty("map_api_key"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 */
	
}
