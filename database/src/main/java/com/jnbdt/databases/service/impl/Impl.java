package com.jnbdt.databases.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jnbdt.databases.entity.Student;
import com.jnbdt.databases.mapper.mapper1.StudentMapper1;
import com.jnbdt.databases.service.StudentMapper1S;

/**
 * @ClassNmame Impl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月14日 下午2:19:26
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class Impl implements StudentMapper1S {

	@Autowired(required = false)
	private StudentMapper1 studentMapper1;

	@Override
	public List<Student> findAll() {

		return studentMapper1.findAll();
	}

}
