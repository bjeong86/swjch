package com.kr.swjch.source.bible.vo;

import java.io.Serializable;

public class bibleScheduleVO implements Serializable {
	private static final long serialVersionUID = 1L;

	String day;
	String title;
	String sChapter;
	String eChapter;
	String chapter;

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getsChapter() {
		return sChapter;
	}

	public void setsChapter(String sChapter) {
		this.sChapter = sChapter;
	}

	public String geteChapter() {
		return eChapter;
	}

	public void seteChapter(String eChapter) {
		this.eChapter = eChapter;
	}

	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
	}

}
