import request from '@/utils/request'

// 查询借阅明细列表
export function listItem(query) {
  return request({
    url: '/book/item/list',
    method: 'get',
    params: query
  })
}

// 查询借阅明细详细
export function getItem(itemId) {
  return request({
    url: '/book/item/' + itemId,
    method: 'get'
  })
}

// 新增借阅明细
export function addItem(data) {
  return request({
    url: '/book/item',
    method: 'post',
    data: data
  })
}

// 修改借阅明细
export function updateItem(data) {
  return request({
    url: '/book/item',
    method: 'put',
    data: data
  })
}

// 删除借阅明细
export function delItem(itemId) {
  return request({
    url: '/book/item/' + itemId,
    method: 'delete'
  })
}