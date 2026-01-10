<script setup>
import { queryPageApi } from "@/api/log";
import { ElMessage } from "element-plus";
import { onMounted, ref } from "vue";

// --- 响应式状态 ---
const tableData = ref([]);
const loading = ref(false);
const pagination = ref({ currentPage: 1, pageSize: 15, total: 0 });

// --- 函数 ---
const fetchData = async () => {
  loading.value = true;
  try {
    const result = await queryPageApi(
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

const handleSizeChange = (pageSize) => {
  pagination.value.pageSize = pageSize;
  fetchData();
};

const handleCurrentChange = (page) => {
  pagination.value.currentPage = page;
  fetchData();
};

// --- 生命周期 ---
onMounted(() => {
  fetchData();
});
</script>

<template>
  <div class="content-card">
    <!-- 列表展示 -->
    <el-table v-loading="loading" :data="tableData" border stripe fit>
      <el-table-column
        prop="operateEmpName"
        label="操作人"
        align="center"
        width="100"
      />
      <el-table-column
        prop="operateTime"
        label="操作时间"
        align="center"
        width="180"
      />
      <el-table-column
        prop="className"
        label="类名"
        align="center"
        min-width="300"
      />
      <el-table-column
        prop="methodName"
        label="方法名"
        align="center"
        width="150"
      />
      <el-table-column
        prop="costTime"
        label="操作耗时(ms)"
        align="center"
        width="120"
      />
      <el-table-column
        prop="methodParams"
        label="请求参数"
        align="center"
        min-width="250"
      >
        <template #default="{ row }">
          <el-popover
            effect="light"
            trigger="hover"
            placement="top"
            width="400"
          >
            <template #default>
              <div
                style="
                  white-space: pre-wrap;
                  max-height: 300px;
                  overflow-y: auto;
                "
              >
                {{ row.methodParams }}
              </div>
            </template>
            <template #reference>
              <span class="param-cell">{{ row.methodParams }}</span>
            </template>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column
        prop="returnValue"
        label="返回值"
        align="center"
        min-width="250"
      >
        <template #default="{ row }">
          <el-popover
            effect="light"
            trigger="hover"
            placement="top"
            width="400"
          >
            <template #default>
              <div
                style="
                  white-space: pre-wrap;
                  max-height: 300px;
                  overflow-y: auto;
                "
              >
                {{ row.returnValue }}
              </div>
            </template>
            <template #reference>
              <span class="param-cell">{{ row.returnValue }}</span>
            </template>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <div class="pagination-container">
      <el-pagination
        v-model:current-page="pagination.currentPage"
        v-model:page-size="pagination.pageSize"
        :page-sizes="[15, 30, 50, 100]"
        layout="total, sizes, prev, pager, next, jumper"
        :total="pagination.total"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<style scoped>
.param-cell {
  display: block;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  cursor: pointer;
}
</style>
