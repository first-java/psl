package com.jnbdt.databases.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jnbdt.databases.entity.Demo1;
import com.jnbdt.databases.entity.Student;
import com.jnbdt.databases.service.StudentMapper1S;
import com.jnbdt.databases.service.StudentMapper2S;
import com.jnbdt.databases.service.StudentMapper3S;

/**
 * @author syp
 * @title: MainController
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2510:28
 */
@Controller
public class MainController {
	@Autowired
	private StudentMapper1S studentMapper1;
	@Autowired
	private StudentMapper2S studentMapper2;
	@Autowired
	private StudentMapper3S studentMapper3;

	@RequestMapping("/")
	private @ResponseBody String findAll() {
		List<Student> lists = studentMapper1.findAll();
		System.out.println(lists);
		return lists.toString();
	}

	@RequestMapping("/find")
	private @ResponseBody String findAll2() {
		List<Student> lists = studentMapper2.findAll2();
		System.out.println(lists);
		return lists.toString();
	}

	@RequestMapping("/find3")
	private @ResponseBody String findAll3() {
		List<Demo1> lists = studentMapper3.findAll3();
		System.out.println(lists);
		return lists.toString();
	}

}
