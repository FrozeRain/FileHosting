package com.frozerain.filehostinger.controller;


import com.frozerain.filehostinger.entity.Role;
import com.frozerain.filehostinger.entity.User;
import com.frozerain.filehostinger.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/panel")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping
    public String panel(Model model) {
        model.addAttribute("users", userService.findAll());
        return "panel";
    }

    @GetMapping("/user/{user}")
    public String edit(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "editUser";
    }

    @PostMapping
    public String editSubmit(@RequestParam String username,
                             @RequestParam Map<String, String> form,
                             @RequestParam("user") User user) {

        userService.saveUser(user, username, form);
        return "redirect:/panel";
    }
}
