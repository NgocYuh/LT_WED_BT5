package com.example.admin.controller;

import com.example.admin.service.CategoryService;
import com.example.admin.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminDashboardController {

    private final CategoryService categoryService;
    private final UserService userService;

    public AdminDashboardController(CategoryService categoryService, UserService userService) {
        this.categoryService = categoryService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String root() {
        return "redirect:/admin";
    }

    @GetMapping({"/admin", "/admin/dashboard"})
    public String dashboard(Model model) {
        model.addAttribute("totalCategories", categoryService.count());
        model.addAttribute("totalUsers", userService.count());
        return "admin/dashboard";
    }
}
