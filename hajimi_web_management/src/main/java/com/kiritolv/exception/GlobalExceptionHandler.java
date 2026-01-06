package com.kiritolv.exception;

import com.kiritolv.pojo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    public Result handleException(Exception e){
        log.error("程序出错了",e);
        return Result.error("出错了");
    }
}
