<script setup>
import {
  addApi,
  deleteApi,
  queryInfoApi,
  queryPageApi,
  updateApi,
} from "@/api/clazz";
import { queryAllApi as queryAllEmpApi } from "@/api/emp";
import { Plus } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { onMounted, ref } from "vue";

// --- 响应式状态 ---
const searchParams = ref({ name: "", begin: "", end: "" });
const dateRange = ref([]);
const tableData = ref([]);
const emps = ref([]);
const loading = ref(false);
const pagination = ref({ currentPage: 1, pageSize: 10, total: 0 });
const dialogVisible = ref(false);
const formTitle = ref("新增班级");
const clazzFormRef = ref(null);
const clazz = ref({});

const subjects = ref([
  { name: "Java", value: 1 },
  { name: "前端", value: 2 },
  { name: "大数据", value: 3 },
  { name: "Python", value: 4 },
  { name: "Go", value: 5 },
  { name: "嵌入式", value: 6 },
]);

const rules = {
  name: [{ required: true, message: "班级名称为必填项", trigger: "blur" }],
  beginDate: [
    { required: true, message: "开课时间为必填项", trigger: "change" },
  ],
  endDate: [{ required: true, message: "结课时间为必填项", trigger: "change" }],
  subject: [{ required: true, message: "学科为必填项", trigger: "change" }],
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
      searchParams.value.begin,
      searchParams.value.end,
      searchParams.value.name,
      pagination.value.currentPage,
      pagination.value.pageSize
    );
    if (result.code) {
      tableData.value = result.data.rows;
      pagination.value.total = result.data.total;
    }
  } catch (error) {
    ElMessage.error("数据加载失败");
  } finally {
    loading.value = false;
  }
};

const handleSearch = () => {
  pagination.value.currentPage = 1;
  fetchData();
};

const handleReset = () => {
  searchParams.value = { name: "", begin: "", end: "" };
  dateRange.value = [];
  handleSearch();
};

const handleSizeChange = (pageSize) => {
  pagination.value.pageSize = pageSize;
  fetchData();
};

const handleCurrentChange = (page) => {
  pagination.value.currentPage = page;
  fetchData();
};

const handleAdd = () => {
  formTitle.value = "新增班级";
  clazz.value = { subject: "", masterId: "" };
  dialogVisible.value = true;
  clazzFormRef.value?.resetFields();
};

const handleEdit = async (id) => {
  formTitle.value = "修改班级";
  const result = await queryInfoApi(id);
  if (result.code) {
    clazz.value = result.data;
    dialogVisible.value = true;
  }
};

const handleDelete = (id) => {
  ElMessageBox.confirm("您确认删除此数据吗?", "删除班级", { type: "warning" })
    .then(async () => {
      const result = await deleteApi([id]);
      if (result.code) {
        ElMessage.success("删除成功");
        await fetchData();
      } else {
        ElMessage.error(result.msg || "删除失败");
      }
    })
    .catch(() => {
      ElMessage.info("取消删除");
    });
};

const save = async () => {
  if (!clazzFormRef.value) return;
  await clazzFormRef.value.validate(async (valid) => {
    if (!valid) return;
    try {
      const api = clazz.value.id ? updateApi(clazz.value) : addApi(clazz.value);
      const result = await api;
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

// --- 生命周期 ---
onMounted(async () => {
  fetchData();
  const empResult = await queryAllEmpApi();
  if (empResult.code) {
    emps.value = empResult.data;
  }
});
</script>

<template>
  <div>
    <!-- 搜索区域 -->
    <div class="content-card filter-container">
      <el-form :inline="true" :model="searchParams">
        <el-form-item label="班级名称">
          <el-input
            v-model="searchParams.name"
            placeholder="请输入班级名称"
            clearable
          />
        </el-form-item>
        <el-form-item label="结课时间">
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            value-format="YYYY-MM-DD"
          />
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
          >新增班级</el-button
        >
      </div>

      <!-- 列表展示 -->
      <el-table v-loading="loading" :data="tableData" border stripe fit>
        <el-table-column type="index" label="序号" width="55" align="center" />
        <el-table-column
          prop="name"
          label="班级名称"
          align="center"
          width="200"
        />
        <el-table-column
          prop="room"
          label="班级教室"
          align="center"
          width="120"
        />
        <el-table-column
          prop="masterName"
          label="班主任"
          align="center"
          width="120"
        />
        <el-table-column
          prop="beginDate"
          label="开课时间"
          align="center"
          width="150"
        />
        <el-table-column
          prop="endDate"
          label="结课时间"
          align="center"
          width="150"
        />
        <el-table-column
          prop="status"
          label="状态"
          align="center"
          width="100"
        />
        <el-table-column
          prop="updateTime"
          label="最后修改时间"
          align="center"
          min-width="180"
        />
        <el-table-column label="操作" align="center" width="150" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleEdit(row.id)"
              >编辑</el-button
            >
            <el-button type="danger" size="small" @click="handleDelete(row.id)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页组件 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!-- 新增/修改班级对话框 -->
    <el-dialog v-model="dialogVisible" :title="formTitle" width="600px">
      <el-form
        :model="clazz"
        ref="clazzFormRef"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="班级名称" prop="name">
          <el-input v-model="clazz.name" placeholder="请输入班级名称" />
        </el-form-item>
        <el-form-item label="班级教室" prop="room">
          <el-input v-model="clazz.room" placeholder="请输入班级教室" />
        </el-form-item>
        <el-form-item label="开课时间" prop="beginDate">
          <el-date-picker
            v-model="clazz.beginDate"
            type="date"
            placeholder="请选择开课时间"
            value-format="YYYY-MM-DD"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="结课时间" prop="endDate">
          <el-date-picker
            v-model="clazz.endDate"
            type="date"
            placeholder="请选择结课时间"
            value-format="YYYY-MM-DD"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="班主任" prop="masterId">
          <el-select
            v-model="clazz.masterId"
            placeholder="请选择班主任"
            style="width: 100%"
          >
            <el-option
              v-for="emp in emps"
              :key="emp.id"
              :label="emp.name"
              :value="emp.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="学科" prop="subject">
          <el-select
            v-model="clazz.subject"
            placeholder="请选择学科"
            style="width: 100%"
          >
            <el-option
              v-for="sub in subjects"
              :key="sub.value"
              :label="sub.name"
              :value="sub.value"
            />
          </el-select>
        </el-form-item>
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
</style>
