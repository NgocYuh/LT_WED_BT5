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
                <a href="<c:url value='/admin/users'/>" class="text-decoration-none text-muted small">
                    <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách người dùng
                </a>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-person-fill-gear me-2 text-primary"></i>${pageTitle}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/users/save'/>" method="post">
                        <!-- Hidden ID for update -->
                        <c:if test="${not empty user.id}">
                            <input type="hidden" name="id" value="${user.id}"/>
                            <input type="hidden" name="createdAt" value="${user.createdAt}"/>
                        </c:if>

                        <!-- Username -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold">
                                Tên đăng nhập (Username) <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="user.username">
                                <input type="text" class="form-control ${status.error ? 'is-invalid' : ''}" 
                                       id="username" name="username" value="${user.username}" 
                                       placeholder="Ví dụ: nguyenvana" />
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-semibold">
                                Mật khẩu <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="user.password">
                                <input type="password" class="form-control ${status.error ? 'is-invalid' : ''}" 
                                       id="password" name="password" value="${user.password}" 
                                       placeholder="Tối thiểu 6 ký tự" />
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                Địa chỉ Email <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="user.email">
                                <input type="email" class="form-control ${status.error ? 'is-invalid' : ''}" 
                                       id="email" name="email" value="${user.email}" 
                                       placeholder="Ví dụ: vana@gmail.com" />
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                        </div>

                        <!-- Role -->
                        <div class="mb-3">
                            <label for="role" class="form-label fw-semibold">
                                Vai trò (Role) <span class="text-danger">*</span>
                            </label>
                            <spring:bind path="user.role">
                                <select class="form-select ${status.error ? 'is-invalid' : ''}" id="role" name="role">
                                    <c:forEach items="${roles}" var="r">
                                        <option value="${r}" ${user.role == r ? 'selected' : ''}>
                                            ${r.displayName} (${r})
                                        </option>
                                    </c:forEach>
                                </select>
                                <c:if test="${status.error}">
                                    <div class="invalid-feedback">${status.errorMessage}</div>
                                </c:if>
                            </spring:bind>
                        </div>

                        <!-- Status -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái tài khoản</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" 
                                       value="true" ${user.status == null || user.status ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-medium" for="statusActive">
                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusInactive" 
                                       value="false" ${user.status != null && !user.status ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-medium" for="statusInactive">
                                    <i class="bi bi-slash-circle me-1"></i>Tạm khóa
                                </label>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary px-4">
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
