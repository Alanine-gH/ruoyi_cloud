import request from '@/utils/request'

// 查询借阅记录列表
export function listRecord(query) {
  return request({
    url: '/book/record/list',
    method: 'get',
    params: query
  })
}

// 查询借阅记录详细
export function getRecord(recordId) {
  return request({
    url: '/book/record/' + recordId,
    method: 'get'
  })
}

// 新增借阅记录
export function addRecord(data) {
  return request({
    url: '/book/record',
    method: 'post',
    data: data
  })
}

// 修改借阅记录
export function updateRecord(data) {
  return request({
    url: '/book/record',
    method: 'put',
    data: data
  })
}

// 删除借阅记录
export function delRecord(recordId) {
  return request({
    url: '/book/record/' + recordId,
    method: 'delete'
  })
}

// 借书操作
export function borrowBooks(data) {
  return request({
    url: '/book/record/borrow',
    method: 'post',
    data: data
  })
}

// 还书操作
export function returnBooks(recordId) {
  return request({
    url: '/book/record/return/' + recordId,
    method: 'put'
  })
}

// 下载借阅记录导入模板
export function importTemplate() {
  return request({
    url: '/book/record/importTemplate',
    method: 'post',
    responseType: 'blob'
  })
}

// 导入借阅记录数据
export function importRecordData(data) {
  return request({
    url: '/book/record/importData',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
