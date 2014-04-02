package com.seekon.yougouhui.file;

import java.io.File;
import java.io.Serializable;

public class FileEntity implements Serializable {

	private static final long serialVersionUID = -6835455636138044256L;

	private String fileUri;// 完整的文件路径（含文件名）

	private String aliasName;// 文件的别名

	public FileEntity(String fileUri, String aliasName) {
		super();
		this.fileUri = fileUri;
		this.aliasName = aliasName;
	}

	public String getFileUri() {
		return fileUri;
	}

	public void setFileUri(String fileUri) {
		this.fileUri = fileUri;
	}

	public String getAliasName() {
		if (aliasName == null) {
			aliasName = new File(fileUri).getName();
		}
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

}
