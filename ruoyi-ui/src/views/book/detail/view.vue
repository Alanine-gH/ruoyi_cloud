<template>
  <el-drawer title="书籍信息详情" :visible.sync="visible" direction="rtl" size="60%" append-to-body :before-close="handleClose" custom-class="detail-drawer">
    <div v-loading="loading" class="drawer-content">
      <h4 class="section-header">基本信息</h4>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">书籍名称：</label>
            <span class="info-value plaintext">
              {{ info.bookName }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">作者：</label>
            <span class="info-value plaintext">
              {{ info.author }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">ISBN编号：</label>
            <span class="info-value plaintext">
              {{ info.isbn }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">书籍分类：</label>
            <span class="info-value plaintext">
              {{ info.category }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">库存数量：</label>
            <span class="info-value plaintext">
              {{ info.stock }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">书籍封面：</label>
            <div class="info-value">
              <el-image
                v-if="info.coverImg"
                :src="info.coverImg"
                fit="cover"
                style="width: 120px; height: 160px;"
                @error="handleImageError"
              />
              <span v-else>无封面</span>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
  </el-drawer>
</template>

<script>
import { getDetail } from '@/api/book/detail'

export default {
  name: 'DetailViewDrawer',
  data() {
    return {
      visible: false,
      loading: false,
      info: {}
    }
  },
  methods: {
    open(bookId) {
      this.visible = true
      this.loading = true
      getDetail(bookId).then(res => {
        this.info = res.data || {}
      }).finally(() => {
        this.loading = false
      })
    },
    handleClose() {
      this.visible = false
    },
    /** 图片加载失败处理 */
    handleImageError(e) {
      e.target.src = 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=book%20cover%20placeholder&image_size=square';
    }
  }
}
</script>
