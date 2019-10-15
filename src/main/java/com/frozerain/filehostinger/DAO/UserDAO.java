package com.frozerain.filehostinger.DAO;

import com.frozerain.filehostinger.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDAO extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
