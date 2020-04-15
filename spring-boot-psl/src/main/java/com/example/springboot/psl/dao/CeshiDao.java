package com.example.springboot.psl.dao;


import java.util.List;
import java.util.Map;

public interface CeshiDao {

    int query();

    @SuppressWarnings("rawtypes")
	List<Map> listUser();
}
