import request from '@/utils/request'

// 查询书籍信息列表
export function listDetail(query) {
  return request({
    url: '/book/detail/list',
    method: 'get',
    params: query
  })
}

// 查询书籍信息详细
export function getDetail(bookId) {
  return request({
    url: '/book/detail/' + bookId,
    method: 'get'
  })
}

// 新增书籍信息
export function addDetail(data) {
  return request({
    url: '/book/detail',
    method: 'post',
    data: data
  })
}

// 修改书籍信息
export function updateDetail(data) {
  return request({
    url: '/book/detail',
    method: 'put',
    data: data
  })
}

// 删除书籍信息
export function delDetail(bookId) {
  return request({
    url: '/book/detail/' + bookId,
    method: 'delete'
  })
}

// 下载书籍导入模板
export function importTemplate() {
  return request({
    url: '/book/detail/importTemplate',
    method: 'post',
    responseType: 'blob'
  })
}

// 导入书籍数据
export function importData(data) {
  return request({
    url: '/book/detail/importData',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
