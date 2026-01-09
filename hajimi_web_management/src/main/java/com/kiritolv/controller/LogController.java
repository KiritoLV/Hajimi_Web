package com.kiritolv.controller;


import com.kiritolv.pojo.OperateLog;
import com.kiritolv.pojo.PageResult;
import com.kiritolv.pojo.Result;
import com.kiritolv.service.EmpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class LogController {
    @Autowired
    private EmpService empService;

    @GetMapping("/log/page")
    public Result LogQuery(Integer page,Integer pageSize){
        PageResult<OperateLog> loglist=empService.logpage(page,pageSize);
        return Result.success(loglist);
    }
}
