package com.frozerain.filehostinger.service;

import com.frozerain.filehostinger.DAO.FilesDAO;
import com.frozerain.filehostinger.config.Constans;
import com.frozerain.filehostinger.entity.User;
import com.frozerain.filehostinger.entity.UserFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import static com.frozerain.filehostinger.config.Constans.CONFIRM_MESSAGE;

@Service
public class FileService {
    @Value("${max.download}")
    private Long maxDownload;

    @Autowired
    private FilesDAO filesDAO;

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;


    public void addUserFile(String fileName, User user, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFile = uuidFile + "-" + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + resultFile));

            if (fileName.equals("")){
                fileName = file.getOriginalFilename();
            }
            UserFile userFile = new UserFile(user, fileName, file.getSize());
            userFile.setFilePath(resultFile);
            filesDAO.save(userFile);
        }
    }

    public void findAllRepos(Model model){
        Iterable<UserFile> files = filesDAO.findAll();

        model.addAttribute("files", files);
    }

    public void findIfFilterContaining(String filter, Model model) {
        Iterable<UserFile> files = filesDAO.findAllByFileNameContaining(filter);

        model.addAttribute("files", files);
        model.addAttribute("filter", filter);
    }

    public void deleteFile(User user, Long fileId) {
        Optional<UserFile> op = filesDAO.findById(fileId);
        if(op.isPresent()){
            UserFile file = op.get();
            if (file.getUser().getId().equals(user.getId())){
                new File(uploadPath + file.getFilePath()).delete();
                filesDAO.deleteById(fileId);
            }
        }

    }

    public boolean canDownload(User user, UserFile file) {
        Date date = new Date();
        if (user.isBlocked()){
            if (user.getDateOfBlock().after(date)){
                user.setBlocked(false);
                user.setFileLimit(0L);
            } else {
                return false;
            }
        }

        if (user.getFileLimit() < maxDownload) {
            user.setFileLimit(user.getFileLimit() + file.getFileSize());
            user.setPassword2(CONFIRM_MESSAGE);
            userService.simpleSaveUser(user);
            return true;
        } else {
            user.setBlocked(true);
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(Calendar.HOUR_OF_DAY, 24);
            user.setDateOfBlock(cal.getTime());
            user.setPassword2(CONFIRM_MESSAGE);
            userService.simpleSaveUser(user);
            return false;
        }
    }
}
