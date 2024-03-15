package com.entities;

import java.util.Date;

public class Comment {
    private int id;
    private int blogId;
    private String content;
    private int authorId;
    private Date createDate;

    // Constructors
    public Comment() {
    }

    public Comment(int id, int blogId, String content, int authorId, Date createDate) {
        this.id = id;
        this.blogId = blogId;
        this.content = content;
        this.authorId = authorId;
        this.createDate = createDate;
    }

    
    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    
    
}
