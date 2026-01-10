<script setup>
import { getDashboardStatsApi } from "@/api/dashboard.js";
import { ElMessage } from "element-plus";
import { onMounted, ref } from "vue";

const userName = ref("Admin");

const stats = ref([
  {
    key: "empCount",
    title: "员工总数",
    value: 0,
    icon: "User",
    color: "#7367f0",
    background: "rgba(115, 103, 240, 0.12)",
  },
  {
    key: "deptCount",
    title: "部门数量",
    value: 0,
    icon: "OfficeBuilding",
    color: "#28c76f",
    background: "rgba(40, 199, 111, 0.12)",
  },
  {
    key: "clazzCount",
    title: "班级数量",
    value: 0,
    icon: "Collection",
    color: "#ff9f43",
    background: "rgba(255, 159, 67, 0.12)",
  },
  {
    key: "stuCount",
    title: "学生总数",
    value: 0,
    icon: "Reading",
    color: "#ea5455",
    background: "rgba(234, 84, 85, 0.12)",
  },
]);

const fetchStats = async () => {
  try {
    const res = await getDashboardStatsApi();
    if (res.code) {
      stats.value.forEach((stat) => {
        if (Object.prototype.hasOwnProperty.call(res.data, stat.key)) {
          stat.value = res.data[stat.key];
        }
      });
    } else {
      ElMessage.error(res.msg || "统计数据加载失败");
    }
  } catch (error) {
    ElMessage.error("统计数据请求异常");
  }
};

onMounted(() => {
  const loginUser = JSON.parse(localStorage.getItem("loginUser"));
  if (loginUser && loginUser.name) {
    userName.value = loginUser.name;
  }
  fetchStats();
});

onMounted(() => {
  const loginUser = JSON.parse(localStorage.getItem("loginUser"));
  if (loginUser && loginUser.name) {
    userName.value = loginUser.name;
  }
  fetchStats();
});

const quickLinks = ref([
  { title: "员工管理", icon: "User", path: "/emp" },
  { title: "部门管理", icon: "OfficeBuilding", path: "/dept" },
  { title: "班级管理", icon: "Collection", path: "/clazz" },
  { title: "学生管理", icon: "Reading", path: "/stu" },
]);

const announcements = ref([
  { type: "新功能", content: "系统已升级为现代化界面" },
  { type: "通知", content: "欢迎使用智能学习辅助系统" },
]);

const systemStatus = ref([
  { status: "正常", text: "服务运行正常", color: "#28c76f" },
  { status: "正常", text: "数据库连接正常", color: "#28c76f" },
  { status: "正常", text: "API 服务正常", color: "#28c76f" },
]);
</script>

<template>
  <div>
    <!-- Welcome Banner -->
    <el-card class="box-card welcome-banner" shadow="never">
      <div class="banner-content">
        <div>
          <h3>欢迎回来, {{ userName }}!</h3>
          <p>高效管理，智能学习，助力成长</p>
        </div>
      </div>
    </el-card>

    <!-- Stats Cards -->
    <el-row :gutter="20">
      <el-col v-for="stat in stats" :key="stat.title" :xs="12" :sm="12" :md="6">
        <el-card class="box-card stat-card" shadow="hover">
          <div class="stat-content">
            <div
              class="stat-icon"
              :style="{ backgroundColor: stat.background, color: stat.color }"
            >
              <el-icon :size="28"><component :is="stat.icon" /></el-icon>
            </div>
            <div class="stat-text">
              <span class="stat-title">{{ stat.title }}</span>
              <span class="stat-value">{{ stat.value }}</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Quick Actions -->
    <el-card class="box-card" shadow="hover">
      <template #header>
        <div class="card-header">
          <span>快捷操作</span>
        </div>
      </template>
      <el-row :gutter="20">
        <el-col
          v-for="link in quickLinks"
          :key="link.title"
          :xs="12"
          :sm="12"
          :md="6"
        >
          <router-link :to="link.path">
            <div class="quick-link">
              <el-icon :size="22"><component :is="link.icon" /></el-icon>
              <span>{{ link.title }}</span>
            </div>
          </router-link>
        </el-col>
      </el-row>
    </el-card>

    <!-- System Info -->
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12">
        <el-card class="box-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统公告</span>
            </div>
          </template>
          <div
            v-for="(item, index) in announcements"
            :key="index"
            class="announcement-item"
          >
            <el-tag
              :type="item.type === '新功能' ? 'success' : 'info'"
              size="small"
              >{{ item.type }}</el-tag
            >
            <span class="announcement-content">{{ item.content }}</span>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12">
        <el-card class="box-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统状态</span>
            </div>
          </template>
          <div
            v-for="(item, index) in systemStatus"
            :key="index"
            class="status-item"
          >
            <span
              class="status-dot"
              :style="{ backgroundColor: item.color }"
            ></span>
            <span>{{ item.text }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.box-card {
  margin-bottom: 20px;
}
.card-header {
  font-weight: bold;
}
.welcome-banner {
  background: linear-gradient(
    135deg,
    var(--color-primary),
    var(--color-primary-light-2)
  );
  color: white;
  border: none;
}
.banner-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.banner-content h3 {
  font-size: 24px;
  margin: 0;
}
.banner-content p {
  margin: 5px 0 0;
  opacity: 0.8;
}
.rocket-img {
  width: 120px;
  height: 120px;
}

.stat-card .stat-content {
  display: flex;
  align-items: center;
}
.stat-icon {
  width: 54px;
  height: 54px;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 16px;
}
.stat-text {
  display: flex;
  flex-direction: column;
}
.stat-title {
  color: var(--text-color-secondary);
  font-size: 14px;
}
.stat-value {
  font-size: 24px;
  font-weight: 600;
  color: var(--text-color-primary);
}

a {
  text-decoration: none;
  color: inherit;
}

.quick-link {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 16px;
  border-radius: 8px;
  transition: all 0.2s ease-in-out;
}
.quick-link:hover {
  background-color: #f5f5f5;
}
.quick-link span {
  margin-top: 8px;
  font-size: 14px;
}

.announcement-item,
.status-item {
  display: flex;
  align-items: center;
  padding: 8px 0;
}
.announcement-content {
  margin-left: 10px;
}
.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  margin-right: 10px;
}
</style>
