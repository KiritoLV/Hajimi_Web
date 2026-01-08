package com.kiritolv.controller;

import com.kiritolv.anno.Log;
import com.kiritolv.pojo.Dept;
import com.kiritolv.pojo.Result;
import com.kiritolv.service.DeptService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/depts")
public class DeptController {

    /*
    查询所有部门信息
     */
    @Autowired
    private DeptService deptService;

    @GetMapping
    public Result list(){
        List<Dept> deptlist=deptService.findAll();
        return Result.success(deptlist);
    }

//    @DeleteMapping("/depts")
//    public Result delete(HttpServletRequest request){
//        String sid=request.getParameter("id");
//        int id=Integer.parseInt(sid);
//        System.out.println("delete ID"+id);
//        return Result.success();
//    }
    @Log
    @DeleteMapping
    public Result delete(Integer id){
//        System.out.println("delete ID"+id);
        log.info("delete ID {}",id);
        deptService.delete(id);
        return Result.success();
    }
    /*
    新增部门
     */
    @Log
    @PostMapping
    public Result addDept(@RequestBody Dept dept){
        System.out.println("add dept "+dept);
        deptService.addDept(dept);
        return Result.success();
    }
    /*
    根据id查询显示部门名称
     */
    @GetMapping("/{id}")
    public Result query(@PathVariable Integer id){
        System.out.println("查询id"+id);
        Dept dept=deptService.query(id);
        return Result.success(dept);
    }
    /*
    修改部门name
     */
    @Log
    @PutMapping
    public Result updatename(@RequestBody Dept dept){
        System.out.println("修改部门ID"+dept.getId()+"名字"+dept.getName());
        deptService.updatename(dept);
        return Result.success();
    }
}
