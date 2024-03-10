package com.entities;

import java.sql.Blob;
import java.util.Date;

public class Blog {
	private int blog_id;
	private int authorId;
	private String title;
	private String body;
	private Date date;
	private int likes;
	private Blob thumbnail,img[];
	private String subTopic[],subBody[];

	public Blog() {
		super();
	}

	public Blog(int blog_id, int authorId, String title, String body, Date date, int likes, Blob thumbnail) {
		super();
		this.blog_id = blog_id;
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.likes = likes;
		this.thumbnail = thumbnail;
	}

	public Blog(int authorId, String title, String body, Date date, int likes, Blob thumbnail) {
		super();
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.likes = likes;
		this.thumbnail = thumbnail;
	}

	public Blog(int authorId, String title, String body, Date date, Blob thumbnail) {
		super();
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.thumbnail = thumbnail;
	}

	
	
	
	public Blog(int authorId, String title, String body, Date date, Blob thumbnail, String[] subTopic,
			String[] subBody,Blob[] img) {
		super();
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.thumbnail = thumbnail;
		this.img = img;
		this.subTopic = subTopic;
		this.subBody = subBody;
	}

	public Blog(int blog_id, int authorId, String title, String body, Date date, Blob thumbnail, Blob[] img,
			String[] subTopic, String[] subBody) {
		super();
		this.blog_id = blog_id;
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.thumbnail = thumbnail;
		this.img = img;
		this.subTopic = subTopic;
		this.subBody = subBody;
	}

	public Blog(int authorId, String title, String body, Blob thumbnail, String[] subTopic,
			String[] subBody,Blob img[]) {
		super();
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.thumbnail = thumbnail;
		this.img = img;
		this.subTopic = subTopic;
		this.subBody = subBody;
	}

	public Blog(int blog_id, int authorId, String title, String body, Date date, int likes, Blob thumbnail, Blob[] img,
			String[] subTopic, String[] subBody) {
		super();
		this.blog_id = blog_id;
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.likes = likes;
		this.thumbnail = thumbnail;
		this.img = img;
		this.subTopic = subTopic;
		this.subBody = subBody;
	}

	public Blog(int authorId, String title, String body, Blob thumbnail, Blob[] img, String[] subTopic,
			String[] subBody) {
		super();
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.thumbnail = thumbnail;
		this.img = img;
		this.subTopic = subTopic;
		this.subBody = subBody;
	}


	public Blog(int blog_id, int authorId, String title, String body, Date date, Blob thumbnail) {
		super();
		this.blog_id = blog_id;
		this.authorId = authorId;
		this.title = title;
		this.body = body;
		this.date = date;
		this.thumbnail = thumbnail;
	}

	public int getBlog_id() {
		return blog_id;
	}

	public void setBlog_id(int blog_id) {
		this.blog_id = blog_id;
	}

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public Blob getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(Blob thumbnail) {
		this.thumbnail = thumbnail;
	}

	public Blob[] getImg() {
		return img;
	}

	public void setImg(Blob[] img) {
		this.img = img;
	}

	public String[] getSubTopic() {
		return subTopic;
	}

	public void setSubTopic(String[] subTopic) {
		this.subTopic = subTopic;
	}

	public String[] getSubBody() {
		return subBody;
	}

	public void setSubBody(String subBody[]) {
		this.subBody = subBody;
	}

}