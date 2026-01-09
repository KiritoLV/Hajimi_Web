package com.kiritolv.service;

import com.kiritolv.pojo.*;

import java.util.List;

public interface EmpService {
    PageResult<Emp> empQuery(EmpQueryParam empQueryParam);

    void save(Emp emp);

    void delete(List<Integer> ids);

    Emp getInfo(Integer id);

    void update(Emp emp);

    LoginInfo login(Emp emp);

    List<Emp> getAllEmp();

    PageResult<OperateLog> logpage(Integer page,Integer pageSize);
}
