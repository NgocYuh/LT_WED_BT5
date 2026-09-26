package com.example.admin.init;

import com.example.admin.entity.Category;
import com.example.admin.entity.Role;
import com.example.admin.entity.User;
import com.example.admin.repository.CategoryRepository;
import com.example.admin.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
public class DataInitializer implements CommandLineRunner {

    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;

    public DataInitializer(CategoryRepository categoryRepository, UserRepository userRepository) {
        this.categoryRepository = categoryRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) {
        // Khởi tạo dữ liệu mẫu cho Category nếu bảng đang rỗng
        if (categoryRepository.count() == 0) {
            categoryRepository.saveAll(Arrays.asList(
                    new Category("Điện thoại thông minh", "CAT_PHONE", true),
                    new Category("Laptop & Máy tính xách tay", "CAT_LAPTOP", true),
                    new Category("Máy tính bảng iPad & Android", "CAT_TABLET", true),
                    new Category("Đồng hồ thông minh Smartwatch", "CAT_WATCH", true),
                    new Category("Tai nghe & Loa Bluetooth", "CAT_AUDIO", true),
                    new Category("Phụ kiện cáp sạc & pin dự phòng", "CAT_ACCESSORY", true),
                    new Category("Thiết bị gia dụng thông minh", "CAT_SMARTHOME", true),
                    new Category("Màn hình máy tính Gaming", "CAT_MONITOR", false),
                    new Category("Bàn phím cơ & Chuột không dây", "CAT_GEAR", true),
                    new Category("Máy ảnh & Thiết bị quay phim", "CAT_CAMERA", false),
                    new Category("Linh kiện PC & Card đồ họa", "CAT_PC_PARTS", true),
                    new Category("Thiết bị mạng Router Wifi", "CAT_NETWORK", true)
            ));
        }

        // Khởi tạo dữ liệu mẫu cho User nếu bảng đang rỗng
        if (userRepository.count() == 0) {
            userRepository.saveAll(Arrays.asList(
                    new User("admin", "admin123", "admin@ute.edu.vn", Role.ADMIN, true),
                    new User("manager", "manager123", "manager@ute.edu.vn", Role.ADMIN, true),
                    new User("huy_developer", "huy123456", "huy.nguyen@example.com", Role.ADMIN, true),
                    new User("lan_tran", "pass123456", "lan.tran@gmail.com", Role.USER, true),
                    new User("minh_tuan", "pass123456", "tuan.minh@yahoo.com", Role.USER, true),
                    new User("hoang_nam", "pass123456", "nam.hoang@outlook.com", Role.USER, false),
                    new User("thanh_huong", "pass123456", "huong.thanh@gmail.com", Role.USER, true),
                    new User("quoc_bao", "pass123456", "bao.quoc@gmail.com", Role.USER, false),
                    new User("thuy_tien", "pass123456", "tien.thuy@gmail.com", Role.USER, true),
                    new User("duc_anh", "pass123456", "anh.duc@gmail.com", Role.USER, true)
            ));
        }
    }
}
