<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển (Dashboard)</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">Tổng quan Hệ thống</h3>
            <p class="text-muted mb-0">Chào mừng bạn quay trở lại trang quản trị.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="<c:url value='/admin/categories/create'/>" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-folder-plus me-1"></i> + Danh mục mới
            </a>
            <a href="<c:url value='/admin/users/create'/>" class="btn btn-primary btn-sm">
                <i class="bi bi-person-plus me-1"></i> + Người dùng mới
            </a>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-12 col-md-6 col-xl-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-3 me-3">
                        <i class="bi bi-tags fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-medium">Tổng Danh Mục</div>
                        <h4 class="fw-bold mb-0 text-dark">${totalCategories}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-3 me-3">
                        <i class="bi bi-people fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-medium">Tổng Người Dùng</div>
                        <h4 class="fw-bold mb-0 text-dark">${totalUsers}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-3 me-3">
                        <i class="bi bi-shield-check fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-medium">Phiên Bản Framework</div>
                        <h5 class="fw-bold mb-0 text-dark">Spring Boot 3.2</h5>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="p-3 bg-info bg-opacity-10 text-info rounded-3 me-3">
                        <i class="bi bi-layout-text-window fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-medium">Layout Decorator</div>
                        <h5 class="fw-bold mb-0 text-dark">SiteMesh 3</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Navigation -->
    <div class="row g-4">
        <div class="col-12 col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 fw-bold"><i class="bi bi-tags me-2 text-primary"></i>Quản lý Danh mục</h6>
                </div>
                <div class="card-body">
                    <p class="text-muted small">Quản lý danh sách, tìm kiếm, phân trang và chỉnh sửa thông tin các loại danh mục trong hệ thống.</p>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-primary btn-sm">
                        Đi tới danh sách danh mục &rarr;
                    </a>
                </div>
            </div>
        </div>

        <div class="col-12 col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 fw-bold"><i class="bi bi-people me-2 text-success"></i>Quản lý Người dùng</h6>
                </div>
                <div class="card-body">
                    <p class="text-muted small">Quản trị tài khoản người dùng, phân quyền ADMIN / USER, khóa và kích hoạt tài khoản.</p>
                    <a href="<c:url value='/admin/users'/>" class="btn btn-outline-success btn-sm">
                        Đi tới danh sách người dùng &rarr;
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
