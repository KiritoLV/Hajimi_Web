<script setup>
import { loginApi } from "@/api/login";
import { Lock, User } from "@element-plus/icons-vue";
import { ElMessage } from "element-plus";
import { ref } from "vue";
import { useRouter } from "vue-router";

const loginForm = ref({ username: "", password: "" });
const loginFormRef = ref(null);
const loading = ref(false);
const router = useRouter();

const rules = {
  username: [{ required: true, message: "请输入用户名", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
};

const login = async () => {
  if (!loginFormRef.value) return;
  await loginFormRef.value.validate(async (valid) => {
    if (!valid) return;
    loading.value = true;
    try {
      const result = await loginApi(loginForm.value);
      if (result.code) {
        ElMessage.success("登录成功");
        localStorage.setItem("loginUser", JSON.stringify(result.data));
        await router.push("/");
      } else {
        ElMessage.error(result.msg || "登录失败");
      }
    } catch (error) {
      ElMessage.error("请求失败");
    } finally {
      loading.value = false;
    }
  });
};

const reset = () => {
  loginFormRef.value.resetFields();
};
</script>

<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-left">
        <img src="@/assets/index.png" alt="login-bg" class="login-bg" />
      </div>
      <div class="login-form-container">
        <el-form
          ref="loginFormRef"
          :model="loginForm"
          :rules="rules"
          class="login-form"
        >
          <h2 class="title">哈基米得管理系统</h2>
          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              placeholder="用户名"
              :prefix-icon="User"
              size="large"
            />
          </el-form-item>
          <el-form-item prop="password">
            <el-input
              type="password"
              v-model="loginForm.password"
              placeholder="密码"
              :prefix-icon="Lock"
              size="large"
              show-password
              @keyup.enter="login"
            />
          </el-form-item>
          <el-form-item>
            <el-button
              :loading="loading"
              type="primary"
              @click="login"
              class="login-button"
              size="large"
            >
              登 录
            </el-button>
          </el-form-item>
          <el-form-item>
            <el-button @click="reset" class="reset-button" size="large">
              重 置
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100vw;
  background-image: linear-gradient(to top, #a8edea 0%, #fed6e3 100%);
}

.login-box {
  display: flex;
  width: 900px;
  height: 500px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.login-left {
  width: 50%;
  background-color: #f0f2f5;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-bg {
  width: 80%;
  object-fit: contain;
}

.login-form-container {
  width: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px;
}

.login-form {
  width: 100%;
}

.title {
  font-size: 24px;
  font-weight: 600;
  text-align: center;
  margin-bottom: 30px;
  color: var(--text-color-primary);
}

.login-button,
.reset-button {
  width: 100%;
}

.reset-button {
  margin-top: 10px;
}
</style>
