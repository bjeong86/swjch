package com.kr.swjch.source.bible.vo;

import java.io.Serializable;

public class bibleContentsVO implements Serializable {
	private static final long serialVersionUID = 1L;

	String day;
	String title;
	String sChapter;
	String eChapter;
	String chapter;
	String verse;
	String contents;
	String hits;

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

	public String getVerse() {
		return verse;
	}

	public void setVerse(String verse) {
		this.verse = verse;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getHits() {
		return hits;
	}

	public void setHits(String hits) {
		this.hits = hits;
	}

}
