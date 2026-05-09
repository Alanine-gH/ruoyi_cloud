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
