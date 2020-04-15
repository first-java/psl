package com.jnbdt.databases.mapper.mapper2;


import java.util.List;

import com.jnbdt.databases.entity.Student;

/**
 * @author syp
 * @title: StudentMapper2
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2510:30
 */
public interface StudentMapper2 {
    List<Student> findAll2();
    Student findOne2(Integer id);
}
