package com.example.admin.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // SiteMesh 3 tự động gắn prefix '/WEB-INF/decorators/' cho các decorator path
        builder.addDecoratorPath("/admin", "/admin-decorator.jsp")
               .addDecoratorPath("/admin/**", "/admin-decorator.jsp");

        // Loại trừ các đường dẫn tĩnh hoặc không cần decorate
        builder.addExcludedPath("/static/**")
               .addExcludedPath("/assets/**")
               .addExcludedPath("/css/**")
               .addExcludedPath("/js/**")
               .addExcludedPath("/images/**")
               .addExcludedPath("/h2-console/**");
    }
}
