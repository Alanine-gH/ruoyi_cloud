<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="借阅人ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入借阅人ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="借阅人姓名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入借阅人姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="借阅时间" prop="borrowTime">
        <el-date-picker clearable
                        v-model="queryParams.borrowTime"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择借阅时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="预计归还时间" prop="planReturnTime">
        <el-date-picker clearable
                        v-model="queryParams.planReturnTime"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择预计归还时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="实际归还时间" prop="returnTime">
        <el-date-picker clearable
                        v-model="queryParams.returnTime"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择实际归还时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="借阅状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择借阅状态" clearable>
          <el-option
            v-for="dict in dict.type.status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
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
          v-hasPermi="['book:record:add']"
        >新增</el-button>
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
        >修改</el-button>
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
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['book:record:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="借阅记录ID" align="center" prop="recordId" />
      <el-table-column label="借阅人ID" align="center" prop="userId" />
      <el-table-column label="借阅人姓名" align="center" prop="userName" />
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
          <dict-tag :options="dict.type.status" :value="scope.row.status"/>
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
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['book:record:remove']"
          >删除</el-button>
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
              <el-input v-model="form.userId" placeholder="请输入借阅人ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="借阅人姓名" prop="userName">
              <el-input v-model="form.userName" placeholder="请输入借阅人姓名" />
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
          <el-col :span="24">
            <el-form-item label="借阅状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择借阅状态">
                <el-option
                  v-for="dict in dict.type.status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-divider content-position="center">借阅明细子信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddBorrowItem">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteBorrowItem">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="borrowItemList" :row-class-name="rowBorrowItemIndex" @selection-change="handleBorrowItemSelectionChange" ref="borrowItem">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="书籍ID" prop="bookId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.bookId" placeholder="请输入书籍ID" />
            </template>
          </el-table-column>
          <el-table-column label="书籍名称" prop="bookName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.bookName" placeholder="请输入书籍名称" />
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRecord, getRecord, delRecord, addRecord, updateRecord } from "@/api/book/record"

export default {
  name: "Record",
  dicts: ['status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedBorrowItem: [],
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
      // 借阅明细子表格数据
      borrowItemList: [],
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
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "借阅人ID不能为空", trigger: "blur" }
        ],
        userName: [
          { required: true, message: "借阅人姓名不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询借阅记录列表 */
    getList() {
      this.loading = true
      listRecord(this.queryParams).then(response => {
        this.recordList = response.rows
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
      this.borrowItemList = []
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
        this.borrowItemList = response.data.borrowItemList
        this.open = true
        this.title = "修改借阅记录"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.borrowItemList = this.borrowItemList
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
      this.$modal.confirm('是否确认删除借阅记录编号为"' + recordIds + '"的数据项？').then(function() {
        return delRecord(recordIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 借阅明细子序号 */
    rowBorrowItemIndex({ row, rowIndex }) {
      row.index = rowIndex + 1
    },
    /** 借阅明细子添加按钮操作 */
    handleAddBorrowItem() {
      let obj = {}
      obj.bookId = ""
      obj.bookName = ""
      this.borrowItemList.push(obj)
    },
    /** 借阅明细子删除按钮操作 */
    handleDeleteBorrowItem() {
      if (this.checkedBorrowItem.length == 0) {
        this.$modal.msgError("请先选择要删除的借阅明细子数据")
      } else {
        const borrowItemList = this.borrowItemList
        const checkedBorrowItem = this.checkedBorrowItem
        this.borrowItemList = borrowItemList.filter(function(item) {
          return checkedBorrowItem.indexOf(item.index) == -1
        })
      }
    },
    /** 复选框选中数据 */
    handleBorrowItemSelectionChange(selection) {
      this.checkedBorrowItem = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('book/record/export', {
        ...this.queryParams
      }, `record_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
