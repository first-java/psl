package com.jnbdt.databases.mapper.mapper1;



import java.util.List;

import com.jnbdt.databases.entity.Student;

/**
 * @author syp
 * @title: StudentMapper1
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2510:29
 */
public interface StudentMapper1 {
    List<Student> findAll();
    Student findOne(Integer id);
}
