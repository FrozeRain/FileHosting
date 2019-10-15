package com.frozerain.filehostinger.DAO;

import com.frozerain.filehostinger.entity.UserFile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FilesDAO extends JpaRepository<UserFile, Long> {

    List<UserFile> findAllByFileNameContaining(String filter);
}
