package com.kiritolv.service;


import com.kiritolv.pojo.Dept;

import java.util.List;

public interface DeptService {
    List<Dept> findAll();

    void delete(Integer id);

    void addDept(Dept dept);

    Dept query(Integer id);

    void updatename(Dept dept);
}
