package com.kiritolv.controller;

import com.kiritolv.anno.Log;
import com.kiritolv.pojo.Clazz;
import com.kiritolv.pojo.PageResult;
import com.kiritolv.pojo.Result;
import com.kiritolv.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/clazzs")
public class ClazzController {
    @Autowired
    private ClazzService clazzService;

    /**
     * 新增班级
     */
    @Log
    @PostMapping
    public Result save(@RequestBody Clazz clazz){
        clazzService.save(clazz);
        return Result.success();
    }

    /**
     * 条件分页查询班级
     */
    @GetMapping
    public Result page(String name ,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin ,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end,
                       @RequestParam(defaultValue = "1") Integer page ,
                       @RequestParam(defaultValue = "10")Integer pageSize){
        PageResult pageResult = clazzService.page(name , begin , end , page , pageSize);
        return Result.success(pageResult);
    }

    /**
     * 根据ID查询班级详情
     */
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        Clazz clazz = clazzService.getInfo(id);
        return Result.success(clazz);
    }

    /**
     * 更新班级信息
     */
    @Log
    @PutMapping
    public Result update(@RequestBody Clazz clazz){
        clazzService.update(clazz);
        return Result.success();
    }

    /**
     * 根据ID删除班级
     */
    @Log
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        clazzService.deleteById(id);
        return Result.success();
    }

    /**
     * 查询全部班级
     */
    @GetMapping("/list")
    public Result findAll(){
        List<Clazz> clazzList = clazzService.findAll();
        return Result.success(clazzList);
    }
}
