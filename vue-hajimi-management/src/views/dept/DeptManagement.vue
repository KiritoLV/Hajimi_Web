<script setup>
import {
  addDeptApi,
  deleteDeptApi,
  queryAllApi,
  queryInfoApi,
  updateDeptApi,
} from "@/api/dept";
import { Plus } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { onMounted, ref } from "vue";

// 响应式状态
const tableData = ref([]);
const loading = ref(false);
const showDialog = ref(false);
const formTitle = ref("");
const deptForm = ref({ name: "" });
const deptFormRef = ref(null);

// 表单验证规则
const formRules = {
  name: [
    { required: true, message: "请输入部门名称", trigger: "blur" },
    { min: 2, max: 10, message: "长度在 2 到 10 个字符", trigger: "blur" },
  ],
};

// 函数
const queryAll = async () => {
  loading.value = true;
  try {
    const result = await queryAllApi();
    tableData.value = result.data;
  } catch (error) {
    ElMessage.error("数据加载失败");
  } finally {
    loading.value = false;
  }
};

const add = () => {
  formTitle.value = "新增部门";
  deptForm.value = { name: "" };
  showDialog.value = true;
};

const handleEdit = async (row) => {
  formTitle.value = "修改部门";
  showDialog.value = true;
  const result = await queryInfoApi(row.id);
  if (result.code) {
    deptForm.value = result.data;
  }
};

const handleDelete = (row) => {
  ElMessageBox.confirm("此操作将永久删除该部门, 是否继续?", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      const result = await deleteDeptApi(row.id);
      if (result.code) {
        ElMessage.success("删除成功");
        await queryAll();
      } else {
        ElMessage.error(result.msg || "删除失败");
      }
    })
    .catch(() => {
      // 取消操作
    });
};

const resetForm = () => {
  if (deptFormRef.value) {
    deptFormRef.value.resetFields();
  }
};

const save = async () => {
  if (!deptFormRef.value) return;
  await deptFormRef.value.validate(async (valid) => {
    if (!valid) return;

    try {
      let result;
      if (deptForm.value.id) {
        result = await updateDeptApi(deptForm.value);
      } else {
        result = await addDeptApi(deptForm.value);
      }

      if (result.code) {
        ElMessage.success("操作成功");
        showDialog.value = false;
        await queryAll();
      } else {
        ElMessage.error(result.msg || "操作失败");
      }
    } catch (error) {
      ElMessage.error("请求失败");
    }
  });
};

// 生命周期钩子
onMounted(() => {
  queryAll();
});
</script>

<template>
  <div class="content-card">
    <!-- 操作区域 -->
    <div class="action-container">
      <el-button type="primary" :icon="Plus" @click="add">新增部门</el-button>
    </div>

    <!-- 数据展示表格 -->
    <el-table
      v-loading="loading"
      :data="tableData"
      border
      stripe
      style="width: 100%"
    >
      <el-table-column type="index" label="序号" width="100" align="center" />
      <el-table-column
        prop="name"
        label="部门名称"
        width="300"
        align="center"
      />
      <el-table-column prop="updateTime" label="最后修改时间" align="center" />
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template #default="{ row }">
          <el-button size="small" @click="handleEdit(row)">修改</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/修改部门的对话框 -->
    <el-dialog
      v-model="showDialog"
      :title="formTitle"
      width="400px"
      @close="resetForm"
    >
      <el-form
        :model="deptForm"
        :rules="formRules"
        ref="deptFormRef"
        label-width="80px"
      >
        <el-form-item label="部门名称" prop="name">
          <el-input v-model="deptForm.name" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showDialog = false">取消</el-button>
          <el-button type="primary" @click="save">确定</el-button>
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
</style>
