package com.example.admin.controller;

import com.example.admin.entity.Role;
import com.example.admin.entity.User;
import com.example.admin.service.UserService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/admin/users")
public class AdminUserController {

    private final UserService userService;

    public AdminUserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Danh sách người dùng có tìm kiếm và phân trang
     */
    @GetMapping({"", "/"})
    public String listUsers(
            @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "5") int size,
            Model model) {

        if (page < 0) {
            page = 0;
        }

        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<User> userPage = userService.findAll(keyword, pageable);

        model.addAttribute("userPage", userPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalElements", userPage.getTotalElements());

        return "admin/user/list";
    }

    /**
     * Hiển thị form thêm mới người dùng
     */
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        User user = new User();
        user.setStatus(true);
        user.setRole(Role.USER);

        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageTitle", "Thêm mới người dùng");
        return "admin/user/form";
    }

    /**
     * Hiển thị form cập nhật người dùng
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes ra) {
        Optional<User> optUser = userService.findById(id);
        if (optUser.isEmpty()) {
            ra.addFlashAttribute("errorMessage", "Không tìm thấy người dùng có ID: " + id);
            return "redirect:/admin/users";
        }
        model.addAttribute("user", optUser.get());
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageTitle", "Cập nhật người dùng #" + id);
        return "admin/user/form";
    }

    /**
     * Xử lý lưu người dùng (Thêm mới hoặc Cập nhật)
     */
    @PostMapping("/save")
    public String saveUser(
            @Valid @ModelAttribute("user") User user,
            BindingResult result,
            Model model,
            RedirectAttributes ra) {

        // Kiểm tra trùng username
        if (user.getUsername() != null && !user.getUsername().trim().isEmpty()) {
            boolean usernameExists = (user.getId() == null)
                    ? userService.existsByUsername(user.getUsername())
                    : userService.existsByUsernameAndIdNot(user.getUsername(), user.getId());

            if (usernameExists) {
                result.rejectValue("username", "duplicate.username", "Tên đăng nhập '" + user.getUsername() + "' đã được sử dụng!");
            }
        }

        // Kiểm tra trùng email
        if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
            boolean emailExists = (user.getId() == null)
                    ? userService.existsByEmail(user.getEmail())
                    : userService.existsByEmailAndIdNot(user.getEmail(), user.getId());

            if (emailExists) {
                result.rejectValue("email", "duplicate.email", "Email '" + user.getEmail() + "' đã được đăng ký!");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageTitle", user.getId() == null ? "Thêm mới người dùng" : "Cập nhật người dùng #" + user.getId());
            return "admin/user/form";
        }

        userService.save(user);
        ra.addFlashAttribute("successMessage", (user.getId() == null ? "Thêm mới" : "Cập nhật") + " người dùng thành công!");
        return "redirect:/admin/users";
    }

    /**
     * Xóa người dùng
     */
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes ra) {
        Optional<User> optUser = userService.findById(id);
        if (optUser.isPresent()) {
            userService.deleteById(id);
            ra.addFlashAttribute("successMessage", "Xóa người dùng '" + optUser.get().getUsername() + "' thành công!");
        } else {
            ra.addFlashAttribute("errorMessage", "Không tìm thấy người dùng cần xóa!");
        }
        return "redirect:/admin/users";
    }
}
