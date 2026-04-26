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
            <el-form-item label="借阅记录ID" prop="recordId">
              <el-input
                v-model="queryParams.recordId"
                placeholder="请输入借阅记录ID"
                clearable
                class="query-input"
                @keyup.enter.native="handleQuery"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="书籍ID" prop="bookId">
              <el-input
                v-model="queryParams.bookId"
                placeholder="请输入书籍ID"
                clearable
                class="query-input"
                @keyup.enter.native="handleQuery"
              />
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="书籍名称" prop="bookName">
              <el-input
                v-model="queryParams.bookName"
                placeholder="请输入书籍名称"
                clearable
                class="query-input"
                @keyup.enter.native="handleQuery"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 第二行：按钮组 -->
        <el-row :gutter="24">
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
          v-hasPermi="['book:item:add']"
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
          v-hasPermi="['book:item:edit']"
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
          v-hasPermi="['book:item:remove']"
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
          v-hasPermi="['book:item:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="itemList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="明细ID" align="center" prop="itemId"/>
      <el-table-column label="借阅记录ID" align="center" prop="recordId"/>
      <el-table-column label="书籍ID" align="center" prop="bookId"/>
      <el-table-column label="书籍名称" align="center" prop="bookName"/>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['book:item:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['book:item:remove']"
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

    <!-- 添加或修改借阅明细对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="借阅记录ID" prop="recordId">
              <el-input v-model="form.recordId" placeholder="请输入借阅记录ID"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="书籍ID" prop="bookId">
              <el-input v-model="form.bookId" placeholder="请输入书籍ID"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="书籍名称" prop="bookName">
              <el-input v-model="form.bookName" placeholder="请输入书籍名称"/>
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
</style>
<script>
import {listItem, getItem, delItem, addItem, updateItem} from "@/api/book/item"

export default {
  name: "Item",
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
      // 借阅明细表格数据
      itemList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        recordId: null,
        bookId: null,
        bookName: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        recordId: [
          {required: true, message: "借阅记录ID不能为空", trigger: "blur"}
        ],
        bookId: [
          {required: true, message: "书籍ID不能为空", trigger: "blur"}
        ],
        bookName: [
          {required: true, message: "书籍名称不能为空", trigger: "blur"}
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询借阅明细列表 */
    getList() {
      this.loading = true
      listItem(this.queryParams).then(response => {
        this.itemList = response.rows
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
        itemId: null,
        recordId: null,
        bookId: null,
        bookName: null,
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
      this.ids = selection.map(item => item.itemId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加借阅明细"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const itemId = row.itemId || this.ids
      getItem(itemId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改借阅明细"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.itemId != null) {
            updateItem(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addItem(this.form).then(response => {
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
      const itemIds = row.itemId || this.ids
      this.$modal.confirm('是否确认删除借阅明细编号为"' + itemIds + '"的数据项？').then(function () {
        return delItem(itemIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('book/item/export', {
        ...this.queryParams
      }, `item_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>