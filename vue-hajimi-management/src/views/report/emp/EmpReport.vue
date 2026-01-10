<script setup>
import { queryEmpGenderDataApi, queryEmpJobDataApi } from "@/api/report";
import * as echarts from "echarts";
import { ElMessage } from "element-plus";
import { onBeforeUnmount, onMounted, ref } from "vue";

const jobChartRef = ref(null);
const genderChartRef = ref(null);

let jobChart = null;
let genderChart = null;

const initCharts = async () => {
  try {
    const [jobResult, genderResult] = await Promise.all([
      queryEmpJobDataApi(),
      queryEmpGenderDataApi(),
    ]);

    if (jobResult.code) {
      const { jobList, dataList } = jobResult.data;
      initJobChart(jobList, dataList);
    } else {
      ElMessage.error("职位统计数据加载失败");
    }

    if (genderResult.code) {
      initGenderChart(genderResult.data);
    } else {
      ElMessage.error("性别统计数据加载失败");
    }
  } catch (error) {
    ElMessage.error("图表数据加载异常");
  }
};

const initJobChart = (jobList, dataList) => {
  jobChart = echarts.init(jobChartRef.value);
  jobChart.setOption({
    title: {
      text: "员工职位统计",
      left: "center",
      textStyle: { color: "#303133" },
    },
    tooltip: { trigger: "axis" },
    grid: { left: "3%", right: "4%", bottom: "3%", containLabel: true },
    xAxis: {
      type: "category",
      data: jobList,
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
            { offset: 0, color: "#409EFF" },
            { offset: 1, color: "#85C1E9" },
          ]),
        },
      },
    ],
  });
};

const initGenderChart = (genderDataList) => {
  genderChart = echarts.init(genderChartRef.value);
  genderChart.setOption({
    title: {
      text: "员工性别统计",
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
        name: "性别",
        type: "pie",
        radius: "50%",
        data: genderDataList,
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: "rgba(0, 0, 0, 0.5)",
          },
        },
        color: ["#409EFF", "#F56C6C"],
      },
    ],
  });
};

const resizeCharts = () => {
  jobChart?.resize();
  genderChart?.resize();
};

onMounted(() => {
  initCharts();
  window.addEventListener("resize", resizeCharts);
});

onBeforeUnmount(() => {
  window.removeEventListener("resize", resizeCharts);
  jobChart?.dispose();
  genderChart?.dispose();
});
</script>

<template>
  <el-row :gutter="20">
    <el-col :xs="24" :sm="24" :md="12">
      <div class="content-card chart-container">
        <div ref="jobChartRef" class="chart"></div>
      </div>
    </el-col>
    <el-col :xs="24" :sm="24" :md="12">
      <div class="content-card chart-container">
        <div ref="genderChartRef" class="chart"></div>
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
