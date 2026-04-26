<template>
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="8">
        <el-card style="height: calc(100vh - 125px)">
          <div slot="header">
            <span><i class="el-icon-collection"></i> 桶列表</span>
            <el-button
              style="float: right; padding: 3px 0"
              type="text"
              icon="el-icon-plus"
              @click="handleCreateBucket"
            ></el-button>
            <el-button
              style="float: right; padding: 3px 0; margin-right: 10px"
              type="text"
              icon="el-icon-refresh-right"
              @click="refreshBuckets()"
            ></el-button>
          </div>
          <el-table
            v-loading="loading"
            :data="buckets"
            :height="tableHeight"
            highlight-current-row
            @row-click="getObjects"
            style="width: 100%"
          >
            <el-table-column
              label="序号"
              width="60"
              type="index"
            ></el-table-column>

            <el-table-column
              label="桶名称"
              align="center"
              prop="name"
              :show-overflow-tooltip="true"
            ></el-table-column>

            <el-table-column
              label="创建时间"
              align="center"
              prop="creationDate"
              :show-overflow-tooltip="true"
            />
            <el-table-column
              label="操作"
              width="120"
              align="center"
              class-name="small-padding fixed-width"
            >
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-view"
                  @click="getObjects(scope.row)"
                ></el-button>
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-delete"
                  @click="handleDeleteBucket(scope.row)"
                ></el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>

      <el-col :span="16">
        <el-card style="height: calc(100vh - 125px)">
          <div slot="header">
            <span><i class="el-icon-file"></i> 对象列表</span>
            <el-button
              style="float: right; padding: 3px 0"
              type="text"
              icon="el-icon-refresh-right"
              @click="refreshObjects()"
            ></el-button>
          </div>
          <el-table
            v-loading="subLoading"
            :data="objects"
            :height="tableHeight"
            style="width: 100%"
          >
            <el-table-column
              label="序号"
              width="60"
              type="index"
            ></el-table-column>
            <el-table-column
              label="对象"
              align="center"
              prop="name"
              :show-overflow-tooltip="true"
            >
              <template slot-scope="scope">
                <el-image
                  v-if="isImage(scope.row.name)"
                  style="width: 30px; height: 30px; cursor: pointer;"
                  :src="getPreviewUrl(scope.row.name)"
                  :preview-src-list="[getPreviewUrl(scope.row.name)]"
                  fit="cover"
                ></el-image>
                <span v-else>{{ scope.row.name }}</span>
              </template>
            </el-table-column>
            <el-table-column
              label="大小"
              align="center"
              prop="size"
              :formatter="sizeFormatter"
            ></el-table-column>
            <el-table-column
              label="最后修改时间"
              align="center"
              prop="lastModified"
              :show-overflow-tooltip="true"
            ></el-table-column>
            <el-table-column
              label="操作"
              width="60"
              align="center"
              class-name="small-padding fixed-width"
            >
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-delete"
                  @click="handleDeleteObject(scope.row)"
                ></el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-dialog
      :title="'创建桶'"
      :visible.sync="createBucketVisible"
      width="300px"
    >
      <el-form :model="bucketForm">
        <el-form-item label="桶名称" prop="bucketName" :label-width="'80px'">
          <el-input v-model="bucketForm.bucketName" placeholder="请输入桶名称" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="createBucketVisible = false">取消</el-button>
        <el-button type="primary" @click="submitCreateBucket">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listBuckets, listObjects, createBucket, deleteBucket, deleteObject } from "@/api/monitor/minio"

export default {
  name: "MinioList",
  data() {
    return {
      buckets: [],
      objects: [],
      loading: true,
      subLoading: false,
      nowBucket: "",
      tableHeight: window.innerHeight - 200,
      createBucketVisible: false,
      bucketForm: {
        bucketName: ""
      }
    }
  },
  created() {
    this.getBuckets()
  },
  methods: {
    getBuckets() {
      this.loading = true
      listBuckets().then(response => {
        console.log('桶列表数据:', response.data)
        if (Array.isArray(response.data)) {
          this.buckets = response.data
        } else {
          this.buckets = []
        }
        this.loading = false
      }).catch(error => {
        console.error('获取桶列表失败:', error)
        this.loading = false
      })
    },
    refreshBuckets() {
      this.getBuckets()
      this.$modal.msgSuccess("刷新桶列表成功")
    },
    getObjects(row) {
      const bucketName = row !== undefined ? row.name : this.nowBucket
      if (bucketName === "") {
        return
      }
      this.subLoading = true
      listObjects(bucketName).then(response => {
        console.log('对象列表数据:', response.data)
        if (Array.isArray(response.data)) {
          this.objects = response.data
        } else {
          this.objects = []
        }
        this.subLoading = false
        this.nowBucket = bucketName
      }).catch(error => {
        console.error('获取对象列表失败:', error)
        this.subLoading = false
      })
    },
    refreshObjects() {
      this.getObjects()
      this.$modal.msgSuccess("刷新对象列表成功")
    },
    handleCreateBucket() {
      this.bucketForm.bucketName = ""
      this.createBucketVisible = true
    },
    submitCreateBucket() {
      if (!this.bucketForm.bucketName) {
        this.$modal.msgError("请输入桶名称")
        return
      }
      createBucket(this.bucketForm.bucketName).then(response => {
        this.$modal.msgSuccess("创建桶成功")
        this.createBucketVisible = false
        this.getBuckets()
      }).catch(error => {
        console.error('创建桶失败:', error)
        this.$modal.msgError("创建桶失败: " + error.message)
      })
    },
    handleDeleteBucket(row) {
      this.$modal.confirm('确定要删除桶 "' + row.name + '" 吗？', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteBucket(row.name).then(response => {
          this.$modal.msgSuccess("删除桶成功")
          this.getBuckets()
          this.objects = []
        }).catch(error => {
          console.error('删除桶失败:', error)
          this.$modal.msgError("删除桶失败: " + error.message)
        })
      })
    },
    handleDeleteObject(row) {
      this.$modal.confirm('确定要删除对象 "' + row.name + '" 吗？', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteObject(this.nowBucket, row.name).then(response => {
          this.$modal.msgSuccess("删除对象成功")
          this.getObjects()
        }).catch(error => {
          console.error('删除对象失败:', error)
          this.$modal.msgError("删除对象失败: " + error.message)
        })
      })
    },
    sizeFormatter(row) {
      const size = row.size
      if (size < 1024) {
        return size + ' B'
      } else if (size < 1048576) {
        return (size / 1024).toFixed(2) + ' KB'
      } else if (size < 1073741824) {
        return (size / 1048576).toFixed(2) + ' MB'
      } else {
        return (size / 1073741824).toFixed(2) + ' GB'
      }
    },
    isImage(fileName) {
      if (!fileName) return false
      const ext = fileName.toLowerCase().split('.').pop()
      return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'].includes(ext)
    },
    getPreviewUrl(objectName) {
      return 'http://localhost:9000/' + this.nowBucket + '/' + objectName
    }
  }
}
</script>
