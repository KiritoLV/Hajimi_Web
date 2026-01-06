package com.kiritolv.service.Impl;

import com.kiritolv.mapper.DeptMapper;
import com.kiritolv.pojo.Dept;
import com.kiritolv.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class DeptServiceImpl  implements DeptService {
    @Autowired
    private DeptMapper deptMapper;
    @Override
    public List<Dept> findAll() {
        return deptMapper.findAll();
    }

    @Override
    public void delete(Integer id) {
        deptMapper.delete(id);
    }

    @Override
    public void addDept(Dept dept) {
        dept.setCreateTime(LocalDateTime.now());
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.addDept(dept);
    }

    @Override
    public Dept query(Integer id) {
        return deptMapper.query(id);
    }

    @Override
    public void updatename(Dept dept) {
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.updatename(dept);
    }
}
