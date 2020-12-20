package com.study.springboot;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {
	private static String SAVE_PATH = "/upload/"; 
	private static String PREFIX_URL = "/upload/";
	
	// 현재 시간을 기준으로 파일 이름 생성
	public String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += extName;
		
		return fileName;
	}
	
	// 파일을 실제로 write 하는 메서드
	private void writeFile(MultipartFile multipartFile, String saveFileName)
								throws IOException{
		System.out.println("savefile:" + SAVE_PATH + "/" + saveFileName );
		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
		
		return;
	}
	
	
	//게시판용 파일업로드 메서드
	public String restore(MultipartFile multipartFile,HttpServletRequest req) {
		
		String url = null;
		
		try {
		    String savepath = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			
			// 파일 정보
			
			String originFilename = multipartFile.getOriginalFilename();
			String extName=null;
			Long size = multipartFile.getSize();
			String saveFileName = null;
			if(originFilename.lastIndexOf(".")==-1) {
				extName="0";
				saveFileName = "0";
			}else {
				 extName=originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
				 saveFileName = genSaveFileName(extName);
				 writeFile(multipartFile, saveFileName);
			}			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			req.setAttribute("fileName",saveFileName);
			//
			url = PREFIX_URL + "/" + saveFileName;
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();	
			throw new RuntimeException(e);
		}
		return url;
	}
	
	//상품등록용 파일업로드 메서드
	public String restore(MultipartFile multipartFile) {
		String url = null;
		try {
			String savepath = ResourceUtils.getFile("classpath:static/uploadPro/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			
			writeFile(multipartFile, saveFileName);
			url = PREFIX_URL + "/" + saveFileName;
		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		return url;
	}
	
	//상품 소개 이미지 파일업로드 메서드
	public String restore2(MultipartFile multipartFile) {
		String url = null;
		try {
			String savepath = ResourceUtils.getFile("classpath:static/uploadPro2/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			
			writeFile(multipartFile, saveFileName);
			url = PREFIX_URL + "/" + originFilename;
		}
		catch (IOException e) {
			throw new RuntimeException(e);
		}
		return url;
	}
		
	//북스토리 -프로필 등록
	//상품등록용 파일업로드 메서드
	public String restore3(MultipartFile multipartFile) {
		
		String url = null;
		
		try {
			String savepath = ResourceUtils.getFile("classpath:static/uploadPro3_bookstory/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			
			writeFile(multipartFile, saveFileName);
			url = PREFIX_URL + "/" + saveFileName;
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();	
			throw new RuntimeException(e);
		}
		return url;
	}
	
	//후기 등록용
	public String restore4(MultipartFile multipartFile) {
		
		if(multipartFile==null) {}
		String url = null;
		
		try {
			String savepath = ResourceUtils.getFile("classpath:static/reviewImage/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			
			writeFile(multipartFile, saveFileName);
			url = PREFIX_URL + "/" + originFilename;
		}
		catch (IOException e) {
			throw new RuntimeException(e);
		}
		
		return url;
	}
	
}