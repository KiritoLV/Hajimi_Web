import Clazz from "@/views/clazz/ClazzManagement.vue";
import Dept from "@/views/dept/DeptManagement.vue";
import Emp from "@/views/emp/EmpManagement.vue";
import Index from "@/views/index/IndexPage.vue";
import Layout from "@/views/layout/MainLayout.vue";
import Log from "@/views/log/LogManagement.vue";
import Login from "@/views/login/LoginPage.vue";
import EmpReport from "@/views/report/emp/EmpReport.vue";
import StuReport from "@/views/report/stu/StuReport.vue";
import Stu from "@/views/stu/StuManagement.vue";
import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/",
    component: Layout,
    redirect: "/index",
    children: [
      {
        path: "/index",
        component: Index,
        meta: { title: "首页", breadcrumb: ["控制台"] },
      },
      {
        path: "/clazz",
        component: Clazz,
        meta: { title: "班级管理", breadcrumb: ["班级学员管理", "班级管理"] },
      },
      {
        path: "/stu",
        component: Stu,
        meta: { title: "学员管理", breadcrumb: ["班级学员管理", "学员管理"] },
      },
      {
        path: "/dept",
        component: Dept,
        meta: { title: "部门管理", breadcrumb: ["系统信息管理", "部门管理"] },
      },
      {
        path: "/emp",
        component: Emp,
        meta: { title: "员工管理", breadcrumb: ["系统信息管理", "员工管理"] },
      },
      {
        path: "/report/emp",
        component: EmpReport,
        meta: {
          title: "员工信息统计",
          breadcrumb: ["数据统计管理", "员工信息统计"],
        },
      },
      {
        path: "/report/stu",
        component: StuReport,
        meta: {
          title: "学员信息统计",
          breadcrumb: ["数据统计管理", "学员信息统计"],
        },
      },
      {
        path: "/log",
        component: Log,
        meta: { title: "日志管理", breadcrumb: ["数据统计管理", "日志管理"] },
      },
    ],
  },
  { path: "/login", component: Login, meta: { title: "登录" } },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
