package com.kiritolv.controller;

import com.kiritolv.pojo.*;
import com.kiritolv.service.EmpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/emps")
public class EmpController {
    @Autowired
    private EmpService empService;
    /*
    员工列表查询
     */
    @GetMapping
    public Result Page(EmpQueryParam empQueryParam){
        PageResult<Emp> emplist=empService.empQuery(empQueryParam);
        return Result.success(emplist);
    }

    /*
    新增员工
     */
    @PostMapping
    public  Result save(@RequestBody Emp emp){
        log.info("新增员工: {}",emp);
        empService.save(emp);
        return Result.success();
    }
    /*
    删除员工
     */
    @DeleteMapping
    public  Result delete(@RequestParam List<Integer> ids){
        log.info("删除员工"+ ids);
        empService.delete(ids);
        return Result.success();
    }
    /*
    查询员工回显
     */
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        log.info("根据员工id查找:{}", id);
        Emp emp = empService.getInfo(id);
        return Result.success(emp);
    }
    /*
    修改员工信息
     */
    @PutMapping
    public Result update(@RequestBody Emp emp){
        log.info("修改员工信息:{}",emp.getId());
        empService.update(emp);
        return Result.success();
    }
    /*
    查询全部员工
     */
    @GetMapping("/list")
    public Result getAllEmp(){

        return Result.success();
    }
}
