package com.example.springboot.psl.service;

import java.util.List;
import java.util.Map;

public interface CeshiService {

    int query();
    @SuppressWarnings("rawtypes")
	List<Map> listUser();
}
