package com.example.admin.controller;

import com.example.admin.entity.Category;
import com.example.admin.service.CategoryService;
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
@RequestMapping("/admin/categories")
public class AdminCategoryController {

    private final CategoryService categoryService;

    public AdminCategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    /**
     * Danh sách danh mục có tìm kiếm và phân trang
     */
    @GetMapping({"", "/"})
    public String listCategories(
            @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "5") int size,
            Model model) {

        // Giữ số trang hợp lệ >= 0
        if (page < 0) {
            page = 0;
        }

        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<Category> categoryPage = categoryService.findAll(keyword, pageable);

        model.addAttribute("categoryPage", categoryPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("totalElements", categoryPage.getTotalElements());

        return "admin/category/list";
    }

    /**
     * Hiển thị form thêm mới danh mục
     */
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        Category category = new Category();
        category.setStatus(true);
        model.addAttribute("category", category);
        model.addAttribute("pageTitle", "Thêm mới danh mục");
        return "admin/category/form";
    }

    /**
     * Hiển thị form cập nhật danh mục
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes ra) {
        Optional<Category> optCategory = categoryService.findById(id);
        if (optCategory.isEmpty()) {
            ra.addFlashAttribute("errorMessage", "Không tìm thấy danh mục có ID: " + id);
            return "redirect:/admin/categories";
        }
        model.addAttribute("category", optCategory.get());
        model.addAttribute("pageTitle", "Cập nhật danh mục #" + id);
        return "admin/category/form";
    }

    /**
     * Xử lý lưu danh mục (Thêm mới hoặc Cập nhật)
     */
    @PostMapping("/save")
    public String saveCategory(
            @Valid @ModelAttribute("category") Category category,
            BindingResult result,
            Model model,
            RedirectAttributes ra) {

        // Kiểm tra trùng lặp mã danh mục (Code)
        if (category.getCode() != null && !category.getCode().trim().isEmpty()) {
            boolean codeExists;
            if (category.getId() == null) {
                codeExists = categoryService.existsByCode(category.getCode());
            } else {
                codeExists = categoryService.existsByCodeAndIdNot(category.getCode(), category.getId());
            }

            if (codeExists) {
                result.rejectValue("code", "duplicate.code", "Mã danh mục '" + category.getCode() + "' đã tồn tại!");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("pageTitle", category.getId() == null ? "Thêm mới danh mục" : "Cập nhật danh mục #" + category.getId());
            return "admin/category/form";
        }

        categoryService.save(category);
        ra.addFlashAttribute("successMessage", (category.getId() == null ? "Thêm mới" : "Cập nhật") + " danh mục thành công!");
        return "redirect:/admin/categories";
    }

    /**
     * Xóa danh mục
     */
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id, RedirectAttributes ra) {
        Optional<Category> optCategory = categoryService.findById(id);
        if (optCategory.isPresent()) {
            categoryService.deleteById(id);
            ra.addFlashAttribute("successMessage", "Xóa danh mục '" + optCategory.get().getName() + "' thành công!");
        } else {
            ra.addFlashAttribute("errorMessage", "Không tìm thấy danh mục cần xóa!");
        }
        return "redirect:/admin/categories";
    }
}
