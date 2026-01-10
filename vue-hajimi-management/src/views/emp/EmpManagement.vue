<script setup>
import { queryAllApi as queryAllDeptApi } from "@/api/dept";
import {
  addEmpApi,
  deleteEmpApi,
  queryInfoApi,
  queryPageApi,
  updateEmpApi,
} from "@/api/emp";
import { Delete, Plus } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { onMounted, ref } from "vue";

// --- 响应式状态 ---
const searchParams = ref({
  name: "",
  gender: "",
  begin: "",
  end: "",
});
const dateRange = ref([]);
const empList = ref([]);
const deptList = ref([]);
const loading = ref(false);
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(0);
const dialogVisible = ref(false);
const dialogTitle = ref("新增员工");
const employeeFormRef = ref(null);
const employee = ref({});
const selectedIds = ref([]);
const token = ref("");

const jobs = ref([
  { name: "班主任", value: 1 },
  { name: "讲师", value: 2 },
  { name: "学工主管", value: 3 },
  { name: "教研主管", value: 4 },
  { name: "咨询师", value: 5 },
  { name: "其他", value: 6 },
]);
const genders = ref([
  { name: "男", value: 1 },
  { name: "女", value: 2 },
]);

const rules = {
  username: [{ required: true, message: "请输入用户名", trigger: "blur" }],
  name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
  gender: [{ required: true, message: "请选择性别", trigger: "change" }],
  phone: [
    { required: true, message: "请输入手机号", trigger: "blur" },
    { pattern: /^1\d{10}$/, message: "手机号格式不正确", trigger: "blur" },
  ],
};

// --- 函数 ---
const fetchData = async () => {
  loading.value = true;
  if (dateRange.value && dateRange.value.length === 2) {
    searchParams.value.begin = dateRange.value[0];
    searchParams.value.end = dateRange.value[1];
  } else {
    searchParams.value.begin = "";
    searchParams.value.end = "";
  }
  try {
    const result = await queryPageApi(
      searchParams.value.name,
      searchParams.value.gender,
      searchParams.value.begin,
      searchParams.value.end,
      currentPage.value,
      pageSize.value
    );
    if (result.code) {
      empList.value = result.data.rows;
      total.value = result.data.total;
    }
  } catch (error) {
    ElMessage.error("数据加载失败");
  } finally {
    loading.value = false;
  }
};

const handleSearch = () => {
  currentPage.value = 1;
  fetchData();
};

const handleReset = () => {
  searchParams.value = { name: "", gender: "", begin: "", end: "" };
  dateRange.value = [];
  handleSearch();
};

const getJobTitle = (job) =>
  jobs.value.find((j) => j.value === job)?.name || "其他";

const handleSizeChange = (val) => {
  pageSize.value = val;
  fetchData();
};

const handleCurrentChange = (val) => {
  currentPage.value = val;
  fetchData();
};

const handleAdd = () => {
  dialogTitle.value = "新增员工";
  employee.value = {
    gender: "",
    job: "",
    deptId: "",
    image: "",
    exprList: [],
  };
  dialogVisible.value = true;
  employeeFormRef.value?.resetFields();
};

const handleEdit = async (id) => {
  dialogTitle.value = "修改员工";
  const result = await queryInfoApi(id);
  if (result.code) {
    employee.value = result.data;
    if (employee.value.exprList && employee.value.exprList.length > 0) {
      employee.value.exprList.forEach((expr) => {
        expr.exprDate = [expr.begin, expr.end];
      });
    }
    dialogVisible.value = true;
  }
};

const handleDelete = (id) => {
  ElMessageBox.confirm("确定删除该员工吗?", "提示", { type: "warning" })
    .then(async () => {
      const result = await deleteEmpApi([id]);
      if (result.code) {
        ElMessage.success("删除成功");
        await fetchData();
      } else {
        ElMessage.error(result.msg || "删除失败");
      }
    })
    .catch(() => {});
};

const handleBatchDelete = () => {
  if (selectedIds.value.length === 0) {
    ElMessage.warning("请选择要删除的员工");
    return;
  }
  ElMessageBox.confirm(
    `确定删除选中的 ${selectedIds.value.length} 名员工吗?`,
    "提示",
    { type: "warning" }
  )
    .then(async () => {
      const result = await deleteEmpApi(selectedIds.value);
      if (result.code) {
        ElMessage.success("批量删除成功");
        await fetchData();
      } else {
        ElMessage.error(result.msg || "删除失败");
      }
    })
    .catch(() => {});
};

const handleSelectionChange = (selection) => {
  selectedIds.value = selection.map((item) => item.id);
};

const save = async () => {
  if (!employeeFormRef.value) return;
  await employeeFormRef.value.validate(async (valid) => {
    if (!valid) return;

    // Process exprList before submitting
    if (employee.value.exprList && employee.value.exprList.length > 0) {
      employee.value.exprList.forEach((expr) => {
        if (expr.exprDate && expr.exprDate.length === 2) {
          expr.begin = expr.exprDate[0];
          expr.end = expr.exprDate[1];
        }
      });
    }

    try {
      const result = employee.value.id
        ? await updateEmpApi(employee.value)
        : await addEmpApi(employee.value);
      if (result.code) {
        ElMessage.success("操作成功");
        dialogVisible.value = false;
        await fetchData();
      } else {
        ElMessage.error(result.msg || "操作失败");
      }
    } catch (error) {
      ElMessage.error("请求失败");
    }
  });
};

const handleAvatarSuccess = (response) => {
  employee.value.image = response.data;
};

const beforeAvatarUpload = (rawFile) => {
  const isJpgOrPng =
    rawFile.type === "image/jpeg" || rawFile.type === "image/png";
  if (!isJpgOrPng) {
    ElMessage.error("头像图片只能是 JPG/PNG 格式!");
    return false;
  }
  const isLt10M = rawFile.size / 1024 / 1024 < 10;
  if (!isLt10M) {
    ElMessage.error("头像图片大小不能超过 10MB!");
    return false;
  }
  return true;
};

const addExprItem = () => {
  employee.value.exprList.push({ exprDate: [], company: "", job: "" });
};

const delExprItem = (index) => {
  employee.value.exprList.splice(index, 1);
};

// --- 生命周期 ---
onMounted(async () => {
  fetchData();
  const deptResult = await queryAllDeptApi();
  if (deptResult.code) {
    deptList.value = deptResult.data;
  }
  const loginUser = localStorage.getItem("loginUser");
  if (loginUser) {
    token.value = JSON.parse(loginUser).token;
  }
});
</script>

<template>
  <div>
    <!-- 搜索区域 -->
    <div class="content-card filter-container">
      <el-form :inline="true" :model="searchParams">
        <el-form-item label="姓名">
          <el-input
            v-model="searchParams.name"
            placeholder="请输入员工姓名"
            clearable
          ></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-select
            v-model="searchParams.gender"
            placeholder="请选择"
            clearable
          >
            <el-option label="男" value="1"></el-option>
            <el-option label="女" value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="入职日期">
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            value-format="YYYY-MM-DD"
          ></el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleReset">清空</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 内容区域 -->
    <div class="content-card">
      <div class="action-container">
        <el-button type="primary" :icon="Plus" @click="handleAdd"
          >新增员工</el-button
        >
        <el-button type="danger" :icon="Delete" @click="handleBatchDelete"
          >批量删除</el-button
        >
      </div>

      <!-- 表格 -->
      <el-table
        v-loading="loading"
        :data="empList"
        border
        stripe
        @selection-change="handleSelectionChange"
      >
        <el-table-column
          type="selection"
          width="55"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="name"
          label="姓名"
          width="120"
          align="center"
        ></el-table-column>
        <el-table-column label="头像" width="100" align="center">
          <template #default="{ row }">
            <el-avatar shape="square" :size="50" :src="row.image"></el-avatar>
          </template>
        </el-table-column>
        <el-table-column label="性别" width="80" align="center">
          <template #default="{ row }">{{
            row.gender == 1 ? "男" : "女"
          }}</template>
        </el-table-column>
        <el-table-column
          prop="deptName"
          label="部门"
          width="150"
          align="center"
        ></el-table-column>
        <el-table-column label="职位" width="120" align="center">
          <template #default="{ row }">{{ getJobTitle(row.job) }}</template>
        </el-table-column>
        <el-table-column
          prop="entryDate"
          label="入职日期"
          width="180"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="updateTime"
          label="最后操作时间"
          min-width="210"
          align="center"
        ></el-table-column>
        <el-table-column label="操作" width="150" fixed="right" align="center">
          <template #default="{ row }">
            <el-button size="small" type="primary" @click="handleEdit(row.id)"
              >编辑</el-button
            >
            <el-button size="small" type="danger" @click="handleDelete(row.id)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
        ></el-pagination>
      </div>
    </div>

    <!-- 新增/修改员工的对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="70%">
      <el-form
        ref="employeeFormRef"
        :model="employee"
        :rules="rules"
        label-width="80px"
      >
        <el-divider content-position="left">基本信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="用户名" prop="username">
              <el-input v-model="employee.username"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="姓名" prop="name">
              <el-input v-model="employee.name"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-select
                v-model="employee.gender"
                placeholder="请选择性别"
                style="width: 100%"
              >
                <el-option
                  v-for="g in genders"
                  :key="g.value"
                  :label="g.name"
                  :value="g.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="employee.phone"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="职位" prop="job">
              <el-select
                v-model="employee.job"
                placeholder="请选择职位"
                style="width: 100%"
              >
                <el-option
                  v-for="j in jobs"
                  :key="j.value"
                  :label="j.name"
                  :value="j.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="薪资" prop="salary">
              <el-input v-model="employee.salary"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="所属部门" prop="deptId">
              <el-select
                v-model="employee.deptId"
                placeholder="请选择部门"
                style="width: 100%"
              >
                <el-option
                  v-for="d in deptList"
                  :key="d.id"
                  :label="d.name"
                  :value="d.id"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="入职日期" prop="entryDate">
              <el-date-picker
                v-model="employee.entryDate"
                type="date"
                style="width: 100%"
                placeholder="选择日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
              ></el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="头像">
              <el-upload
                class="avatar-uploader"
                action="/api/upload"
                :headers="{ token: token }"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload"
              >
                <img
                  v-if="employee.image"
                  :src="employee.image"
                  class="avatar"
                />
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              </el-upload>
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">工作经历</el-divider>
        <el-row>
          <el-col :span="24" style="text-align: right; margin-bottom: 10px">
            <el-button type="success" size="small" @click="addExprItem"
              >+ 添加经历</el-button
            >
          </el-col>
        </el-row>
        <div
          v-for="(expr, index) in employee.exprList"
          :key="index"
          class="expr-item"
        >
          <el-row :gutter="10">
            <el-col :span="10">
              <el-form-item label="时间" label-width="80px">
                <el-date-picker
                  type="daterange"
                  v-model="expr.exprDate"
                  range-separator="-"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期"
                  format="YYYY-MM-DD"
                  value-format="YYYY-MM-DD"
                  style="width: 100%"
                ></el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="公司" label-width="50px">
                <el-input
                  v-model="expr.company"
                  placeholder="公司名称"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="职位" label-width="50px">
                <el-input v-model="expr.job" placeholder="职位"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="2">
              <el-button type="danger" size="small" @click="delExprItem(index)"
                >删除</el-button
              >
            </el-col>
          </el-row>
        </div>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">保存</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.action-container {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 20px;
}

.avatar-uploader .avatar {
  width: 100px;
  height: 100px;
  display: block;
}

.avatar-uploader .el-upload {
  border: 1px dashed var(--border-color-light);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
}

.expr-item {
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid var(--border-color-lighter);
  border-radius: 4px;
}
</style>
