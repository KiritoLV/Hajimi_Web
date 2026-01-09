package com.kiritolv.controller;


import com.kiritolv.mapper.*;
import com.kiritolv.pojo.Dash;
import com.kiritolv.pojo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/dashboard")
public class DashBoardController {

    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private ClazzMapper clazzMapper;
    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private StudentMapper studentMapper;
    @GetMapping("/stats")
    public Result getData(){
        Dash dash=new Dash();
        dash.setEmpCount(empMapper.getData());
        dash.setDeptCount(deptMapper.getData());
        dash.setClazzCount(clazzMapper.getData());
        dash.setStuCount(studentMapper.getData());
        return Result.success(dash);
    }
}
