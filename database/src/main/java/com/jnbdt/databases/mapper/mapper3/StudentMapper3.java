package com.jnbdt.databases.mapper.mapper3;

import java.util.List;

import com.jnbdt.databases.entity.Demo1;

/**
 * @author syp
 * @title: StudentMapper3
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2513:38
 */
public interface StudentMapper3 {
    List<Demo1> findAll3();
    Demo1 findOne3(Integer id);
}
