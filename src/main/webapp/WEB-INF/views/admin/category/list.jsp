<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Danh Mục</title>
</head>
<body>

    <!-- Header & Action -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <div>
            <h3 class="fw-bold text-dark mb-1">Quản lý Danh mục</h3>
            <p class="text-muted small mb-0">Quản lý các nhóm sản phẩm và phân loại trong hệ thống</p>
        </div>
        <a href="<c:url value='/admin/categories/create'/>" class="btn btn-primary shadow-sm">
            <i class="bi bi-plus-lg me-1"></i> Thêm mới danh mục
        </a>
    </div>

    <!-- Flash Alerts -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Filter & Search Card -->
    <div class="card mb-4 border-0 shadow-sm">
        <div class="card-body">
            <form action="<c:url value='/admin/categories'/>" method="get" class="row g-3 align-items-center">
                <input type="hidden" name="page" value="0" />
                
                <div class="col-12 col-md-6 col-lg-5">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0">
                            <i class="bi bi-search text-muted"></i>
                        </span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control border-start-0 ps-0" 
                               placeholder="Tìm theo tên danh mục hoặc mã code..." />
                        <button type="submit" class="btn btn-primary px-3">Tìm kiếm</button>
                    </div>
                </div>

                <div class="col-6 col-md-3 col-lg-2">
                    <select name="size" class="form-select" onchange="this.form.submit()">
                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5 dòng / trang</option>
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10 dòng / trang</option>
                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20 dòng / trang</option>
                    </select>
                </div>

                <div class="col-6 col-md-3 col-lg-2">
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i> Xóa bộ lọc
                        </a>
                    </c:if>
                </div>
            </form>
        </div>
    </div>

    <!-- Data Table Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h6 class="mb-0 fw-bold text-dark">
                <i class="bi bi-list-ul me-2 text-primary"></i>Danh sách dữ liệu
            </h6>
            <span class="badge bg-secondary">Tổng số: ${totalElements} danh mục</span>
        </div>
        
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light text-secondary small text-uppercase">
                    <tr>
                        <th style="width: 70px;" class="text-center">ID</th>
                        <th>Tên danh mục</th>
                        <th>Mã Code</th>
                        <th class="text-center">Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th class="text-center" style="width: 150px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${categoryPage.hasContent()}">
                            <c:forEach items="${categoryPage.content}" var="item">
                                <tr>
                                    <td class="text-center fw-semibold text-muted">#${item.id}</td>
                                    <td>
                                        <span class="fw-semibold text-dark">${item.name}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border font-monospace px-2 py-1">${item.code}</span>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${item.status}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">
                                                    <i class="bi bi-slash-circle me-1"></i>Tạm khóa
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-muted small">
                                        ${item.createdAt}
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm" role="group">
                                            <a href="<c:url value='/admin/categories/edit/${item.id}'/>" 
                                               class="btn btn-outline-primary" title="Chỉnh sửa">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <a href="<c:url value='/admin/categories/delete/${item.id}'/>" 
                                               class="btn btn-outline-danger" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${item.name}] không?');"
                                               title="Xóa danh mục">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    Không có dữ liệu danh mục nào phù hợp!
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Pagination Controls -->
        <c:if test="${totalPages > 0}">
            <div class="card-footer bg-white py-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div class="small text-muted">
                    Trang <strong>${currentPage + 1}</strong> trên tổng số <strong>${totalPages}</strong> trang
                    (Hiển thị ${categoryPage.numberOfElements} / ${totalElements} dòng)
                </div>

                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <!-- First Page -->
                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=0&size=${pageSize}&keyword=${keyword}'/>" title="Trang đầu">
                                <i class="bi bi-chevron-double-left"></i>
                            </a>
                        </li>
                        <!-- Previous Page -->
                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage - 1}&size=${pageSize}&keyword=${keyword}'/>" title="Trang trước">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>

                        <!-- Numbered Pages -->
                        <c:forEach begin="0" end="${totalPages - 1}" var="p">
                            <c:if test="${p >= currentPage - 2 && p <= currentPage + 2}">
                                <li class="page-item ${p == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/categories?page=${p}&size=${pageSize}&keyword=${keyword}'/>">
                                        ${p + 1}
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <!-- Next Page -->
                        <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage + 1}&size=${pageSize}&keyword=${keyword}'/>" title="Trang kế">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                        <!-- Last Page -->
                        <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=${totalPages - 1}&size=${pageSize}&keyword=${keyword}'/>" title="Trang cuối">
                                <i class="bi bi-chevron-double-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>

</body>
</html>
