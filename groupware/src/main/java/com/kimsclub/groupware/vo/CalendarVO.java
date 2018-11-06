package com.kimsclub.groupware.vo;

public class CalendarVO {
	int event_no; //이벤트 번호
	String title; //이벤트 제목
	String content; //이벤트 내용
	String color; //이벤트 컬러
	String start; //이벤트 시작
	String end; //이벤트 끝
	public CalendarVO() {
		super();
	}
	public CalendarVO(int event_no, String title, String content, String color, String start, String end) {
		super();
		this.event_no = event_no;
		this.title = title;
		this.content = content;
		this.color = color;
		this.start = start;
		this.end = end;
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "CalendarVO [event_no=" + event_no + ", title=" + title + ", content=" + content + ", color=" + color
				+ ", start=" + start + ", end=" + end + "]";
	}

}
