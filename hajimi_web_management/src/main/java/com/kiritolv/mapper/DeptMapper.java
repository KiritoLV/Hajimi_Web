package com.kiritolv.mapper;

import com.kiritolv.pojo.Dept;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface DeptMapper {
    /*
    查询所有部门
     */
    @Select("select * from dept order by update_time desc")
    List<Dept> findAll();
    @Delete("delete from dept where id= #{id}")
    void delete(Integer id);
    @Insert("insert into dept(name,create_time,update_time) values(#{name},#{createTime},#{updateTime})")
    void addDept(Dept dept);
    @Select("select * from dept where id=#{id}")
    Dept query(Integer id);
    @Update("update dept set name=#{name},update_time=#{updateTime}where id=#{id}")
    void updatename(Dept dept);
}
