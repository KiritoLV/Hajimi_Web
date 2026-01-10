package com.kiritolv.controller;


import com.kiritolv.mapper.*;
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
    private StatsMapper statsMapper;
    @GetMapping("/stats")
    public Result getData(){
        return Result.success(statsMapper.getGlobalStats());
    }
}
