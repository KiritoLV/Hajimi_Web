<script setup>
import { ArrowDown } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { computed, onMounted, ref } from "vue";
import { useRoute, useRouter } from "vue-router";
import ChangePasswordDialog from "./components/ChangePasswordDialog.vue";

const router = useRouter();
const route = useRoute();

const loginName = ref("");
const changePasswordDialogVisible = ref(false);

// 计算面包屑导航
const breadcrumbs = computed(() => {
  return route.meta.breadcrumb || [];
});

// 计算当前页面标题
const pageTitle = computed(() => {
  return route.meta.title || "仪表盘";
});

onMounted(() => {
  let loginUser = JSON.parse(localStorage.getItem("loginUser"));
  if (loginUser) {
    loginName.value = loginUser.name;
  }
});

const handleCommand = (command) => {
  if (command === "logout") {
    logout();
  } else if (command === "changePassword") {
    changePasswordDialogVisible.value = true;
  }
};

const logout = () => {
  ElMessageBox.confirm("确认退出登录吗?", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(() => {
      ElMessage.success("退出登录成功");
      localStorage.removeItem("loginUser");
      router.push("/login");
    })
    .catch(() => {
      // catch cancel action
    });
};
</script>

<template>
  <div class="common-layout">
    <el-container>
      <!-- 左侧菜单 -->
      <el-aside width="220px" class="aside">
        <div class="logo">
          <span>哈基米得管理系统</span>
        </div>
        <el-menu router :default-active="route.path" class="el-menu-vertical">
          <el-menu-item index="/index">
            <el-icon><Promotion /></el-icon>
            <span>首页</span>
          </el-menu-item>

          <el-sub-menu index="/manage">
            <template #title>
              <el-icon><Menu /></el-icon>
              <span>班级学员管理</span>
            </template>
            <el-menu-item index="/clazz">
              <el-icon><HomeFilled /></el-icon>
              <span>班级管理</span>
            </el-menu-item>
            <el-menu-item index="/stu">
              <el-icon><UserFilled /></el-icon>
              <span>学员管理</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu index="/system">
            <template #title>
              <el-icon><Tools /></el-icon>
              <span>系统信息管理</span>
            </template>
            <el-menu-item index="/dept">
              <el-icon><HelpFilled /></el-icon>
              <span>部门管理</span>
            </el-menu-item>
            <el-menu-item index="/emp">
              <el-icon><Avatar /></el-icon>
              <span>员工管理</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu index="/report">
            <template #title>
              <el-icon><Histogram /></el-icon>
              <span>数据统计管理</span>
            </template>
            <el-menu-item index="/report/emp">
              <el-icon><InfoFilled /></el-icon>
              <span>员工信息统计</span>
            </el-menu-item>
            <el-menu-item index="/report/stu">
              <el-icon><Share /></el-icon>
              <span>学员信息统计</span>
            </el-menu-item>
            <el-menu-item index="/log">
              <el-icon><Document /></el-icon>
              <span>日志信息统计</span>
            </el-menu-item>
          </el-sub-menu>
        </el-menu>
      </el-aside>

      <el-container>
        <!-- Header 区域 -->
        <el-header class="header">
          <div class="header-left"></div>
          <div class="header-right">
            <el-dropdown @command="handleCommand">
              <span class="el-dropdown-link">
                {{ loginName }}
                <el-icon class="el-icon--right"><arrow-down /></el-icon>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="changePassword"
                    >修改密码</el-dropdown-item
                  >
                  <el-dropdown-item command="logout" divided
                    >退出登录</el-dropdown-item
                  >
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </el-header>

        <!-- 主展示区域 -->
        <el-main>
          <div class="page-container">
            <div class="page-header">
              <h2 class="page-title">{{ pageTitle }}</h2>
              <el-breadcrumb separator="/">
                <el-breadcrumb-item
                  v-for="(item, index) in breadcrumbs"
                  :key="index"
                  >{{ item }}</el-breadcrumb-item
                >
              </el-breadcrumb>
            </div>
            <router-view></router-view>
            <el-backtop :right="100" :bottom="100" />
          </div>
        </el-main>
      </el-container>
    </el-container>
    <!-- 修改密码弹窗 -->
    <ChangePasswordDialog v-model="changePasswordDialogVisible" />
  </div>
</template>

<style scoped>
.common-layout,
.el-container {
  height: 100vh;
}

.aside {
  background-color: #fff;
  border-right: 1px solid var(--border-color-light);
  display: flex;
  flex-direction: column;
}

.logo {
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: bold;
  color: var(--color-primary);
  background-color: #fff;
}

.el-menu {
  border-right: none;
}

.el-menu-item.is-active {
  background-color: var(--color-primary) !important;
  color: #fff !important;
}

.el-menu-item.is-active .el-icon {
  color: #fff !important;
}

.el-menu-vertical:not(.el-menu--collapse) {
  width: 220px;
}

.header {
  background: linear-gradient(
    135deg,
    var(--color-primary),
    var(--color-primary-light-2)
  );
  color: #fff;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
}

.header-right {
  display: flex;
  align-items: center;
}

.el-dropdown-link {
  cursor: pointer;
  color: #fff;
  display: flex;
  align-items: center;
}

.el-main {
  background-color: transparent; /* Let the body background show through */
  padding: 0;
}
</style>
