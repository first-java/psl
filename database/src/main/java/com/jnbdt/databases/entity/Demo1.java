package com.jnbdt.databases.entity;

import java.io.Serializable;

/**
 * @author syp
 * @title: Demo1
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2510:29
 */
public class Demo1 implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
    private String name;
    private String password;

    @Override
    public String toString() {
        return "Demo1{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Demo1() {
    }

    public Demo1(int id, String name, String password) {
        this.id = id;
        this.name = name;
        this.password = password;
    }
}
