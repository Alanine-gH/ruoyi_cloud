<template>
  <div class="app-container">

    <div class="query-form-wrapper">
      <el-form
        :model="queryParams"
        ref="queryForm"
        size="small"
        :inline="false"
        v-show="showSearch"
        label-width="120px"
        class="query-form-main"
      >
        <!-- 第一行：3个查询项 -->
        <el-row :gutter="24">
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="借阅人ID" prop="userId">
              <el-input
                v-model="queryParams.userId"
                placeholder="请输入借阅人ID"
                clearable
                class="query-input"
                @keyup.enter.native="handleQuery"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="借阅人姓名" prop="userName">
              <el-input
                v-model="queryParams.userName"
                placeholder="请输入借阅人姓名"
                clearable
                class="query-input"
                @keyup.enter.native="handleQuery"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="借阅时间" prop="borrowTime">
              <el-date-picker
                clearable
                v-model="queryParams.borrowTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择借阅时间"
                class="query-input"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 第二行：2个查询项 + 按钮组 -->
        <el-row :gutter="24">
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="预计归还时间" prop="planReturnTime">
              <el-date-picker
                clearable
                v-model="queryParams.planReturnTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择预计归还时间"
                class="query-input"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="实际归还时间" prop="returnTime">
              <el-date-picker
                clearable
                v-model="queryParams.returnTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择实际归还时间"
                class="query-input"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item class="btn-form-item">
              <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">搜索</el-button>
              <el-button icon="el-icon-refresh" size="small" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </div>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['book:record:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['book:record:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['book:record:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['book:record:export']"
        >导出
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleImportTemplate"
        >下载模板
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-upload2"
          size="mini"
          @click="handleImport"
          :disabled="!downloadClicked"
        >导入数据
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleBorrow"
          v-hasPermi="['book:record:add']"
        >借书
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-check"
          size="mini"
          :disabled="single"
          @click="handleReturn"
          v-hasPermi="['book:record:edit']"
        >还书
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="借阅记录ID" align="center" prop="recordId"/>
      <el-table-column label="借阅人ID" align="center" prop="userId"/>
      <el-table-column label="借阅人姓名" align="center" prop="userName"/>
      <el-table-column label="书籍名称" align="center" prop="bookName"/>
      <el-table-column label="作者" align="center" prop="author"/>
      <el-table-column label="ISBN" align="center" prop="isbn"/>
      <el-table-column label="分类" align="center" prop="category"/>
      <el-table-column label="借阅时间" align="center" prop="borrowTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.borrowTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预计归还时间" align="center" prop="planReturnTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.planReturnTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际归还时间" align="center" prop="returnTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.returnTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="借阅状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag
            :type="getStatusType(scope.row.status)"
            size="small"
          >{{ getStatusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['book:record:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['book:record:remove']"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改借阅记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="借阅人ID" prop="userId">
              <el-input v-model="form.userId" placeholder="请输入借阅人ID"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="借阅人姓名" prop="userName">
              <el-input v-model="form.userName" placeholder="请输入借阅人姓名"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="借阅时间" prop="borrowTime">
              <el-date-picker clearable
                              v-model="form.borrowTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择借阅时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预计归还时间" prop="planReturnTime">
              <el-date-picker clearable
                              v-model="form.planReturnTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择预计归还时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="实际归还时间" prop="returnTime">
              <el-date-picker clearable
                              v-model="form.returnTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择实际归还时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 借书对话框 -->
    <el-dialog :title="'借书'" :visible.sync="borrowDialogVisible" width="600px" append-to-body>
      <el-form ref="borrowForm" :model="borrowForm" :rules="borrowRules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="借阅人ID" prop="userId">
              <el-input v-model="borrowForm.userId" placeholder="请输入借阅人ID"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="借阅人姓名" prop="userName">
              <el-input v-model="borrowForm.userName" placeholder="请输入借阅人姓名"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预计归还时间" prop="planReturnTime">
              <el-date-picker clearable
                              v-model="borrowForm.planReturnTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择预计归还时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="选择书籍" prop="bookIds">
              <el-select
                v-model="borrowForm.bookIds"
                multiple
                placeholder="请选择要借的书籍"
                style="width: 100%"
              >
                <el-option
                  v-for="book in bookList"
                  :key="book.bookId"
                  :label="book.bookName + ' - ' + book.author"
                  :value="book.bookId"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitBorrow">确 定</el-button>
        <el-button @click="borrowDialogVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 还书确认对话框 -->
    <el-dialog :title="'还书确认'" :visible.sync="returnDialogVisible" width="400px" append-to-body>
      <p>确定要归还该借阅记录吗？</p>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitReturn">确 定</el-button>
        <el-button @click="returnDialogVisible = false">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 导入文件上传组件 -->
    <el-upload
      ref="uploadRef"
      :action="''"
      :http-request="handleFileUpload"
      :on-success="handleImportSuccess"
      :on-error="handleImportError"
      :auto-upload="true"
      :show-file-list="false"
      accept=".xlsx,.xls"
    >
      <el-button>导入</el-button>
    </el-upload>
  </div>
</template>

<style scoped>
/* 表单容器，控制整体边距，避免贴边 */
.query-form-wrapper {
  padding: 16px 0;
  width: 100%;
}

/* 表单主体，限制最大宽度，超宽屏不会无限拉伸 */
.query-form-main {
  max-width: 1400px;
  width: 100%;
}

/* 统一输入框宽度，避免不同控件宽度不一致，宽屏不臃肿 */
.query-input {
  width: 100%;
  max-width: 240px;
}

/* 按钮组和输入框完美底部对齐，消除标签占位的高度差 */
.btn-form-item {
  display: flex;
  align-items: flex-end;
  height: 100%;
  margin-bottom: 22px; /* 和Element默认表单项下边距完全一致，保证对齐 */
}

/* 小屏响应式适配，自动换行不挤压 */
@media (max-width: 768px) {
  .query-form-main {
    label-width: 90px;
  }

  .query-input {
    max-width: 100%;
  }
}

/* 隐藏上传按钮 */
.hidden-upload {
  display: none;
}
</style>
<script>
import {listRecord, getRecord, delRecord, addRecord, updateRecord, borrowBooks, returnBooks, importTemplate, importRecordData} from "@/api/book/record"
import {listDetail} from "@/api/book/detail"

export default {
  name: "Record",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 借阅记录表格数据
      recordList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        userName: null,
        borrowTime: null,
        planReturnTime: null,
        returnTime: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 借书对话框可见性
      borrowDialogVisible: false,
      // 还书对话框可见性
      returnDialogVisible: false,
      // 借书表单
      borrowForm: {
        userId: null,
        userName: null,
        planReturnTime: null,
        bookIds: []
      },
      // 书籍列表
      bookList: [],
      // 是否点击过下载模板
      downloadClicked: false,
      // 表单校验
      rules: {
        userId: [
          {required: true, message: "借阅人ID不能为空", trigger: "blur"}
        ],
        userName: [
          {required: true, message: "借阅人姓名不能为空", trigger: "blur"}
        ],
      },
      // 借书表单校验
      borrowRules: {
        userId: [
          {required: true, message: "借阅人ID不能为空", trigger: "blur"}
        ],
        userName: [
          {required: true, message: "借阅人姓名不能为空", trigger: "blur"}
        ],
        planReturnTime: [
          {required: true, message: "预计归还时间不能为空", trigger: "blur"}
        ],
        bookIds: [
          {required: true, message: "请选择要借的书籍", trigger: "blur"}
        ]
      }
    }
  },
  created() {
    this.getList()
    this.getBookList()
  },
  methods: {
    /** 查询借阅记录列表 */
    getList() {
      this.loading = true
      listRecord(this.queryParams).then(response => {
        const records = response.rows
        const now = new Date()
        const overdueRecords = []
        
        // 检查每条记录是否逾期
        records.forEach(record => {
          if (record.status === '1' && record.planReturnTime) {
            const planReturnDate = new Date(record.planReturnTime)
            if (now > planReturnDate) {
              // 标记为逾期
              record.status = '3'
              overdueRecords.push(record)
            }
          }
        })
        
        // 如果有逾期记录，批量更新后端
        if (overdueRecords.length > 0) {
          // 批量更新逾期状态
          overdueRecords.forEach(record => {
            updateRecord(record).then(() => {
              console.log('更新逾期状态成功:', record.recordId)
            }).catch(error => {
              console.error('更新逾期状态失败:', error)
            })
          })
        }
        
        this.recordList = records
        this.total = response.total
        this.loading = false
      })
    },
    /** 查询书籍列表 */
    getBookList() {
      listDetail({}).then(response => {
        this.bookList = response.rows
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        recordId: null,
        userId: null,
        userName: null,
        borrowTime: null,
        planReturnTime: null,
        returnTime: null,
        status: null,
        createTime: null,
        updateTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.recordId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加借阅记录"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const recordId = row.recordId || this.ids
      getRecord(recordId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改借阅记录"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.recordId != null) {
            updateRecord(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addRecord(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const recordIds = row.recordId || this.ids
      this.$modal.confirm('是否确认删除借阅记录编号为"' + recordIds + '"的数据项？').then(function () {
        return delRecord(recordIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('book/record/export', {
        ...this.queryParams
      }, `record_${new Date().getTime()}.xlsx`)
    },
    /** 借书按钮操作 */
    handleBorrow() {
      this.borrowForm = {
        userId: null,
        userName: null,
        planReturnTime: null,
        bookIds: []
      }
      this.borrowDialogVisible = true
    },
    /** 提交借书操作 */
    submitBorrow() {
      this.$refs['borrowForm'].validate(valid => {
        if (valid) {
          const borrowRequest = {
            borrowRecord: {
              userId: this.borrowForm.userId,
              userName: this.borrowForm.userName,
              planReturnTime: this.borrowForm.planReturnTime
            },
            bookIds: this.borrowForm.bookIds
          }
          borrowBooks(borrowRequest).then(response => {
            if (response.code === 200) {
              this.$modal.msgSuccess('借书成功')
              this.borrowDialogVisible = false
              this.getList()
            } else {
              this.$modal.msgError('借书失败：' + response.msg)
            }
          })
        }
      })
    },
    /** 还书按钮操作 */
    handleReturn() {
      this.returnDialogVisible = true
    },
    /** 提交还书操作 */
    submitReturn() {
      const recordId = this.ids[0]
      returnBooks(recordId).then(response => {
        if (response.code === 200) {
          // console.log(response.data)
          if (response.data === "2"|| response.data == 2) {
            this.$modal.msgWarning('还书成功，该记录已逾期！')
          } else {
            this.$modal.msgSuccess('还书成功')
          }
          this.returnDialogVisible = false
          this.getList()
        } else {
          this.$modal.msgError('还书失败：' + response.msg)
        }
      })
    },
    /** 下载导入模板 */
    handleImportTemplate() {
      console.log('点击了下载模板按钮')
      importTemplate().then(response => {
        console.log('下载模板成功', response)
        this.downloadClicked = true
        const blob = new Blob([response], { type: 'application/vnd.ms-excel' })
        const url = window.URL.createObjectURL(blob)
        const link = document.createElement('a')
        link.href = url
        link.download = `record_template_${new Date().getTime()}.xlsx`
        link.click()
        window.URL.revokeObjectURL(url)
      }).catch(error => {
        console.error('下载模板失败', error)
        this.$modal.msgError('下载模板失败：' + error.message)
      })
    },
    /** 导入数据 */
    handleImport() {
      console.log('点击了导入数据按钮')
      this.$modal.confirm('是否确认导入借阅记录数据？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        console.log('确认导入数据')
        if (this.$refs['uploadRef']) {
          console.log('点击上传按钮')
          const uploadInput = this.$refs['uploadRef'].$el.querySelector('input[type="file"]')
          if (uploadInput) {
            console.log('找到文件输入框')
            uploadInput.click()
          } else {
            console.error('文件输入框不存在')
            this.$modal.msgError('文件输入框不存在')
          }
        } else {
          console.error('上传组件不存在')
          this.$modal.msgError('上传组件不存在')
        }
      })
    },
    /** 导入成功处理 */
    handleImportSuccess(response) {
      if (response.code === 200) {
        this.$modal.msgSuccess('导入成功：' + response.msg)
        this.getList()
      } else {
        this.$modal.msgError('导入失败：' + response.msg)
      }
    },
    /** 导入失败处理 */
    handleImportError(error) {
      this.$modal.msgError('导入失败，请重试')
    },
    /** 文件上传处理 */
    handleFileUpload(options) {
      const formData = new FormData()
      formData.append('file', options.file)
      formData.append('updateSupport', false)
      
      importRecordData(formData).then(response => {
        if (response.code === 200) {
          this.$modal.msgSuccess('导入成功：' + response.msg)
          this.getList()
          options.onSuccess(response)
        } else {
          this.$modal.msgError('导入失败：' + response.msg)
          options.onError(response)
        }
      }).catch(error => {
        this.$modal.msgError('导入失败：' + error.message)
        options.onError(error)
      })
    },
    /** 获取借阅状态标签 */
    getStatusLabel(status) {
      const statusMap = {
        '0': '待借阅',
        '1': '已借出',
        '2': '已归还',
        '3': '逾期'
      }
      return statusMap[status] || status
    },
    /** 获取借阅状态标签类型 */
    getStatusType(status) {
      const typeMap = {
        '0': 'info',
        '1': 'primary',
        '2': 'success',
        '3': 'danger'
      }
      return typeMap[status] || 'default'
    }
  }
}
</script>
