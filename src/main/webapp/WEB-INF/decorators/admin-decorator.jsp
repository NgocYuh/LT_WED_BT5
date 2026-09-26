<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --sidebar-width: 260px;
            --topbar-height: 64px;
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }
        /* Sidebar Styling */
        #sidebar {
            width: var(--sidebar-width);
            min-height: 100vh;
            background: #0f172a;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            transition: all 0.3s ease-in-out;
            box-shadow: 4px 0 16px rgba(0,0,0,0.06);
        }
        #sidebar .sidebar-brand {
            height: var(--topbar-height);
            display: flex;
            align-items: center;
            padding: 0 1.5rem;
            background: #020617;
            font-size: 1.15rem;
            font-weight: 700;
            color: #f8fafc;
            border-bottom: 1px solid #1e293b;
            text-decoration: none;
        }
        #sidebar .nav-link {
            display: flex;
            align-items: center;
            padding: 0.85rem 1.5rem;
            color: #94a3b8;
            font-weight: 500;
            font-size: 0.95rem;
            border-left: 4px solid transparent;
            transition: all 0.2s ease;
        }
        #sidebar .nav-link i {
            font-size: 1.25rem;
            margin-right: 0.75rem;
            transition: transform 0.2s ease;
        }
        #sidebar .nav-link:hover {
            color: #ffffff;
            background-color: #1e293b;
        }
        #sidebar .nav-link.active {
            color: #ffffff;
            background: rgba(79, 70, 229, 0.2);
            border-left-color: #6366f1;
        }
        #sidebar .nav-link:hover i {
            transform: translateX(3px);
        }

        /* Top Navbar */
        #topbar {
            height: var(--topbar-height);
            margin-left: var(--sidebar-width);
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        /* Content Area */
        #main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem 2.5rem;
            min-height: calc(100vh - var(--topbar-height) - 60px);
        }

        /* Footer */
        #footer {
            margin-left: var(--sidebar-width);
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
            padding: 1.25rem;
            font-size: 0.875rem;
            color: #64748b;
        }

        /* Card Styles */
        .card {
            border: 1px solid #e2e8f0;
            border-radius: 0.75rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            font-weight: 600;
        }

        /* Badges & Buttons */
        .btn-primary {
            background: #4f46e5;
            border-color: #4f46e5;
        }
        .btn-primary:hover {
            background: #4338ca;
            border-color: #4338ca;
        }

        @media (max-width: 992px) {
            #sidebar {
                margin-left: calc(-1 * var(--sidebar-width));
            }
            #sidebar.show {
                margin-left: 0;
            }
            #topbar, #main-content, #footer {
                margin-left: 0;
            }
        }
    </style>
    
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Sidebar Navigation -->
    <nav id="sidebar">
        <a href="<c:url value='/admin'/>" class="sidebar-brand">
            <i class="bi bi-shield-lock-fill text-primary me-2 fs-4"></i>
            <span>ADMIN PORTAL</span>
        </a>

        <div class="px-3 pt-3 pb-2 text-uppercase text-secondary" style="font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em;">
            Quản Lý Hệ Thống
        </div>

        <ul class="nav flex-column mb-auto">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.endsWith('/admin') || pageContext.request.requestURI.contains('/dashboard') ? 'active' : ''}" 
                   href="<c:url value='/admin'/>">
                    <i class="bi bi-speedometer2"></i>
                    <span>Tổng quan (Dashboard)</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/categories') ? 'active' : ''}" 
                   href="<c:url value='/admin/categories'/>">
                    <i class="bi bi-tags"></i>
                    <span>Quản lý Danh mục</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/users') ? 'active' : ''}" 
                   href="<c:url value='/admin/users'/>">
                    <i class="bi bi-people"></i>
                    <span>Quản lý Người dùng</span>
                </a>
            </li>
        </ul>

        <div class="px-3 pt-4 pb-2 text-uppercase text-secondary" style="font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em;">
            Công Cụ Phát Triển
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/h2-console'/>" target="_blank">
                    <i class="bi bi-database-check text-warning"></i>
                    <span>H2 Database Console</span>
                </a>
            </li>
        </ul>
    </nav>

    <!-- Topbar Header -->
    <header id="topbar" class="d-flex align-items-center justify-content-between px-4">
        <div class="d-flex align-items-center">
            <button class="btn btn-outline-secondary d-lg-none me-3" id="sidebarToggle" type="button">
                <i class="bi bi-list fs-5"></i>
            </button>
            <div class="d-none d-sm-block">
                <span class="text-muted small">Hệ thống Quản trị / </span>
                <span class="fw-semibold text-dark"><sitemesh:write property='title'/></span>
            </div>
        </div>

        <div class="d-flex align-items-center gap-3">
            <div class="d-flex align-items-center gap-2">
                <img src="https://ui-avatars.com/api/?name=Admin+Master&background=4f46e5&color=fff&rounded=true&size=38" 
                     alt="Avatar" class="rounded-circle shadow-sm" width="38" height="38">
                <div class="d-none d-md-block text-start">
                    <div class="fw-semibold small text-dark">Quản trị viên</div>
                    <div class="text-muted" style="font-size: 0.75rem;">admin@ute.edu.vn</div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content Injected by SiteMesh 3 -->
    <main id="main-content">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer -->
    <footer id="footer" class="text-center">
        <div class="container-fluid">
            <span>&copy; 2026 Admin Management Portal - Spring Boot 3 & SiteMesh 3 & Bootstrap 5</span>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle mobile sidebar
        document.getElementById('sidebarToggle')?.addEventListener('click', function () {
            document.getElementById('sidebar').classList.toggle('show');
        });
    </script>
</body>
</html>
