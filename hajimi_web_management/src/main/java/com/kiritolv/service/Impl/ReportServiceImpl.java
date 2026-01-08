package com.kiritolv.service.Impl;

import com.kiritolv.mapper.ClazzMapper;
import com.kiritolv.mapper.EmpMapper;
import com.kiritolv.mapper.StudentMapper;
import com.kiritolv.pojo.ClazzCountOption;
import com.kiritolv.pojo.JobOption;
import com.kiritolv.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ClazzMapper clazzMapper;

    @Override
    public JobOption getEmpJobData() {
        List<Map<String,Object>> list= empMapper.countEmpJobData();
        List<Object> jobList = list.stream().map(dataMap -> dataMap.get("pos")).toList();
        List<Object> numList = list.stream().map(dataMap -> dataMap.get("num")).toList();

        return new JobOption(jobList,numList);
    }

    @Override
    public List<Map> getEmpGenderData() {
        return empMapper.countEmpGenderData();
    }

    @Override
    public List<Map> getStuDegreeData() {
        return studentMapper.countStudentDegreeData();
    }

    @Override
    public ClazzCountOption getStuCountData() {
        List<Map<String,Object>> list= clazzMapper.countEmpJobData();
        List<Object> clazzList = list.stream().map(dataMap -> dataMap.get("clazz")).toList();
        List<Object> dataList = list.stream().map(dataMap -> dataMap.get("value")).toList();
        return new ClazzCountOption(clazzList,dataList);
    }
}
