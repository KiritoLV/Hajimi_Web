<script setup>
import { queryAllApi as queryAllClazzApi } from "@/api/clazz";
import {
  addApi,
  deleteApi,
  handleViolationApi,
  queryInfoApi,
  queryPageApi,
  updateApi,
} from "@/api/stu";
import { Delete, Plus } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { onMounted, ref } from "vue";

// --- 静态数据 ---
const degrees = ref([
  { name: "初中", value: 1 },
  { name: "高中", value: 2 },
  { name: "大专", value: 3 },
  { name: "本科", value: 4 },
  { name: "硕士", value: 5 },
  { name: "博士", value: 6 },
]);
const genders = ref([
  { name: "男", value: 1 },
  { name: "女", value: 2 },
]);
const whethers = ref([
  { name: "是", value: 1 },
  { name: "否", value: 0 },
]);

// --- 响应式状态 ---
const searchParams = ref({ clazzId: "", degree: "", name: "" });
const tableData = ref([]);
const clazzs = ref([]);
const loading = ref(false);
const pagination = ref({ currentPage: 1, pageSize: 10, total: 0 });
const selectedIds = ref([]);
const dialogVisible = ref(false);
const formTitle = ref("新增学员");
const stuFormRef = ref(null);
const stu = ref({});

const rules = {
  name: [{ required: true, message: "姓名为必填项", trigger: "blur" }],
  no: [
    { required: true, message: "学号为必填项", trigger: "blur" },
    { min: 10, max: 10, message: "学号长度为10个字符", trigger: "blur" },
  ],
  gender: [{ required: true, message: "性别为必填项", trigger: "change" }],
  phone: [
    { required: true, message: "手机号为必填项", trigger: "blur" },
    {
      pattern: /^1[3-9]\d{9}$/,
      message: "请输入合法的手机号",
      trigger: "blur",
    },
  ],
  idCard: [
    { required: true, message: "身份证号为必填项", trigger: "blur" },
    {
      pattern: /^\d{17}(\d|X)$/i,
      message: "请输入合法的身份证号",
      trigger: "blur",
    },
  ],
  isCollege: [
    { required: true, message: "是否院校学员为必填项", trigger: "change" },
  ],
  clazzId: [{ required: true, message: "所属班级为必填项", trigger: "change" }],
};

// --- 函数 ---
const fetchData = async () => {
  loading.value = true;
  try {
    const result = await queryPageApi(
      searchParams.value.clazzId,
      searchParams.value.degree,
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
  searchParams.value = { clazzId: "", degree: "", name: "" };
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

const handleSelectionChange = (selection) => {
  selectedIds.value = selection.map((item) => item.id);
};

const handleAdd = () => {
  formTitle.value = "新增学员";
  stu.value = { gender: "", degree: "", isCollege: "", clazzId: "" };
  dialogVisible.value = true;
  stuFormRef.value?.resetFields();
};

const handleEdit = async (id) => {
  formTitle.value = "修改学员";
  const result = await queryInfoApi(id);
  if (result.code) {
    stu.value = result.data;
    dialogVisible.value = true;
  }
};

const handleDelete = (ids) => {
  const isBatch = Array.isArray(ids);
  if (isBatch && ids.length === 0) {
    ElMessage.warning("请选择要删除的学员");
    return;
  }
  ElMessageBox.confirm(`您确认删除选中的数据吗?`, "提示", { type: "warning" })
    .then(async () => {
      const result = await deleteApi(isBatch ? ids.join(",") : ids);
      if (result.code) {
        ElMessage.success("删除成功");
        await fetchData();
      } else {
        ElMessage.error(result.msg || "删除失败");
      }
    })
    .catch(() => {});
};

const save = async () => {
  if (!stuFormRef.value) return;
  await stuFormRef.value.validate(async (valid) => {
    if (!valid) return;
    try {
      const api = stu.value.id ? updateApi(stu.value) : addApi(stu.value);
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

const openViolation = (id) => {
  ElMessageBox.prompt("请输入违纪扣分", "违纪处理", {
    confirmButtonText: "确认",
    cancelButtonText: "取消",
    inputPattern: /^\d+$/,
    inputErrorMessage: "请输入有效的数字",
  })
    .then(async ({ value }) => {
      const result = await handleViolationApi(id, value);
      if (result.code) {
        ElMessage.success("处理成功");
        await fetchData();
      } else {
        ElMessage.error(result.msg || "处理失败");
      }
    })
    .catch(() => {});
};

const getDegreeName = (degree) =>
  degrees.value.find((d) => d.value === degree)?.name || "其他";

// --- 生命周期 ---
onMounted(async () => {
  fetchData();
  const clazzResult = await queryAllClazzApi();
  if (clazzResult.code) {
    clazzs.value = clazzResult.data;
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
            placeholder="请输入学生姓名"
            clearable
          />
        </el-form-item>
        <el-form-item label="最高学历">
          <el-select
            v-model="searchParams.degree"
            placeholder="请选择"
            clearable
          >
            <el-option
              v-for="d in degrees"
              :key="d.value"
              :label="d.name"
              :value="d.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="所属班级">
          <el-select
            v-model="searchParams.clazzId"
            placeholder="请选择"
            clearable
          >
            <el-option
              v-for="c in clazzs"
              :key="c.id"
              :label="c.name"
              :value="c.id"
            />
          </el-select>
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
          >新增学员</el-button
        >
        <el-button
          type="danger"
          :icon="Delete"
          @click="handleDelete(selectedIds)"
          >批量删除</el-button
        >
      </div>

      <!-- 列表展示 -->
      <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" align="center" width="55" />
        <el-table-column prop="name" label="姓名" align="center" width="100" />
        <el-table-column prop="no" label="学号" align="center" width="130" />
        <el-table-column
          prop="clazzName"
          label="班级"
          align="center"
          width="160"
        />
        <el-table-column label="性别" align="center" width="70">
          <template #default="{ row }">{{
            row.gender == 1 ? "男" : "女"
          }}</template>
        </el-table-column>
        <el-table-column
          prop="phone"
          label="手机号"
          align="center"
          width="130"
        />
        <el-table-column label="最高学历" align="center" width="90">
          <template #default="{ row }">{{
            getDegreeName(row.degree)
          }}</template>
        </el-table-column>
        <el-table-column
          prop="violationCount"
          label="违纪次数"
          align="center"
          width="85"
        />
        <el-table-column
          prop="violationScore"
          label="违纪扣分"
          align="center"
          width="85"
        />
        <el-table-column
          prop="updateTime"
          label="最后修改时间"
          align="center"
          min-width="170"
        />
        <el-table-column label="操作" align="center" width="220" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleEdit(row.id)"
              >编辑</el-button
            >
            <el-button
              type="warning"
              size="small"
              @click="openViolation(row.id)"
              >违纪</el-button
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

    <!-- 新增/修改学员对话框 -->
    <el-dialog v-model="dialogVisible" :title="formTitle" width="60%">
      <el-form :model="stu" ref="stuFormRef" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="姓名" prop="name">
              <el-input v-model="stu.name" placeholder="请输入学员姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="学号" prop="no">
              <el-input v-model="stu.no" placeholder="请输入学员学号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-select
                v-model="stu.gender"
                placeholder="请选择"
                style="width: 100%"
              >
                <el-option
                  v-for="g in genders"
                  :key="g.value"
                  :label="g.name"
                  :value="g.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="stu.phone" placeholder="请输入手机号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="身份证号" prop="idCard">
              <el-input v-model="stu.idCard" placeholder="请输入身份证号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="是否院校" prop="isCollege">
              <el-select
                v-model="stu.isCollege"
                placeholder="请选择"
                style="width: 100%"
              >
                <el-option
                  v-for="w in whethers"
                  :key="w.value"
                  :label="w.name"
                  :value="w.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="最高学历" prop="degree">
              <el-select
                v-model="stu.degree"
                placeholder="请选择"
                style="width: 100%"
              >
                <el-option
                  v-for="d in degrees"
                  :key="d.value"
                  :label="d.name"
                  :value="d.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="所属班级" prop="clazzId">
              <el-select
                v-model="stu.clazzId"
                placeholder="请选择"
                style="width: 100%"
              >
                <el-option
                  v-for="c in clazzs"
                  :key="c.id"
                  :label="c.name"
                  :value="c.id"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="毕业时间" prop="graduationDate">
              <el-date-picker
                v-model="stu.graduationDate"
                type="date"
                placeholder="请选择毕业时间"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系地址" prop="address">
              <el-input v-model="stu.address" placeholder="请输入联系地址" />
            </el-form-item>
          </el-col>
        </el-row>
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
