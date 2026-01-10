<script setup>
import {
  queryStudentCountDataApi,
  queryStudentDegreeDataApi,
} from "@/api/report";
import * as echarts from "echarts";
import { ElMessage } from "element-plus";
import { onBeforeUnmount, onMounted, ref } from "vue";

const countChartRef = ref(null);
const degreeChartRef = ref(null);

let countChart = null;
let degreeChart = null;

const initCharts = async () => {
  try {
    const [countResult, degreeResult] = await Promise.all([
      queryStudentCountDataApi(),
      queryStudentDegreeDataApi(),
    ]);

    if (countResult.code) {
      const { clazzList, dataList } = countResult.data;
      initStudentCountChart(clazzList, dataList);
    } else {
      ElMessage.error("班级人数数据加载失败");
    }

    if (degreeResult.code) {
      initDegreeChart(degreeResult.data);
    } else {
      ElMessage.error("学员学历数据加载失败");
    }
  } catch (error) {
    ElMessage.error("图表数据加载异常");
  }
};

const initStudentCountChart = (clazzList, dataList) => {
  countChart = echarts.init(countChartRef.value);
  countChart.setOption({
    title: {
      text: "班级人数统计",
      left: "center",
      textStyle: { color: "#303133" },
    },
    tooltip: { trigger: "axis" },
    grid: { left: "3%", right: "4%", bottom: "3%", containLabel: true },
    xAxis: {
      type: "category",
      data: clazzList,
      axisLabel: { interval: 0, rotate: 30 },
    },
    yAxis: { type: "value" },
    series: [
      {
        name: "人数",
        type: "bar",
        data: dataList,
        itemStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: "#67C23A" },
            { offset: 1, color: "#B3E19D" },
          ]),
        },
      },
    ],
  });
};

const initDegreeChart = (degreeDataList) => {
  degreeChart = echarts.init(degreeChartRef.value);
  degreeChart.setOption({
    title: {
      text: "学员学历统计",
      left: "center",
      textStyle: { color: "#303133" },
    },
    tooltip: { trigger: "item", formatter: "{a} <br/>{b} : {c} ({d}%)" },
    legend: {
      orient: "vertical",
      left: "left",
    },
    series: [
      {
        name: "学历",
        type: "pie",
        radius: "50%",
        data: degreeDataList,
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: "rgba(0, 0, 0, 0.5)",
          },
        },
        color: [
          "#409EFF",
          "#67C23A",
          "#E6A23C",
          "#F56C6C",
          "#909399",
          "#C0C4CC",
        ],
      },
    ],
  });
};

const resizeCharts = () => {
  countChart?.resize();
  degreeChart?.resize();
};

onMounted(() => {
  initCharts();
  window.addEventListener("resize", resizeCharts);
});

onBeforeUnmount(() => {
  window.removeEventListener("resize", resizeCharts);
  countChart?.dispose();
  degreeChart?.dispose();
});
</script>

<template>
  <el-row :gutter="20">
    <el-col :xs="24" :sm="24" :md="12">
      <div class="content-card chart-container">
        <div ref="countChartRef" class="chart"></div>
      </div>
    </el-col>
    <el-col :xs="24" :sm="24" :md="12">
      <div class="content-card chart-container">
        <div ref="degreeChartRef" class="chart"></div>
      </div>
    </el-col>
  </el-row>
</template>

<style scoped>
.chart-container {
  height: 400px;
  padding: 20px;
}
.chart {
  width: 100%;
  height: 100%;
}
</style>
