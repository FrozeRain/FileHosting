package com.frozerain.filehostinger.controller;

import com.frozerain.filehostinger.DAO.UserDAO;
import com.frozerain.filehostinger.entity.User;
import com.frozerain.filehostinger.entity.UserFile;
import com.frozerain.filehostinger.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    private FileService fileService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping
    public String main() {
        return "lobby";
    }

    @GetMapping("home")
    public String home(@RequestParam(name = "filter", required = false) String filter, Model model) {
        if (filter != null && !filter.isEmpty()) {
            fileService.findIfFilterContaining(filter, model);
        } else {
            fileService.findAllRepos(model);
        }
        return "home";
    }

    @PostMapping("home")
    public String upload(@AuthenticationPrincipal User user,
                         @RequestParam(name = "filename") String filename,
                         MultipartFile file) throws IOException {

        if (user != null) {
            System.out.println(user.toString());
            fileService.addUserFile(filename, user, file);
        }
        return "redirect:/home";
    }

    @GetMapping("delete/file/{fileId}")
    public String deleteFile(@AuthenticationPrincipal User user,
                             @PathVariable Long fileId) {
        fileService.deleteFile(user, fileId);
        return "redirect:/home";
    }

    @GetMapping("download")
    public String downloadFile(@AuthenticationPrincipal User user,
                               @RequestParam(name = "file") UserFile file,
                               Model model) {
        if (fileService.canDownload(user, file)) {
            return "redirect:/file/" + file.getFilePath();
        } else {
            fileService.findAllRepos(model);
            model.addAttribute("warn", "Download limit exceeded!");
            return "home";
        }
    }
}
