package com.jnbdt.databases.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jnbdt.databases.entity.Demo1;
import com.jnbdt.databases.mapper.mapper3.StudentMapper3;
import com.jnbdt.databases.service.StudentMapper3S;

/**
 * @ClassNmame Impl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月14日 下午2:19:26
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class Impl3 implements StudentMapper3S {

	@Autowired(required = false)
	private StudentMapper3 studentMapper3;

	@Override
	public List<Demo1> findAll3() {

		return studentMapper3.findAll3();
	}

}
