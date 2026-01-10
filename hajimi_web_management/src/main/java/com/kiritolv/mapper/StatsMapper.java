package com.kiritolv.mapper;

import com.kiritolv.pojo.Dash;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StatsMapper {

    Dash getGlobalStats();
}
