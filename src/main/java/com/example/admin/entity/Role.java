package com.example.admin.entity;

public enum Role {
    ADMIN("Quản trị viên"),
    USER("Người dùng");

    private final String displayName;

    Role(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
