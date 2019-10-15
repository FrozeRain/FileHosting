package com.frozerain.filehostinger.entity;

import org.springframework.security.core.GrantedAuthority;

public enum  Role implements GrantedAuthority {
    USER,
    ADMIN,
    VIP,
    PREMIUM;

    @Override
    public String getAuthority() {
        return name();
    }
}
