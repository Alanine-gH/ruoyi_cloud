<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
      label-width="130px"
      class="book-query-inline-form"
    >
      <el-form-item label="书籍名称" prop="bookName">
        <el-input
          v-model="queryParams.bookName"
          placeholder="请输入书籍名称"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="作者" prop="author">
        <el-input
          v-model="queryParams.author"
          placeholder="请输入作者"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="ISBN编号" prop="isbn">
        <el-input
          v-model="queryParams.isbn"
          placeholder="请输入ISBN编号"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="书籍分类" prop="category">
        <el-input
          v-model="queryParams.category"
          placeholder="请输入书籍分类"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="库存数量" prop="stock">
        <el-input
          v-model="queryParams.stock"
          placeholder="请输入库存数量"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="书籍封面图片地址" prop="coverImg">
        <el-input
          v-model="queryParams.coverImg"
          placeholder="请输入书籍封面图片地址"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <!-- 关键修复：按钮项取消默认margin，强制垂直居中 -->
      <el-form-item class="inline-btn-group">
        <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="small" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['book:detail:add']"
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
          v-hasPermi="['book:detail:edit']"
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
          v-hasPermi="['book:detail:remove']"
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
          v-hasPermi="['book:detail:export']"
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
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="detailList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="书籍ID" align="center" prop="bookId"/>
      <el-table-column label="书籍名称" align="center" prop="bookName"/>
      <el-table-column label="作者" align="center" prop="author"/>
      <el-table-column label="ISBN编号" align="center" prop="isbn"/>
      <el-table-column label="书籍分类" align="center" prop="category"/>
      <el-table-column label="库存数量" align="center" prop="stock"/>
      <el-table-column label="书籍封面" align="center">
        <template slot-scope="scope">
          <el-image
            v-if="scope.row.coverImg"
            :src="scope.row.coverImg"
            fit="cover"
            style="width: 80px; height: 100px;"
            @error="handleImageError"
          />
          <span v-else>无封面</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleViewData(scope.row)"
            v-hasPermi="['book:detail:query']"
          >详情
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['book:detail:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['book:detail:remove']"
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

    <!-- 书籍信息详情抽屉 -->
    <detail-view-drawer ref="detailViewRef"/>
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
    <!-- 添加或修改书籍信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="书籍名称" prop="bookName">
              <el-input v-model="form.bookName" placeholder="请输入书籍名称"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="作者" prop="author">
              <el-input v-model="form.author" placeholder="请输入作者"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="ISBN编号" prop="isbn">
              <el-input v-model="form.isbn" placeholder="请输入ISBN编号"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="书籍分类" prop="category">
              <el-input v-model="form.category" placeholder="请输入书籍分类"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="库存数量" prop="stock">
              <el-input v-model="form.stock" placeholder="请输入库存数量"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="书籍封面" prop="coverImg">
              <el-upload
                ref="uploadRef"
                class="upload-demo"
                action="/book/detail/uploadCover"
                :on-success="handleUploadSuccess"
                :on-error="handleUploadError"
                :limit="1"
                :file-list="fileList"
                :auto-upload="false"
                :on-change="handleFileChange"
              >
                <el-button size="small" type="primary">选择文件</el-button>
                <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过2MB</div>
              </el-upload>
              <el-image
                v-if="form.coverImg"
                :src="form.coverImg"
                fit="cover"
                style="width: 100px; height: 140px; margin-top: 10px;"
                @error="handleImageError"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>
/* 核心：统一所有表单项的垂直对齐方式，取消默认的margin-bottom导致的行高差 */
.book-query-inline-form {
  display: flex;
  align-items: center; /* 所有子项垂直居中，彻底解决换行根源 */
  flex-wrap: wrap; /* 屏幕不够时才换行，足够宽时完全同行 */
  margin-bottom: 16px; /* 表单和下面按钮/表格的间距 */
}

/* 统一表单项间距，取消默认的margin-bottom */
.book-query-inline-form .el-form-item {
  margin-right: 15px;
  margin-bottom: 12px !important; /* 关键：去掉默认底部边距，避免按钮被挤到下一行 */
}

/* 按钮组额外微调，和输入框视觉对齐 */
.inline-btn-group {
  display: flex;
  align-items: center;
  padding-top: 2px; /* 像素级微调，和输入框完全对齐 */
}

/* 隐藏上传按钮 */
.hidden-upload {
  display: none;
}
</style>
<script>
import {listDetail, getDetail, delDetail, addDetail, updateDetail, importTemplate, importData} from "@/api/book/detail"
import {uploadCover} from "@/api/common"
import DetailViewDrawer from "./view"

export default {
  name: "Detail",
  components: {DetailViewDrawer},
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
      // 书籍信息表格数据
      detailList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        bookName: null,
        author: null,
        isbn: null,
        category: null,
        stock: null,
        coverImg: null,
      },
      // 表单参数
      form: {},
      // 文件列表
      fileList: [],
      // 是否点击过下载模板
      downloadClicked: false,
      // 表单校验
      rules: {
        bookName: [
          {required: true, message: "书籍名称不能为空", trigger: "blur"}
        ],
        isbn: [
          {required: true, message: "ISBN编号不能为空", trigger: "blur"}
        ],
        stock: [
          {required: true, message: "库存数量不能为空", trigger: "blur"}
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询书籍信息列表 */
    getList() {
      this.loading = true
      listDetail(this.queryParams).then(response => {
        this.detailList = response.rows
        this.total = response.total
        this.loading = false
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
        bookId: null,
        bookName: null,
        author: null,
        isbn: null,
        category: null,
        stock: null,
        coverImg: null,
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
      this.ids = selection.map(item => item.bookId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加书籍信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const bookId = row.bookId || this.ids
      getDetail(bookId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改书籍信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          console.log('提交的form数据:', this.form);
          if (this.form.bookId != null) {
            updateDetail(this.form).then(response => {
              console.log('修改响应:', response);
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            }).catch(error => {
              console.error('修改失败:', error);
              this.$modal.msgError('修改失败：' + error.message);
            })
          } else {
            addDetail(this.form).then(response => {
              console.log('新增响应:', response);
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            }).catch(error => {
              console.error('新增失败:', error);
              this.$modal.msgError('新增失败：' + error.message);
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const bookIds = row.bookId || this.ids
      this.$modal.confirm('是否确认删除书籍信息编号为"' + bookIds + '"的数据项？').then(function () {
        return delDetail(bookIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 详情按钮操作 */
    handleViewData(row) {
      this.$refs["detailViewRef"].open(row.bookId)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('book/detail/export', {
        ...this.queryParams
      }, `detail_${new Date().getTime()}.xlsx`)
    },
    /** 图片加载失败处理 */
    handleImageError(e) {
      e.target.src = 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=book%20cover%20placeholder&image_size=square';
    },
    /** 文件选择处理 */
    handleFileChange(file, fileList) {
      this.fileList = fileList;
      // 手动上传
      if (file.status === 'ready' && fileList.length > 0) {
        const formData = new FormData();
        formData.append('file', file.raw);
        uploadCover(formData).then(response => {
          if (response.code === 200) {
            this.form.coverImg = response.url;
            console.log('设置coverImg:', this.form.coverImg);
            this.$modal.msgSuccess('上传成功');
          } else {
            this.$modal.msgError('上传失败：' + response.msg);
          }
        }).catch(error => {
          this.$modal.msgError('上传失败，请重试');
          console.error('上传失败:', error);
        });
      }
    },
    /** 上传成功处理 */
    handleUploadSuccess(response, file, fileList) {
      console.log('上传成功响应:', response);
      if (response.code === 200) {
        this.form.coverImg = response.url;
        console.log('设置coverImg:', this.form.coverImg);
        this.$modal.msgSuccess('上传成功');
      } else {
        this.$modal.msgError('上传失败：' + response.msg);
      }
    },
    /** 上传失败处理 */
    handleUploadError(error, file, fileList) {
      this.$modal.msgError('上传失败，请重试');
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
        link.download = `book_template_${new Date().getTime()}.xlsx`
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
      console.log('uploadRef:', this.$refs['uploadRef'])
      this.$modal.confirm('是否确认导入书籍数据？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        console.log('确认导入数据')
        if (this.$refs['uploadRef']) {
          console.log('点击上传按钮')
          // 触发el-upload组件的点击事件
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
      
      importData(formData).then(response => {
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
    }
  }
}
</script>
