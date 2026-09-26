<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
</head>
<body>

    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            
            <!-- Breadcrumb & Back -->
            <div class="mb-3">
                <a href="<c:url value='/admin/categories'/>" class="text-decoration-none text-muted small">
                    <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách danh mục
                </a>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-folder-check me-2 text-primary"></i>${pageTitle}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/categories/save'/>" method="post">
                        <!-- Hidden ID for update -->
                        <c:if test="${not empty category.id}">
                            <input type="hidden" name="id" value="${category.id}"/>
                            <input type="hidden" name="createdAt" value="${category.createdAt}"/>
                        </c:if>

                        <!-- Category Name -->
                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">
                                Tên danh mục <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="category.name">
                                <input type="text" class="form-control ${status.error ? 'is-invalid' : ''}" 
                                       id="name" name="name" value="${category.name}" 
                                       placeholder="Ví dụ: Thiết bị gia dụng thông minh" />
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                        </div>

                        <!-- Category Code -->
                        <div class="mb-3">
                            <label for="code" class="form-label fw-semibold">
                                Mã danh mục (Code) <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="category.code">
                                <input type="text" class="form-control text-uppercase font-monospace ${status.error ? 'is-invalid' : ''}" 
                                       id="code" name="code" value="${category.code}" 
                                       placeholder="Ví dụ: CAT_SMARTHOME" />
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                            <div class="form-text small text-muted">
                                Mã định danh duy nhất (không trùng lặp, viết hoa tự động).
                            </div>
                        </div>

                        <!-- Status -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái hoạt động</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" 
                                       value="true" ${category.status == null || category.status ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-medium" for="statusActive">
                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusInactive" 
                                       value="false" ${category.status != null && !category.status ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-medium" for="statusInactive">
                                    <i class="bi bi-slash-circle me-1"></i>Tạm khóa
                                </label>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary px-4">
                                Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-save me-1"></i> Lưu thông tin
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
