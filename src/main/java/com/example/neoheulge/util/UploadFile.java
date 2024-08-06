package com.example.neoheulge.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import ch.qos.logback.core.CoreConstants;
import ch.qos.logback.core.net.SyslogOutputStream;
import org.springframework.web.multipart.MultipartFile;


public class UploadFile {
	
	private String fullname;
	
	public String getFullName() {
		return fullname;
	}

	public void setUniqueName(String fullname) {
		this.fullname = fullname;
	}

	public boolean uploadFile(MultipartFile file) {
		String fileDir = ""; // 경로 프로퍼티 추가 예정
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String uniqueName = uuids[0];
		String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."),file.getOriginalFilename().length());
		fullname = uniqueName+fileExtension;
		System.out.println(fileDir);

		try {
			file.transferTo(new File(fileDir+fullname));
			return true;
		} catch (IllegalStateException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}
}
