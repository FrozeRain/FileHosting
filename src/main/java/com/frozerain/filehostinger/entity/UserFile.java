package com.frozerain.filehostinger.entity;

import javax.persistence.*;

@Entity
@Table(name = "USER_FILES")
public class UserFile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(targetEntity = com.frozerain.filehostinger.entity.User.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "FILENAME")
    private String fileName;

    @Column(name = "FILE_SIZE")
    private Long fileSize;

    @Column(name = "FILE_PATH")
    private String filePath;

    public UserFile() {
    }

    public UserFile(User user, String fileName, Long fileSize) {
        this.user = user;
        this.fileName = fileName;
        this.fileSize = fileSize;
    }

    public String getFilePath() {
        return filePath;
    }

    public String getAuthorName(){
        return user.getUsername();
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }
}
