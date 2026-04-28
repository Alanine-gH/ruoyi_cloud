<template>
  <div class="dark-login" :class="{ 'light-on': lightOn }">
    <!-- 背景光晕 -->
    <div class="light-glow" :class="{ active: lightOn }" :style="lightGlowStyle"></div>

    <!-- 台灯区域 -->
    <div class="lamp-area">
      <div class="lamp-container">
        <!-- 灯光光晕（从灯泡处扩散） -->
        <div class="bulb-glow" :class="{ active: lightOn }" :style="bulbGlowStyle"></div>
        <!-- 灯罩 -->
        <div class="lamp-shade" :class="{ lit: lightOn }" :style="lampShadeStyle">
          <!-- 眼睛 -->
          <div class="lamp-eyes">
            <span class="eye eye-left" :class="{ glowing: lightOn }" :style="eyeGlowingStyle"></span>
            <span class="eye eye-right" :class="{ glowing: lightOn }" :style="eyeGlowingStyle"></span>
          </div>
          <!-- 微笑（灯亮时显示） -->
          <span class="mouth" :class="{ visible: lightOn }"></span>
        </div>

        <!-- 灯泡 -->
        <div class="lamp-bulb" :class="{ lit: lightOn }" :style="bulbLitStyle"></div>

        <!-- 灯杆 -->
        <div class="lamp-pole"></div>

        <!-- 灯座 -->
        <div class="lamp-base"></div>

        <!-- 拉绳 -->
        <div class="pull-string-container" @click="toggleLight">
          <span class="pull-line" :class="{ pulling: pullAnimating }"></span>
          <span
            class="pull-ball"
            :class="{ pulling: pullAnimating }"
            :key="pullKey"
          ></span>
        </div>
      </div>
      <!-- 提示文字 -->
      <p class="lamp-hint" :style="lampHintStyle">{{ lightOn ? '点击拉绳关闭灯光' : '拉动拉绳点亮台灯' }}</p>
    </div>

    <!-- 登录卡片区域 -->
    <div class="login-card-area">
      <transition name="card-fade" appear>
        <div v-show="lightOn" class="login-card-wrapper">
          <el-form
            ref="loginForm"
            :model="loginForm"
            :rules="loginRules"
            class="login-form-dark"
            :style="lightOn ? loginCardLitStyle : loginCardStyle"
          >
            <!-- 标题 -->
            <h2 class="card-title">欢迎回来</h2>
            <p class="card-subtitle">输入您的凭据以访问控制中心</p>

            <!-- 账号 -->
            <el-form-item prop="username">
              <el-input
                v-model="loginForm.username"
                type="text"
                auto-complete="off"
                placeholder="电子邮箱 / 账号"
                class="dark-input"
              >
                <svg-icon
                  slot="prefix"
                  icon-class="user"
                  class="el-input__icon input-icon-dark"
                />
              </el-input>
            </el-form-item>

            <!-- 密码 -->
            <el-form-item prop="password">
              <el-input
                v-model="loginForm.password"
                type="password"
                auto-complete="off"
                placeholder="访问密码"
                class="dark-input"
                @keyup.enter.native="handleLogin"
              >
                <svg-icon
                  slot="prefix"
                  icon-class="password"
                  class="el-input__icon input-icon-dark"
                />
              </el-input>
            </el-form-item>

            <!-- 验证码 -->
            <el-form-item prop="code" v-if="captchaEnabled">
              <el-input
                v-model="loginForm.code"
                auto-complete="off"
                placeholder="验证码"
                class="dark-input code-input"
                @keyup.enter.native="handleLogin"
              >
                <svg-icon
                  slot="prefix"
                  icon-class="validCode"
                  class="el-input__icon input-icon-dark"
                />
              </el-input>
              <div class="login-code-dark">
                <img
                  :src="codeUrl"
                  @click="getCode"
                  class="login-code-img-dark"
                  alt="验证码"
                />
              </div>
            </el-form-item>

            <!-- 记住密码 -->
            <el-checkbox
              v-model="loginForm.rememberMe"
              class="dark-checkbox"
            >
              记住密码
            </el-checkbox>

            <!-- 登录按钮 -->
            <el-form-item style="width: 100%; margin-bottom: 16px;">
              <el-button
                :loading="loading"
                size="medium"
                class="login-btn-dark"
                :style="loginBtnStyle"
                @click.native.prevent="handleLogin"
              >
                <span v-if="!loading">立即登录</span>
                <span v-else>登录中...</span>
              </el-button>
            </el-form-item>

            <!-- 底部链接 -->
            <div class="card-footer-links">
              <router-link class="footer-link" to="/reset-password">
                忘记访问密码？
              </router-link>
              <router-link
                v-if="register"
                class="footer-link"
                to="/register"
              >
                立即注册
              </router-link>
            </div>
          </el-form>
        </div>
      </transition>
    </div>

    <!-- 底部 -->
    <div class="el-login-footer-dark" :style="footerStyle">
      <span>{{ footerContent }}</span>
    </div>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from '@/utils/jsencrypt'
import defaultSettings from '@/settings'

export default {
  name: "DarkLogin",
  data() {
    return {
      title: process.env.VUE_APP_TITLE,
      footerContent: defaultSettings.footerContent,
      codeUrl: "",
      loginForm: {
        username: "admin",
        password: "admin123",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [
          { required: true, trigger: "change", message: "请输入验证码" }
        ]
      },
      loading: false,
      captchaEnabled: true,
      register: false,
      redirect: undefined,
      // 台灯状态
      lightOn: false,
      pullAnimating: false,
      pullKey: 0,
      // 当前主题颜色
      currentTheme: '#409EFF'
    }
  },
  computed: {
    themeColor() {
      let theme = this.currentTheme
      try {
        if (this.$store && this.$store.state && this.$store.state.settings) {
          theme = this.$store.state.settings.theme || theme
        }
      } catch (e) {
        console.log('Store not available, using localStorage')
      }
      const storageSetting = localStorage.getItem('layout-setting')
      if (storageSetting) {
        try {
          const setting = JSON.parse(storageSetting)
          theme = setting.theme || theme
        } catch (e) {
          console.log('Failed to parse localStorage')
        }
      }
      return theme
    },
    lightGlowStyle() {
      return {
        background: `radial-gradient(circle, ${this.hexToRgba(this.themeColor, 0.18)} 0%, ${this.hexToRgba(this.themeColor, 0.06)} 35%, ${this.hexToRgba(this.themeColor, 0.02)} 60%, transparent 100%)`
      }
    },
    bulbGlowStyle() {
      return {
        background: `radial-gradient(circle, ${this.hexToRgba(this.themeColor, 0.7)} 0%, ${this.hexToRgba(this.themeColor, 0.35)} 18%, ${this.hexToRgba(this.themeColor, 0.1)} 40%, ${this.hexToRgba(this.themeColor, 0.03)} 65%, transparent 100%)`
      }
    },
    lampShadeStyle() {
      if (this.lightOn) {
        return {
          background: this.themeColor,
          boxShadow: `0 0 20px ${this.hexToRgba(this.themeColor, 0.7)}, 0 0 50px ${this.hexToRgba(this.themeColor, 0.35)}, 0 0 90px ${this.hexToRgba(this.themeColor, 0.15)}, 0 4px 20px rgba(0, 0, 0, 0.4)`
        }
      } else {
        return {
          background: '#2a2a2a',
          boxShadow: '0 2px 12px rgba(0, 0, 0, 0.6)'
        }
      }
    },
    bulbLitStyle() {
      if (!this.lightOn) return {}
      return {
        background: '#ffffff',
        boxShadow: `0 0 16px #ffffff, 0 0 40px ${this.hexToRgba(this.themeColor, 0.9)}, 0 0 70px ${this.hexToRgba(this.themeColor, 0.5)}, 0 0 100px ${this.hexToRgba(this.themeColor, 0.25)}`
      }
    },
    eyeGlowingStyle() {
      if (!this.lightOn) return {}
      return {
        background: '#ffffff',
        boxShadow: `0 0 8px #ffffff, 0 0 16px rgba(255, 255, 255, 0.8), 0 0 28px ${this.hexToRgba(this.themeColor, 0.6)}`
      }
    },
    pullBallHoverStyle() {
      return {
        '--theme-color': this.themeColor
      }
    },
    lampHintStyle() {
      if (!this.lightOn) return {}
      return {
        color: this.hexToRgba(this.themeColor, 0.6)
      }
    },
    loginCardStyle() {
      const themeColor = this.themeColor
      return {
        '--theme-color': themeColor,
        border: `1px solid ${this.hexToRgba(themeColor, 0.25)}`,
        boxShadow: `0 0 30px ${this.hexToRgba(themeColor, 0.12)}, 0 0 60px ${this.hexToRgba(themeColor, 0.04)}, 0 8px 32px rgba(0, 0, 0, 0.5)`
      }
    },
    loginCardLitStyle() {
      const themeColor = this.themeColor
      return {
        '--theme-color': themeColor,
        border: `1px solid ${this.hexToRgba(themeColor, 0.5)}`,
        boxShadow: `0 0 40px ${this.hexToRgba(themeColor, 0.2)}, 0 0 80px ${this.hexToRgba(themeColor, 0.08)}, 0 8px 32px rgba(0, 0, 0, 0.5)`
      }
    },
    loginBtnStyle() {
      const darken = (color, percent) => {
        const num = parseInt(color.replace('#', ''), 16)
        const amt = Math.round(2.55 * percent)
        const R = (num >> 16) - amt
        const G = (num >> 8 & 0x00FF) - amt
        const B = (num & 0x0000FF) - amt
        return '#' + (
          0x1000000 +
          (R < 255 ? R < 1 ? 0 : R : 255) * 0x10000 +
          (G < 255 ? G < 1 ? 0 : G : 255) * 0x100 +
          (B < 255 ? B < 1 ? 0 : B : 255)
        ).toString(16).slice(1)
      }
      return {
        '--btn-bg': darken(this.themeColor, 12),
        '--btn-hover': this.themeColor,
        '--btn-loading': darken(this.themeColor, 23)
      }
    },
    footerStyle() {
      if (!this.lightOn) return {}
      return {
        color: this.hexToRgba(this.themeColor, 0.3)
      }
    }
  },
  watch: {
    themeColor(val) {
      this.currentTheme = val
    },
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  created() {
    this.getCode()
    this.getCookie()
  },
  methods: {
    /** 切换台灯灯光 */
    toggleLight() {
      // 触发拉绳弹性动画
      this.pullAnimating = true
      this.pullKey++
      setTimeout(() => {
        this.pullAnimating = false
      }, 420)

      // 切换灯光状态
      this.lightOn = !this.lightOn

      // 灯光亮起时刷新验证码（如果需要）
      if (this.lightOn && this.captchaEnabled && !this.codeUrl) {
        this.getCode()
      }
    },

    /** 获取验证码 */
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled =
          res.captchaEnabled === undefined ? true : res.captchaEnabled
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img
          this.loginForm.uuid = res.uuid
        }
      })
    },

    /** 获取Cookie中的记住密码信息 */
    getCookie() {
      const username = Cookies.get("username")
      const password = Cookies.get("password")
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        ...this.loginForm,
        username: username === undefined ? this.loginForm.username : username,
        password:
          password === undefined
            ? this.loginForm.password
            : decrypt(password),
        rememberMe:
          rememberMe === undefined ? false : Boolean(rememberMe)
      }
    },

    /** 处理登录 */
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 })
            Cookies.set("password", encrypt(this.loginForm.password), {
              expires: 30
            })
            Cookies.set('rememberMe', this.loginForm.rememberMe, {
              expires: 30
            })
          } else {
            Cookies.remove("username")
            Cookies.remove("password")
            Cookies.remove('rememberMe')
          }
          this.$store
            .dispatch("Login", this.loginForm)
            .then(() => {
              this.$router.push({ path: this.redirect || "/" }).catch(() => {})
            })
            .catch(() => {
              this.loading = false
              if (this.captchaEnabled) {
                this.getCode()
              }
            })
        }
      })
    },

    /** 将十六进制颜色转换为RGBA */
    hexToRgba(hex, alpha) {
      const r = parseInt(hex.slice(1, 3), 16)
      const g = parseInt(hex.slice(3, 5), 16)
      const b = parseInt(hex.slice(5, 7), 16)
      return `rgba(${r}, ${g}, ${b}, ${alpha})`
    }
  }
}
</script>

<style lang="scss" scoped>
/* ==================== 页面整体 ==================== */
.dark-login {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100vh;
  min-height: 100vh;
  background: #0a0a0a;
  overflow: hidden;
  font-family: 'Inter', 'PingFang SC', 'Microsoft YaHei', sans-serif;

  /* 页面微弱的噪点纹理（可选） */
  &::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(
        ellipse at center,
        rgba(20, 20, 20, 0) 0%,
        rgba(0, 0, 0, 0.6) 100%
    );
    pointer-events: none;
    z-index: 0;
  }
}

/* ==================== 背景光晕（大范围环境光） ==================== */
.light-glow {
  position: fixed;
  top: 50%;
  left: 50%;
  width: 900px;
  height: 900px;
  border-radius: 50%;
  background: radial-gradient(
      circle,
      rgba(0, 255, 60, 0.18) 0%,
      rgba(0, 255, 60, 0.06) 35%,
      rgba(0, 200, 40, 0.02) 60%,
      transparent 100%
  );
  transform: translate(-50%, -50%) scale(0.3);
  opacity: 0;
  pointer-events: none;
  z-index: 1;
  transition: opacity 0.9s cubic-bezier(0.25, 0.46, 0.45, 0.94),
  transform 0.9s cubic-bezier(0.25, 0.46, 0.45, 0.94);

  &.active {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1);
  }
}

/* ==================== 台灯区域 ==================== */
.lamp-area {
  position: relative;
  z-index: 3;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 60px;
  flex-shrink: 0;
}

.lamp-container {
  position: relative;
  width: 160px;
  height: 440px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* --- 灯泡光晕（从灯泡处扩散） --- */
.bulb-glow {
  position: absolute;
  top: 148px;
  left: 50%;
  width: 320px;
  height: 320px;
  border-radius: 50%;
  background: radial-gradient(
      circle,
      rgba(0, 255, 60, 0.7) 0%,
      rgba(0, 255, 60, 0.35) 18%,
      rgba(0, 255, 60, 0.1) 40%,
      rgba(0, 200, 40, 0.03) 65%,
      transparent 100%
  );
  transform: translate(-50%, -50%) scale(0.2);
  opacity: 0;
  pointer-events: none;
  z-index: 0;
  transition: opacity 0.75s cubic-bezier(0.25, 0.46, 0.45, 0.94),
  transform 0.75s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  filter: blur(8px);

  &.active {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1);
    animation: glowPulse 3s ease-in-out infinite;
  }
}

@keyframes glowPulse {
  0%,
  100% {
    opacity: 0.85;
    transform: translate(-50%, -50%) scale(1);
  }
  50% {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1.06);
  }
}

/* --- 灯罩 --- */
.lamp-shade {
  position: absolute;
  top: 100px;
  left: 50%;
  width: 120px;
  height: 70px;
  clip-path: polygon(18% 0%, 82% 0%, 100% 100%, 0% 100%);
  transform: translateX(-50%);
  z-index: 2;
  transition: background 0.6s ease, box-shadow 0.6s ease;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.6);
}

/* --- 眼睛 --- */
.lamp-eyes {
  position: absolute;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 22px;
  z-index: 3;
}

.eye {
  display: block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #2a2a2a;
  transition: background 0.5s ease, box-shadow 0.5s ease;

  &.glowing {
    animation: eyeFlicker 4s ease-in-out infinite;
  }
}

.eye-left.glowing {
  animation-delay: 0s;
}
.eye-right.glowing {
  animation-delay: 0.6s;
}

@keyframes eyeFlicker {
  0%,
  95%,
  100% {
    opacity: 1;
  }
  96% {
    opacity: 0.7;
  }
  97% {
    opacity: 1;
  }
}

/* --- 微笑 --- */
.mouth {
  position: absolute;
  bottom: 10px;
  left: 50%;
  width: 24px;
  height: 10px;
  border-bottom: 2px solid transparent;
  border-radius: 0 0 12px 12px;
  transform: translateX(-50%);
  z-index: 3;
  transition: border-color 0.5s ease;

  &.visible {
    border-color: rgba(0, 0, 0, 0.5);
  }
}

/* --- 灯泡 --- */
.lamp-bulb {
  position: absolute;
  top: 168px;
  left: 50%;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: #2a2a2a;
  transform: translateX(-50%);
  z-index: 1;
  transition: background 0.5s ease, box-shadow 0.5s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
}

/* --- 灯杆 --- */
.lamp-pole {
  position: absolute;
  top: 188px;
  left: 50%;
  width: 6px;
  height: 170px;
  background: linear-gradient(to bottom, #3a3a3a, #2a2a2a, #1a1a1a);
  transform: translateX(-50%);
  z-index: 1;
  border-radius: 3px;
  box-shadow: 1px 0 2px rgba(0, 0, 0, 0.3);
}

/* --- 灯座 --- */
.lamp-base {
  position: absolute;
  bottom: 55px;
  left: 50%;
  width: 70px;
  height: 16px;
  background: linear-gradient(to bottom, #2a2a2a, #1a1a1a);
  border-radius: 50%;
  transform: translateX(-50%);
  z-index: 2;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
}

/* --- 拉绳 --- */
.pull-string-container {
  position: absolute;
  top: 160px;
  right: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  z-index: 5;
  user-select: none;
  -webkit-tap-highlight-color: transparent;
}

.pull-line {
  display: block;
  width: 2px;
  height: 70px;
  background: #555;
  border-radius: 1px;
  transition: height 0.15s ease-out;
  transform-origin: top center;

  &.pulling {
    animation: lineStretch 0.42s cubic-bezier(0.68, -0.3, 0.27, 1.3);
  }
}

@keyframes lineStretch {
  0% {
    height: 70px;
  }
  35% {
    height: 94px;
  }
  65% {
    height: 64px;
  }
  80% {
    height: 73px;
  }
  100% {
    height: 70px;
  }
}

.pull-ball {
  display: block;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: radial-gradient(circle at 40% 35%, #888, #444);
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.5);
  transition: box-shadow 0.3s ease;
  margin-top: -1px;

  &.pulling {
    animation: ballBounce 0.42s cubic-bezier(0.68, -0.3, 0.27, 1.3);
  }

  &:hover {
    box-shadow: 0 3px 14px rgba(0, 255, 60, 0.5), 0 3px 8px rgba(0, 0, 0, 0.5);
  }

  &:active {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
  }
}

@keyframes ballBounce {
  0% {
    transform: translateY(0);
  }
  35% {
    transform: translateY(22px);
  }
  65% {
    transform: translateY(-5px);
  }
  80% {
    transform: translateY(3px);
  }
  100% {
    transform: translateY(0);
  }
}

/* --- 提示文字 --- */
.lamp-hint {
  margin-top: 20px;
  color: #555;
  font-size: 13px;
  text-align: center;
  letter-spacing: 0.5px;
  transition: color 0.5s ease;
}

.dark-login.light-on .lamp-hint {
  color: rgba(0, 255, 60, 0.6);
}

/* ==================== 登录卡片区域 ==================== */
.login-card-area {
  position: relative;
  z-index: 3;
  flex-shrink: 0;
}

/* Vue transition: card-fade */
.card-fade-enter-active {
  transition: all 0.55s cubic-bezier(0.4, 0, 0.2, 1) 0.2s;
}
.card-fade-leave-active {
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}
.card-fade-enter {
  opacity: 0;
  transform: scale(0.82) translateX(30px);
}
.card-fade-leave-to {
  opacity: 0;
  transform: scale(0.9) translateX(15px);
}

.login-card-wrapper {
  width: 420px;
}

/* 登录表单卡片 */
.login-form-dark {
  background: rgba(18, 18, 18, 0.95);
  border-radius: 16px;
  padding: 36px 32px 24px 32px;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  transition: box-shadow 0.6s ease, border-color 0.6s ease;
}

/* 标题 */
.card-title {
  margin: 0 0 6px 0;
  font-size: 26px;
  font-weight: 700;
  color: #ffffff;
  text-align: center;
  letter-spacing: 1px;
}

.card-subtitle {
  margin: 0 0 28px 0;
  font-size: 14px;
  color: #777;
  text-align: center;
  letter-spacing: 0.3px;
}

/* ==================== 深色输入框覆盖 ==================== */
.dark-input {
  ::v-deep .el-input__inner {
    background-color: #1a1a1a !important;
    border: 1px solid #333 !important;
    border-radius: 8px !important;
    color: #e0e0e0 !important;
    height: 44px !important;
    line-height: 44px !important;
    font-size: 14px !important;
    padding-left: 40px !important;
    transition: border-color 0.3s ease, box-shadow 0.3s ease,
    background-color 0.3s ease;

    &::placeholder {
      color: #555;
    }

    &:focus {
      border-color: var(--theme-color, #00ff2a) !important;
      box-shadow: 0 0 12px color-mix(in srgb, var(--theme-color, #00ff2a) 20%, transparent),
      0 0 24px color-mix(in srgb, var(--theme-color, #00ff2a) 6%, transparent) !important;
      background-color: #1e1e1e !important;
    }

    &:hover {
      border-color: #444 !important;
    }

    /* 自动填充样式覆盖 */
    &:-webkit-autofill,
    &:-webkit-autofill:hover,
    &:-webkit-autofill:focus {
      -webkit-text-fill-color: #e0e0e0 !important;
      -webkit-box-shadow: 0 0 0px 1000px #1a1a1a inset !important;
      border-color: #333 !important;
      transition: background-color 5000s ease-in-out 0s;
    }
  }
}

/* 输入框图标 */
.input-icon-dark {
  height: 44px !important;
  width: 16px !important;
  margin-left: 4px;
  color: #666;
  transition: color 0.3s ease;
}

.dark-input ::v-deep .el-input__prefix {
  left: 8px;
  display: flex;
  align-items: center;
}

/* 聚焦时图标变色 */
.dark-input ::v-deep .el-input.is-focus .input-icon-dark,
.dark-input ::v-deep .el-input__inner:focus ~ .el-input__prefix .input-icon-dark {
  color: var(--theme-color, #00ff2a);
}

/* 验证码输入框 */
.code-input {
  width: 62%;
  display: inline-block;

  ::v-deep .el-input__inner {
    border-radius: 8px 0 0 8px !important;
  }
}

/* 验证码图片 */
.login-code-dark {
  width: 36%;
  height: 44px;
  display: inline-block;
  vertical-align: top;
  border-radius: 0 8px 8px 0;
  overflow: hidden;
  cursor: pointer;
  border: 1px solid #333;
  border-left: none;
  background: #1a1a1a;
  transition: border-color 0.3s ease, box-shadow 0.3s ease;

  &:hover {
    border-color: var(--theme-color, #00ff2a);
    box-shadow: 0 0 10px color-mix(in srgb, var(--theme-color, #00ff2a) 15%, transparent);
  }
}

.login-code-img-dark {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ==================== 记住密码复选框 ==================== */
.dark-checkbox {
  margin: 0 0 22px 0;

  ::v-deep .el-checkbox__label {
    color: #999 !important;
    font-size: 13px;
  }

  ::v-deep .el-checkbox__inner {
    background-color: #1a1a1a !important;
    border-color: #444 !important;
    border-radius: 4px !important;
    transition: border-color 0.3s ease, background-color 0.3s ease;
  }

  ::v-deep .el-checkbox__input.is-checked .el-checkbox__inner {
    background-color: var(--theme-color, #00ff2a) !important;
    border-color: var(--theme-color, #00ff2a) !important;
  }

  ::v-deep .el-checkbox__input.is-checked .el-checkbox__inner::after {
    border-color: #0a0a0a !important;
  }

  ::v-deep .el-checkbox__input.is-focus .el-checkbox__inner {
    border-color: var(--theme-color, #00ff2a) !important;
    box-shadow: 0 0 8px color-mix(in srgb, var(--theme-color, #00ff2a) 25%, transparent) !important;
  }
}

/* ==================== 登录按钮 ==================== */
.login-btn-dark {
  width: 100%;
  height: 46px;
  border-radius: 10px;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 2px;
  background: var(--btn-bg, #00cc22) !important;
  border: none !important;
  color: #0a0a0a !important;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;

  &:hover {
    background: var(--btn-hover, #00ff2a) !important;
    box-shadow:
      0 0 24px color-mix(in srgb, var(--btn-hover, #00ff2a) 50%, transparent),
      0 0 50px color-mix(in srgb, var(--btn-hover, #00ff2a) 20%, transparent),
      0 6px 20px rgba(0, 0, 0, 0.4) !important;
    transform: translateY(-1px);
  }

  &:active {
    transform: translateY(1px);
    box-shadow: 0 0 10px color-mix(in srgb, var(--btn-hover, #00ff2a) 30%, transparent) !important;
  }

  /* loading 状态 */
  &.is-loading {
    background: var(--btn-loading, #00aa1d) !important;
    box-shadow: none !important;
  }

  ::v-deep .el-loading-spinner .circular circle {
    stroke: #0a0a0a;
  }
}

/* ==================== 底部链接 ==================== */
.card-footer-links {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 4px;
}

.footer-link {
  color: #555;
  font-size: 13px;
  text-decoration: none;
  transition: color 0.3s ease, text-shadow 0.3s ease;

  &:hover {
    color: var(--theme-color, #00ff2a);
    text-shadow: 0 0 10px color-mix(in srgb, var(--theme-color, #00ff2a) 40%, transparent);
  }
}

/* ==================== 底部版权 ==================== */
.el-login-footer-dark {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 40px;
  line-height: 40px;
  text-align: center;
  color: #333;
  font-family: Arial, sans-serif;
  font-size: 12px;
  letter-spacing: 1px;
  z-index: 2;
  pointer-events: none;
  transition: color 0.5s ease;
}

.dark-login.light-on .el-login-footer-dark {
  color: color-mix(in srgb, var(--theme-color, #00ff2a) 30%, transparent);
}

/* ==================== 全局表单项间距 ==================== */
.login-form-dark ::v-deep .el-form-item {
  margin-bottom: 18px;
}

.login-form-dark ::v-deep .el-form-item__error {
  color: #ff4444;
  font-size: 12px;
  padding-top: 4px;
}

/* ==================== 响应式适配 ==================== */
@media (max-width: 900px) {
  .dark-login {
    flex-direction: column;
    padding: 20px;
    gap: 20px;
  }

  .lamp-area {
    margin-right: 0;
    margin-bottom: 0;
    transform: scale(0.8);
  }

  .lamp-container {
    height: 380px;
  }

  .login-card-wrapper {
    width: 100%;
    max-width: 400px;
  }

  .login-form-dark {
    padding: 24px 20px 18px 20px;
  }

  .bulb-glow {
    width: 220px;
    height: 220px;
  }

  .light-glow {
    width: 500px;
    height: 500px;
  }
}

@media (max-width: 480px) {
  .lamp-area {
    transform: scale(0.65);
    margin-bottom: -30px;
  }

  .lamp-container {
    height: 340px;
  }

  .login-card-wrapper {
    width: 100%;
    max-width: 340px;
  }

  .login-form-dark {
    padding: 20px 16px 14px 16px;
    border-radius: 12px;
  }

  .card-title {
    font-size: 22px;
  }

  .card-subtitle {
    font-size: 12px;
    margin-bottom: 20px;
  }
}
</style>
