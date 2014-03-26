package com.seekon.yougouhui.rest.resource;

public class TextResource implements Resource {

	private String text = null;

	public TextResource(String text) {
		super();
		this.text = text;
	}

	public String getText() {
		return this.text;
	}
}
