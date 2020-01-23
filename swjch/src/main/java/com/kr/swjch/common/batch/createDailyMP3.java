package com.kr.swjch.common.batch;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

@Component()
public class createDailyMP3 {

	private static Connection con;
	private static Statement stmt;
	private static ResultSet rs;

//	private static String dburl = "jdbc:mysql://swjch.org/swjch?characterEncoding=euckr"; // 개발
//	private static String id = "swjch";
//	private static String pw = "sjch0191!!";

	 private static String dburl = "jdbc:mysql://localhost:3306/swjch?characterEncoding=euckr"; // 운영
	 private static String id = "swjch";
	 private static String pw = "sjch0191!!";

//	 @Scheduled(cron = "*/30 * * * * *")
//	 public static void main() throws IOException, ParseException, SQLException {
	public static void main(String[] args) throws IOException, ParseException, SQLException {
		System.out.println("::::::::: create mp3 file Start :::::::::");

		List<Mp3VO> mp3List = getDailyBibleMP3(9);

		for (Mp3VO vo : mp3List) {
			System.out.println("::::::::");
			System.out.println(vo.getFileName());
			System.out.println("::::::::");
			
			createMP3(vo);
		}

		System.out.println("::::::::: mp3 file End :::::::::");

	}
	
	static void createMP3(Mp3VO vo) throws IOException, ParseException, SQLException {
		
		InputStream in = vo.getData().getBinaryStream();
		String fileName = vo.getFileName();
//		FileOutputStream fos = new FileOutputStream("D://"+fileName);
		
		String path = System.getProperty("user.dir");
		System.out.println("Working Directory = " + path);
		
		FileOutputStream fos = new FileOutputStream(path +"/"+ fileName);
		
		int size = (int) vo.getData().length();
		byte[] buffer = new byte[size];
		int length = -1;
		
		while((length = in.read(buffer)) != -1){
			fos.write(buffer,0,length);
		}
		
		in.close();
		fos.close();
	}
	
	
	static List<Mp3VO> getDailyBibleMP3(int day) throws IOException, ParseException {
		List<Mp3VO> mp3List = new ArrayList<Mp3VO>();

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = (Connection) DriverManager.getConnection(dburl, id, pw);
			stmt = (Statement) con.createStatement();

			String sql = "select day, fileName, data from BIBLE_MP3 where day = \"" + day + "\"";
			rs = stmt.executeQuery(sql);
			
			System.out.println(":::::::: sql:"+sql);
			
			while(rs.next()) {
				
				Mp3VO mp3vo = new Mp3VO();
				mp3vo.setDay(rs.getInt("day"));
				mp3vo.setFileName(rs.getString("fileName"));
				mp3vo.setData(rs.getBlob("data"));
				mp3List.add(mp3vo);

			}
			
			rs.close();
		} catch (

		ClassNotFoundException cnfe) {
			System.out.println("com.mysql.jdbc.Driver를 찾을 수 없습니다.");
		} catch (SQLException sql) {
			System.out.println(sql.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return mp3List;
	}

}

class Mp3VO {
	int day;
	String fileName;
	Blob data;

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Blob getData() {
		return data;
	}

	public void setData(Blob data) {
		this.data = data;
	}
}
