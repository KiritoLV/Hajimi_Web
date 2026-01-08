package com.kiritolv.aop;

import com.kiritolv.anno.Log;
import com.kiritolv.mapper.OperateLogMapper;
import com.kiritolv.pojo.OperateLog;
import com.kiritolv.util.ThreadLocalSave;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import java.util.Arrays;

@Slf4j
@Aspect
@Component
public class OperationLogAspect {

    @Autowired
    private OperateLogMapper operateLogMapper;

    // 环绕通知
    @Around("@annotation(com.kiritolv.anno.Log)")
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
        // 记录开始时间
        long startTime = System.currentTimeMillis();
        // 执行方法
        Object result = joinPoint.proceed();
        // 当前时间
        long endTime = System.currentTimeMillis();
        // 耗时
        long costTime = endTime - startTime;

        // 构建日志对象
        OperateLog xlog = new OperateLog();
        xlog.setOperateEmpId(getCurrentUserId()); // 需要实现 getCurrentUserId 方法
        xlog.setOperateTime(LocalDateTime.now());
        xlog.setClassName(joinPoint.getTarget().getClass().getName());
        xlog.setMethodName(joinPoint.getSignature().getName());
        xlog.setMethodParams(Arrays.toString(joinPoint.getArgs()));
        xlog.setReturnValue(result!=null?result.toString():"void");
        xlog.setCostTime(costTime);
        log.info("记录操作日志{}",xlog);
        // 插入日志
        operateLogMapper.insert(xlog);
        return result;
    }

    // 示例方法，获取当前用户ID
    private int getCurrentUserId() {
        return ThreadLocalSave.getCurrentId();
    }

}